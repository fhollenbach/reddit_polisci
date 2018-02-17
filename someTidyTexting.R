
library(anytime)
library(dplyr)
library(tidytext)
months <- c("01","02","03","04","05","06","07","08","09","10","11","12")

load("~/Dropbox/RedditData/Downloads/politicssubreddit_2016_01_.rda")
res$date <- as.Date(anytime(res$created_utc))
res$year <- format(res$date, "%Y")
res$month <- format(res$date, "%m")
data <- res %>% select(body, author,  month, year)      


for(i in months[-1]){
  load(paste("~/Dropbox/RedditData/Downloads/nflsubreddit_2016_",i,"_.rda", sep = ""))
  res$date <- as.Date(anytime(res$created_utc))
  res$year <- format(res$date, "%Y")
  res$month <- format(res$date, "%m")
  
  data <- res  %>% select(body, author,  month, year) %>% bind_rows(data)
}


data <- data %>% mutate(linenumber = row_number())



text_df <- data %>% group_by(author)


text_df <- text_df %>% mutate(linenumber = row_number()) %>% ungroup() %>% unnest_tokens(word, body)

data(stop_words)

text_df <- text_df %>% filter(word != "deleted")
### get rid of stop words
text_df <- text_df %>%
  anti_join(stop_words)



word_counts <- text_df %>% count(word, sort = TRUE)



#### plot 20 most common words
plot <- text_df %>%
  count(word, sort = TRUE) %>%
  filter(n > word_counts$n[21]) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()



## Sentiment based on Bing et al
redditsentiment <- text_df %>%
  inner_join(get_sentiments("bing")) %>%
  count(author, index = month, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

## Bing et al plots
hist(redditsentiment$sentiment)
hist(redditsentiment$negative)
hist(redditsentiment$positive)

## Adding AFINN scores 
afinn <- text_df %>% 
  inner_join(get_sentiments("afinn")) %>% 
  group_by(index = month) %>% 
  summarise(sentiment = sum(score)) %>% 
  mutate(method = "AFINN")


## Bind and NRC scores
bing_and_nrc <- bind_rows(text_df %>% 
                            inner_join(get_sentiments("bing")) %>%
                            mutate(method = "Bing et al."),
                          text_df %>% 
                            inner_join(get_sentiments("nrc") %>% 
                                         filter(sentiment %in% c("positive", 
                                                                 "negative"))) %>%
                            mutate(method = "NRC")) %>%
  count(method, index = month, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

## Combine all scores and plot them
sentiment_plot2016 <- bind_rows(afinn, 
          bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")
plot(sentiment_plot2016)
ggsave("~/Dropbox/RedditData/sentiment2016_politics.pdf")

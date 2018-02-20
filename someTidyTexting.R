
library(anytime)
library(dplyr)
library(tidytext)

load("~/Dropbox/RedditData/nfl_2016.rda")


data <- data %>% mutate(linenumber = row_number())



text_df <- data %>% group_by(author)

text_df <- text_df   %>% mutate(body = iconv(body, to = 'latin1'))

text_df <- text_df   %>% filter(body!="[deleted]")

text_df <- text_df %>% ungroup() %>% unnest_tokens(word, body, token = "lines")





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
plot(plot)
ggsave("~/Dropbox/RedditData/commonComments.pdf")

## Sentiment based on Bing et al

## Sentiment based on Bing et al
redditsentiment <- text_df %>%
  inner_join(get_sentiments("bing")) %>%
  count(author, index = linenumber%/% 4, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

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
ggsave("~/Dropbox/RedditData/sentiment2016.pdf")

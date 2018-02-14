##--------------------------------------------------
## Project:    Reddit Sentiment Analysis
## File:       reddit_clean.R
## Purpose:    Cleaning the reddit data for text analysis
## Author:     Daniel Weitzel
## Email:      daniel.weitzel@utexas.edu
## Data, in: 
## Data, out: 
## Modified:   2018-02-14
## Notes:      Date variable needs to be cleaned
##             Commas delimit 
##             tm_year, tm_month, tm_day clear IDs
##--------------------------------------------------

## Setting the workind directory
getwd()
##setwd(basedir)
setwd("~/Dropbox/RedditData")

## Loading the libraries
library(rio)
library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(ggplot2)

##--------------------------------------------------
## Loading the data set
reddit_data <- import("test.csv")

## Renaming the columns 
## word is default column for lots of What's V3?
reddit_data <- reddit_data %>% rename(user = V1, comment = V2, date = V4)
                               
## Generating linenumbers
reddit_data <- reddit_data %>% mutate(linenumber = row_number())

## Dropping unnecessary variables for now
reddit_data$date <- NULL
reddit_data$V3 <- NULL

## getting a tidy data frame based on words
tidy_reddit <- reddit_data %>%
  group_by(user) %>%
  mutate(linenumber = row_number()) %>%
  ungroup() %>%
  unnest_tokens(word, comment)


## Sentiment based on Bing et al
redditsentiment <- tidy_reddit %>%
  inner_join(get_sentiments("bing")) %>%
  count(user, index = linenumber%/% 4, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

## Bing et al plots
hist(redditsentiment$sentiment)
hist(redditsentiment$negative)
hist(redditsentiment$positive)

## Adding AFINN scores 
afinn <- tidy_reddit %>% 
  inner_join(get_sentiments("afinn")) %>% 
  group_by(index = user) %>% 
  summarise(sentiment = sum(score)) %>% 
  mutate(method = "AFINN")


## Bind and NRC scores
bing_and_nrc <- bind_rows(tidy_reddit %>% 
                            inner_join(get_sentiments("bing")) %>%
                            mutate(method = "Bing et al."),
                          tidy_reddit %>% 
                            inner_join(get_sentiments("nrc") %>% 
                                         filter(sentiment %in% c("positive", 
                                                                 "negative"))) %>%
                            mutate(method = "NRC")) %>%
  count(method, index = user, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

## Combine all scores and plot them
bind_rows(afinn, 
          bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")

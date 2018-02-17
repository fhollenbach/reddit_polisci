

library(dplyr)
library(tidytext)
raw_data<-('~/Dropbox/RedditData/data2015000000000000.json')


rm(dat)
rm(input)
test <- data.frame(matrix(unlist(test), nrow=10, byrow=T))
names(test) <- c("subreddit", "body", "author", "score", "utc")

test$body[test$body == "[deleted]"] <- NA
test <- test[is.na(test$body) == F, ]
test$body <- as.character(test$body)
text_df <- data_frame(c(test$subreddit), c(test$body), c(test$author), c(test$score), c(test$utc))
names(text_df) <- c("subreddit", "body", "author", "score", "utc")


unnest_tokens(text_df, word, test$body)




text <- c("Because I could not stop for Death -",
          "He kindly stopped for me -",
          "The Carriage held but just Ourselves -",
          "and Immortality")

text
library(dplyr)
text_df <- data_frame(line = 1:4, text = text)

text_df
text_df %>%
  unnest_tokens(word, text)

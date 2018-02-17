

library(rjson)
library(dplyr)
library(tidytext)
raw_data<-('~/Dropbox/RedditData/data2015000000000000.json')

con = file(raw_data, "r")
input <- readLines(con, -1L)
dat <- lapply(X=input,fromJSON)


test <- dat[1:10]
save(test, file = "~/Dropbox/RedditData/test.rda")

library(tidyverse)
library(anytime)
library(jsonlite)
library(tidytext)

data <- data.frame()
num <- c(0,1,2)
for(i in num){
  raw_data<-paste("~/Dropbox/RedditData/data201500000000000",i,".json",sep = "")
  res <- fromJSON(sprintf("[%s]", paste(readLines(raw_data),collapse=",")))
  
  res$date <- as.Date(anytime(as.numeric(as.character(res$created_utc))))
  res$year <- format(res$date, "%Y")
  res$month <- format(res$date, "%m")
  data <- res  %>% select(body, author,  month, year) %>% bind_rows(data)
}
save(data, file = "~/Dropbox/RedditData/nfl_2015.rda")


data <- data.frame()
num <- c(0,1,2)
for(i in num){
  raw_data<-paste("~/Dropbox/RedditData/data201600000000000",i,".json",sep = "")
  res <- fromJSON(sprintf("[%s]", paste(readLines(raw_data),collapse=",")))
  
  res$date <- as.Date(anytime(as.numeric(as.character(res$created_utc))))
  res$year <- format(res$date, "%Y")
  res$month <- format(res$date, "%m")
  data <- res  %>% select(body, author,  month, year) %>% bind_rows(data)
}
save(data, file = "~/Dropbox/RedditData/nfl_2016.rda")


data <- data.frame()
num <- c(0,1,2)
for(i in num){
  raw_data<-paste("~/Dropbox/RedditData/data201700000000000",i,".json",sep = "")
  res <- fromJSON(sprintf("[%s]", paste(readLines(raw_data),collapse=",")))
  
  res$date <- as.Date(anytime(as.numeric(as.character(res$created_utc))))
  res$year <- format(res$date, "%Y")
  res$month <- format(res$date, "%m")
  data <- res  %>% select(body, author,  month, year) %>% bind_rows(data)
}
save(data, file = "~/Dropbox/RedditData/nfl_2017.rda")

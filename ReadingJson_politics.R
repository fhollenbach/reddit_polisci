library(tidyverse)
library(anytime)
library(jsonlite)
library(tidytext)

data <- data.frame()
num <- c(0,1,2)
for(i in num){
  raw_data<-paste("~/Dropbox/RedditData/politics/2F2015politics00000000000",i,sep = "")
  res <- fromJSON(sprintf("[%s]", paste(readLines(raw_data),collapse=",")))
  
  res$date <- as.Date(anytime(as.numeric(as.character(res$created_utc))))
  res$year <- format(res$date, "%Y")
  res$month <- format(res$date, "%m")
  data <- res  %>% select(body, author,  month, year) %>% bind_rows(data)
}
save(data, file = "~/Dropbox/RedditData/politics_2015.rda", compress = "xz")


data <- data.frame()
num <- c(0,1,2,3,4,5,6,7,8,9)
for(i in num){
  raw_data<-paste("~/Dropbox/RedditData/politics/2F2016politics00000000000",i,sep = "")
  res <- fromJSON(sprintf("[%s]", paste(readLines(raw_data),collapse=",")))
  
  res$date <- as.Date(anytime(as.numeric(as.character(res$created_utc))))
  res$year <- format(res$date, "%Y")
  res$month <- format(res$date, "%m")
  data <- res  %>% select(body, author,  month, year) %>% bind_rows(data)
}
save(data, file = "~/Dropbox/RedditData/politics_2016.rda", compress = "xz")


data <- data.frame()
num <- c("00","01","02","03","04","05","06","07","08","09","10","11")
for(i in num){
  raw_data<-paste("~/Dropbox/RedditData/politics/2F2017politics0000000000",i,sep = "")
  res <- fromJSON(sprintf("[%s]", paste(readLines(raw_data),collapse=",")))
  
  res$date <- as.Date(anytime(as.numeric(as.character(res$created_utc))))
  res$year <- format(res$date, "%Y")
  res$month <- format(res$date, "%m")
  data <- res  %>% select(body, author,  month, year) %>% bind_rows(data)
}
save(data, file = "~/Dropbox/RedditData/politics_2017.rda", compress = "xz")

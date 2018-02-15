##--------------------------------------------------
## Project:    Reddit Sentiment Analysis
## File:       reddit_jan2015.R
## Purpose:    Cleaning the reddit data for text analysis
## Author:     Daniel Weitzel
## Email:      daniel.weitzel@utexas.edu
## Data, in: 
## Data, out: 
## Modified:   2018-02-15
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
library(anytime)

##--------------------------------------------------
## Loading the data set
reddit_data <- import("jan2015_data.txt")
##export(reddit_data, "jan2015.Rdata")

## Change the date from unix to separate variables
reddit_data$date <- anytime(reddit_data$created_utc)
reddit_data <- separate(reddit_data, col = date, into = c("date", "time"), sep = " ", remove = TRUE)
reddit_data <- separate(reddit_data, col = date, into = c("year", "month", "day"), sep = "-", remove = TRUE)
reddit_data <- separate(reddit_data, col = time, into = c("hour", "minute", "second"), sep = ":", remove = TRUE)


export(reddit_data, "jan2015.Rdata")
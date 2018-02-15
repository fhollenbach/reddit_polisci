

library(rjson)

raw_data<-('~/Downloads/data2015000000000000.json')

con = file(raw_data, "r")
input <- readLines(con, -1L)
dat <- lapply(X=input,fromJSON)
df <- data.frame(matrix(unlist(l), nrow=132, byrow=T),stringsAsFactors=FALSE)

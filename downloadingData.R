
library(bigrquery)
project <- "redditpolsciproj"

years <- c(2015,2016,2017)
months <- c("01","02","03","04","05","06","07","08","09","10","11","12")

for(year in years){
  for(month in months){
    sql<-paste("SELECT",
    " * ",
      " FROM", " (",
      "   SELECT",
      "   subreddit,",
      "   body,",
      "   name,",
      "   author,",
      "   created_utc,",
      "   score",
      "   FROM",
      "   [fh-bigquery:reddit_comments.",year,"_",month,"])",
      "   WHERE LOWER(subreddit) in ('nfl')",
      sep = "")

  res <- query_exec(sql, project = project, useLegacySql = FALSE, max_pages = Inf)
  save(res, file = paste("~/Dropbox/RedditData/Downloads/nflsubreddit",year,month,".rda",sep = "_"))
  rm(res)
  }
}

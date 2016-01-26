setwd("/Users/mrlajoie/Dropbox/MBA/P3/Big data analytics/TwitterProject")
getwd()
install.packages('twitteR',dependencies=T)
install.packages('ROAuth')
library(twitteR)
library(plyr)
library(ROAuth)

### method from http://thinktostart.com/sentiment-analysis-on-twitter/ 
### twitter account into @BigDataWizzes, pword: insead2016 

require(twitteR)

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "http://api.twitter.com/oauth/access_token"
authURL <- "http://api.twitter.com/oauth/authorize"
consumerKey <- "qqY6WBBDBXcAlj2pfnoTqEdmY"
consumerSecret <- "DfJSeSQfApCOUhQc8yruKzSZlS7KVn5tLyXyfQ7Iz37Jyj11Lc"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,consumerSecret=consumerSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
twitCred$handshake(cainfo="cacert.pem")
registerTwitterOAuth(twitCred)

### I had to stop here, see issue in github Error: Forbidden after > twitCred$handshake(cainfo="cacert.pem")


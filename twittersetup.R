install.packages('twitteR',dependencies=T)
library(twitteR)
install.packages('ROAuth')
library(ROAuth)
install.packages("base64enc")

### twitter account into @BigDataWizzes, pword: insead2016 
require(twitteR)
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "http://api.twitter.com/oauth/access_token"
authURL <- "http://api.twitter.com/oauth/authorize"
consumerKey <- "qqY6WBBDBXcAlj2pfnoTqEdmY"
consumerSecret <- "DfJSeSQfApCOUhQc8yruKzSZlS7KVn5tLyXyfQ7Iz37Jyj11Lc"
access_token = "4850083229-NfLMzFoChxRi7rRUM9b9qvWS7ofuZVFEBRE3dic"
access_secret = "y6T1lQ43KfQKc1TpqpU1MdA3OQAE8ctXZgR2XwYBW4aFY"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,consumerSecret=consumerSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
setup_twitter_oauth(consumerKey, consumerSecret, access_token, access_secret)

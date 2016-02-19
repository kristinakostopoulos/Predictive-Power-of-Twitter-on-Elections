
##Basic Twitter Data structure

#Creates one big table with tweets from everybody
twall<-rbind(
  twcan1<-twListToDF(searchTwitter("from:HillaryClinton",n=1000)),
  twcan2<-twListToDF(searchTwitter("from:realDonaldTrump",n=1000)),
  twcan3<-twListToDF(searchTwitter("from:marcorubio",n=1000)),
  twcan4<-twListToDF(searchTwitter("from:BernieSanders",n=1000))
)

#Creates a column with only the day, taking out the minutes
twall$day=as.Date(twall$created)

#Creates a table that sums the number of retweet everyday for each candidate separately
retweets=sqldf("select screenName,day,sum(retweetCount) as retweets from twall group by screenName,day")

##WordCloud Data Cleaning
#create CSV files

write.csv(twcan1,file="twcan1.csv") #create variable for the csv file
write.csv(twcan2,file="twcan2.csv")
write.csv(twcan3,file="twcan3.csv")
write.csv(twcan4,file="twcan4.csv")

can1 <- read.csv("twcan1.csv", stringsAsFactors=FALSE)
review_can1 <- paste(can1$text, collapse=" ") #Collapse all rows into one long vector

can2 <- read.csv("twcan2.csv", stringsAsFactors=FALSE)
review_can2 <- paste(can2$text, collapse=" ") #Collapse all rows into one long vector

can3 <- read.csv("twcan3.csv", stringsAsFactors=FALSE)
review_can3 <- paste(can3$text, collapse=" ") #Collapse all rows into one long vector

can4 <- read.csv("twcan4.csv", stringsAsFactors=FALSE)
review_can4 <- paste(can4$text, collapse=" ") #Collapse all rows into one long vector

#Interprets all elements of vector as a document
corpus1<-Corpus(VectorSource(review_can1))
corpus2<-Corpus(VectorSource(review_can2))
corpus3<-Corpus(VectorSource(review_can3))
corpus4<-Corpus(VectorSource(review_can4))


#clean data
corpus1 <- tm_map(corpus1, removePunctuation)
corpus1 <- tm_map(corpus1, stripWhitespace)
corpus1 <- tm_map(corpus1, removeWords, stopwords("english"))
corpus1 <- tm_map(corpus1, removeWords, c("-", "the", "this"))

corpus2 <- tm_map(corpus2, removePunctuation)
corpus2<- tm_map(corpus2, stripWhitespace)
corpus2 <- tm_map(corpus2, removeWords, stopwords("english"))
corpus2 <- tm_map(corpus2, removeWords, c("-", "the", "this"))

corpus3 <- tm_map(corpus3, removePunctuation)
corpus3<- tm_map(corpus3, stripWhitespace)
corpus3 <- tm_map(corpus3, removeWords, stopwords("english"))
corpus3 <- tm_map(corpus3, removeWords, c("-", "the", "this"))

corpus4 <- tm_map(corpus4, removePunctuation)
corpus4<- tm_map(corpus4, stripWhitespace)
corpus4 <- tm_map(corpus4, removeWords, stopwords("english"))
corpus4 <- tm_map(corpus4, removeWords, c("-", "the", "this"))


#frequency matrices
frequency1 <- colSums(as.matrix(DocumentTermMatrix(corpus1)))
frequency1 <- sort(frequency1, decreasing=TRUE)
freq1=as.data.frame(frequency1)

frequency2 <- colSums(as.matrix(DocumentTermMatrix(corpus2)))
frequency2 <- sort(frequency2, decreasing=TRUE)
freq2=as.data.frame(frequency2)

frequency3 <- colSums(as.matrix(DocumentTermMatrix(corpus3)))
frequency3 <- sort(frequency3, decreasing=TRUE)
freq3=as.data.frame(frequency3)

frequency4 <- colSums(as.matrix(DocumentTermMatrix(corpus4)))
frequency4 <- sort(frequency4, decreasing=TRUE)
freq4=as.data.frame(frequency4)

#Structure and rename dataframe columns
freq1 <- cbind(rownames(freq1), freq1)
rownames(freq1) <- NULL
colnames(freq1) <- c("word","count1")

freq2 <- cbind(rownames(freq2), freq2)
rownames(freq2) <- NULL
colnames(freq2) <- c("word","count2")

freq3 <- cbind(rownames(freq3), freq3)
rownames(freq3) <- NULL
colnames(freq3) <- c("word","count3")

freq4 <- cbind(rownames(freq4), freq4)
rownames(freq4) <- NULL
colnames(freq4) <- c("word","count4")

#build general frequency table
temp1=merge(x = freq1, y = freq2, by = "word", all = TRUE)
temp2=merge(x = freq3, y = freq4, by = "word", all = TRUE)
allwords=merge(x = temp1, y = temp2, by = "word", all = TRUE)
colnames(allwords) <- c("word","countcan1","countcan2","countcan3","countcan4")

#turn absolute frequencies into relative frequencies
allwords[is.na(allwords)] <- 0 #replaces all NA with 0 to be able to sum
allwords[,2:5]=allwords[,2:5]/colSums(allwords[,2:5]) #compute relative frequency


#Compute frequency differential
allwords$can1diff=allwords[,2]-apply(allwords[,3:5],1,mean)
allwords$can2diff=allwords[,3]-(allwords[,2]+allwords[,4]+allwords[,5])/3
allwords$can3diff=allwords[,4]-(allwords[,2]+allwords[,3]+allwords[,5])/3
allwords$can4diff=allwords[,5]-apply(allwords[,2:4],1,mean)

allwords=arrange(allwords,-can1diff)
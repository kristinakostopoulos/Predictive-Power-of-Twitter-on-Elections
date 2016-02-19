numbr<-15
upxlim<-10000
upylim<-0.01
bins<-seq(0, upxlim, by=1000)



myhist<- function(Hist,y){
  plot(Hist, xlab="Retweets", ylab="number of tweets", main=paste(y),
       col="dark blue", border="dark blue",
       xlim=c(0,upxlim),ylim=c(0,upylim))
}

myhist2<- function(Can){
  ggplot(paste("twcan",Can,sep=""), aes(retweetCount))
}

Hist1 <- hist(twcan1$retweetCount, breaks=bins)
Hist1$counts=Hist1$counts/sum(Hist1$counts)

Hist2 <- hist(twcan2$retweetCount, breaks=bins)
Hist2$counts=Hist2$counts/sum(Hist2$counts)

Hist3 <- hist(twcan3$retweetCount, breaks=bins)
Hist3$counts=Hist3$counts/sum(Hist3$counts)

Hist4 <- hist(twcan4$retweetCount, breaks=bins)
Hist4$counts=Hist4$counts/sum(Hist4$counts)



Hist1 <- hist(twcan1$retweetCount, breaks=bins)
Hist1$density

ggplot(twcan2, aes(retweetCount, ..density..)) +
  geom_histogram(breaks = seq(0,upxlim, by=1000))

ggplot(twcan1, aes(retweetCount)) +
  geom_histogram(breaks = seq(0,upxlim, by=1000))+ylim(c(0,150))

ggplot(twcan4, aes(retweetCount)) +
  geom_histogram(breaks = seq(0,upxlim, by=1000))+ylim(c(0,150))



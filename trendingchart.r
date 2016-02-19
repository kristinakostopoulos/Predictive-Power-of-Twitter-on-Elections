#Sample 500 tweets per day on different days to be able to find trends
alltw<-rbind(
twListToDF(searchTwitter("#hillaryclinton OR #donaldtrump OR #berniesanders OR #marcorubio", n=500, geocode = '36.1215,115.1739, 10km', since="2016-02-18", until="2016-02-19")),
twListToDF(searchTwitter("#hillaryclinton OR #donaldtrump OR #berniesanders OR #marcorubio", n=500, geocode = '36.1215,115.1739, 10km', since="2016-02-17", until="2016-02-18")),
twListToDF(searchTwitter("#hillaryclinton OR #donaldtrump OR #berniesanders OR #marcorubio", n=500, geocode = '36.1215,115.1739, 10km', since="2016-02-16", until="2016-02-17")),
twListToDF(searchTwitter("#hillaryclinton OR #donaldtrump OR #berniesanders OR #marcorubio", n=500, geocode = '36.1215,115.1739, 10km', since="2016-02-15", until="2016-02-16")),
twListToDF(searchTwitter("#hillaryclinton OR #donaldtrump OR #berniesanders OR #marcorubio", n=500, geocode = '36.1215,115.1739, 10km', since="2016-02-14", until="2016-02-15")),
twListToDF(searchTwitter("#hillaryclinton OR #donaldtrump OR #berniesanders OR #marcorubio", n=500, geocode = '36.1215,115.1739, 10km', since="2016-02-13", until="2016-02-16"))
)
#vectors
hv=c("Hillary","hillary","clinton","Clinton")
tv=c("trump","Trump","donald","Donald")
bv=c("bernie","Bernie","sanders","Sanders")
mv=c("marco","Marco","Rubio","rubio")

#add a field that counts whenever each of the candidates is mentioned
alltw$hillcount = str_detect(alltw$text,hv)
alltw$trumpcount = str_detect(alltw$text,tv)
alltw$berniecount = str_detect(alltw$text,bv)
alltw$marcocount = str_detect(alltw$text,mv)


# Create a frequency table for each hashtag that aggregates tweets by hour 

temphill<-aggregate(alltw$hillcount, 
                 list(hour=cut(as.POSIXct(alltw$created), "hour")),
                 sum)
          temphill$hashtag='#HillaryClinton'

temptrump<-aggregate(alltw$trumpcount, 
                    list(hour=cut(as.POSIXct(alltw$created), "hour")),
                    sum)
            temptrump$hashtag='#DonaldTrump'

tempbernie<-aggregate(alltw$berniecount, 
                     list(hour=cut(as.POSIXct(alltw$created), "hour")),
                     sum)
            tempbernie$hashtag='#berniesanders'

tempmarco<-aggregate(alltw$marcocount, 
                      list(hour=cut(as.POSIXct(alltw$created), "hour")),
                      sum)
            tempmarco$hashtag='#marcorubio'
            

hashcount<-rbind(temphill,temptrump,tempbernie,tempmarco)


#Plotting the results
p5 <- ggplot(hashcount, aes(x = hour, y = x))
p5 + geom_line(aes(color=hashtag, group=hashtag))+ theme(axis.text.x  = element_text(angle=45, vjust=0.5))


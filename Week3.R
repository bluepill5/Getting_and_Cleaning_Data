# Week3 Quiz
# Sorry for the mess

#Q1
q1 <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# Variables of interest: ACR==3 (Lot size); AGS (Sales of  Agriculture 
# Products)==6
agricultureLogical <- (q1$ACR==3 & q1$AGS==6)
which(agricultureLogical)


#Q2
library(jpeg)
# read a image
img <- readJPEG("D:/Cthulhu/IMG/getdata_jeff.jpg", native=TRUE)
# What are the 30th and 80th quantiles of the resulting data? 
quantile(img, probs=c(.3, .8))


# Q3
scan("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",sep=',', what="character" , nlines=1 )
q3_GDP <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
                   skip=4, nrows=190, stringsAsFactors=FALSE)
q3_GDP <- q3_GDP[,c(1,2 ,4, 5)]
colnames(q3_GDP) <- c("id","Ranking","Name","GDP")

q3_ED <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

names(q3_GDP)
names(q3_ED)

q3 <- merge(q3_GDP, q3_ED, by.x="id", by.y="CountryCode", all=TRUE)
nrow(q3) # Remember the world
head(q3[!is.na(q3$GDP),])
q3.v2 <- q3[!is.na(q3$GDP),]
# Eliminates the white spaces and the commas
q3.v2[,"GDP"] <- as.numeric(sub("\\,", "", sub("(.+)-$","-\\1", gsub("\\,", "", q3.v2[,"GDP"]))))
head(q3.v2[order(q3.v2$GDP, decreasing=TRUE),"Long.Name"], n=13)

names(q3.v2)
# Average GDP ranking for the "High income: OECD" and "High income: nonOECD" 
# group
mean(q3.v2[q3.v2$Income.Group=="High income: OECD", ]$Ranking, na.rm=TRUE)
mean(q3.v2[q3.v2$Income.Group=="High income: nonOECD", ]$Ranking, na.rm=TRUE)

library(Hmisc)

# How many countries are Lower middle income but among the 38 nations with 
# highest GDP?
table(cut2(q3.v2$Ranking, g=5), q3.v2$Income.Group) # 5

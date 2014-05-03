# Week4 Quiz
# Sorry for the mess

#Q1
# The American Community Survey distributes downloadable data about United 
# States communities. Download the 2006 microdata survey about housing for the 
# state of Idaho using download.file() from here:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 

q1 <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# Apply strsplit() to split all the names of the data frame on the characters 
# "wgtp". What is the value of the 123 element of the resulting list?

?strsplit
strsplit(names(q1), "[0-9]") # Testing
strsplit(names(q1), "wgtp")

# Load the Gross Domestic Product data for the 190 ranked countries in this 
# data set: 
q2 <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
               skip=4, stringsAsFactors=FALSE, nrows=190)
q2_GDP <- q2[,5]

# Remove the commas from the GDP numbers in millions of dollars and average 
# them. What is the average? 
mean(as.numeric(gsub("\\,", "", q2_GDP)))

# What is a regular expression that would allow you to count the number of 
# countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United? 
names(q2)
length(grep("^United", q2$X.3))

# Match the data based on the country shortcode. Of the countries for which the
# end of the fiscal year is available, how many end in June? 
q3_GDP <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
                   skip=4, nrows=190, stringsAsFactors=FALSE)
q3_GDP <- q3_GDP[,c(1,2 ,4, 5)]
colnames(q3_GDP) <- c("id","Ranking","Name","GDP")
q3_ED <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

q3 <- merge(q3_GDP, q3_ED, by.x="id", by.y="CountryCode", all=TRUE)
names(q3)
q3$Special.Notes[grepl("^Fiscal year end: June 30", q3$Special.Notes)]
length(grep("^Fiscal year end: June 30", q3$Special.Notes))

# How many values were collected in 2012? How many values were collected on 
# Mondays in 2012?
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sampleTimes2012 = sampleTimes[grepl("^2012", sampleTimes)]
sampleTimesDays2012 = sapply(sampleTimes2012, weekdays)
length(sampleTimes2012)
length(grep("lunes", sampleTimesDays2012))


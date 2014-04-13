# Week 1 Quiz
#
# The American Community Survey distributes downloadable data about United 
# States communities. Download the 2006 microdata survey about housing for 
# the state of Idaho using download.file() from here:

# Download data:
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(fileUrl, destfile="./data", method="curl")
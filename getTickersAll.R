# Get tickers symbols from www.barchart.com
#
# JM Albornoz
# January 2016
#

# clear everything
rm(list=ls(all=TRUE))

# proxy settings
Sys.setenv(http_proxy="http://195.171.204.252:8080/")
Sys.setenv(https_proxy="http://195.171.204.252:8080/")

# invokes library
library(XML)
library(dplyr)

# url to scrape
# SouthEast : http://www.barchart.com/stocks/sectors/-BKSE?f=ind
# NorthEast : http://www.barchart.com/stocks/sectors/-BKNW?f=ind
# West : http://www.barchart.com/stocks/sectors/-BKWT?f=ind
# Midwest : http://www.barchart.com/stocks/sectors/-BKMW?f=ind
# Southwest : http://www.barchart.com/stocks/sectors/-BKSW?f=ind
# Major regional : http://www.barchart.com/stocks/sectors/-BKMR?f=ind
# Foreign : http://www.barchart.com/stocks/sectors/-BKFG?f=ind
#
url <- 'http://www.barchart.com/stocks/sectors/-BKFG?f=ind'

# gets url content
tabs <- GET(url)

# converts url content to table
tabs <- readHTMLTable(rawToChar(tabs$content), stringsAsFactors = F)

# gets tickers and bank names
tickerList <- tabs[[3]][[1]]
tickers <- tickerList[10:length(tickerList)]
namesList <- tabs[[3]][[2]]
bankNames <- namesList[10:length(namesList)]

# generates data frame with tickers and names
theData0 <- data.frame(tickers = tickers, names = bankNames)     # SouthEast
theData1 <- data.frame(tickers = tickers, names = bankNames)     # NorthEast
theData2 <- data.frame(tickers = tickers, names = bankNames)     # West
theData3 <- data.frame(tickers = tickers, names = bankNames)     # Midwest 
theData4 <- data.frame(tickers = tickers, names = bankNames)     # Southwest 
theData5 <- data.frame(tickers = tickers, names = bankNames)     # Major regional 
theData6 <- data.frame(tickers = tickers, names = bankNames)     # Foreign 


# binds data frames
theData <- rbind(theData0, theData1)
theData <- rbind(theData, theData2)
theData <- rbind(theData, theData3)
theData <- rbind(theData, theData4)
theData <- rbind(theData, theData5)
theData <- rbind(theData, theData6)

# writes resulting data frames to file
#write.table(theData, "allBanks.txt", sep="\t", row.names = FALSE)
write.csv(theData, "BHCsAndTickers.csv", row.names = FALSE)



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
theData <- data.frame(tickers = tickers, names = bankNames)

# writes resulting data frame to file
write.table(theData, "allBanks.txt", sep="\t", row.names = FALSE)

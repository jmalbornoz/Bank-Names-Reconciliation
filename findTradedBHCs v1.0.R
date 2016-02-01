# Find publicly traded BHCs in FDICs data
#
# JM Albornoz
# January 2016
#

# clear everything
rm(list=ls(all=TRUE))

# invokes libraries
library(dplyr)
library(stringdist)

# invokes utility functions
source("utility1.R")

############################################################
############################################################

# reads list of publicly traded BHCs
theData <- read.csv("BHCsAndTickers.csv")
theDataC <- mutate(theData, sig = sapply(theData$names, clean1))  

# read FDIC's list of BHCs
BHCsList <- read.csv("ActiveNonMutual_short.csv", stringsAsFactors = FALSE)
BHCsList <- unique(BHCsList)
names(BHCsList) <- "names"

# pre-processes list of BHCs
BHCsListC <- mutate(BHCsList, sig = sapply(BHCsList$names, clean1))       # 4073 records

# eliminates duplicated BHCs
BHCsListC <- filter(BHCsListC, !duplicated(BHCsListC$sig))

# saves list of BHCs
write.table(BHCsListC, "BHC_List.csv", row.names = FALSE, col.names = FALSE, sep = ",")

# finds traded BHCs
tradedBHCs <- inner_join(BHCsListC, theDataC, by = "sig")

# BHCs whose names are not recognised
notRecognised <- anti_join(theDataC, tradedBHCs, by = "sig")

# find partial matches between the list of BHCs and list of not recognised BHCs
notRecognised <- mutate(notRecognised, parMatch = as.character(sapply(notRecognised$sig, ClosestMatch2, BHCsListC$sig)))
partials <- filter(notRecognised, !is.na(parMatch))

# finds corresponding BHCs
partialBHCs <- inner_join(theDataC, partials, by = "tickers")

# assembles resulting list of traded BHCs
tradedBHCs <- select(tradedBHCs, tickers)
partialBHCs <- select(partialBHCs, tickers)
tradedBHCs <- rbind(tradedBHCs, partialBHCs)

# list of traded BHCs
listOfTradedBHCs <- inner_join(tradedBHCs, theData, by = "tickers")

# saves list of traded BHCs
write.table(listOfTradedBHCs, "tradedBHCs.csv", row.names = FALSE, col.names = FALSE, sep = ",")

# the ones that did not match
notMatching <- filter(theData, !theData$tickers %in% listOfTradedBHCs$tickers)
write.table(notMatching, "notListed.csv", row.names = FALSE, col.names = FALSE, sep = ",")

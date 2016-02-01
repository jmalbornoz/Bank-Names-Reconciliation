# Get publicly traded BHCs from FDICs data
#
# JM Albornoz
# January 2016
#

# clear everything
rm(list=ls(all=TRUE))

# invokes library
library(dplyr)

############################################################
# this function takes a bank names and transforms it into a "signature" by
# converting to lowercase, sorting words, and eliminating blank spaces
signature=function(x){
    punct <- punct <- '[]\\?!\"\'#$%(){}+*/:;,._`|~\\[<=>@\\^]'
    x <- gsub(punct, "", x)            # removes punctuation except hyphen
    x <- gsub("Inc", "", x)            # removes "Inc"
    x <- gsub("Inc", "", x)            # removes "Inc"
    x <- gsub("Corp$", "", x)             # substitutes "Corp" for "" at the end of a line
    x <- gsub("Corporation", "", x)     # substitutes "Corporation" for "" 
    x <- gsub(" $", "", x)              # removes blanks at the end
    
    sig=paste(sort(unlist(strsplit(tolower(x)," "))),collapse='')
    return(sig)
}
############################################################

# reads list of publicly traded BHCs
theData <- read.csv("BHCsAndTickers.csv")

# read FDIC's list of active non-mutual bank holding companies
BHCsList <- read.csv("ActiveNonMutual_short.csv", stringsAsFactors = FALSE)
BHCsList <- unique(BHCsList)
names(BHCsList) <- "names"

# saves cleaned list of BHCs
write.table(BHCsList, "BHC_List.csv", row.names = FALSE, col.names = FALSE, sep = ",")

# adds signature to data
theDataC <- mutate(theData, sig = sapply(theData$names, signature))
BHCsListC <- mutate(BHCsList, sig = sapply(BHCsList$names, signature))

BHCsListC$names <- as.character(BHCsListC$names)
BHCsListC <- unique(BHCsListC)

# finds merge
inCommon <- inner_join(BHCsListC, theDataC, by = "names")

# finds those banks not in the merge
notInCommon <- anti_join(theDataC, inCommon, by = "names")




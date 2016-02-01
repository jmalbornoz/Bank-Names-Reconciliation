clean1 = function(z) {
    punct <- punct <- '[]\\?!\"\'#$%(){}+*/:;,._`|~\\[<=>@\\^]'
    z <- gsub(punct, "", z)             # removes punctuation except hyphen
    z <- gsub("Inc$", "", z)            # removes "Inc" at the end of a line
    z <- gsub("Inc ", "", z)            # removes "Inc"
    z <- gsub("Ltd$", "", z)            # substitutes "Ltd" for "" at the end of a line
    z <- gsub("Corp$", "Corporation", z)           # substitutes "Corp" for "Corporation" at the end of a line
    #z <- gsub("Corporation$", "", z)    # substitutes "Corporation" for "" at the end of a line
    #z <- gsub("Corporation ", "", z)    # substitutes "Corporation" for ""
    z <- gsub("Bancorporation$", "", z) # substitutes "Bancorporation" for "Bancorp" at the end of a line
    z <- gsub("Bancorporation ", "", z) # substitutes "Bancorporation" for "Bancorp"
    #z <- gsub("Bancorp$", "", z)        # substitutes "Bancorp" for "" at the end of a line
    #z <- gsub("Bancorp ", "", z)        # substitutes "Bancorp" for "" 
    #z <- gsub("Bank$", "", z)           # substitutes "Bank" for "" at the end of a line
    #z <- gsub("Bank ", "", z)           # substitutes "Bank" for ""
    #z <- gsub("Bancshares$", "", z)     # substitutes "Bancshares" for "" at the end of a line
    #z <- gsub("Bancshares ", "", z)     # substitutes "Bancshares" for ""
    #z <- gsub("Holdings$", "", z)       # substitutes "Holdings" for "" at the end of a line
    #z <- gsub("Holdings ", "", z)       # substitutes "Holdings" for ""
    #z <- gsub("Mhc$", "", z)            # substitutes "Mhc" for "" at the end of a line
    z <- gsub(" $", "", z)              # removes blanks at the end
    z <- gsub("  ", "", z)              # removes double blanks
    z <- tolower(z)                     # converts everything to lowercase
    z
}

ClosestMatch2 = function(string, stringVector){
    
    stringVector[amatch(string, stringVector, maxDist = 1)]
    
    
}

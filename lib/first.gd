##############################################################################
##
#W  first.gd                    GAP4 package `Utils'             Chris Wensley
##
##  version 0.14, 16/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

DeclareInfoClass( "InfoUtils" );

##  in order to prevent global functions which are being transferred to this 
##  package being declared twice, the function names are added to the following 
##  list, and a similar one in last.gd.  These lists are declared in oper.g. 

AllowGlobalRedeclaration( 
    "DifferencesList", 
    "QuotientsList", 
    "FloatQuotientsList",
    "SendEmail", 
    "EmailLogFile", 
    "DownloadFile",
    "BlankFreeString",
    "QuotesStripped", 
    "IntOrInfinityToLaTeX",
    "SetupCache", 
    "PutIntoCache", 
    "FetchFromCache",
    "SearchCycle",
    "AllSmoothIntegers",
    "ExponentOfPrime",
    "NextProbablyPrimeInt",
    "PrimeNumbersIterator",
    "AllProducts",
    "RestrictedPartitionsWithoutRepetitions" 
    ); 

AllowGlobalRebinding( 
    "AUTODOC_GetSuffix" 
    ); 

#############################################################################
##
#E  first.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

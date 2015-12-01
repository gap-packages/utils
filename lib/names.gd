##############################################################################
##
#W  names.gd                    GAP4 package `Utils'             Chris Wensley
##
##  version 0.12, 01/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

##  allow global functions which are being transferred to this package 
##  to be declared twice 

UTILS_FUNCTION_NAMES := 
  [ "DifferencesList", 
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
  ];

UTILS_FUNCTION_STATUS := ListWithIdenticalEntries( 
    Length( UTILS_FUNCTION_NAMES ), 0 ); 

#############################################################################
##
#E  names.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

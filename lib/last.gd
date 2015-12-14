##############################################################################
##
#W  last.gd                     GAP4 package `Utils'             Chris Wensley
##
##  version 0.13, 14/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

##  prevent global functions which are being transferred to this package 
##  being declared twice 

Append( UTILS_FUNCTION_OPERS, 
  [ DifferencesList, 
    QuotientsList, 
    FloatQuotientsList,
    SendEmail, 
    EmailLogFile, 
    DownloadFile,
    BlankFreeString,
    QuotesStripped, 
    IntOrInfinityToLaTeX,
    SetupCache, 
    PutIntoCache, 
    FetchFromCache,
    SearchCycle,
    AllSmoothIntegers,
    ExponentOfPrime,
    NextProbablyPrimeInt,
    PrimeNumbersIterator,
    AllProducts,
    RestrictedPartitionsWithoutRepetitions 
  ] ); 

len := Length( UTILS_FUNCTION_OPERS ); 
for i in [1..len] do 
    if not ( NameFunction( UTILS_FUNCTION_OPERS[i] ) 
             = UTILS_FUNCTION_NAMES[i] ) then 
        Error( "incompatible lists in first.gd and last.gd" ); 
    fi; 
od; 

#############################################################################
##
#E  last.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

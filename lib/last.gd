##############################################################################
##
#W  last.gd                     GAP4 package `Utils'             Chris Wensley
##
##  version 0.14, 16/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

##  prevent global functions which are being transferred to this package 
##  being declared twice 

AllowGlobalReinstallation(  
    DifferencesList, 
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
    ); 

len := Length( GLOBAL_REINSTALLATION_LIST ); 
for i in [1..len] do 
    if not ( NameFunction( GLOBAL_REINSTALLATION_LIST[i] ) 
             = GLOBAL_REDECLARATION_LIST[i] ) then 
        Error( "incompatible GLOBAL_RE...ATION_LISTs" ); 
    fi; 
od; 

#############################################################################
##
#E  last.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

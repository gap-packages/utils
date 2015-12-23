##############################################################################
##
#W  last.gd                     GAP4 package `Utils'             Chris Wensley
##
##  version 0.15, 18/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

##  prevent global functions which are being transferred to this package 
##  being declared twice 

##  global functions from ResClasses:
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
    NextProbablyPrimeInt,
    SetupCache, 
    PutIntoCache, 
    FetchFromCache
    ); 

##  global functions from RCWA:
AllowGlobalReinstallation( 
    SearchCycle,
    AllSmoothIntegers,
    ExponentOfPrime,
    PrimeNumbersIterator,
    RestrictedPartitionsWithoutRepetitions 
    ); 

Print( GLOBAL_REDECLARATION_LIST, "\n\n" ); 
if ( List( GLOBAL_REINSTALLATION_LIST, f -> NameFunction(f) ) 
     = GLOBAL_REDECLARATION_LIST ) then 
    Print( "redeclaration and reinstallation lists are consistent\n" ); 
else
    Error( "incompatible GLOBAL_RE...ATION_LISTs" ); 
fi; 

#############################################################################
##
#E  last.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

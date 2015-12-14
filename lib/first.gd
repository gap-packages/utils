##############################################################################
##
#W  first.gd                    GAP4 package `Utils'             Chris Wensley
##
##  version 0.13, 14/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

DeclareInfoClass( "InfoUtils" );

##  in order to prevent global functions which are being transferred to this 
##  package being declared twice, the function names are added to the following 
##  list, and a similar one in last.gd.  These lists are declared in oper.g. 

Append( UTILS_FUNCTION_NAMES, 
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
  ] ); 

len := Length( UTILS_FUNCTION_NAMES ); 
Append( UTILS_FUNCTION_COUNT, ListWithIdenticalEntries( len, 0 ) ); 
for pos in [1..len] do 
    name := UTILS_FUNCTION_NAMES[pos]; 
    if ISBOUND_GLOBAL(name) then 
        UTILS_FUNCTION_COUNT[pos] := 1; 
    fi; 
od;

#############################################################################
##
#E  first.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

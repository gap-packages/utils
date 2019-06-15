##############################################################################
##
#W  record.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2019, The GAP Group 
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 7.1.1 
gap> r := rec( a := 1, b := 2, c := 3 );;                                      
gap> AssignGlobals( r );
The following global variables have been assigned:
[ "a", "b", "c" ]
gap> [ a, b, c ];
[ 1, 2, 3 ]

#@local  r, defaults

##############################################################################
##
#W  record.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2022, The GAP Group 
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

## SubSection 7.2.1 
gap> defaults := rec( a := 1, b := 2, c := 3 );;
gap> OptionRecordWithDefaults( defaults, rec( a := 6) );
rec( a := 6, b := 2, c := 3 )
gap> OptionRecordWithDefaults( defaults, rec( b := 7, c := 8 ) );
rec( a := 1, b := 7, c := 8 )
gap> OptionRecordWithDefaults( defaults, [ ] );
rec( a := 1, b := 2, c := 3 )
gap> OptionRecordWithDefaults( defaults, [ rec( c := 8 ) ] );
rec( a := 1, b := 2, c := 8 )
gap> OptionRecordWithDefaults( defaults, rec( d := 9 ) );
Error, Unknown option: d
gap> OptionRecordWithDefaults( defaults, [ rec( b := 7 ), rec( c := 8 ) ] );
Error, Too many arguments for function
gap> OptionRecordWithDefaults( defaults, 5 );
Error, Options should be a record
gap> OptionRecordWithDefaults( defaults, [6,7,8] );
Error, Too many arguments for function

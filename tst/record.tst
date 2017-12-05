##############################################################################
##
#W  record.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2017, The GAP Group 
##  

gap> UtilsLoadingComplete;
true

## SubSection 2.1.1 

gap> r := rec( a := 1, b := 2 );                                      
rec( a := 1, b := 2 )
gap> SetIfMissing( r, "c", 3 );
gap> names := RecNames( r );;
gap> Set( names );
[ "a", "b", "c" ]
gap> SetIfMissing( r, "c", 4 );
gap> r;
rec( a := 1, b := 2, c := 3 )

## SubSection 2.1.1 
gap> AssignGlobals( r );
The following global variables have been assigned:
[ "a", "b", "c" ]
gap> [ a, b, c ];
[ 1, 2, 3 ]

#############################################################################
##
#E  record.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

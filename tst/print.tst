#@local  L, s5

##############################################################################
##
#W  print.tst                   Utils Package                    
##
#Y  Copyright (C) 2015-2022, The GAP Group
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 2.1.1 
gap> L := List( [1..20], n -> n^5 );;
gap> PrintSelection( L, [18..20] );
18 : 1889568
19 : 2476099
20 : 3200000
gap> PrintSelection( L, 2, 9 );       
2 : 32
11 : 161051
20 : 3200000
gap> PrintSelection( L, 2, 3, 11 );
2 : 32
5 : 3125
8 : 32768
11 : 161051
gap> s5 := SymmetricGroup( 5 );;
gap> PrintSelection( s5, [30,31,100,101] );
30 : (1,5)(3,4)
31 : (1,5,2)
100 : (1,4,3)
101 : (1,4)(3,5)
gap> PrintSelection( s5, 1, 30 );
1 : ()
31 : (1,5,2)
61 : (1,2,3)
91 : (1,3,5,2,4)
gap> PrintSelection( s5, 9, 11, 43 );
9 : (2,5,3)
20 : (2,4)
31 : (1,5,2)
42 : (1,5,2,3,4)

#############################################################################
##
#E  print.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

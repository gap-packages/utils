#@local  C, c4, d16, gens, i, J, K, L, n, P, trans

##############################################################################
##
#W  lists.tst                   Utils Package                    
##
#Y  Copyright (C) 2015-2022, The GAP Group
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 3.1.1 
gap> List( [1..12], n->n^3 );
[ 1, 8, 27, 64, 125, 216, 343, 512, 729, 1000, 1331, 1728 ]
gap> DifferencesList( last );
[ 7, 19, 37, 61, 91, 127, 169, 217, 271, 331, 397 ]
gap> DifferencesList( last );
[ 12, 18, 24, 30, 36, 42, 48, 54, 60, 66 ]
gap> DifferencesList( last );
[ 6, 6, 6, 6, 6, 6, 6, 6, 6 ]
gap> L := [ 0 ];;         
gap> DifferencesList( L );
[  ]
gap> L := [ ];;           
gap> DifferencesList( L );
[  ]

## SubSection 3.1.2 
gap> List( [0..10], n -> Factorial(n) );
[ 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800 ]
gap> QuotientsList( last );
[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
gap> L := [ 1, 3, 5, -1, -3, -5 ];;
gap> QuotientsList( L );
[ 3, 5/3, -1/5, 3, 5/3 ]
gap> FloatQuotientsList( L );
[ 3., 1.66667, -0.2, 3., 1.66667 ]
gap> QuotientsList( [ 2, 1, 0, -1, -2 ] );
[ 1/2, 0, fail, 2 ]
gap> FloatQuotientsList( [1..10] );
[ 2., 1.5, 1.33333, 1.25, 1.2, 1.16667, 1.14286, 1.125, 1.11111 ]
gap> Product( last );
10.

## SubSection 3.1.3 
gap> L := [1..20];;  L[1]:=13;;                                              
gap> for i in [1..19] do                                                     
>        if IsOddInt(L[i]) then L[i+1]:=3*L[i]+1; else L[i+1]:=L[i]/2; fi;
>    od;                                                                  
gap> L;                                                                      
[ 13, 40, 20, 10, 5, 16, 8, 4, 2, 1, 4, 2, 1, 4, 2, 1, 4, 2, 1, 4 ]
gap> SearchCycle( L );                                                       
[ 1, 4, 2 ]
gap> n := 1;;  L := [n];;
gap> for i in [1..100] do  n:=(n^2+1) mod 1093;  Add(L,n);  od;
gap> L; 
[ 1, 2, 5, 26, 677, 363, 610, 481, 739, 715, 795, 272, 754, 157, 604, 848, 
  1004, 271, 211, 802, 521, 378, 795, 272, 754, 157, 604, 848, 1004, 271, 
  211, 802, 521, 378, 795, 272, 754, 157, 604, 848, 1004, 271, 211, 802, 521, 
  378, 795, 272, 754, 157, 604, 848, 1004, 271, 211, 802, 521, 378, 795, 272, 
  754, 157, 604, 848, 1004, 271, 211, 802, 521, 378, 795, 272, 754, 157, 604, 
  848, 1004, 271, 211, 802, 521, 378, 795, 272, 754, 157, 604, 848, 1004, 
  271, 211, 802, 521, 378, 795, 272, 754, 157, 604, 848, 1004 ]
gap> C := SearchCycle( L );
[ 157, 604, 848, 1004, 271, 211, 802, 521, 378, 795, 272, 754 ]
gap> P := Positions( L, 157 );
[ 14, 26, 38, 50, 62, 74, 86, 98 ]
gap> Length( C );  DifferencesList( P );
12
[ 12, 12, 12, 12, 12, 12, 12 ]

## SubSection 3.1.4 
## this manual example not tested as answers vary from run to run 
## gap> RandomCombination( [1..49], 6 );
## [ 3, 5, 21, 24, 27, 31 ]


## SubSection 3.2.1 
gap> J := [ [1,2,3], [3,4], [3,4], [1,2,4] ];;
gap> DistinctRepresentatives( J );
[ 1, 3, 4, 2 ]
gap> K := [ [3,4], [1,2], [2,3], [2,3,4] ];;
gap> CommonRepresentatives( J, K );
[ [ 3, 3, 3, 1 ], [ 1, 3, 4, 2 ] ]
gap> d16 := DihedralGroup( IsPermGroup, 16 );  SetName( d16, "d16" );
Group([ (1,2,3,4,5,6,7,8), (2,8)(3,7)(4,6) ])
gap> c4 := Subgroup( d16, [ d16.1^2 ] );  SetName( c4, "c4" );
Group([ (1,3,5,7)(2,4,6,8) ])
gap> RightCosets( d16, c4 );
[ RightCoset(c4,()), RightCoset(c4,(2,8)(3,7)(4,6)), RightCoset(c4,(1,8,7,6,5,
   4,3,2)), RightCoset(c4,(1,8)(2,7)(3,6)(4,5)) ]
gap> trans := CommonTransversal( d16, c4 );
[ (), (2,8)(3,7)(4,6), (1,2,3,4,5,6,7,8), (1,2)(3,8)(4,7)(5,6) ]
gap> IsCommonTransversal( d16, c4, trans );
true

## SubSection 3.3.1 
gap> gens := GeneratorsOfGroup( DihedralGroup(12) );
[ f1, f2, f3 ]
gap> String( gens );                                
"[ f1, f2, f3 ]"
gap> BlankFreeString( gens );                       
"[f1,f2,f3]"

#############################################################################
##
#E  lists.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

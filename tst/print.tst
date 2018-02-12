##############################################################################
##
#W  print.tst                   Utils Package                    
##
#Y  Copyright (C) 2015-2018, The GAP Group
##  

gap> UtilsLoadingComplete;
true

## SubSection 2.1.1 
gap> s3 := SymmetricGroup( 3 );; 
gap> L := KnownPropertiesOfObject( GeneratorsOfGroup( s3 ) );;
gap> L0 := [ "IsFinite", "IsSmallList", "IsGeneratorsOfMagmaWithInverses", 
>            "IsGeneratorsOfSemigroup", "IsSubsetLocallyFiniteGroup" ];; 
gap> ForAll( L0, x -> x in L );
true
gap> PrintOneItemPerLine( L0 );
[ IsFinite,
  IsSmallList,
  IsGeneratorsOfMagmaWithInverses,
  IsGeneratorsOfSemigroup,
  IsSubsetLocallyFiniteGroup ]
gap> PrintOneItemPerLine( s3 ); 
()
(2,3)
(1,3)
(1,3,2)
(1,2,3)
(1,2)

## SubSection 2.1.2 
gap> L := List( [1..20], n -> n^5 );; 
gap> PrintSelection( L, 1, 8 );
1 : 1
9 : 59049
17 : 1419857
gap> PrintSelection( L, [9..11] );
9 : 59049
10 : 100000
11 : 161051
gap> s5 := SymmetricGroup( 5 );; 
gap> PrintSelection( s5, 12, 30 );
12 : (2,5)(3,4)
42 : (1,5,2,3,4)
72 : (1,2,4,3)
102 : (1,4,3,5)
gap> PrintSelection( s5, [118..122] );
118 : (1,4,3,2,5)
119 : (1,4,2,5,3)
120 : (1,4,3)(2,5)
gap> f2 := FreeGroup( 2 );; 
gap> PrintSelection( f2, 20, 20, 100 ); 
20 : f2*f1^2
40 : f2*f1*f2
60 : f1*f2*f1^2
80 : (f2*f1)^2
100 : f1*f2^2*f1^-1
gap> PrintSelection( f2, [11..15] );
11 : f2^-1*f1^-1
12 : f1*f2
13 : f1^-1*f2
14 : f1*f2^-1
15 : f1^-1*f2^-1

#############################################################################
##
#E  lists.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

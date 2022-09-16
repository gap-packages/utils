#@local  i, iter, n, p, sum

##############################################################################
##
#W  number.tst                 Utils Package                       Stefan Kohl
##
#Y  Copyright (C) 2015-2022, The GAP Group
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 4.1.1 
gap> AllSmoothIntegers( 3, 1000 );
[ 1, 2, 3, 4, 6, 8, 9, 12, 16, 18, 24, 27, 32, 36, 48, 54, 64, 72, 81, 96, 
  108, 128, 144, 162, 192, 216, 243, 256, 288, 324, 384, 432, 486, 512, 576, 
  648, 729, 768, 864, 972 ]
gap> AllSmoothIntegers( [5,11,17], 1000 );
[ 1, 5, 11, 17, 25, 55, 85, 121, 125, 187, 275, 289, 425, 605, 625, 935 ]
gap> Length( last );
16
gap> List( [3..20], n -> Length( AllSmoothIntegers( [5,11,17], 10^n ) ) );
[ 16, 29, 50, 78, 114, 155, 212, 282, 359, 452, 565, 691, 831, 992, 1173, 
  1374, 1595, 1843 ]

## SubSection 4.1.2 
gap> AllProducts([1..4],3); 
[ 1, 2, 3, 4, 2, 4, 6, 8, 3, 6, 9, 12, 4, 8, 12, 16, 2, 4, 6, 8, 4, 8, 12, 
  16, 6, 12, 18, 24, 8, 16, 24, 32, 3, 6, 9, 12, 6, 12, 18, 24, 9, 18, 27, 
  36, 12, 24, 36, 48, 4, 8, 12, 16, 8, 16, 24, 32, 12, 24, 36, 48, 16, 32, 
  48, 64 ]
gap> Set(last);            
[ 1, 2, 3, 4, 6, 8, 9, 12, 16, 18, 24, 27, 32, 36, 48, 64 ]
gap> AllProducts( [(1,2,3),(2,3,4)], 2 );
[ (2,4,3), (1,2)(3,4), (1,3)(2,4), (1,3,2) ]

## SubSection 4.1.3 
gap> RestrictedPartitions( 20, [4..10] );
[ [ 4, 4, 4, 4, 4 ], [ 5, 5, 5, 5 ], [ 6, 5, 5, 4 ], [ 6, 6, 4, 4 ], 
  [ 7, 5, 4, 4 ], [ 7, 7, 6 ], [ 8, 4, 4, 4 ], [ 8, 6, 6 ], [ 8, 7, 5 ], 
  [ 8, 8, 4 ], [ 9, 6, 5 ], [ 9, 7, 4 ], [ 10, 5, 5 ], [ 10, 6, 4 ], 
  [ 10, 10 ] ]
gap> RestrictedPartitionsWithoutRepetitions( 20, [4..10] );
[ [ 10, 6, 4 ], [ 9, 7, 4 ], [ 9, 6, 5 ], [ 8, 7, 5 ] ]
gap> RestrictedPartitionsWithoutRepetitions( 10^2, List([1..10], n->n^2 ) );
[ [ 100 ], [ 64, 36 ], [ 49, 25, 16, 9, 1 ] ]

## SubSection 4.1.4 
gap> n := 2^251;;
gap> NextProbablyPrimeInt( n );
3618502788666131106986593281521497120414687020801267626233049500247285301313

## SubSection 4.1.6 
gap> iter := PrimeNumbersIterator();;
gap> for i in [1..100] do  p := NextIterator(iter);  od;
gap> p;
541
gap> sum := 0;;
gap> ## "prime number race" 1 vs. 3 mod 4
gap> for p in PrimeNumbersIterator() do 
>       if p <> 2 then sum := sum + E(4)^(p-1); fi;
>       if sum > 0 then break; fi;
>    od;
gap> p;
26861 

## this final example takes quite a while: use examples/number.g 
## gap> sum := 0;;
## gap> ## "prime number race" 1 vs. 5 mod 8
## gap> for p in PrimeNumbersIterator() do 
## >       if p mod 8 in [1,5] then sum := sum + E(4)^((p-1)/2); fi;
## >       if sum > 0 then break; fi;
## >    od;
## gap> p;
## 588067889

#############################################################################
##
#E  number.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

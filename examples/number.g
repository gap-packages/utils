##############################################################################
##
#W  number.g                   Utils Package                       Stefan Kohl
##
#Y  Copyright (C) 2015-2017, The GAP Group
##  

## some of these examples are considered to take too long to include in a test 

## SubSection 3.1.1 
Print( AllSmoothIntegers( 3, 1000 ), "\n" );
all := AllSmoothIntegers( [5,11,17], 1000 ); 
Print( all, "\n", Length( all ), "\n" );
Print( List( [3..20], n -> Length(AllSmoothIntegers([5,11,17],10^n) ) ), "\n" );

## SubSection 3.1.2 
all := AllProducts([1..4],3); 
Print( all, "\n", Set(all), "\n" );            
Print( AllProducts( [(1,2,3),(2,3,4)], 2 ), "\n" );

## SubSection 3.1.3 
Print( RestrictedPartitions( 20, [4..10] ), "\n" );
Print( RestrictedPartitionsWithoutRepetitions( 20, [4..10] ), "\n" );
Print( RestrictedPartitionsWithoutRepetitions(10^2,List([1..10],n->n^2)), "\n");

## SubSection 3.1.4 
Print( ExponentOfPrime( 13577531, 11 ), "\n" ); 
Print( List( [1..40], n -> ExponentOfPrime( 3^n-1, 2 ) ), "\n" );
Print( List( [1..40], n -> ExponentOfPrime( n^2-1, 2 ) ), "\n" );

## SubSection 3.1.5 
n := 2^251;;
Print( NextProbablyPrimeInt( n ), "\n" );

## SubSection 3.1.6 
iter := PrimeNumbersIterator();;
for i in [1..100] do  p := NextIterator(iter);  od;
Print( p, "\n" );

## "prime number race" 1 vs. 3 mod 4
sum := 0;;
for p in PrimeNumbersIterator() do 
    if p <> 2 then sum := sum + E(4)^(p-1); fi;
    if sum > 0 then break; fi;
od;
Print( p, "\n" );

## "prime number race" 1 vs. 5 mod 8
sum := 0;;
for p in PrimeNumbersIterator() do 
    if p mod 8 in [1,5] then sum := sum + E(4)^((p-1)/2); fi;
    if sum > 0 then break; fi;
od;
Print( p, "\n" ); 

#############################################################################
##
#E  number.g  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

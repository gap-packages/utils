#@local  A, e1

##############################################################################
##
#W  algebras.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2022, The GAP Group 
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 8.1.1 
gap> A := MatrixAlgebra( Rationals, 2 );
( Rationals^[ 2, 2 ] )
gap> e1 := AlgebraHomomorphismByFunction( Rationals, A, f -> [[f,0],[0,0]] );
MappingByFunction( Rationals, ( Rationals^[ 2, 2 ] ), function( f ) ... end )
gap> 11^e1;
[ [ 11, 0 ], [ 0, 0 ] ]

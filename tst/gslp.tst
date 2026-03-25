#@local prg, data
############################################################################
##
#W  gslp.tst                   Utils Package                   Thomas Breuer
##
#Y  Copyright (C) 2026, The GAP Group
##
gap> START_TEST( "gslp.tst" );

#
gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

# test inconsistent input for `GeneralizedStraightLineProgram`
gap> GeneralizedStraightLineProgram( "union", [[[1,2]]], 1 );
Error, usage: GeneralizedStraightLineProgram( <lines>[, <nrgens>] ) or General\
izedStraightLineProgram( <kind>, <list> )
gap> GeneralizedStraightLineProgram( "union", [] );
Error, <list> must be a nonempty list
gap> GeneralizedStraightLineProgram( "union",
>        [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 2 ] ] );
Error, all entries of <list> must have the same input number
gap> GeneralizedStraightLineProgram( "compose",
>        [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 2 ] ] );
Error, inputs and outputs for <list> are not compatible
gap> GeneralizedStraightLineProgram( "other", [[[1,2]]] );
Error, <kind> must be one of "union", "compose"

# test cases of `NrOutputsOfGeneralizedStraightLineProgram`
gap> prg:= StraightLineProgram( [ [1,2,2,3], [3,-1] ], 2 );;
gap> NrOutputsOfGeneralizedStraightLineProgram( prg );
1

# test `false` cases of `IsInternallyConsistent`
gap> prg:= GeneralizedStraightLineProgram( "compose",
>              [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );;
gap> ResetFilterObj( prg, HasNrInputsOfGeneralizedStraightLineProgram );
gap> SetNrInputsOfGeneralizedStraightLineProgram( prg, 3 );
gap> IsInternallyConsistent( prg );
false
gap> data:= ShallowCopy( DataOfGeneralizedStraightLineProgram( prg ) );;
gap> data[1]:= "other";;
gap> ResetFilterObj( prg, HasDataOfGeneralizedStraightLineProgram );
gap> SetDataOfGeneralizedStraightLineProgram( prg, data );
gap> IsInternallyConsistent( prg );
false

# `ViewString` and `String`
gap> ViewString( StraightLineProgram( [[[1,2]]], 1 ) );
"<straight line program>"
gap> ViewString( GeneralizedStraightLineProgram( "union", [ [[[1,2]]] ] ) );
"<generalized straight line program>"
gap> String( StraightLineProgram( [[[1,2]]], 1 ) );
"StraightLineProgram( [ [ [ 1, 2 ] ] ], 1 )"
gap> String( GeneralizedStraightLineProgram( "union", [ [[[1,2]]] ] ) );
"GeneralizedStraightLineProgram( \"union\", [ StraightLineProgram( [ [ 1, 2 ] \
], 1 ) ] )"

#
gap> STOP_TEST( "gslp.tst" );

##############################################################################
##
#W  lcset.gi                 GAP4 package `Utils'                Chris Wensley
##
#Y  Copyright (C) 2015-2022, The GAP Group 

#############################################################################
##
#O  LeftCoset( <g>, <U> ) . . . . . . . . forms a left coset of U by g \in G 
##
InstallMethod( LeftCoset, "generic method for left cosets", true, 
    [ IsObject, IsGroup ], 0,
function( g, U )
    local lc;

    lc := rec();
    ObjectifyWithAttributes( lc, IsLeftCosetType,
        Representative, g,
        ActingDomain, U, 
        IsLeftCoset, true );
    return lc;
end);

#############################################################################
##
#A  AsociatedRightCoset( <lc> ) . . . . . forms a right coset of U by g \in G 
#A  AsociatedLeftCoset( <lc> ) . . . . . . forms a left coset of U by g \in G 
##
InstallMethod( AssociatedRightCoset, "generic method for left cosets", true, 
    [ IsLeftCoset ], 0,
function( lc )
    local g, U, rc; 
    g := Representative( lc ); 
    U := ActingDomain( lc ); 
    rc := RightCoset( U, g^-1 ); 
    SetAssociatedLeftCoset( rc, lc ); 
    return rc;
end); 

InstallMethod( AssociatedLeftCoset, "generic method for right cosets", true, 
    [ IsRightCoset ], 0,
function( rc )
    local g, U, lc; 
    g := Representative( rc ); 
    U := ActingDomain( rc ); 
    lc := LeftCoset( g^-1, U ); 
    SetAssociatedRightCoset( lc, rc ); 
    return lc;
end); 

InstallMethod( PrintString, "for a left coset", true, [ IsLeftCosetObj ], 0,
function( d )
    return STRINGIFY( "LeftCoset(\<",
                      PrintString( Representative(d) ), ",\>",
                      PrintString( ActingDomain(d) ), ")" );
end);

InstallMethod( PrintObj, "for a left coset", true, [ IsLeftCosetObj ], 0,
function( d )
    Print( PrintString( d ) );
end);

InstallMethod( ViewString, "for a left coset", true, [ IsLeftCosetObj ], 0,
function( d )
    return STRINGIFY( "LeftCoset(\<",
                      ViewString( Representative(d) ), ",\>",
                      ViewString( ActingDomain(d) ), ")" );
end);

InstallMethod( ViewObj, "for a left coset", true, [ IsLeftCosetObj ], 0,
function( d )
    Print( ViewString( d ) );
end);

InstallMethod( \=, "for two left cosets", IsIdenticalObj,
    [ IsLeftCoset, IsLeftCoset ], 0,
function( lc1, lc2 ) 
    return AssociatedRightCoset( lc1 ) = AssociatedRightCoset( lc2 ); 
end);

InstallMethod( \in, "element and LeftCoset", true,
    [ IsMultiplicativeElementWithInverse, IsLeftCoset ], 100,
function( g, lc )
    Print( "Hey, hey!  The method for \in in lcset.gi is being called!\n" ); 
    return g^-1 in AssociatedRightCoset( lc );
end);

InstallOtherMethod( \*, "element and LeftCoset", true,
    [ IsMultiplicativeElementWithInverse, IsLeftCoset ], 0,
function( g, lc )
    return LeftCoset( g * Representative( lc ), ActingDomain( lc ) );
end);

InstallMethod( Size, "for a left coset", true, [ IsLeftCoset ], 0,
function( lc ) 
    return Size( AssociatedRightCoset( lc ) ); 
end);

InstallOtherMethod( IsBiCoset, "for a left coset", true, [ IsLeftCoset ], 0,
function( lc ) 
    return IsBiCoset( AssociatedRightCoset( lc ) ); 
end);

InstallOtherMethod( AsSet, "for a left coset", true, [ IsLeftCoset ], 0,
function( lc ) 
    local L; 
    L := AsSet( AssociatedRightCoset( lc ) ); 
    return Set( L, g -> g^-1 ); 
end);

InstallOtherMethod( Intersection2, "for two left cosets", true, 
    [ IsLeftCoset, IsLeftCoset ], 0,
function( lc1, lc2 ) 
    local L; 
    L := Intersection2( AssociatedRightCoset( lc1 ),
                        AssociatedRightCoset( lc2 ) ); 
    return Set( L, g -> g^-1 ); 
end);

#############################################################################
##
#F  LeftCosets( <G> <U> ) . . . . . . . . . . . . left cosets of U by g \in G 
#O  LeftCosetsNC( <G> <U> ) . . . . . . . . . . . left cosets of U by g \in G 
##
InstallGlobalFunction( LeftCosets, function( G, U )
    if not IsSubset( G, U ) then
        Error("not contained");
    fi;
    return LeftCosetsNC( G, U );
end );

InstallMethod( LeftCosetsNC, "generic", IsIdenticalObj, [ IsGroup, IsGroup ], 0,
function( G, U )
    local L; 
    L := RightCosetsNC( G, U ); 
    return List( L, rc -> AssociatedLeftCoset( rc ) ); 
end);



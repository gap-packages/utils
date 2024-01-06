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
    local lc, fam;

    fam := FamilyObj( U );
    if not IsBound( fam!.leftCosetsDefaultType ) then
        fam!.leftCosetsDefaultType := 
            NewType( fam, IsLeftCosetDefaultRep and HasActingDomain 
                     and HasFunctionAction and HasRepresentative );
    fi;
    lc := rec();
    ObjectifyWithAttributes( lc, fam!.leftCosetsDefaultType,
        Representative, g,
        ActingDomain, U, 
        FunctionAction, OnLeftInverse, 
        IsLeftCoset, true ); 
    if HasSize( U ) then 
        SetSize( lc, Size( U ) ); 
    fi; 
    return lc;
end);

#############################################################################
##
#A  Inverse( <lc> ) . . . . . forms the right coset Ug^-1 corresponding to gU
#A  Inverse( <rc> ) . . . . . forms the left coset g^-1U corresponding to Ug 
##
InstallOtherMethod( Inverse, "generic method for left cosets", true, 
    [ IsLeftCoset ], 0,
function( lc )
    local g, U, rc; 
    g := Representative( lc ); 
    U := ActingDomain( lc ); 
    rc := RightCoset( U, g^-1 ); 
    SetInverse( rc, lc ); 
    return rc;
end); 

InstallOtherMethod( Inverse, "generic method for right cosets", true, 
    [ IsRightCoset ], 0,
function( rc )
    local g, U, lc; 
    g := Representative( rc ); 
    U := ActingDomain( rc ); 
    lc := LeftCoset( g^-1, U ); 
    SetInverse( lc, rc ); 
    return lc;
end); 

InstallMethod( PrintString, "for a left coset", true, [ IsLeftCoset ], 0,
function( d )
    return STRINGIFY( "LeftCoset(\<",
                      PrintString( Representative(d) ), ",\>",
                      PrintString( ActingDomain(d) ), ")" );
end);

InstallMethod( PrintObj, "for a left coset", true, [ IsLeftCoset ], 0,
function( d )
    Print( PrintString( d ) );
end);

InstallMethod( ViewString, "for a left coset", true, [ IsLeftCoset ], 0,
function( d )
    return STRINGIFY( "LeftCoset(\<",
                      ViewString( Representative(d) ), ",\>",
                      ViewString( ActingDomain(d) ), ")" );
end);

InstallMethod( ViewObj, "for a left coset", true, [ IsLeftCoset ], 0,
function( d )
    Print( ViewString( d ) );
end);

InstallMethod( \=, "for two left cosets", IsIdenticalObj,
    [ IsLeftCoset, IsLeftCoset ], 0,
function( lc1, lc2 )  
    return ( ActingDomain( lc1 ) = ActingDomain( lc2 ) ) and 
           ( Representative(lc1)/Representative(lc2) in ActingDomain( lc1 ) );
end);

InstallMethod( \in, "element and LeftCoset", true,
    [ IsMultiplicativeElementWithInverse, IsLeftCoset ], 100,
function( g, lc )
    return ( Representative(lc)^-1 * g ) in ActingDomain( lc );
end);

InstallOtherMethod( \*, "element and LeftCoset", true,
    [ IsMultiplicativeElementWithInverse, IsLeftCoset ], 0,
function( g, lc )
    return LeftCoset( g * Representative( lc ), ActingDomain( lc ) );
end);

InstallOtherMethod( \^, "LeftCoset and element", true,
    [ IsLeftCoset, IsMultiplicativeElementWithInverse ], 0,
function( lc, g ) 
    return g^-1 * lc; 
end);

InstallMethod( Size, "for a left coset", true, [ IsLeftCoset ], 0,
function( lc ) 
    return Size( ActingDomain( lc ) ); 
end);

InstallOtherMethod( IsBiCoset, "for a left coset", true, [ IsLeftCoset ], 0,
function( lc ) 
    return IsBiCoset( Inverse( lc ) ); 
end);

InstallOtherMethod( AsSet, "for a left coset", true, [ IsLeftCoset ], 0,
function( lc ) 
    local L; 
    L := AsSet( Inverse( lc ) ); 
    return Set( L, g -> g^-1 ); 
end);

InstallOtherMethod( Intersection2, "for two left cosets", true, 
    [ IsLeftCoset, IsLeftCoset ], 0,
function( lc1, lc2 ) 
    local L; 
    L := Intersection2( Inverse( lc1 ), Inverse( lc2 ) ); 
    return Set( L, g -> g^-1 ); 
##    return Inverse( L );        to be used once 4r12 is out 
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
    return List( L, Inverse ); 
end);



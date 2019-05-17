#############################################################################
##
#W  maps.gi                  GAP4 package `Utils'                 Stefan Kohl 
##                                                              Chris Wensley
#Y  Copyright (C) 2015-2019, The GAP Group 

#############################################################################
##
#F  EpimorphismByGenerators( <D1>, <D2> ) . epi: gen's of <D1>->gen's of <D2>
##
InstallMethod( EpimorphismByGenerators, "for groups", ReturnTrue, 
    [ IsGroup, IsGroup ], 0, 

function( G, H )
    if not ( IsFreeGroup( G ) ) then 
      Print( "Warning: calling GroupHomomorphismByImagesNC without checks\n" );
    fi; 
    
return GroupHomomorphismByImagesNC( G, H, GeneratorsOfGroup(G),
                                              GeneratorsOfGroup(H) );
end );

##############################################################################
##
#M  Pullback . . . . . . . . . for two group homomorphisms with a common range
##
InstallMethod( Pullback, "for two group homomorphisms", true, 
    [ IsGroupHomomorphism, IsGroupHomomorphism ], 0,
function( nu, mu )

    local M, N, P, NxM, projM, pmu, projN, pnu, genNxM, e, genL, L, 
          imphi, phi, impsi, psi, info; 

    M := Source( mu ); 
    P := Range( mu ); 
    N := Source( nu ); 
    if not ( Range(nu) = P ) then 
        Error( "homs nu,mu should have a common range" );
    fi; 
    NxM := DirectProduct( N, M ); 
    genNxM := GeneratorsOfGroup( NxM ); 
    projN := Projection( NxM, 1 ); 
    pnu := projN * nu; 
    projM := Projection( NxM, 2 ); 
    pmu := projM * mu; 
    if IsFinite( NxM ) then 
        genL := [ ]; 
        L := Subgroup( NxM, [ One(NxM) ] ); 
        for e in NxM do 
            if ImageElm( pnu, e ) = ImageElm( pmu, e ) then 
                if not ( e in L ) then 
                    Add( genL, e ); 
                    L := Group( genL );
                fi;
            fi; 
        od;
    else 
        return fail; 
    fi;
    imphi := List( genL, g -> ImageElm( projN, g ) ); 
    phi := GroupHomomorphismByImages( L, N, genL, imphi ); 
    impsi := List( genL, g -> ImageElm( projM, g ) ); 
    psi := GroupHomomorphismByImages( L, M, genL, impsi ); 
    info := rec( directProduct := NxM, projections := [phi,psi] ); 
    SetPullbackInfo( L, info ); 
    return L;
end ); 

##############################################################################
##
#M  AllIsomorphismsIterator . . . . . . for a list containing a pair of groups  
#M  AllIsomorphismsNumber . . . . . . . . . . . . . . . . for a pair of groups  
#M  AllIsomorphisms . . . . . . . . . . . . . . . . . . . for a pair of groups  
##
BindGlobal( "NextIterator_AllIsomorphisms", function ( iter ) 
    local a; 
    if not IsDoneIterator( iter ) then 
        a := NextIterator( iter!.autoIterator ); 
        return CompositionMapping( iter!.firstiso, a ); 
    fi;
    Error( "iterator is exhausted" );
end ); 

BindGlobal( "IsDoneIterator_AllIsomorphisms", 
    iter -> IsDoneIterator( iter!.autoIterator ) ); 

BindGlobal( "ShallowCopy_AllIsomorphisms", 
    iter -> rec( firstiso := iter!.firstiso, 
             autoIterator := ShallowCopy( iter!.autoIterator ) ) ); 

BindGlobal( "DoAllIsomorphismsIterator", 
function( arg )

    local G, H, iso, autoiter, iter;

    G := arg[1][1]; 
    H := arg[1][2];
    if not IsGroup( G ) and IsGroup( H ) then 
       return fail; 
    fi; 
    iso := IsomorphismGroups( G, H ); 
    if ( iso = fail ) then 
        return fail; 
    fi;
    autoiter := Iterator( AutomorphismGroup( G ) ); 
    iter := IteratorByFunctions( 
        rec(  firstiso := iso,
          autoIterator := ShallowCopy( autoiter ), 
          NextIterator := NextIterator_AllIsomorphisms, 
        IsDoneIterator := IsDoneIterator_AllIsomorphisms, 
           ShallowCopy := ShallowCopy_AllIsomorphisms ) ); 
    return iter;
end );

InstallMethod( AllIsomorphismsIterator, "for a list of a pair of groups", 
    [ IsList ], 0, arg -> DoAllIsomorphismsIterator( arg ) ); 

InstallMethod( AllIsomorphismsIterator, "for a pair of groups", 
    [ IsGroup, IsGroup ], 0, 
function( G, H ); 
    return AllIsomorphismsIterator( [G,H] ); 
end );  

InstallMethod( AllIsomorphisms, "for a pair of groups", 
    [ IsGroup, IsGroup ], 0, 
function( G, H ) 

    local iter, L, iso; 

    iter := AllIsomorphismsIterator( [G,H] );
    if ( iter = fail ) then 
        return [ ];
    fi;    
    L := [ ];
    for iso in iter do 
       Add( L, iso ); 
    od;
    return L; 
end ); 

InstallMethod( AllIsomorphisms, "for a list of a pair of groups", 
    [ IsList ], 0, 
function( L ) 
    if not ( Length( L ) = 2 ) then 
        return fail; 
    fi; 
    return AllIsomorphisms( L[1], L[2] ); 
end ); 

InstallMethod( AllIsomorphismsNumber, "for a pair of groups", 
    [ IsGroup, IsGroup ], 0, 
function( G, H ) 

    local iter, n, iso; 

    iter := AllIsomorphismsIterator( [G,H] );
    if ( iter = fail ) then 
        return 0;
    fi;    
    n := 0;
    for iso in iter do 
        n := n+1; 
    od;
    return n; 
end ); 

InstallMethod( AllIsomorphismsNumber, "for a list of a pair of groups", 
    [ IsList ], 0, 
function( L ) 
    if not ( Length(L) = 2 ) then 
        return fail; 
    fi; 
    return AllIsomorphismsNumber( L[1], L[2] ); 
end );

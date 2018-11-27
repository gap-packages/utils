#############################################################################
##
#W  maps.gi                  GAP4 package `Utils'                 Stefan Kohl 
##                                                              Chris Wensley
##
#Y  Copyright (C) 2015-2018, The GAP Group 

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

#############################################################################
##
#E  maps.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

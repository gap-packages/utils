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

#############################################################################
##
#M  CentralProduct( <G1>, <G2>, <Z1>, <Phi> )
##
InstallMethod( CentralProduct,
    [ "IsGroup", "IsGroup", "IsGroup", "IsGroupHomomorphism" ],
    function( G1, G2, Z1, Phi )
    local gens, imgs, dp, emb1, emb2, N, proj, G;

    if not ( IsSubset( G1, Z1 ) and IsCentral( G1, Z1 ) ) then
      Error( "<Z1> must be a central subgroup of <G1>" );
    fi;
    gens:= GeneratorsOfGroup( Z1 );
    imgs:= List( gens, x -> (x^-1)^Phi );
    if not ( IsSubset( G2, imgs ) and
             ForAll( imgs, x -> IsCentral( G2, x ) ) ) then
      Error( "<Phi> must map <Z1> to a central subgroup of <G2>" );
    fi;

    dp:= DirectProduct( G1, G2 );
    emb1:= Embedding( dp, 1 );
    emb2:= Embedding( dp, 2 );
    N:= SubgroupNC( dp,
            List( [ 1 .. Length( gens ) ], i -> gens[i]^emb1 * imgs[i]^emb2 ) );
    proj:= NaturalHomomorphismByNormalSubgroup( dp, N );
    G:= Image( proj );
    SetCentralProductInfo( G, rec( projection:= proj, phi:= Phi ) );

    return G;
end );

##############################################################################
##
#M  IdempotentEndomorphisms  . . . . . . . . . . . . . . . . . . . for a group  
#M  IdempotentEndomorphismsData  . . . . . . . . . . . . . . . . . for a group  
#M  IdempotentEndomorphismsWithImage . . . . .  for a group and a chosen image 
##
InstallMethod( IdempotentEndomorphismsWithImage, 
    "for a list of group generators and a chosen image", 
    [ IsList, IsGroup ], 0, 
function( genG, R ) 

    local G, numG, r, q, norm, n, reps, i, j, rc;

    G := Group( genG );
    if not IsSubgroup( G, R ) then 
        Error( "R should be a subgroup of G" ); 
    fi; 
    numG := Length( genG );
    r := Size( R ); 
    q := Size( G )/r;     
    norm := Filtered( NormalSubgroups( G ), N -> ( Size( N ) = q ) and 
                          IsTrivial( Intersection( N, R ) ) ); 
    n := Length( norm );
    reps := [ ]; 
    for i in [1..n] do 
        Add( reps, [ ] );
        for j in [1..numG] do 
            rc := norm[i]*genG[j]; 
            Add( reps[i], First( rc, g -> g in R ) );   
        od;
    od;
    return reps; 
end );

InstallMethod( IdempotentEndomorphismsData, "for a group", [ IsGroup ], 0, 
function( G ) 

    local genG, R, data, images; 

    genG := SmallGeneratingSet( G ); 
    images := [ ]; 
    for R in AllSubgroups( G ) do 
        data := IdempotentEndomorphismsWithImage( genG, R ); 
        if ( data <> [ ] ) then 
            Add( images, data ); 
        fi; 
    od;
    return rec( gens := genG, images := images );
end );

InstallMethod( IdempotentEndomorphisms, "for a group", [ IsGroup ], 0, 
function( G ) 

    local data, genG, images, len, L, i, im; 

    data := IdempotentEndomorphismsData( G ); 
    genG := data!.gens;
    G := Group( genG );  
    images := data!.images; 
    len := Length( images ); 
    L := [ ]; 
    for i in [1..len] do 
        for im in images[i] do 
            Add( L, GroupHomomorphismByImages( G, G, genG, im ) ); 
        od;  
    od;  
    return L;
end );

##############################################################################
##
#M  DirectProductOfFunctions . . . . . . for two groups and two homomorphisms  
##
InstallMethod( DirectProductOfFunctions, "for two groups and two homs", 
    [ IsGroup, IsGroup, IsGroupHomomorphism, IsGroupHomomorphism ], 0, 
function( G, H, f1, f2 ) 

    local infoG, gpsG, G1, G2, infoH, gpsH, H1, H2, eG1, eG2, eH1, eH2, 
          mgi1, mgi2, genG, imH1, imH2, imH;

    if not HasDirectProductInfo( G ) and HasDirectProductInfo( H ) then 
        Error( "first two parameters should be direct products" ); 
    fi; 
    infoG := DirectProductInfo( G ); 
    gpsG := infoG!.groups; 
    G1 := gpsG[1]; 
    G2 := gpsG[2]; 
    if not ( ( G1 = Source( f1 ) ) and ( G2 = Source( f2 ) ) ) then 
        Error( "f1,f2 should have source G1,G2" ); 
    fi; 
    eG1 := Embedding( G, 1 ); 
    eG2 := Embedding( G, 2 ); 
    mgi1 := MappingGeneratorsImages( f1 ); 
    mgi2 := MappingGeneratorsImages( f2 ); 
    infoH := DirectProductInfo( H ); 
    gpsH := infoH!.groups; 
    H1 := gpsH[1]; 
    H2 := gpsH[2]; 
    if not ( ( H1 = Range( f1 ) ) and ( H2 = Range( f2 ) ) ) then 
        Error( "f1,f2 should have range H1,H2" ); 
    fi; 
    eH1 := Embedding( H, 1 ); 
    eH2 := Embedding( H, 2 ); 
    genG := Concatenation( List( mgi1[1], g -> ImageElm( eG1, g ) ),
                           List( mgi2[1], g -> ImageElm( eG2, g ) ) ); 
    imH1 := List( mgi1[2], h -> ImageElm( eH1, h ) ); 
    imH2 := List( mgi2[2], h -> ImageElm( eH2, h ) ); 
    imH := Concatenation( imH1, imH2 );
    return GroupHomomorphismByImagesNC( G, H, genG, imH ); 
end );

##############################################################################
##
#M  DirectProductOfAutomorphismGroups . . . . . . for two automorphism groups   
##
InstallMethod( DirectProductOfAutomorphismGroups, "for two groups", 
    [ IsGroup, IsGroup ], 0, 
function( A1, A2 ) 

    local gen1, gen2, G1, G2, id1, id2, dp, dp1, dp2, gen12, A12, 
          em1, em2, pr1, pr2, info; 

    if not ( IsGroupOfAutomorphisms(A1) and IsGroupOfAutomorphisms(A2) ) then 
        Error( "A1,A2 should be automorphism groups" ); 
    fi;
    gen1 := GeneratorsOfGroup( A1 ); 
    gen2 := GeneratorsOfGroup( A2 ); 
    G1 := Source( gen1[1] ); 
    G2 := Source( gen2[1] ); 
    if not ( IsGroup( G1 ) and IsGroup( G2 ) ) then 
        Error( "A1,A2 should be automorphism groups of groups G1,G2" ); 
    fi; 
    id1 := IdentityMapping( G1 ); 
    id2 := IdentityMapping( G2 ); 
    dp := DirectProduct( G1, G2 ); 
    dp1 := List( gen1, g -> DirectProductOfFunctions( dp, dp, g, id2 ) ); 
    dp2 := List( gen2, g -> DirectProductOfFunctions( dp, dp, id1, g ) ); 
    gen12 := Concatenation( dp1, dp2 ); 
    A12 := Group( gen12 ); 
    em1 := GroupHomomorphismByImages( A1, A12, gen1, dp1 ); 
    em2 := GroupHomomorphismByImages( A2, A12, gen2, dp2 ); 
    pr1 := GroupHomomorphismByImages( A12, A1, gen12, 
               Concatenation( gen1, List( gen2, g -> id1 ) ) ); 
    pr2 := GroupHomomorphismByImages( A12, A2, gen12, 
               Concatenation( List( gen1, g -> id2 ), gen2 ) ); 
    info := rec( embeddings := [ em1, em2 ], 
                 groups := [ A1, A2 ], 
                 projections := [ pr1, pr2 ] ); 
    SetDirectProductInfo( A12, info ); 
    return A12; 
end ); 

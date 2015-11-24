#############################################################################
##
#W  util.gi                    GAP4 package `XMod'               Chris Wensley
#W                                                                 & Murat Alp
##
##  version 2.43, 08/11/2015 
##
#Y  Copyright (C) 2001-2015, Chris Wensley et al,  
#Y  School of Computer Science, Bangor University, U.K. 

#############################################################################
##
#M  PrintListOneItemPerLine( <list> )
##
##  (was "Display" until June 2012) 
InstallMethod( PrintListOneItemPerLine, "generic method for lists", 
    true, [ IsList ], 0,
function( L )

    local  len, i;

    len := Length( L );
    if ( len < 2 ) then
        Print( L, "\n" );
    else
        Print( "[ " );
        for i in [1..len-1] do
            if IsBound( L[i] ) then
                Print( L[i], ",\n  " );
            else
                Print( "," );
            fi;
        od;
        Print( L[len], "\n  ]\n" );
    fi;
end );

## 08/01/04  replace by the library function IsEndoMapping ??
#############################################################################
##
#M  IsEndomorphism( <f> )
#M  IsAutomorphism( <f> )
##
## (10/04/02) changed to subgroup test, rather than equality
##
##InstallMethod( IsEndomorphism,
##    "generic method for homomorphisms", true, [ IsGroupHomomorphism ], 0,
##function( f )
##    return IsSubgroup( Source( f ), Range( f ) ); 
##end );
##
##InstallMethod( IsAutomorphism,
##    "generic method for homomorphisms", true, [ IsGroupHomomorphism ], 0,
##function( f )
##    return ( ( Source( f ) = Range( f ) ) and IsBijective( f ) ); 
##end );

#############################################################################
##
#M  AbelianModuleObject( <abgrp>, <act> )
#M  TrivialAction                                       of group H on group G
#M  AbelianModuleWithTrivialAction( <abgrp>, <gp> )           (added 19/07/07)
##
InstallMethod( AbelianModuleObject, "for abelian group and group action",
    true, [ IsGroup, IsGroupHomomorphism ], 0,
function( ab, act )

    local  rng, filter, fam, obj;

    if not IsCommutative( ab ) then 
        Error( "group is not commutative" );
    fi; 
    rng := Range( act ); 
    if not ( IsGroupOfAutomorphisms( rng ) and 
             ( AutomorphismDomain( rng ) = ab ) ) then 
        Error( "Range(act) is not a group of autios of ab" ); 
    fi; 
    fam := FamilyObj( [ ab, act ] );
    filter := IsAbelianModuleObj;
    obj := rec();
    ObjectifyWithAttributes( obj, NewType( fam, filter ), 
      AbelianModuleGroup, ab,
      AbelianModuleAction, act,
      IsAbelianModule, true );
    return obj;
end );

InstallMethod( TrivialAction, "for groups", true, [ IsGroup, IsGroup ], 0,
function( G, H )

    local  triv;

    triv := Group( IdentityMapping( G ) );
    return MappingToOne( H, triv );
end );

InstallMethod( AbelianModuleWithTrivialAction, 
    "for abelian group and group action", true, [ IsGroup, IsGroup ], 0,
function( ab, gp )
    return AbelianModuleObject( ab, TrivialAction( ab, gp ) );
end );

##############################################################################
##
#M  InnerAutomorphismsByNormalSubgroup       for a group and a normal subgroup
##
InstallMethod( InnerAutomorphismsByNormalSubgroup,
    "for a group and a normal subgroup", true, [ IsGroup, IsGroup ], 0,
function( G, N )

    local  nargs, id, genG, genN, autG, genA, A, g, conj, name;

    if not IsNormal( G, N ) then
        Error( "Second parameter must be normal subgroup of the first\n" );
    fi;
    if ( ( G = N ) and HasAutomorphismGroup( G ) ) then
        autG := AutomorphismGroup( G );
        return InnerAutomorphismsAutomorphismGroup( autG );
    fi;
    genG := GeneratorsOfGroup( G );
    genN := GeneratorsOfGroup( N );
    id := InclusionMappingGroups( N, N );
    genA := [ ];
    for g in genG do
        conj := InnerAutomorphism( N, g );
        Add( genA, conj );
    od;
    A := Group( genA, id );
    SetIsGroupOfAutomorphisms( A, true );
    return A;
end );

##############################################################################
##  ????? needs to be removed/changed ?????
##############################################################################
##
#M  IsomorphismSmallPermGroup
##
##  added 08/04/01, using SmallerDegreePermutationRepresentation
##  revised 23/06/06, introducing Nicer...
##
InstallMethod( IsomorphismSmallPermGroup, "for a group", true,
    [ IsGroup ], 0,
function( G )

    local  G2P, P, nP, P2S, nS, S, genG, numG, j, p, imiso, iso;

    if HasNicerMonomorphism( G ) then 
        G2P := NicerMonomorphism( G );
        if ( G2P = fail ) then
            ## tried this before, with no success
            return NiceMonomorphism( G );
        else
            return NicerMonomorphism( G );
        fi;
    fi;
    if HasNiceMonomorphism( G ) then 
        G2P := NiceMonomorphism( G );
    else
        G2P := IsomorphismPermGroup( G );
        SetNiceMonomorphism( G, G2P );
        SetNiceObject( G, Image( G2P ) );
    fi;
    P := Image( G2P );
    nP := NrMovedPoints( P );
    P2S := SmallerDegreePermutationRepresentation( P );
    if ( P2S = fail ) then
        SetNicerMonomorphism( G, fail );
        iso := G2P;
    else
        S := ImagesSource( P2S );
        nS := NrMovedPoints( S );
        if ( nP = nS ) then
        SetNicerMonomorphism( G, fail );
        iso := G2P;            
        else
            Info( InfoXMod, 2, "found smaller perm representation" );
            genG := GeneratorsOfGroup( G );
            numG := Length( genG );
            imiso := ListWithIdenticalEntries( numG, 0 );
            for j in [1..numG] do
                p := Image( G2P, genG[j] );
                imiso[j] := Image( P2S, p );
            od; 
            iso := GroupHomomorphismByImages( G, S, genG, imiso );
        fi;
    fi;
    if ( HasName( G ) and not HasName( Range( iso ) ) ) then
        SetName( Range( iso ), Concatenation( "P", Name( G ) ) );
    fi;
    SetNicerMonomorphism( G, iso );
    if not ( iso = fail ) then
        SetNicerObject( G, Image( iso ) );
    fi;
    return iso;
end );

## ???? replace by ElementsInGenerators ???? ## 

##############################################################################
##
#M  GenerationOrder         elements of G generated as words in the generators
##
InstallMethod( GenerationOrder, "method for a group", true, [ IsGroup ], 0,
function( G )

    local  oG, eG, ord, ngG, stgG, g, i, j, k, P, pos, n, x, y;

    stgG := StrongGeneratorsStabChain( StabChain( G ) );
    ngG := Length( stgG );
    oG := Size( G );
    eG := Elements( G );
    ord := 0 * [1..oG];
    ord[1] := 1;
    P := 0 * [1..oG];
    P[1] := [ 1, 0 ];
    for n in [1..ngG] do
        g := stgG[n];
        pos := Position( eG, g );
        P[pos] := [ 1, n ];
        ord[ n+1 ] := pos;
    od;
    n := ngG + 1;
    k := 2;
    while ( k < oG ) do
        i := ord[k];
        x := eG[i];
        for j in [1..ngG] do
            g := stgG[j];
            y := x * g;
            pos := Position( eG, y );
            if ( P[pos] = 0 ) then
                P[pos] := [ i, j ];
                n := n+1;
                ord[n] := pos;
            fi;
        od;
        k := k+1;
    od;
    SetGenerationPairs( G, P );
    return ord;
end );

##############################################################################
##
#M  CheckGenerationPairs             G.generationPairs, G.generationOrder ok ?
##
InstallMethod( CheckGenerationPairs, "method for a ", true, [ IsGroup ], 0,
function( G )

    local  eG, oG, stgG, P, i, g, x;

    stgG := StrongGeneratorsStabChain( StabChain( G ) );
    oG := Size( G );
    eG := Elements( G );
    P := GenerationPairs( G );
    if ( P[1] <> [1,0] ) then
        return false;
    fi;
    for i in [2..oG] do
        x := eG[ P[i][1] ];
        g := stgG[ P[i][2] ];
        if ( x*g <> eG[i] ) then
            Info( InfoXMod, 2, x, " * ", g, " <> ", eG[i] );
            return false;
        fi;
    od;
    return true;
end );

##############################################################################
##
#M  DistinctRepresentatives( <L> )
##
InstallMethod( DistinctRepresentatives, "for a list of sets", true,
    [ IsList ], 0,
function( L )

    local  n, rep, U, len, i, j, k, used, found, S, T, M, P, x, y, z;

    if not  ( IsList( L ) and
              ( ForAll( L, IsList ) or ForAll( L, IsSet ) ) ) then
        Error( "argument should be a list of sets" );
    fi;
    n := Length( L );
    U := [1..n];
    len := 0 * U;
    for i in U do
        S := L[i];
        if IsList( S ) then
            S := Set( S );
        fi;
        len[i] := Length( S );
        if ( len[i] = 0 ) then
            Error( "subsets must be non-empty" );
        fi;
        if not ForAll( S, j -> ( j in U ) ) then
            Error( "each set must be a subset of [1..n]" );
        fi;
    od;
    rep := 0 * U;
    used := 0 * U;
    rep[1] := L[1][1];
    used[ rep[1] ] := 1;
    for i in [2..n] do
        found := false;
        S := L[i];
        j := 0;
        while ( ( j < len[i] ) and not found ) do 
            j := j+1;
            x := S[j];
            if ( used[x] = 0 ) then
                rep[i] := x;
                used[x] := i;
                found := true;
            fi;
        od;
        # construct the graph component
        T := ShallowCopy( S );
        M := List( T );
        P := 0 * U;
        for x in M do
            P[x] := i;
        od;
        j := 0;
        while not found do
            j := j+1;
            x := M[j];
            k := used[x];
            if ( k = 0 ) then
                # reassign representatives
                y := P[x];
                while ( y <> i ) do
                    z := rep[y];
                    rep[y] := x;
                    used[x] := y;
                    x := z;
                    y := P[x];
                od;
                rep[i] := x;
                used[x] := i;
                found := true;
            else
                for y in L[k] do
                    if not ( y in T ) then
                        Add( M, y );
                        P[y] := k;
                        T := Union( T, [y] );
                    fi;
                od;
            fi;
            if ( ( not found ) and ( j = Length( M ) ) ) then
                Print( "Hall condition not satisfied!\n" );
                return false;
            fi;
        od;
    od;
    return rep;
end );

##############################################################################
##
#M  CommonRepresentatives( <J>, <K> )
##
InstallMethod( CommonRepresentatives, "for a pair of lists/sets", true,
    [ IsList, IsList ], 0,
function( J, K )

    local  U, i, j, k, m, n, lenJ, lenK, S, L, I, rep, perm, common;

    if not ( ForAll( J, IsList ) or ForAll( J, IsSet ) ) then
        Error( "first argument should be a list of sets" );
    fi;
    m := Length( J );
    if not ( ForAll( K, IsList ) or ForAll( K, IsSet ) ) then
        Error( "second argument should be a list of sets" );
    fi;
    n := Length( K );
    if not ( m = n ) then
        Error( "lists <J> and <K> have unequal length" );
    fi;
    U := [1..n];
    lenJ := 0 * U;
    lenK := 0 * U;
    for i in U do
        S := J[i];
        if IsList( S ) then
            S := Set( S );
        fi;
        lenJ[i] := Length( S );
        if ( lenJ[i] = 0 ) then
            Error( "sets must be non-empty" );
        fi;
        S := K[i];
        if IsList( S ) then
            S := Set( S );
        fi;
        lenK[i] := Length( S );
        if ( lenK[i] = 0 ) then
            Error( "sets must be non-empty" );
        fi;
    od;
    L := List( U, x -> [ ] );
    for i in U do
        S := J[i];
        for j in U do
            I := Intersection( S, K[j] );
            if ( Length( I ) > 0 ) then
                Add( L[i], j );
            fi;
        od;
    od;
    rep := DistinctRepresentatives( L );
    perm := PermList( rep );
    K := Permuted( K, perm^-1 );
    common := 0 * U;
    for i in U do
        I := Intersection( J[i], K[i] );
        common[i] := I[1];
    od;
    return [ common, rep ];
end );

##############################################################################
##
#M  CommonTransversal
##
InstallMethod( CommonTransversal, "for a group and a subgroup", true,
    [ IsGroup, IsGroup ], 0,
function( G, H )

    local  R, ER, EL, T;

    if not IsSubgroup( G, H ) then
        Error( "<H> must be a subgroup of <G>" );
    fi;
    R := RightCosets( G, H );
    ER := List( R, x -> Elements( x ) );
    EL := List( ER, C -> List( C, x -> x^(-1) ) );
    Info( InfoXMod, 3, "right cosets: ", ER );
    Info( InfoXMod, 3, " left cosets: ", EL );
    T := CommonRepresentatives( EL, ER );
    return T[1];
end );

##############################################################################
##
#M  IsCommonTransversal
##
InstallMethod( IsCommonTransversal, "for group, subgroup, list", true,
    [ IsGroup, IsGroup, IsList ], 0,
function( G, H, T )

    local  eG, eH, oG, oH, g, h, t, pos, ind, found;

    if not IsSubgroup( G, H ) then
        Print( "second group must be subgroup of first\n" );
        return fail;
    fi;
    oG := Size( G );
    oH := Size( H );
    eG := Elements( G );
    eH := Elements( H );
    ind := oG/oH;
    found := 0 * [1..oG];
    for t in T do
        if not ( t in eG ) then
            Print( "element of T not in G\n" );
            return false;
        fi;
        for h in eH do
            g := t*h;
            pos := Position( eG, g );
            found[pos] := found[pos] +1;
            g := h*t;
            pos := Position( eG, g );
            found[pos] := found[pos] + 1;
        od;
    od;  
    for t in [1..oG] do
        if not ( found[t] = 2 ) then
            Print( eG[t], " found ", found[t], " times\n" );
            return false;
        fi;
    od;
    return true;
end );

##############################################################################
##
#M  TzCommutatorPair( <tietze>, <rel> )
##
InstallGlobalFunction( TzCommutatorPair, function( T, rel )

    local  tietze, numgens, invs, numinvs, 
           x, ax, ix, px, y, ay, iy, py, pair;

    TzCheckRecord( T );
    tietze := T!.tietze;
    invs := tietze[TZ_INVERSES];
    numgens := tietze[TZ_NUMGENS];
    numinvs := 1 + 2 * numgens;
    if not ( IsList( rel ) and ( Length( rel ) = 4 ) ) then
        Print( "Second parameter must be a relator of length 4.\n" );
        return [ 0, 0 ];
    fi;
    x := rel[1];
    y := rel[2];
    ax := AbsInt( x );            
    ay := AbsInt( y );
    px := Position( invs, x );
    ix := invs[numinvs + 1 - px];
    py := Position( invs, y );
    iy := invs[numinvs + 1 - py];
    if ( ( rel[3] = ix ) and ( rel[4] = iy ) ) then
        pair := Set( [ ax, ay ] );
    else
        pair := [ 0, 0 ];
    fi;
    return pair;    
end );

##############################################################################
##
#M  TzPartition( <tietze> ) partition generators into commuting subsets
##
InstallGlobalFunction( TzPartition, function( T )

    local  tietze, numgens, gens, partition, count, bipartite,
           invs, allgens, others, rels, numrels, lengths, numpart, numold,
           numinvs, i, j, k, x, ax, y, ay, z, r, lr, s, ok,
           commpairs, c, d, pair, commutators, comm1, comm2,
           left, right, rest, powerof, powers, freq, fnum, L, S;

    TzCheckRecord( T );
    tietze := T!.tietze;
    invs := tietze[TZ_INVERSES];
    rels := tietze[TZ_RELATORS];
    lengths := tietze[TZ_LENGTHS];
    numrels := tietze[TZ_NUMRELS];
    numgens := tietze[TZ_NUMGENS];
    numinvs := 1 + 2 * numgens;
    allgens := [1..numgens];
    left := allgens;
    partition := [ Set( allgens ) ];

    # phase1: find explicit commutators
    commpairs := [ ];
    for j in [1..numgens] do
        Add( commpairs, [ ] );
    od;
    commutators := 0 * [1..numrels];
    comm1 := 0;
    comm2 := 0;
    for j in [1..numrels] do
        if ( lengths[j] <> 4 ) then
            commutators[j] := false;
        else
            r := rels[j];
            pair := TzCommutatorPair( T, r );
            if ( pair <> [ 0, 0 ] ) then
                commutators[j] := true;
                comm2 := comm2 + 1;
                ax := pair[1];
                ay := pair[2];
                if ( ( ax in allgens ) and ( ay in allgens ) ) then
                    Add( commpairs[ax], ay );
                    Add( commpairs[ay], ax );
                fi;
            else
                commutators[j] := false;
            fi;
        fi;
    od;
    commpairs := List( commpairs, L -> Set( L ) );
    if ( ( TzOptions(T).printLevel > 1 ) and ( comm2 > 0 ) ) then
        Print( "There were ", comm2, " commutators found in phase 1\n" );
    fi;

    # phase2: find implicit commutators
    while ( comm1 < comm2 ) do
        comm1 := comm2;
        for j in [1..numrels] do 
            r := rels[j];
            lr := Length( r );
            if ( lr > 1 ) then
                freq := Collected( List( r, x -> AbsInt( x ) ) );
                fnum := Length( freq );
                for x in [1..fnum] do
                    L := freq[x];
                    if ( L[2] = 1 ) then
                        S := allgens;
                        for y in [1..fnum] do
                            if ( x <> y ) then
                                z := freq[y][1];
                                S := Intersection( S, commpairs[z] );
                            fi;
                        od;
                        y := L[1];
                        commpairs[y] := Union( commpairs[y], S );
                        for z in S do
                            commpairs[z] := Union( commpairs[z], [y] );
                        od;
                    fi;
                od;
            fi;
        od;
    comm2 := Sum( List( commpairs, L -> Length( L ) ) )/2;
    if ( ( TzOptions(T).printLevel > 1 ) and ( comm2 > comm1 ) ) then
        Print( "There were ", comm2 - comm1 );
        Print( " commutators found in phase 2\n" );
    fi;
    od;

    # phase3: separate into parts
    numpart := 1;
    numold := 0;
    while ( ( numold <> numpart ) and ( Length( partition[1] ) > 1 ) ) do
        if ( numpart > 1 ) then
            commpairs := List( commpairs, 
                                  L -> Difference( L, partition[2] ) );
        fi;
        gens := partition[1];
        others := Difference( allgens, gens );
        rest := partition{[ 2..Length(partition) ]};
        bipartite := false;
        left := commpairs[ gens[1] ];
        if ( left <> [ ] ) then
            right := Difference( gens, left );
            bipartite := true;
            for c in commpairs do
                d := Difference( c, left );
                if not ( c = [ ] ) then
                    if not ( ( c = left ) or ( d = right ) ) then
                        bipartite := false;
                    fi;
                fi;
            od;
        fi;
        if bipartite then
            # reorder the letters in each relator (but not the commutators)
            partition := Concatenation( [ left ], [ right ], rest );
            for j in [1..numrels] do
                if not commutators[j] then
                    r := rels[j];
                    s := [ ];
                    for x in r do
                        ax := AbsInt( x );
                        if ( ax in left ) then
                            Add( s, x );
                        fi;
                    od;
                    for y in r do
                        ay := AbsInt( y );
                        if ( ay in right ) then
                            Add( s, y );
                        fi;
                    od;
                    for x in r do
                        ax := AbsInt( x );
                        if ( ax in others ) then
                            Add( s, x );
                        fi;
                    od;
                    if ( r <> s ) then
                        rels[j] := s;
                        tietze[TZ_MODIFIED] := true;
                    fi;
                fi;
            od;
            if ( TzOptions(T).printLevel > 1 ) then
                Print( "#I factoring ", gens, " into " );
                Print( left, ", ", right, "\n" );
            fi;
        else
            left := [ ];
        fi;
    numold := numpart;
    numpart := Length( partition );
    od;
    T!.partition := partition;
    ## return partition;
end );

##############################################################################
##
#M  FactorsPresentation( <tietze> ) 
##
InstallGlobalFunction( FactorsPresentation, function( arg )

    local  T, printlevel, tietze, gens, rels, numrels, numgens, invs, numinvs,
           lengths, flags, partition, part, numpart, i, j, k, rel, diff, F,
           commutator, fx, fy, pair, factor, fac, len, chosen, posn,
           subrels, subnumi, subtot, sublen, subflags, subtriv, subT;

    T := arg[1];
    TzCheckRecord( T );
    # check that the second argument is an integer
    printlevel := 1;
    if ( Length( arg ) = 2 ) then
        printlevel := arg[2];
    fi;
    if not IsInt( printlevel ) then
        Error( "second argument must be an integer" );
    fi;

    TzPartition( T );
    partition := T!.partition;
    if ( Length( partition ) = 1 ) then
        return [ T ];
    fi;
    tietze := T!.tietze;
    invs := tietze[TZ_INVERSES];
    numgens := tietze[TZ_NUMGENS];
    numinvs := 1 + 2 * numgens;
    gens := T!.generators;         ## ??????
    rels := tietze[TZ_RELATORS];
    lengths := tietze[TZ_LENGTHS];
    flags := tietze[TZ_FLAGS];
    numrels := tietze[TZ_NUMRELS];
    numpart := Length( partition );
    factor := 0 * [1..numgens ];
    for i in [1..numpart] do
        part := partition[i];
        for j in [1..Length(part)] do
            factor[ part[j] ] := i;
        od;
    od;
    chosen := List( [1..numpart], i -> [ ] );
    for j in [1..numrels] do
        rel := rels[j];
        len := lengths[j];
        commutator := false;
        if ( len = 4 ) then
            pair := TzCommutatorPair( T, rel );
            if ( pair <> [ 0, 0 ] ) then
                fx := factor[ pair[1] ];
                fy := factor[ pair[2] ];
                commutator := ( fx <> fy );
            fi;
        fi;
        if not commutator then
            fac := List( rel, i -> factor[ AbsInt( i ) ] );
            # check that fac is increasing
            for i in [2..len] do
                if ( fac[i] < fac[i-1] ) then
                    Print( "relator = ", rel, "\n" );
                    Error( "factors mixed in relator" );
                fi;
            od;
            for i in Set( fac ) do
                Add( chosen[i], j );
            od;           
        fi;
    od;
    # construct Tietze records for each factor
    subflags := 0 * [1..numpart];
    F := List( [1..numpart], i -> ShallowCopy( T ) );
    for i in [1..numpart] do
        subrels := [ ];
        for j in chosen[i] do
            rel := rels[j];
            len := lengths[j];
            fac := List( rel, k -> factor[ AbsInt( k ) ] );
            posn := Filtered( [1..len], k -> fac[k]=i );
            Add( subrels, rel{posn} );
        od;
        sublen := List( subrels, L -> Length( L ) );
        subflags := List( chosen[i], k -> flags[k] );
        F[i].printLevel := printlevel;
        subT := F[i].tietze;
        diff := Difference( [1..numgens], partition[i] );
        subtriv := List( diff, x -> [x] );
        subrels := Concatenation( subtriv, subrels );
        sublen := Concatenation( List( subtriv, x -> 1 ), sublen );
        subflags := Concatenation( List( subtriv, x -> 0 ), subflags );
        subnumi := Length( subrels );
        subtot := 0;
        for j in [1..subnumi] do
            subtot := subtot + sublen[j];
        od;
        subT[TZ_TOTAL] := subtot;
        subT[TZ_RELATORS] := subrels;
        subT[TZ_NUMRELS] := subnumi;
        subT[TZ_LENGTHS] := sublen;
        subT[TZ_FLAGS] := subflags;
        subT[TZ_STATUS] := [ subT[1], subT[2], subT[3] ];
    od;
    return F;
end );

##############################################################################
##
#M  IsomorphismFpInfo( <G> ) . . . . . . . . . . . . isomorphic fp-group for G
##
InstallOtherMethod( IsomorphismFpInfo, "for a group", true, [ IsGroup ], 0,
function( grp )

    local  iso, inv, fp, mgi;
    iso := IsomorphismFpGroup( grp );
    fp := ImagesSource( iso );
    mgi := MappingGeneratorsImages( iso );
    inv := GroupHomomorphismByImagesNC( fp, grp, mgi[2], mgi[1] );
    if IsPermGroup( grp ) then
        SetIsomorphismPermInfo( fp,
            rec( perm := grp, g2perm := inv, perm2g := iso ) );
    fi;
    SetIsomorphismFpInfo( grp, 
        rec( fp := fp, g2fp := iso, fp2g := inv ) );
    return rec( fp := fp, g2fp := iso, fp2g := inv );
end );

##############################################################################
##
#M  IsomorphismPermInfo( <G> ) . . . . . . . . . . isomorphic perm group for G
##
InstallOtherMethod( IsomorphismPermInfo, "for a group", true, [ IsGroup ], 0,
function( grp )

    local  iso, inv, perm, mgi;
    iso := IsomorphismPermGroup( grp );
    perm := ImagesSource( iso );
    mgi := MappingGeneratorsImages( iso );
    inv := GroupHomomorphismByImagesNC( perm, grp, mgi[2], mgi[1] );
    if IsFpGroup( grp ) then
        SetIsomorphismFpInfo( perm,
            rec( fp := grp, g2fp := inv, fp2g := iso ) );
    fi;
    SetIsomorphismPermInfo( grp,
        rec( perm := perm, g2perm := iso, perm2g := inv ) );
    return rec( perm := perm, g2perm := iso, perm2g := inv );
end );

##############################################################################
##
#M  IsomorphismPcInfo( <G> ) . . . . . . . . . . . . isomorphic pc group for G
##
InstallOtherMethod( IsomorphismPcInfo, "for a group", true, [ IsGroup ], 0,
function( grp )

    local  iso, inv, pc, mgi;
    iso := IsomorphismPcGroup( grp );
    if ( iso = fail ) then 
        return fail; 
    fi; 
    pc := ImagesSource( iso );
    mgi := MappingGeneratorsImages( iso );
    inv := GroupHomomorphismByImages( pc, grp, mgi[2], mgi[1] );
    if IsFpGroup( grp ) then
        SetIsomorphismFpInfo( pc,
            rec( fp := grp, g2fp := inv, fp2g := iso ) ); 
    elif IsPermGroup( grp ) then 
        SetIsomorphismPermInfo( pc, 
            rec( perm := grp, g2perm := inv, pc2g := iso ) ); 
    fi;
    SetIsomorphismPcInfo( grp,
        rec( pc := pc, g2pc := iso, pc2g := inv ) );
    return rec( pc := pc, g2pc := iso, pc2g := inv );
end );

##############################################################################
##
#M  IsomorphismPermOrPcInfo( <G> ) . . . . . isomorphic perm or pc group for G
##
InstallOtherMethod( IsomorphismPermOrPcInfo, "for a group", true, 
    [ IsGroup ], 0,
function( grp )

    local  id, info1, info2, iso1, iso2, iso, inv1, inv2, inv, perm, 
           pc, ispc; 
    if IsPermGroup( grp ) then 
        return IsomorphismPcInfo( grp );
    elif IsPcGroup( grp ) then 
        return IsomorphismPermInfo( grp ); 
    else 
        info1 := IsomorphismPermInfo( grp ); 
        perm := info1!.perm; 
        iso1 := info1!.g2perm; 
        inv1 := info1!.perm2g; 
        info2 := IsomorphismPcInfo( perm ); 
        ispc := not ( info2 = fail ); 
        if ispc then 
            pc := info2!.pc; 
            iso2 := info2!.g2pc; 
            iso := iso1 * iso2; 
            inv2 := info2!.pc2g; 
            inv := inv2 * inv1; 
            if IsFpGroup( grp ) then
                SetIsomorphismFpInfo( pc,
                    rec( fp := grp, g2fp := inv, fp2g := iso ) ); 
            fi; 
            return rec( type := "pc", pc := pc, g2pc := iso, pc2g := inv );
        else  ## return the perm info 
            return rec( type := "perm", perm := perm, 
                        g2perm := iso1, perm2g := inv1 ); 
        fi; 
    fi; 
end );

##############################################################################
##
#M  IsomorphismPermObject( <obj> ) 
#M  IsomorphismFpObject( <obj> ) 
#M  IsomorphismPcObject( <obj> ) 
##
InstallGlobalFunction( IsomorphismPermObject, function( obj )
    if IsGroup( obj ) then
        return IsomorphismPermGroup( obj );
    elif IsPreXMod( obj ) then
        return IsomorphismPerm2dGroup( obj );
    elif IsPreCat1( obj ) then
        return IsomorphismPerm2dGroup( obj );
    else
        return fail;
    fi;
end );

InstallGlobalFunction( IsomorphismFpObject, function( obj )
    if IsGroup( obj ) then
        return IsomorphismFpGroup( obj );
    elif IsPreXMod( obj ) then
        return IsomorphismFp2dGroup( obj );
    elif IsPreCat1( obj ) then
        return IsomorphismFp2dGroup( obj );
    else
        return fail;
    fi;
end );

InstallGlobalFunction( IsomorphismPcObject, function( obj )
    if IsGroup( obj ) then
        return IsomorphismPcGroup( obj );
    elif IsPreXMod( obj ) then
        return IsomorphismPc2dGroup( obj );
    elif IsPreCat1( obj ) then
        return IsomorphismPc2dGroup( obj );
    else
        return fail;
    fi;
end );

##############################################################################
##
#M  MetacyclicGroup
##
InstallMethod( MetacyclicGroup, "for three positive integers", true,
    [ IsPosInt, IsPosInt, IsPosInt ], 0,
function( m, n, l )

    local  f, x, y, rels, fp, iso;
    if not ( RemInt( l^m, n ) = 1 ) then
        return fail;
    fi;
    f := FreeGroup( 2 );
    x := GeneratorsOfGroup( f )[1];
    y := GeneratorsOfGroup( f )[2];
    rels := [ x^m, y^n, x^(-1)*y*x*y^(-l) ];
    fp := f/rels;
    iso := IsomorphismPermGroup( fp );
    return Image( iso );
end );

##############################################################################
##  added  17/07/07
##############################################################################
##
#M  AutomorphismsFixingSubgroups . . . . . for a group and a list of subgroups
##
InstallMethod( AutomorphismsFixingSubgroups, "for a group and subgroup list", 
    true, [ IsGroup, IsList ], 0,
function( G, H )

    local  autG, id, genautG, numautG, L, a, i, F, gensub, subG, 
           stop, reps, numrep, r, found, ok; 

    if not ForAll( H, J -> IsSubgroup( G, J ) ) then 
        Error( "H is not a list of subgroups of G" );
    fi;
    autG := AutomorphismGroup( G ); 
    id := TrivialSubgroup( G ); 
    if ForAll( H, J -> ( (J=G) or (J=id) ) ) then 
        return autG; 
    fi;
    genautG := GeneratorsOfGroup( autG ); 
    numautG := Length( genautG ); 
    L := ListWithIdenticalEntries( numautG, 0 );
    for i in [1..numautG] do 
        a := genautG[i]; 
        L[i] := ForAll( H, J -> 
           ForAll( List(GeneratorsOfGroup(J),j -> j^a in J), x -> x=true) ); 
    od;
    if ForAll( L, l -> l ) then 
        return autG;
    fi;
    F := Filtered( [1..numautG], x -> L[x] ); 
    Info( InfoXMod, 2, "L,F = ", L, F );
    gensub := List( F, f -> genautG[f] );
    stop := false; 
    subG :=  Subgroup( autG, gensub ); 
    while not stop do 
        stop := true; 
        reps := List( RightCosets( autG, subG ), c -> Representative(c) ); 
        numrep := Length( reps ); 
        i := 1; 
        found := false; 
        while ( not found and ( i < numrep ) ) do 
            i := i+1; 
            r := reps[i]; 
            ok := ForAll( H, J -> 
                  ForAll( List(GeneratorsOfGroup(J),j->j^r in J), x->x=true) );
            if ok then 
                found := true; 
                stop := false; 
                Add( gensub, r );
                subG :=  Subgroup( autG, gensub ); 
            fi; 
        od; 
    od; 
    return subG;
end );

#############################################################################
##
#E  util.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

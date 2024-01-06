#############################################################################
##
#W  lists.gi                  GAP4 package `Utils'                Stefan Kohl
##
#Y  Copyright (C) 2015-2018, The GAP Group 

#############################################################################
##  these functions have been transferred from ResClasses 
##
#F  DifferencesList( <list> ) . . . . differences of consecutive list entries
#F  QuotientsList( <list> ) . . . . . . quotients of consecutive list entries
#F  FloatQuotientsList( <list> )  . . . . . . . . . . . . dito, but as floats
##

InstallGlobalFunction( DifferencesList,
    list -> List( [ 2..Length(list) ],
                  pos -> list[ pos ] - list[ pos-1 ] ) );

InstallGlobalFunction( QuotientsList, 
    function( list ) 
    local  len, pos, quot;
    len := Length( list ); 
    quot := ListWithIdenticalEntries( len-1, 0 ); 
    for pos in [1..len-1] do 
        if IsZero( list[pos] ) then 
            quot[pos] := fail; 
        else 
            quot[pos] := list[pos+1]/list[pos]; 
        fi; 
    od;
    return quot;
    end );

InstallGlobalFunction( FloatQuotientsList,
    list -> List( QuotientsList( list ), Float ) );

#############################################################################
##  this function has been transferred from ResClasses 
##
#M  RandomCombination( S, k ) . . . . . . . . . . . . . . . .  default method
##
InstallMethod( RandomCombination, "default method",
               ReturnTrue, [ IsListOrCollection, IsPosInt ],

  function ( S, k )

    local  c, elm, i;

    if k > Size(S) then return fail; fi;
    c := [];
    for i in [1..k] do
      repeat
        elm := Random(S);
      until not elm in c;
      Add(c,elm);
    od;
    return Set(c);
  end );

#############################################################################
##  this function has been transferred from RCWA 
##
#F  SearchCycle( <list> ) .  a utility function for detecting cycles in lists
##
InstallGlobalFunction( SearchCycle,

  function ( list )

    local  preperiod, cycle, startpos, mainpart, mainpartdiffs,
           elms, inds, min, n, d, i, j;

    n        := Length(list);
    mainpart := list{[Int(n/3)..n]};
    elms     := Set(mainpart);
    cycle    := [elms[1]];
    startpos := Filtered(Positions(list,elms[1]),i->i>n/3);
    if Length(elms) = 1 then
      if ValueOption("alsopreperiod") <> true then return cycle; else
        i := Length(list);
        repeat i := i - 1; until i = 0 or list[i] <> elms[1];
        preperiod := list{[1..i]};
        return [preperiod,cycle];
      fi;
    fi;
    i := 0;
    repeat
      i := i + 1;
      inds := Intersection(startpos+i,[1..n]);
      if inds = [] then return fail; fi;
      min := Minimum(list{inds});
      Add(cycle,min);
      startpos := Filtered(startpos,j->j+i<=n and list[j+i]=min);
      if Length(startpos) <= 1 then return fail; fi;
      mainpartdiffs := DifferencesList(Intersection(startpos,[Int(n/3)..n]));
      if mainpartdiffs = [] then return fail; fi;
      d := Maximum(mainpartdiffs); 
    until Length(cycle) = d;
    if    Minimum(startpos) > n/2
       or n-Maximum(startpos)-d+1 > d
       or list{[Maximum(startpos)+d..n]}<>cycle{[1..n-Maximum(startpos)-d+1]}
    then return fail; fi;
    if ValueOption("alsopreperiod") <> true then return cycle; else
      i := Minimum(startpos) + Length(cycle);
      repeat
        i := i - Length(cycle);
      until i <= 0 or list{[i..i+Length(cycle)-1]} <> cycle;
      preperiod := list{[1..i+Length(cycle)-1]};
      return [preperiod,cycle];
    fi;
  end );

##############################################################################
##  this function has been transferred from XMod 
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
##  this function has been transferred from XMod 
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
##  this function has been transferred from XMod 
##
#M  CommonTransversal
##
InstallMethod( CommonTransversal, "for left and right cosets of a subgroup", 
    true, [ IsGroup, IsGroup ], 0,
function( G, H )

    local  R, ER, EL, T;

    if not IsSubgroup( G, H ) then
        Error( "<H> must be a subgroup of <G>" );
    fi;
    R := RightCosets( G, H );
    ER := List( R, Elements );
    EL := List( ER, C -> List( C, Inverse ) );
    Info( InfoUtils, 3, "right cosets: ", ER );
    Info( InfoUtils, 3, " left cosets: ", EL );
    T := CommonRepresentatives( EL, ER );
    return T[1];
end );

##############################################################################
##  this function has been transferred from XMod 
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

#############################################################################
##
#E  lists.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

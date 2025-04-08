#############################################################################
##
#W  magma.gi                  GAP4 package `Utils'                   Max Horn
##                                                           Alexander Hulpke
##                                                               Frank Lübeck
#Y  Copyright (C) 2015-2025, The GAP Group 

#############################################################################
##
#F  ConvertToMagmaInputString( <obj> )  . . output a string readable by Magma 
##
InstallGlobalFunction( ConvertToMagmaInputString,

    function ( arg )

        local  len, obj, s, str; 
        len := Length( arg );
        obj := arg[1]; 
        if not IsGroup( obj ) then 
            Error( "input obj should be a group" ); 
        elif IsPcGroup( obj ) then 
            str := PcGroupToMagmaFormat( obj ); 
        elif IsPermGroup( obj ) then 
            str := PermGroupToMagmaFormat( obj ); 
        elif IsMatrixGroup( obj ) then 
            str := MatrixGroupToMagmaFormat( obj ); 
        elif IsFpGroup( obj ) then 
            Print( "no conversion function yet available for fp-groups\n" );
            return fail; 
            ## str := FpGroupToMagmaFormat( obj ); 
        else 
            Print( "no conversion function yet available for this group\n" );
            return fail; 
        fi; 
        if ( len > 1 ) then 
            s := arg[2]; 
            if IsMatrixGroup( obj ) then 
                str := ReplacedString( str, "sub", Concatenation(s," := sub") ); 
            else 
                str := Concatenation( s, " := ", str ); 
            fi;
        fi; 
        return str; 
    end );

#############################################################################
##  this function was originally authored by Alexander Hulpke; 
##  has been transferred from other.gi in the main library; 
##  and was originally named MagmaInputString
## 
InstallMethod( PermGroupToMagmaFormat, "perm group", true, [IsPermGroup], 0,
    function( g )
    local s, i, nf;
    ## s := ShallowCopy(s);
    ## Append(s,":=PermutationGroup<");
    s := "PermutationGroup<";
    Append( s, String( LargestMovedPoint(g) ) );
    Add( s, '|' );
    nf := false;
    for i in GeneratorsOfGroup(g) do
        if nf then
            Append( s, ",\n" );
        fi;
        nf:=true;
        Append( s, String(i) );
    od;
    Append( s, ">;\n" );
    return s;
end );

#############################################################################
##  this function was private code of Max Horn 
## 
InstallMethod( PcGroupToMagmaFormat, "pc-group", true, [IsPcGroup], 0, 
    function(G)
    local str, g, n, r, gens, rels, i, j;
    g := Pcgs(G);
    n := Length(g);
    r := RelativeOrders(g);
    gens := List(g,String);
    str := "PolycyclicGroup< ";
    Append(str, JoinStringsWithSeparator(gens));
    Append(str, " |\n");
    rels := [];
    for i in [1..n] do
        if r[i] = 0 then continue; fi;
        if IsOne(g[i]^r[i]) then
            Add(rels, Concatenation(String(g[i]), "^", String(r[i])));
        else
            Add(rels, Concatenation(String(g[i]), "^", String(r[i]),
                           " = ", String(g[i]^r[i])));
        fi;
    od;
    for i in [2..n] do
        for j in [1..i-1] do
            if g[i]*g[j] <> g[j]*g[i] then
                Add(rels, Concatenation(String(g[i]), "^", String(g[j]), 
                           " = ", String(g[i]^g[j])));
                if r[j] = 0 then
                    Add(rels, Concatenation(String(g[i]), "^", String(g[j]), 
                           "^-1 = ", String(g[i]^(g[j]^-1))));
                fi;
            fi;
        od;
    od;
    Append(str, JoinStringsWithSeparator(rels, ",\n"));
    Append(str, "\n>;\n");
    return str;
end );

###############################################################################
##  This function has been converted from private code of Frank Lübeck. 
##  His GapToMagma(file,mats) wrote Magma code to a file 'file' for the group 
##  generated by a list 'mats' of matrices over same finite field. 
##  In this revised form the function inputs a matrix group over a finite 
##  field and outputs a string which can be read by Magma. 
##
InstallMethod( MatrixGroupToMagmaFormat, "matrix group over a finite field", 
    true, [ IsMatrixGroup ], 0, 
    function(G)

    local mats, nr, nc, F, tab, p, q, e, w, wp, pow, zero, one, val, cpn, npl,
          NmrIter, FinalIter, i, j, cno, isint, matrix, str;

    mats := GeneratorsOfGroup( G );
    F := Field( Flat( mats ) );
    if not IsFinite( F ) then
      TryNextMethod();
    fi;
    p := Characteristic( F ); 
    e := DegreeOverPrimeField( F ); 
    q := Size( F );
    w := PrimitiveRoot( F );
    zero := Zero( F ); 
    one := One( F );
    matrix := mats[1];
    nr := Length( matrix ); 
    nc := Length( matrix[1] );
    str := Concatenation( "F := ", String(F), ";\n" );
    Append( str, Concatenation( "P := GL(", String(nr), ",F);\n" ) );
    matrix := mats;
    if ( e > 1 ) then
        Append( str, "w := PrimitiveElement(F);\n" );
    fi;

    pow := (q-1)/(p-1);
    wp := w^pow;
    tab := [ ];
    for i in [1..p-1] do
        tab[ LogFFE( i*one, wp ) + 1 ] := i;
    od;

    if ( p < 10 ) then 
        cpn := 3; 
    elif ( p < 100 ) then 
        cpn := 4; 
    elif ( p < 1000 ) then 
        cpn := 5;
    elif ( p < 10000 ) then 
        cpn := 6; 
    else 
        cpn := 7; 
    fi;
    if ( e > 1 ) then 
        cpn := cpn + 2; 
    fi;
    npl := Int(76/(cpn));  ## should be 78, but it overflowed.

    Append( str, "gens := [\n");

    FinalIter := Length( mats );
    NmrIter := 0;
    for matrix in mats do
        NmrIter := NmrIter + 1;
        nr := Length( matrix ); 
        nc := Length( matrix[1] );
        Append( str, "P![" );
        for i in [1..nr] do
            cno := 0;
            for j in [1..nc] do
                if ( matrix[i][j] = zero ) then
                    val := 0; 
                    isint := true;
                else
                    val := LogFFE( matrix[i][j], w );
                    if ( val mod pow = 0 ) then
                        val := tab[ LogFFE( matrix[i][j], wp ) + 1]; 
                        isint := true;
                    else
                        isint := false;
                    fi;
                fi;
                if ( q<10 ) or ( q<100 and val>=10 ) 
                            or ( q<1000 and val>=100 )
                            or ( q<10000 and val>=1000 ) 
                            or ( val>=10000 ) then
                    if not (i = 1 and j = 1) then 
                        Append( str, "," );
                    fi;
                elif ( q<100 ) or ( q<1000 and val>=10 ) 
                               or ( q<10000 and val>=100 )
                               or ( val>=1000 ) then
                    if not (i = 1 and j = 1) then 
                        Append( str, " , " );
                    fi;
                elif ( q<1000 ) or ( q<10000 and val>=10 ) 
                                or ( val>=100 ) then
                    if not (i = 1 and j = 1) then 
                        Append( str, " , " );
                    fi;
                elif ( q<10000 ) or ( val>=10 ) then
                    if not (i = 1 and j = 1) then 
                        Append( str, "  , " );
                    fi;
                else
                    if not (i = 1 and j = 1) then 
                        Append( str, "   , " );
                    fi;
                fi;
                if ( e > 1 ) then
                    if isint then 
                        Append( str, " " ); 
                    else 
                        Append( str, "w^" ); 
                    fi;
                fi;
                Append( str, String(val) );
                cno := cno+1;
                if ( cno>=npl and j<nc ) then
                    Append( str, "\n "); 
                    cno := 0;
                fi;
            od;
        od;
        if ( NmrIter <> FinalIter ) then 
            Append( str, "],\n" );
        else 
            Append( str, "]\n" );
        fi;
    od;
    Append( str, "];\n" );
    Append( str, "sub<P | gens>;\n" );
    return str;
end );

#############################################################################
##
#E  magma.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

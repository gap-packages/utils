#############################################################################
##
#W  magma.gi                  GAP4 package `Utils'                   Max Horn
##                                                           Alexander Hulpke
##                                                          
#Y  Copyright (C) 2015-2017, The GAP Group 

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
        elif IsFpGroup( obj ) then 
            Error( "no conversion function yet available for fp-groups" ); 
        ##  str := FpGroupToMagmaFormat( obj ); 
        else 
            Error( "no conversion function yet available for this group" ); 
        fi; 
        if ( len > 1 ) then 
            s := arg[2]; 
            str := Concatenation( s, ":=", str ); 
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
    if IsPcpGroup(G) then
        g := Pcp(G);
        r := RelativeOrders(Collector(G));
        n := Length(r);
        gens := List(g,String);
    else
        g := Pcgs(G);
        n := Length(g);
        r := RelativeOrders(g);
        gens := List(g,String);
    fi;
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

#############################################################################
##
#E  magma.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

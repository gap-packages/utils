#############################################################################
##
#W  latex.gi                  GAP4 package `Utils'                Stefan Kohl
##
#Y  Copyright (C) 2015-2016, The GAP Group  

#############################################################################
##  this function has been transferred from ResClasses 
##
#F  IntOrInfinityToLaTeX( n ) .  LaTeX string for a given integer or infinity
##
InstallGlobalFunction( IntOrInfinityToLaTeX,

  function( n )
    if   IsInt(n)      then return String(n);
    elif IsInfinity(n) then return "\\infty";
    else return fail; fi;
  end );

#############################################################################
##  this function has been transferred from RCWA 
##
#F  LaTeXStringFactorsInt( <n> ) . . . . prime factorization in LaTeX format
##
InstallGlobalFunction( LaTeXStringFactorsInt,

  function ( n )

    local  facts, str, i; 

    if   not IsInt(n) then
      Error("usage: LaTeXStringFactorsInt( <n> ) for an integer <n>"); 
    fi;
    if n < 0 then str := "-"; n := -n; 
             else str := ""; 
    fi;
    facts := Collected(Factors(n));
    for i in [1..Length(facts)] do
      Append(str,String(facts[i][1]));
      if facts[i][2] > 1 then
        Append(str,"^");
        if facts[i][2] >= 10 then Append(str,"{"); fi;
        Append(str,String(facts[i][2]));
        if facts[i][2] >= 10 then Append(str,"}"); fi;
      fi;
      if i < Length(facts) then Append(str," \\cdot "); fi;
    od;
    return str;
  end );

#############################################################################
##
#E  latex.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

#############################################################################
##
#W  latex.gi                  GAP4 package `Utils'              Chris Wensley
##
##  version 0.12, 01/12/2015 
##
#Y  Copyright (C) 2015, Chris Wensley et al,  

#############################################################################
##  this function transferred from ResClasses 
##
#F  IntOrInfinityToLaTeX( n ) .  LaTeX string for a given integer or infinity
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "IntOrInfinityToLaTeX" )] = 0 ) then 

InstallGlobalFunction( IntOrInfinityToLaTeX,

  function( n )
    if   IsInt(n)      then return String(n);
    elif IsInfinity(n) then return "\\infty";
    else return fail; fi;
  end );

fi; 

#############################################################################
##
#E  latex.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

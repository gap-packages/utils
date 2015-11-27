#############################################################################
##
#W  lists.gi                  GAP4 package `Utils'              Chris Wensley
##
##  version 0.11, 27/11/2015 
##
#Y  Copyright (C) 2015, Chris Wensley et al,  
#Y  School of Computer Science, Bangor University, U.K. 

#############################################################################
##  this function transferred from Gpd 
##
#M  PrintListOneItemPerLine( <list> )
##
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

#############################################################################
##  these functions transferred from ResClasses 
##
#F  DifferencesList( <list> ) . . . . differences of consecutive list entries
#F  QuotientsList( <list> ) . . . . . . quotients of consecutive list entries
#F  FloatQuotientsList( <list> )  . . . . . . . . . . . . dito, but as floats
##

if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "DifferencesList" )] = 0 ) then 
InstallGlobalFunction( DifferencesList,
                       list -> List( [ 2..Length(list) ],
                                     pos -> list[ pos ] - list[ pos-1 ] ) );
fi;

if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "QuotientsList" )] = 0 ) then 
InstallGlobalFunction( QuotientsList,
                       list -> List( [ 2 .. Length( list ) ],
                                     pos -> list[ pos ] / list[ pos-1 ] ) );
fi;

if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "FloatQuotientsList" )] = 0 ) then 
InstallGlobalFunction( FloatQuotientsList,
                       list -> List( QuotientsList( list ), Float ) );
fi;

#############################################################################
##  this function transferred from ResClasses 
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
##
#E  lists.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

#############################################################################
##
#W  lists.gi                  GAP4 package `XMod'               Chris Wensley
##
##  version 0.11, 12/11/2015 
##
#Y  Copyright (C) 2015, Chris Wensley et al,  
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

#############################################################################
##
#E  lists.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

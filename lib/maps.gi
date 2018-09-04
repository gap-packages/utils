#############################################################################
##
#W  maps.gi                  GAP4 package `Utils'                 Stefan Kohl 
##
#Y  Copyright (C) 2015-2016, The GAP Group 

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

#############################################################################
##
#E  maps.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

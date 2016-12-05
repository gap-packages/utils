#############################################################################
##
#W  maps.gi                  GAP4 package `Utils'                 Stefan Kohl 
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  these three functions were in RCWA and were initially transferred
##  to simplify the situation, just EpimorphismByGenerators has been retained 
##
#F  EpimorphismByGenerators( <D1>, <D2> ) . epi: gen's of <D1>->gen's of <D2>
#M  EpimorphismByGeneratorsNC( <D1>, <D2> ) .  NC version as underlying oper.
#M  EpimorphismByGeneratorsNC( <G>, <H> ) . . . . . . . . . . . .  for groups
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

fi; 

#############################################################################
##
#E  maps.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

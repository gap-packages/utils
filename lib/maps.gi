#############################################################################
##
#W  maps.gi                  GAP4 package `Utils'                 Stefan Kohl 
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  these functions have been transferred from RCWA
##
#F  EpimorphismByGenerators( <D1>, <D2> ) . epi: gen's of <D1>->gen's of <D2>
#M  EpimorphismByGeneratorsNC( <D1>, <D2> ) .  NC version as underlying oper.
#M  EpimorphismByGeneratorsNC( <G>, <H> ) . . . . . . . . . . . .  for groups
##
InstallMethod( EpimorphismByGeneratorsNC, "for groups", ReturnTrue, 
    [ IsGroup, IsGroup ], 0,

    function ( G, H )
    return GroupHomomorphismByImagesNC(G,H,GeneratorsOfGroup(G),
                                           GeneratorsOfGroup(H));
    end );

InstallGlobalFunction( EpimorphismByGenerators,
  function ( D1, D2 )
    return EpimorphismByGeneratorsNC( D1, D2 );
  end );

fi; 

#############################################################################
##
#E  maps.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

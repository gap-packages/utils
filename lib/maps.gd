##############################################################################
##
#W  maps.gd                     GAP4 package `Utils'               Stefan Kohl
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  these functions have been transferred from RCWA 
##
#F  EpimorphismByGenerators( <D1>, <D2> ) .epi.: gen's of <D1>->gen's of <D2>
#O  EpimorphismByGeneratorsNC( <D1>, <D2> ) .  NC version as underlying oper.
#M  EpimorphismByGeneratorsNC( <G>, <H> ) . . . . . . . . . . . .  for groups
##
DeclareOperation( "EpimorphismByGeneratorsNC", [ IsDomain, IsDomain ] );
DeclareGlobalFunction( "EpimorphismByGenerators" );

fi; 

#############################################################################
##
#E  maps.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

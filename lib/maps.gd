##############################################################################
##
#W  maps.gd                     GAP4 package `Utils'               Stefan Kohl
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  these three functions were in RCWA and were initially transferred
##  to simplify the situation, just EpimorphismByGenerators has been retained 
##
#O  EpimorphismByGenerators( <D1>, <D2> ) . epi: gen's of <D1>->gen's of <D2>
#O  EpimorphismByGeneratorsNC( <D1>, <D2> ) . . NC version as underlying oper
#M  EpimorphismByGeneratorsNC( <G>, <H> ) . . . . . . . . . . . .  for groups
##
DeclareOperation( "EpimorphismByGenerators", [ IsDomain, IsDomain ] );

fi; 

#############################################################################
##
#E  maps.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

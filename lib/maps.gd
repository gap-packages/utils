##############################################################################
##
#W  maps.gd                     GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "XMod" ) then

#############################################################################
##  these functions have been transferred from XMod 
##
#A  IsomorphismFpInfo( <G> )
#A  IsomorphismPermInfo( <G> )
#A  IsomorphismPcInfo( <G> )
#A  IsomorphismPermOrPcInfo( <G> )
##
DeclareAttribute( "IsomorphismFpInfo", IsGroup, "mutable" );
DeclareAttribute( "IsomorphismPermInfo", IsGroup, "mutable" );
DeclareAttribute( "IsomorphismPcInfo", IsGroup, "mutable" );
DeclareAttribute( "IsomorphismPermOrPcInfo", IsGroup, "mutable" );

fi; 

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

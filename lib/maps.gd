##############################################################################
##
#W  maps.gd                     GAP4 package `Utils'               Stefan Kohl
##                                                               Chris Wensley
#Y  Copyright (C) 2015-2019, The GAP Group 

#############################################################################
##  these three functions were in RCWA and were initially transferred but, 
##  to simplify the situation, just EpimorphismByGenerators has been retained 
##
#O  EpimorphismByGenerators( <D1>, <D2> ) . epi: gen's of <D1>->gen's of <D2>
#O  EpimorphismByGeneratorsNC( <D1>, <D2> ) . . NC version as underlying oper
#M  EpimorphismByGeneratorsNC( <G>, <H> ) . . . . . . . . . . . .  for groups
##
DeclareOperation( "EpimorphismByGenerators", [ IsDomain, IsDomain ] );

#############################################################################
## 
#O  Pullback( <nu>, <mu> ) 
#A  PullbackInfo( <pb> ) 
## 
DeclareOperation( "Pullback", [ IsGroupHomomorphism, IsGroupHomomorphism ] ); 
DeclareAttribute( "PullbackInfo", IsGroup, "mutable" );

#############################################################################
##
#O  CentralProduct( <G1>, <G2>, <Z1>, <Phi> )
#A  CentralProductInfo( <cp> )
##
DeclareOperation( "CentralProduct",
    [ IsGroup, IsGroup, IsGroup, IsGroupHomomorphism ] );
DeclareAttribute( "CentralProductInfo", IsGroup, "mutable" );

#############################################################################
##  these functions compute idempotent endomorphisms on G with image R 
## 
#O  IdempotentEndomorphisms( <G> ) 
#A  IdempotentEndomorphismsWithImage( <genG>, <R> ) 
#A  IdempotentEndomorphismsData( <G> ) 
## 
DeclareOperation( "IdempotentEndomorphisms", [ IsGroup ] );
DeclareOperation( "IdempotentEndomorphismsWithImage", [ IsList, IsGroup ] );
DeclareAttribute( "IdempotentEndomorphismsData", IsGroup );

#############################################################################
## 
#O  DirectProductOfFunctions( <G>, <H>, <f1>, <f2> ) 
#O  DirectProductOfAutomorphismGroups( <A1>, <A2> ) 
##
DeclareOperation( "DirectProductOfFunctions", 
    [ IsGroup, IsGroup, IsGroupHomomorphism, IsGroupHomomorphism ] );
DeclareOperation( "DirectProductOfAutomorphismGroups", [ IsGroup, IsGroup ] );

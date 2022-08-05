##############################################################################
##
#W  lcset.gd                  GAP4 package `Utils'               Chris Wensley
##
#Y  Copyright (C) 2015-2022, The GAP Group 

#############################################################################
##
#C  IsLeftCoset( <obj> ) . . . . . . . . . . . . . . coset of the form gU
#R  IsLeftCosetDefaultRep
#V  IsLeftCosetFamily 
#T  IsLeftCosetType 
##
DeclareCategory( "IsLeftCoset", IsDomain and IsExternalOrbit ); 
DeclareRepresentation( "IsLeftCosetDefaultRep",
    IsComponentObjectRep and IsAttributeStoringRep and IsLeftCoset, 
    [ "Representative", "ActingDomain" ] ); 
BindGlobal( "IsLeftCosetFamily", NewFamily( "IsLeftCosetFamily", 
            IsMultiplicativeElementWithInverse ) ); 
BindGlobal( "IsLeftCosetType", 
            NewType( IsLeftCosetFamily, IsLeftCosetDefaultRep ) ); 

#############################################################################
##
#O  LeftCoset( <g>, <U> ) . . . . . . . element g acts on the left of group U 
##
DeclareOperation( "LeftCoset", [ IsObject, IsGroup ] ); 

#############################################################################
##
#O  LeftCosets( <G>, <U> ) . . . . . . . . . . . . . . . cosets gU for g in G 
#O  LeftCosetsNC( <G>, <U> ) . . . . . . . . . . . . . . cosets gU for g in G 
##
DeclareGlobalFunction( "LeftCosets" ); 
DeclareOperation( "LeftCosetsNC", [ IsGroup, IsGroup ] ); 

##############################################################################
##
#W  lcset.gd                  GAP4 package `Utils'               Chris Wensley
##
#Y  Copyright (C) 2015-2022, The GAP Group 

#############################################################################
##
#C  IsLeftCosetObj( <obj> ) . . . . . . . . . . . . . . coset of the form gU
#R  IsLeftCosetDefaultRep
#V  IsLeftCosetFamily 
#T  IsLeftCosetType 
#P  IsLeftCoset 
##
DeclareCategory( "IsLeftCosetObj", IsDomain and IsExternalOrbit ); 
DeclareRepresentation( "IsLeftCosetDefaultRep",
    IsComponentObjectRep and IsAttributeStoringRep and IsLeftCosetObj, 
    [ "Representative", "ActingDomain" ] ); 
BindGlobal( "IsLeftCosetFamily", NewFamily( "IsLeftCosetFamily", 
            IsMultiplicativeElementWithInverse ) ); 
BindGlobal( "IsLeftCosetType", 
            NewType( IsLeftCosetFamily, IsLeftCosetDefaultRep ) ); 
DeclareProperty( "IsLeftCoset", IsLeftCosetObj ); 

#############################################################################
##
#A  AssociatedLeftCoset( <rc> ) . . . . . . . . . . . . . . . . gU <--> Ug^-1
#A  AssociatedRightCoset( <lc> ) . . . . . . . . . . . . . . .  gU <--> Ug^-1
##
DeclareAttribute( "AssociatedLeftCoset", IsRightCoset );
DeclareAttribute( "AssociatedRightCoset", IsLeftCoset );

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

#############################################################################
##

##


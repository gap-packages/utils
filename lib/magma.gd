##############################################################################
##
#W  magma.gd                   GAP4 package `Utils'                   Max Horn
##                                                            Alexander Hulpke
##                                                   
#Y  Copyright (C) 2015-2017, The GAP Group 

#############################################################################
##  these functions are new in Utils but call functions which have been 
##  transferred from the main library or from private code
##
#F  ConvertToMagmaInputString( <arg> )  . . output a string readable by Magma
#F  ConvertFromMagmaOutputString( <arg> ) . input Magma string readable by GAP
##
DeclareGlobalFunction( "ConvertToMagmaInputString" );
DeclareGlobalFunction( "ConvertFromMagmaOutputString" );

#############################################################################
##  this function was originally authored by Alexander Hulpke; 
##  has been transferred from other.gd in the main library; 
##  and was originally named MagmaInputString
## 
#O  PermGroupToMagmaFormat( <g> ) 
##
DeclareOperation( "PermGroupToMagmaFormat", [ IsPermGroup ] ); 

#############################################################################
##  this function was private code of Max Horn 
## 
#O  PcGroupToMagmaFormat( <G> ) 
##
DeclareOperation( "PcGroupToMagmaFormat", [ IsPcGroup ] ); 

#############################################################################
##
#E  magma.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

##############################################################################
##
#W  magma.gd                   GAP4 package `Utils'                   Max Horn
##                                                            Alexander Hulpke
##                                                   
#Y  Copyright (C) 2015-2017, The GAP Group 

#############################################################################
##  this function is new in Utils but calls functions which have been 
##  transferred from the main library or from private code
##
#F  ConvertToMagmaInputString( <arg> )  . . output a string readable by Magma
##
DeclareGlobalFunction( "ConvertToMagmaInputString" );

#############################################################################
##  this function was originally authored by Alexander Hulpke; 
##  it has been transferred from other.gd in the main library; 
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
##  this function was private code of Frank Lübeck 
## 
#O  MatrixGroupToMagmaFormat( <G> ) 
##
DeclareOperation( "MatrixGroupToMagmaFormat", [ IsMatrixGroup ] ); 

#############################################################################
##
#E  magma.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

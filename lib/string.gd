##############################################################################
##
#W  string.gd                  GAP4 package `Utils'          Sebastian Gutsche
##                                                   
##  version 0.25, 11/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  these functions transferred from ResClasses 
##
#F  BlankFreeString( <obj> )  . . . . . . . . . . . . . string without blanks
##
DeclareGlobalFunction( "BlankFreeString" );

fi; 

#############################################################################
##  this function transferred from AutoDoc, 
##  originally AUTODOC_GetSuffix 
##
#O  StringDotSuffix( <str>, <suf> ) 
##
DeclareOperation( "StringDotSuffix", [ IsString ] ); 


#############################################################################
##
#E  string.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

##############################################################################
##
#W  string.gd                  GAP4 package `Utils'          Sebastian Gutsche
##                                                                 Stefan Kohl
##                                                   
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  this function has been transferred from ResClasses 
##
#F  BlankFreeString( <obj> )  . . . . . . . . . . . . . string without blanks
##
DeclareGlobalFunction( "BlankFreeString" );

fi; 

#############################################################################
##  this function has been transferred from AutoDoc, 
##  and was originally named AUTODOC_GetSuffix 
##
#O  StringDotSuffix( <str>, <suf> ) 
##
DeclareOperation( "StringDotSuffix", [ IsString ] ); 


#############################################################################
##
#E  string.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

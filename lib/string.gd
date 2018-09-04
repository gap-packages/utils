##############################################################################
##
#W  string.gd                  GAP4 package `Utils'          Sebastian Gutsche
##                                                                 Stefan Kohl
##                                                   
#Y  Copyright (C) 2015-2016, The GAP Group 

#############################################################################
##  this function has been transferred from ResClasses 
##
#F  BlankFreeString( <obj> )  . . . . . . . . . . . . . string without blanks
##
DeclareGlobalFunction( "BlankFreeString" );

#############################################################################
##  this function has been copied from AutoDoc, 
##  and was originally named AUTODOC_GetSuffix 
##  the original still exists: AutoDoc is used by most packages, 
##  so it is unreasonable for it to make Utils a required package.
##
#O  StringDotSuffix( <str>, <suf> ) 
##
DeclareOperation( "StringDotSuffix", [ IsString ] ); 

#############################################################################
##
#E  string.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

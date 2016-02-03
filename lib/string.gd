##############################################################################
##
#W  string.gd                  GAP4 package `Utils'               Stefan Kohl
##
##  version 0.21, 02/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  these functions transferred from ResClasses 
##
#F  BlankFreeString( <obj> )  . . . . . . . . . . . . . string without blanks
#F  QuotesStripped( <str> ) . . . . . . . . . . .  string with quotes removed
##
DeclareGlobalFunction( "BlankFreeString" );
DeclareGlobalFunction( "QuotesStripped" );

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

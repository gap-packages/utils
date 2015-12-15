##############################################################################
##
#W  string.gd                  GAP4 package `Utils'               Stefan Kohl
##
##  version 0.13, 15/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

#############################################################################
##  these functions transferred from ResClasses 
##
#F  BlankFreeString( <obj> )  . . . . . . . . . . . . . string without blanks
#F  QuotesStripped( <str> ) . . . . . . . . . . .  string with quotes removed
##
DeclareGlobalFunction( "BlankFreeString" );
DeclareGlobalFunction( "QuotesStripped" );

#############################################################################
##  these functions transferred from AutoDoc
##
#O  StringDotSuffix( <str>, <suf> ) 
##
DeclareOperation( "StringDotSuffix", [ IsString ] ); 


#############################################################################
##
#E  string.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

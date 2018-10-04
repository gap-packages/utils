##############################################################################
##
#W  app-meth.gd                 GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2018, The GAP Group 

#############################################################################
##  these functions are an attempt to replace GAP's ApplicableMethod
##
#F  ApplicableMethodUtils( <fn>, <params> ) 
#F  PrintApplicableMethodUtils( <fn>, <params> ) 
#F  ApplicableMethodResetUtils( <fn>, <params> ) 
#F  ApplicableMethodSetupUtils( <fn>, <params> ) 
#F  ApplicableMethodPrintLevelUtils( <val> ) 
##
DeclareGlobalFunction( "ApplicableMethodUtils" );
DeclareGlobalFunction( "PrintApplicableMethodUtils" );
DeclareGlobalFunction( "ApplicableMethodResetUtils" );
DeclareGlobalFunction( "ApplicableMethodSetupUtils" );
DeclareGlobalFunction( "ApplicableMethodPrintLevelUtils" );

#############################################################################

APPLICABLE_METHODS_RECORD := rec(); 
APPLICABLE_METHODS_RECORD.reset := true; 

#############################################################################
##
#E  app-meth.gd . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
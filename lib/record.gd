##############################################################################
##
#W  record.gd                   GAP4 package `Utils'         Sebastian Gutsche
##                                                           Max Horn 
##                                                           Stefan Kohl 
##  version 0.25, 11/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

#############################################################################
##  this function transferred from AutoDoc, 
##  was originally AUTODOC_WriteOnce and then AUTODOC_SetIfMissing  
##
#F  SetIfMissing( <rec>, <name>, <val> ) 
##
DeclareGlobalFunction( "SetIfMissing" );

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  this function transferred from RCWA
##
#F  AssignGlobals( <record> )
##
##  This auxiliary function assigns the record components of <record> to
##  global variables with the same names.
##
DeclareGlobalFunction( "AssignGlobals" );

fi; 

#############################################################################
##
#E  record.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

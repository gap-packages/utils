##############################################################################
##
#W  files.gd                    GAP4 package `Utils'         Sebastian Gutsche
##                                                                    Max Horn
##                                                                 Stefan Kohl
#Y  Copyright (C) 2015-2018, The GAP Group 

#############################################################################
##  these functions have been copied from AutoDoc  
##  they were originally named AUTODOC_CreateDirIfMissing 
##  and AUTODOC_FindMatchingFiles
##  the originals still exist: AutoDoc is used by most packages, 
##  so it is unreasonable for it to make Utils a required package.
##
#F  CreateDirIfMissing( <str> )
#F  FindMatchingFiles( <args> )
##
DeclareGlobalFunction( "CreateDirIfMissing" );
DeclareGlobalFunction( "FindMatchingFiles" );

#############################################################################
##  this function has been transferred from RCWA 
##
#F  Log2HTML ( logfilename )
##
##  Utility to convert GAP log files to XHTML 1.0 Strict.
##
##  Usage:
##
##  - Issue Log2HTML( <logfilename> ). The extension of the input file must
##    be *.log. The name of the output file is the same as the one of the
##    input file except that the extension *.log is replaced by *.html.
##
##  - Adapt the style file rcwa/doc/gaplog.css to your taste.
##
DeclareGlobalFunction( "Log2HTML" );

#############################################################################
##
#E  files.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

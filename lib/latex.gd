##############################################################################
##
#W  latex.gd                    GAP4 package `Utils'               Stefan Kohl
##
##  version 0.21, 03/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  this function transferred from ResClasses 
##
#F  IntOrInfinityToLaTeX( n ) . LaTeX string representing integer or infinity
##
DeclareGlobalFunction( "IntOrInfinityToLaTeX" );

fi; 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  this function transferred from RCWA
##
#F  LaTeXStringFactorsInt( <n> )
##
##  Returns the prime factorization of the integer <n> as a string in LaTeX
##  format.
##
DeclareGlobalFunction( "LaTeXStringFactorsInt" );

fi; 

#############################################################################
##
#E  latex.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

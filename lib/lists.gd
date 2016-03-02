##############################################################################
##
#W  lists.gd                    GAP4 package `Utils'               Stefan Kohl
##                                                               Chris Wensley
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "XMod" ) then

##############################################################################
##  this function has been transferred from XMod 
##
#O  PrintListOneItemPerLine( <L> )
##  
DeclareOperation( "PrintListOneItemPerLine", [ IsList ] );

fi; 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  these functions have been transferred from ResClasses 
##
#F  DifferencesList( <list> ) . . . . differences of consecutive list entries
#F  QuotientsList( <list> ) . . . . . . quotients of consecutive list entries
#F  FloatQuotientsList( <list> )  . . . . . . . . . . . . dito, but as floats
##
DeclareGlobalFunction( "DifferencesList" );
DeclareGlobalFunction( "QuotientsList" );
DeclareGlobalFunction( "FloatQuotientsList" );

#############################################################################
##  this function has been transferred from ResClasses 
##
#F  RandomCombination( S, k )
##
##  Returns a random unordered <k>-tuple of distinct elements of the set <S>.
##
DeclareOperation( "RandomCombination", [ IsListOrCollection, IsPosInt ] );

fi; 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  this function has been transferred from RCWA 
##
#F  SearchCycle( <l> ) . . . a utility function for detecting cycles in lists
##
DeclareGlobalFunction( "SearchCycle" );

fi; 

#############################################################################
##
#E  lists.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

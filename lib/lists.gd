##############################################################################
##
#W  lists.gd                    GAP4 package `Utils'             Chris Wensley
##
##  version 0.11, 27/11/2015 
##
#Y  Copyright (C) 2015, Chris Wensley et al,  
#Y  School of Computer Science, Bangor University, U.K. 

##############################################################################
##  this function transferred from Gpd 
##
#O  PrintListOneItemPerLine( <L> )
##  
DeclareOperation( "PrintListOneItemPerLine", [ IsList ] );

#############################################################################
##  these functions transferred from ResClasses 
##
#F  DifferencesList( <list> ) . . . . differences of consecutive list entries
#F  QuotientsList( <list> ) . . . . . . quotients of consecutive list entries
#F  FloatQuotientsList( <list> )  . . . . . . . . . . . . dito, but as floats
##
DeclareGlobalFunction( "DifferencesList" );
DeclareGlobalFunction( "QuotientsList" );
DeclareGlobalFunction( "FloatQuotientsList" );

DeclareGlobalFunction( "SumsOfCubes" ); 

#############################################################################
##  this function transferred from ResClasses 
##
#F  RandomCombination( S, k )
##
##  Returns a random unordered <k>-tuple of distinct elements of the set <S>.
##
DeclareOperation( "RandomCombination", [ IsListOrCollection, IsPosInt ] );

#############################################################################
##
#E  lists.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

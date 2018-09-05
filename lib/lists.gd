##############################################################################
##
#W  lists.gd                    GAP4 package `Utils'               Stefan Kohl
##
#Y  Copyright (C) 2015-2018, The GAP Group 

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

#############################################################################
##  this function has been transferred from RCWA 
##
#F  SearchCycle( <l> ) . . . a utility function for detecting cycles in lists
##
DeclareGlobalFunction( "SearchCycle" );

#############################################################################
##  these functions have been have been transferred from XMod 
##
#O  DistinctRepresentatives( <L> )
#O  CommonRepresentatives( <J>, <K> )
#O  CommonTransversal( <G>, <H> )
#O  IsCommonTransversal( <G>, <H>, <T> )
##
DeclareOperation( "DistinctRepresentatives", [ IsList ] );
DeclareOperation( "CommonRepresentatives", [ IsList, IsList ] );
DeclareOperation( "CommonTransversal", [ IsGroup, IsGroup ] );
DeclareOperation( "IsCommonTransversal", [ IsGroup, IsGroup, IsList ] );

#############################################################################
##
#E  lists.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

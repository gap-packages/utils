##############################################################################
##
#W  iterator.gd                 GAP4 package `Utils'             Chris Wensley
##   
#Y  Copyright (C) 2015-2019, The GAP Group 

#############################################################################
##  These functions complement AllHomomorphisms, AllEndomorphisms, and 
##  AllAutomorphisms in the main library. 
##  The code gives an example of an iterator preferrred to a list. 
## 
#O  AllIsomorphismsIterator( <G>, <H> ) 
#F  DoAllIsomorphismsIterator 
#O  AllIsomorphismsNumber( <G>, <H> ) 
#O  AllIsomorphisms( <G>, <H> ) 
## 
DeclareOperation( "AllIsomorphismsIterator", [ IsGroup, IsGroup ] );
DeclareGlobalFunction( "DoAllIsomorphismsIterator" ); 
DeclareOperation( "AllIsomorphismsNumber", [ IsGroup, IsGroup ] );
DeclareOperation( "AllIsomorphisms", [ IsGroup, IsGroup ] );

#############################################################################
##  These functions provide an iterator for all subgroups of a group. 
## 
#O  AllSubgroupsIterator( <G> ) 
#F  DoAllSubgroupsIterator  
## 
DeclareOperation( "AllSubgroupsIterator", [ IsGroup ] );
DeclareGlobalFunction( "DoAllSubgroupsIterator" ); 

#############################################################################
##  These functions provide ways of combining two iterators into one 
## 
#O  CartesianIterator( <it1> <it2> ) 
#F  DoCartesianIterator  
#O  UnorderedPairsIterator( <it> ) 
#F  DoUnorderedPairsIterator  
## 
DeclareOperation( "CartesianIterator", [ IsIterator, IsIterator ] );
DeclareGlobalFunction( "DoCartesianIterator" ); 
DeclareOperation( "UnorderedPairsIterator", [ IsIterator ] );
DeclareGlobalFunction( "DoUnorderedPairsIterator" ); 

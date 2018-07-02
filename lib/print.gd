##############################################################################
##
#W  print.gd                    GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2018, The GAP Group 

##############################################################################
##  this function has been transferred from XMod 
##
#O  PrintListOneItemPerLine( <L> )
##  
DeclareOperation( "PrintListOneItemPerLine", [ IsList ] );

##############################################################################
##  added global function and method for iterators to complement the above 
##  
#F  PrintOneItemPerLine( <args> ) 
#O  PrintIteratorOneItemPerLine( <iter> ) 
##  
DeclareGlobalFunction( "PrintOneItemPerLine" );
DeclareOperation( "PrintIteratorOneItemPerLine", [ IsIterator ] );

##############################################################################
##  added global function and methods to print subsets of lists/iterators  
##  
DeclareGlobalFunction( "PrintSelection" ); 
DeclareOperation( "PrintSelectionFromList", 
    [ IsList, IsPosInt, IsPosInt, IsPosInt ] ); 
DeclareOperation( "PrintSelectionFromIterator", 
    [ IsIterator, IsPosInt, IsPosInt, IsAdditiveElement ] ); 
DeclareOperation( "PrintSelectionFromListByList", [ IsList, IsList ] ); 
DeclareOperation( "PrintSelectionFromIteratorByList", [ IsIterator, IsList ] ); 

#############################################################################
##
#E  print.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

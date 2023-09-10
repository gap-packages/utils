############################################################################
##
#W  matrix.gd                 GAP4 package `Utils'             Chris Wensley
##   
#Y  Copyright (C) 2023, The GAP Group 

#############################################################################
##  This function ... 
## 
#O  DirectSumDecompositionMatrices( <M> ) 
## 
DeclareOperation( "DirectSumDecompositionMatrices", 
    [ IsMatrixOrMatrixObj ] );
DeclareOperation( "DirectSumBlock", 
    [ IsMatrixOrMatrixObj, IsInt, IsList, IsList ] ); 

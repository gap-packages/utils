##############################################################################
##
#W  names.gd                    GAP4 package `Utils'             Chris Wensley
##
##  version 0.11, 24/11/2015 
##
#Y  Copyright (C) 2015, Chris Wensley et al,  
#Y  School of Computer Science, Bangor University, U.K. 

##  allow global functions which are being transferred to this package 
##  to be declared twice 

UTILS_FUNCTION_NAMES := 
  [ "DifferencesList", 
    "QuotientsList", 
    "FloatQuotientsList" 
  ];

UTILS_FUNCTION_STATUS := ListWithIdenticalEntries( 
    Length( UTILS_FUNCTION_NAMES ), 0 ); 

#############################################################################
##
#E  names.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

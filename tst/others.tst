##############################################################################
##
#W  others.tst                   Utils Package                    
##
#Y  Copyright (C) 2015-2016, The GAP Group 
##  

## SubSection 6.5.1 
gap> IntOrInfinityToLaTeX( 10^3 );
"1000"
gap> IntOrInfinityToLaTeX( infinity );
"\\infty"

## SubSection 6.5.2 
gap> LaTeXStringFactorsInt( Factorial(12) );
"2^{10} \\cdot 3^5 \\cdot 5^2 \\cdot 7 \\cdot 11"

#############################################################################
##
#E  others.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

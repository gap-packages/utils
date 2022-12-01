##############################################################################
##
#W  algebras.gd                 GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2022, The GAP Group 

#############################################################################
##  this function has been transferred from fr and from xmodalg
##  so as to avoid any confusion: xmodalg issue 67 by Max Horn  

if OKtoReadFromUtils( "xmodalg" ) and OKtoReadFromUtils( "fr" ) then 

DeclareOperation( "AlgebraHomomorphismByFunction",
    [ IsAlgebra, IsAlgebra, IsFunction ] );

fi;

#############################################################################
##
#E  algebras.gd . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

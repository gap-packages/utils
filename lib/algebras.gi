##############################################################################
##
#W  algebras.gi                 GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2022, The GAP Group 

#############################################################################
##  this function has been transferred from fr and from xmodalg
##  so as to avoid any confusion: xmodalg issue 67 by Max Horn  

if OKtoReadFromUtils( "xmodalg" ) and OKtoReadFromUtils( "fr" ) then 

InstallMethod( AlgebraHomomorphismByFunction, 
    "for two algebras and a function", [IsAlgebra,IsAlgebra,IsFunction],
function( S, R, f )
    return Objectify( 
               TypeOfDefaultGeneralMapping( S, R,
                   IsSPMappingByFunctionRep and IsAlgebraHomomorphism ),
               rec( fun := f ) );
end);

fi;

#############################################################################
##
#E  algebras.gi . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

##############################################################################
##
#W  combinat.gd                 GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2016, The GAP Group 

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
#E  combinat.gd . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

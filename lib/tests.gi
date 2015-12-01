#############################################################################
##
#W  tests.gi                  GAP4 package `Utils'              Chris Wensley
##
##  version 0.11, 25/11/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

##############################################################################
##
#M  IsAbelianModule( <obj> )
##
InstallMethod( IsAbelianModule, "generic method for 2d-group objects",
    true, [ Is2dGroup ], 0,
function( obj )
    return ( IsPermGroup( Source( obj ) ) and IsPermGroup( Range( obj ) ) );
end );

##############################################################################
##
#M  IsomorphismFpInfo( <G> ) . . . . . . . . . . . . isomorphic fp-group for G
##
InstallOtherMethod( IsomorphismFpInfo, "for a group", true, [ IsGroup ], 0,
function( grp )

    local  iso, inv, fp, mgi;
    iso := IsomorphismFpGroup( grp );
    fp := ImagesSource( iso );
    mgi := MappingGeneratorsImages( iso );
    inv := GroupHomomorphismByImagesNC( fp, grp, mgi[2], mgi[1] );
    if IsPermGroup( grp ) then
        SetIsomorphismPermInfo( fp,
            rec( perm := grp, g2perm := inv, perm2g := iso ) );
    fi;
    SetIsomorphismFpInfo( grp, 
        rec( fp := fp, g2fp := iso, fp2g := inv ) );
    return rec( fp := fp, g2fp := iso, fp2g := inv );
end );

#############################################################################
##
#E  tests.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

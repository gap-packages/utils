#############################################################################
##
#W  maps.gi                   GAP4 package `XMod'               Chris Wensley
##
##  version 0.21, 02/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

if OKtoReadFromUtils( "XMod" ) then
Print( "reading XMod functions from maps.gi\n" ); 

##############################################################################
##  this method transferred from XMod 
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

##############################################################################
##  this method transferred from XMod 
##
#M  IsomorphismPermInfo( <G> ) . . . . . . . . . . isomorphic perm group for G
##
InstallOtherMethod( IsomorphismPermInfo, "for a group", true, [ IsGroup ], 0,
function( grp )

    local  iso, inv, perm, mgi;
    iso := IsomorphismPermGroup( grp );
    perm := ImagesSource( iso );
    mgi := MappingGeneratorsImages( iso );
    inv := GroupHomomorphismByImagesNC( perm, grp, mgi[2], mgi[1] );
    if IsFpGroup( grp ) then
        SetIsomorphismFpInfo( perm,
            rec( fp := grp, g2fp := inv, fp2g := iso ) );
    fi;
    SetIsomorphismPermInfo( grp,
        rec( perm := perm, g2perm := iso, perm2g := inv ) );
    return rec( perm := perm, g2perm := iso, perm2g := inv );
end );

##############################################################################
##  this method transferred from XMod 
##
#M  IsomorphismPcInfo( <G> ) . . . . . . . . . . . . isomorphic pc group for G
##
InstallOtherMethod( IsomorphismPcInfo, "for a group", true, [ IsGroup ], 0,
function( grp )

    local  iso, inv, pc, mgi;
    iso := IsomorphismPcGroup( grp );
    if ( iso = fail ) then 
        return fail; 
    fi; 
    pc := ImagesSource( iso );
    mgi := MappingGeneratorsImages( iso );
    inv := GroupHomomorphismByImages( pc, grp, mgi[2], mgi[1] );
    if IsFpGroup( grp ) then
        SetIsomorphismFpInfo( pc,
            rec( fp := grp, g2fp := inv, fp2g := iso ) ); 
    elif IsPermGroup( grp ) then 
        SetIsomorphismPermInfo( pc, 
            rec( perm := grp, g2perm := inv, pc2g := iso ) ); 
    fi;
    SetIsomorphismPcInfo( grp,
        rec( pc := pc, g2pc := iso, pc2g := inv ) );
    return rec( pc := pc, g2pc := iso, pc2g := inv );
end );

##############################################################################
##  this method transferred from XMod 
##
#M  IsomorphismPermOrPcInfo( <G> ) . . . . . isomorphic perm or pc group for G
##
InstallOtherMethod( IsomorphismPermOrPcInfo, "for a group", true, 
    [ IsGroup ], 0,
function( grp )

    local  id, info1, info2, iso1, iso2, iso, inv1, inv2, inv, perm, 
           pc, ispc; 
    if IsPermGroup( grp ) then 
        return IsomorphismPcInfo( grp );
    elif IsPcGroup( grp ) then 
        return IsomorphismPermInfo( grp ); 
    else 
        info1 := IsomorphismPermInfo( grp ); 
        perm := info1!.perm; 
        iso1 := info1!.g2perm; 
        inv1 := info1!.perm2g; 
        info2 := IsomorphismPcInfo( perm ); 
        ispc := not ( info2 = fail ); 
        if ispc then 
            pc := info2!.pc; 
            iso2 := info2!.g2pc; 
            iso := iso1 * iso2; 
            inv2 := info2!.pc2g; 
            inv := inv2 * inv1; 
            if IsFpGroup( grp ) then
                SetIsomorphismFpInfo( pc,
                    rec( fp := grp, g2fp := inv, fp2g := iso ) ); 
            fi; 
            return rec( type := "pc", pc := pc, g2pc := iso, pc2g := inv );
        else  ## return the perm info 
            return rec( type := "perm", perm := perm, 
                        g2perm := iso1, perm2g := inv1 ); 
        fi; 
    fi; 
end );

fi; 

if OKtoReadFromUtils( "RCWA" ) then
Print( "reading RCWA functions from maps.gi\n" ); 

#############################################################################
##  these methods transferred from RCWA
##
#F  EpimorphismByGenerators( <D1>, <D2> ) . epi: gen's of <D1>->gen's of <D2>
#M  EpimorphismByGeneratorsNC( <D1>, <D2> ) .  NC version as underlying oper.
#M  EpimorphismByGeneratorsNC( <G>, <H> ) . . . . . . . . . . . .  for groups
##
InstallMethod( EpimorphismByGeneratorsNC, "for groups", ReturnTrue, 
    [ IsGroup, IsGroup ], 0,

    function ( G, H )
    return GroupHomomorphismByImagesNC(G,H,GeneratorsOfGroup(G),
                                           GeneratorsOfGroup(H));
    end );

InstallGlobalFunction( EpimorphismByGenerators,
  function ( D1, D2 )
    return EpimorphismByGeneratorsNC( D1, D2 );
  end );

fi; 

#############################################################################
##
#E  maps.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

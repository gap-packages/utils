#############################################################################
##
#W  iterator.gi              GAP4 package `Utils'               Chris Wensley
##  
#Y  Copyright (C) 2015-2019, The GAP Group 

##############################################################################
##
#M  AllIsomorphismsIterator . . . . . . . . . . . . . . . for a pair of groups  
#M  DoAllIsomorphismsIterator . . . . . . . . . . . . . . for a pair of groups  
#M  AllIsomorphismsNumber . . . . . . . . . . . . . . . . for a pair of groups  
#M  AllIsomorphisms . . . . . . . . . . . . . . . . . . . for a pair of groups  
##
BindGlobal( "NextIterator_AllIsomorphisms", function ( iter ) 
    local a; 
    if not IsDoneIterator( iter ) then 
        a := NextIterator( iter!.autoIterator ); 
        return CompositionMapping( iter!.firstiso, a ); 
    fi;
    Error( "iterator is exhausted" );
end ); 

BindGlobal( "IsDoneIterator_AllIsomorphisms", 
    iter -> IsDoneIterator( iter!.autoIterator ) ); 

BindGlobal( "ShallowCopy_AllIsomorphisms", 
    iter -> rec( firstiso := iter!.firstiso, 
             autoIterator := ShallowCopy( iter!.autoIterator ) ) ); 

InstallGlobalFunction( "DoAllIsomorphismsIterator", 
function( G, H )

    local iso, autoiter, iter;

    if not IsGroup( G ) and IsGroup( H ) then 
       Error( "G,H should be groups" ); 
    fi; 
    iso := IsomorphismGroups( G, H ); 
    if ( iso = fail ) then 
        ## there are no isomorphisms so return an empty iterator 
        return IteratorList( [ ] ); 
    fi;
    autoiter := Iterator( AutomorphismGroup( G ) ); 
    iter := IteratorByFunctions( 
        rec(  firstiso := iso,
          autoIterator := ShallowCopy( autoiter ), 
          NextIterator := NextIterator_AllIsomorphisms, 
        IsDoneIterator := IsDoneIterator_AllIsomorphisms, 
           ShallowCopy := ShallowCopy_AllIsomorphisms ) ); 
    return iter;
end );

InstallMethod( AllIsomorphismsIterator, "for a pair of groups", 
    [ IsGroup, IsGroup ], 0, 
function( G, H )
    return DoAllIsomorphismsIterator( G, H ); 
end );  

InstallMethod( AllIsomorphisms, "for a pair of groups", 
    [ IsGroup, IsGroup ], 0, 
function( G, H ) 

    local iter, L, iso; 

    iter := AllIsomorphismsIterator( G, H );
    if IsDoneIterator( iter ) then 
        return [ ];
    fi;    
    L := [ ];
    for iso in iter do 
       Add( L, iso ); 
    od;
    return L; 
end ); 

InstallMethod( AllIsomorphismsNumber, "for a pair of groups", 
    [ IsGroup, IsGroup ], 0, 
function( G, H ) 

    local iter, n, iso; 

    iter := AllIsomorphismsIterator( G, H );
    if IsDoneIterator( iter ) then 
        return 0;
    fi;    
    n := 0;
    for iso in iter do 
        n := n+1; 
    od;
    return n; 
end ); 

##############################################################################
##
#M  AllSubgroupsIterator . . . . . . . . . . . . . . . . . . . . . for a group  
#M  DoAllSubgroupsIterator . . . . . . . . . . . . . . . . . . . . for a group  
##
BindGlobal( "NextIterator_AllSubgroups", function ( iter ) 

    local class, i; 

    if IsDoneIterator( iter!.subgpIterator ) then 
        class := NextIterator( iter!.classIterator ); 
        iter!.class := class; 
        iter!.subgpIterator := IteratorList( [1..Size(class)] ); 
    fi; 
    i := NextIterator( iter!.subgpIterator ); 
    return iter!.class[i]; 
end ); 

BindGlobal( "IsDoneIterator_AllSubgroups", 
    iter -> IsDoneIterator( iter!.classIterator ) 
            and IsDoneIterator( iter!.subgpIterator ) ); 

BindGlobal( "ShallowCopy_AllSubgroups", 
    iter -> rec(         class := iter!.class, 
                 classIterator := ShallowCopy( iter!.classIterator ), 
                 subgpIterator := ShallowCopy( iter!.subgpIterator ) ) ); 

InstallGlobalFunction( "DoAllSubgroupsIterator", 
function( G )

    local lat, ccs, classIterator, subgpIterator, iter;

    lat := LatticeSubgroups( G ); 
    ccs := ConjugacyClassesSubgroups( lat ); 
    classIterator := IteratorList( ccs ); 
    subgpIterator := 0; 
    iter := IteratorByFunctions( 
        rec(         class := 0,
             classIterator := ShallowCopy( classIterator ), 
             subgpIterator := IteratorList( [ ] ), 
              NextIterator := NextIterator_AllSubgroups, 
            IsDoneIterator := IsDoneIterator_AllSubgroups, 
               ShallowCopy := ShallowCopy_AllSubgroups ) ); 
    return iter;
end );

InstallMethod( AllSubgroupsIterator, "for a group", [ IsGroup ], 0, 
function( G )
    return DoAllSubgroupsIterator( G ); 
end );  

##############################################################################
##
#M  CartesianIterator . . . . . . . . . . . . . . . . . . . for two iterators  
#M  DoCartesianIterator . . . . . . . . . . . . . . . . . . for two iterators  
##
BindGlobal( "NextIterator_CartesianIterator", function ( iter ) 

    local first, second; 

    if IsDoneIterator( iter!.Iterator2Copy ) then 
        iter!.Iterator2Copy := ShallowCopy( iter!.Iterator2 ); 
        first := NextIterator( iter!.Iterator1 ); 
        iter!.first := first; 
    else 
        first := iter!.first; 
    fi; 
    second := NextIterator( iter!.Iterator2Copy ); 
    return [ first, second ]; 
end ); 

BindGlobal( "IsDoneIterator_CartesianIterator", 
    iter -> IsDoneIterator( iter!.Iterator1 ) 
            and IsDoneIterator( iter!.Iterator2Copy ) ); 

BindGlobal( "ShallowCopy_CartesianIterator", 
    iter -> rec(         first := iter!.first, 
                     Iterator1 := ShallowCopy( iter!.Iterator1 ), 
                     Iterator2 := ShallowCopy( iter!.Iterator2 ),  
                 Iterator2Copy := ShallowCopy( iter!.Iterator2Copy ) ) ); 

InstallGlobalFunction( "DoCartesianIterator", 
function( iter1, iter2 )

    local iter;

    if IsDoneIterator( iter1 ) or IsDoneIterator( iter2 ) then 
        return IteratorList( [ ] ); 
    fi;
    iter := IteratorByFunctions( 
        rec(         first := 0, 
                 Iterator1 := ShallowCopy( iter1 ), 
                 Iterator2 := ShallowCopy( iter2 ), 
             Iterator2Copy := IteratorList( [ ] ), 
              NextIterator := NextIterator_CartesianIterator, 
            IsDoneIterator := IsDoneIterator_CartesianIterator, 
               ShallowCopy := ShallowCopy_CartesianIterator ) ); 
    return iter;
end );

InstallMethod( CartesianIterator, "for two iterators", 
    [ IsIterator, IsIterator ], 0, 
function( iter1, iter2 )
    return DoCartesianIterator( iter1, iter2 ); 
end );  

##############################################################################
##
#M  UnorderedPairsIterator . . . . . . . . . . . . . . . . . . for an iterator 
#M  DoUnorderedPairsIterator . . . . . . . . . . . . . . . . . for an iterator 
##
BindGlobal( "NextIterator_UnorderedPairs", function ( iter ) 

    local first, second; 

    if ( iter!.pos1 = iter!.pos2 ) then 
        iter!.Iterator1Copy := ShallowCopy( iter!.Iterator1 ); 
        iter!.pos1 := 0;
        second := NextIterator( iter!.Iterator2 ); 
        iter!.pos2 := iter!.pos2 + 1; 
        iter!.second := second; 
    else 
        second := iter!.second; 
    fi; 
    first := NextIterator( iter!.Iterator1Copy ); 
    iter!.pos1 := iter!.pos1 + 1;
    return [ first, second ]; 
end ); 

BindGlobal( "IsDoneIterator_UnorderedPairs", 
    iter -> IsDoneIterator( iter!.Iterator2 ) 
            and IsDoneIterator( iter!.Iterator1Copy ) ); 

BindGlobal( "ShallowCopy_UnorderedPairs", 
    iter -> rec(          pos1 := iter!.pos1, 
                          pos2 := iter!.pos2, 
                        second := iter!.second, 
                     Iterator1 := ShallowCopy( iter!.Iterator1 ), 
                     Iterator2 := ShallowCopy( iter!.Iterator2 ),  
                 Iterator1Copy := ShallowCopy( iter!.Iterator1Copy ) ) ); 

InstallGlobalFunction( "DoUnorderedPairsIterator", 
function( iter0 )

    local iter;

    if IsDoneIterator( iter0 ) then 
        return IteratorList( [ ] ); 
    fi;
    iter := IteratorByFunctions( 
        rec(          pos1 := 0, 
                      pos2 := 0,
                    second := 0,
                 Iterator1 := ShallowCopy( iter0 ), 
                 Iterator2 := ShallowCopy( iter0 ), 
             Iterator1Copy := ShallowCopy( iter0 ), 
              NextIterator := NextIterator_UnorderedPairs, 
            IsDoneIterator := IsDoneIterator_UnorderedPairs, 
               ShallowCopy := ShallowCopy_UnorderedPairs ) ); 
    return iter;
end );

InstallMethod( UnorderedPairsIterator, "for an iterator", [ IsIterator ], 0, 
function( iter0 )
    return DoUnorderedPairsIterator( iter0 ); 
end );  


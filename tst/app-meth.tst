##############################################################################
##
#W  app-meth.tst                   Utils Package                    
##
#Y  Copyright (C) 2015-2018, The GAP Group 
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 7.5.1 
gap> ApplicableMethodPrintLevelUtils( 1 );                                 
gap> s4 := Group( (1,2,3,4), (3,4) );;
gap> a4 := Subgroup( s4, [ (1,2,3), (2,3,4) ] );; 
gap> ApplicableMethodUtils( CommutatorSubgroup, [ s4, a4 ] );
#I  Searching Methods for CommutatorSubgroup with 2 arguments:
#I  CommutatorSubgroup has 8 methods
#I  of which 3 are satisfied by the input.
#I Method: 2,  value: 116,  is applicable method #1.
#I  CommutatorSubgroup: permgroups
#I  at: /Applications/gap/gap4r9/lib/grpperm.gi:949
function( U, V ) ... end
gap> ApplicableMethodUtils( CommutatorSubgroup, [ s4, a4 ], 2 );
#I  Searching Methods for CommutatorSubgroup with 2 arguments:
#I  CommutatorSubgroup has 8 methods
#I  of which 3 are satisfied by the input.
#I Method: 7,  value: 72,  is applicable method #2.
#I  CommutatorSubgroup: groups with home pcgs
#I  at: /Applications/gap/gap4r9/lib/grppc.gi:875
function( U, V ) ... end
gap> ApplicableMethodUtils( CommutatorSubgroup, [ s4, a4 ], 3 );
#I  Searching Methods for CommutatorSubgroup with 2 arguments:
#I  CommutatorSubgroup has 8 methods
#I  of which 3 are satisfied by the input.
#I Method: 8,  value: 70,  is applicable method #3.
#I  CommutatorSubgroup: generic method for two groups
#I  at: /Applications/gap/gap4r9/lib/grp.gi:2386
function( U, V ) ... end
gap> ApplicableMethodUtils( DirectProduct, [a4,s4] );
#I  This function starts at the following file and line number:
#I  /Applications/gap/gap4r9/lib/gprd.gi:17
function( arg... ) ... end

## SubSection 7.5.2 
gap> PrintApplicableMethodUtils( IsCyclic, [ Group((1,2,3),(4,5)) ] );
#I  IsCyclic has 7 methods
#I  of which 3 are satisfied by the input.
#I  This method starts at the following file and line number:
#I  /Applications/gap/gap4r9/lib/grp.gi:30
function ( G )
    if Length( GeneratorsOfGroup( G ) ) = 1 then
        return true;
    else
        TryNextMethod();
    fi;
    return;
end

## SubSection 7.5.3 
gap> ApplicableMethodPrintLevelUtils( 4 );                                 
gap> ApplicableMethodUtils( CommutatorSubgroup, [a4,s4] );             
#I  Searching Methods for CommutatorSubgroup with 2 arguments:
#I  CommutatorSubgroup has 8 methods
#I  of which 3 are satisfied by the input.
#I Method: 1,  value: 744
#I  CommutatorSubgroup: handled by nice monomorphism:group CollColl
#I  at: /Applications/gap/gap4r9/lib/grpnice.gd:450
#I  arg 1 needs [ "IsHandledByNiceMonomorphism", 
  "HasIsHandledByNiceMonomorphism" ]
#I  arg 2 needs [ "IsHandledByNiceMonomorphism", 
  "HasIsHandledByNiceMonomorphism" ]
#I Method: 2,  value: 116,  is applicable method #1.
#I  CommutatorSubgroup: permgroups
#I  at: /Applications/gap/gap4r9/lib/grpperm.gi:949
function( U, V ) ... end

## SubSection 7.5.5 



#############################################################################
##
#E  app-meth.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here

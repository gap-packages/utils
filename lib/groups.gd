##############################################################################
##
#W  groups.gd                  GAP4 package `Utils'                Stefan Kohl
##
#Y  Copyright (C) 2015-2016, The GAP Group 

#############################################################################
##  this function has been transferred from ResClasses 
##
#O  IsCommuting( <a>, <b> ) .  checks whether two group elements etc. commute
##
DeclareOperation( "IsCommuting", [ IsMultiplicativeElement,
                                   IsMultiplicativeElement ] ); 

#############################################################################
##  these functions have been transferred from ResClasses 
##
#A  UpperFittingSeries( <G> ) . . . . . . . . . . upper fitting series of <G>
#A  LowerFittingSeries( <G> ) . . . . . . . . . . lower fitting series of <G>
#A  FittingLength( <G> )  . . . . . . . . . . . . . . . fitting length of <G>
##
##  The upper and lower Fitting series and the Fitting length of a solvable
##  group, as described here: https://en.wikipedia.org/wiki/Fitting_length
##
if not IsBound( UpperFittingSeries ) then 
    DeclareAttribute( "UpperFittingSeries", IsGroup ); fi;
if not IsBound( LowerFittingSeries ) then 
    DeclareAttribute( "LowerFittingSeries", IsGroup ); fi;
if not IsBound( FittingLength ) then 
    DeclareAttribute( "FittingLength", IsGroup ); fi;

#############################################################################
##  this function has been transferred from RCWA 
##
#F  ListOfPowers( <g>, <exp> ) . . . . . .  list of powers <g>^1 .. <g>^<exp>
##
DeclareGlobalFunction( "ListOfPowers" );

#############################################################################
##  this function has been transferred from RCWA 
##
#O  GeneratorsAndInverses( <D> ) list of generators of <D> and their inverses
#M  GeneratorsAndInverses( <G> ) . . . . . . . . . . . . . . . . . for groups
##
DeclareOperation( "GeneratorsAndInverses", [ IsMagmaWithInverses ] );

#############################################################################
##  this function has been copied from main library gprd.gd and renamed 
##
#O  SubdirectProductWithEmbeddings(<G>, <H>, <Ghom>, <Hhom> )
##
DeclareGlobalFunction("SubdirectProductWithEmbeddings");
DeclareOperation( "SubdirectProductWithEmbeddingsOp",
    [ IsGroup, IsGroup, IsGroupHomomorphism, IsGroupHomomorphism ] );
DeclareAttribute( "SubdirectProductWithEmbeddingsInfo", IsGroup, "mutable" );

#############################################################################
##
#E  groups.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

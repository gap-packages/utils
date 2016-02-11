##############################################################################
##
#W  groups.gd                  GAP4 package `Utils'                Stefan Kohl
##
##  version 0.25, 11/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  this function transferred from ResClasses 
##
#O  IsCommuting( <a>, <b> ) .  checks whether two group elements etc. commute
##
DeclareOperation( "IsCommuting", [ IsMultiplicativeElement,
                                   IsMultiplicativeElement ] ); 

fi;

if ( ( InstalledPackageVersion("resclasses") <> fail ) and 
     ( InstalledPackageVersion("resclasses") > "4.1.0" ) ) then  

#############################################################################
##  these functions transferred from ResClasses 
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

fi; 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  this function transferred from RCWA 
##
#F  ListOfPowers( <g>, <exp> ) . . . . . .  list of powers <g>^1 .. <g>^<exp>
##
DeclareGlobalFunction( "ListOfPowers" );

#############################################################################
##
#O  GeneratorsAndInverses( <D> ) list of generators of <D> and their inverses
#M  GeneratorsAndInverses( <G> ) . . . . . . . . . . . . . . . . . for groups
##
DeclareOperation( "GeneratorsAndInverses", [ IsMagmaWithInverses ] );

#############################################################################
##
#F  ReducedWordByOrdersOfGenerators( <w>, <gensords> )
##
##  Given a word <w>, this function returns the word obtained from <w> by
##  reducing the exponents of powers of generators modulo their orders, as
##  specified in the list <gensords>.
##
DeclareGlobalFunction( "ReducedWordByOrdersOfGenerators" );

#############################################################################
##
#O  NormalizedRelator( <w>, <gensords> )
##
##  Given a word <w>, this operation returns its normal form obtained by
##
##    1. reducing the exponents of powers of generators modulo their orders,
##       as specified in the list <gensords>,
##    2. cyclic reduction and
##    3. cyclic conjugation to the lexicographically smallest such conjugate.
##
##  As the name of the operation suggests, the main purpose of this operation
##  is to get the relators in a finite presentation short and nice, and to be
##  able to spot and remove redundant relators in easy cases.
##
DeclareOperation( "NormalizedRelator", [ IsAssocWord, IsList ] );

fi; 

#############################################################################
##
#E  groups.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

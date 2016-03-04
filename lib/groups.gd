##############################################################################
##
#W  groups.gd                  GAP4 package `Utils'                Stefan Kohl
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  this function has been transferred from ResClasses 
##
#O  IsCommuting( <a>, <b> ) .  checks whether two group elements etc. commute
##
DeclareOperation( "IsCommuting", [ IsMultiplicativeElement,
                                   IsMultiplicativeElement ] ); 

fi;

if OKtoReadFromUtilsSpec( "ResClasses", "4.0.0" ) then

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

fi; 

if OKtoReadFromUtils( "RCWA" ) then

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

fi; 

#############################################################################
##
#E  groups.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

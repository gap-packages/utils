##############################################################################
##
#W  groups.gd                  GAP4 package `Utils'                Stefan Kohl
##
##  version 0.12, 01/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

#############################################################################
##  this function transferred from ResClasses 
##
#O  IsCommuting( <a>, <b> ) .  checks whether two group elements etc. commute
##
DeclareOperation( "IsCommuting", [ IsMultiplicativeElement,
                                   IsMultiplicativeElement ] );

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




#############################################################################
##
#E  groups.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

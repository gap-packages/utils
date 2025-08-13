#############################################################################
##
#W  groups.gi                 GAP4 package `Utils'                Stefan Kohl
##
#Y  Copyright (C) 2015-2025, The GAP Group 

#############################################################################
##  this function has been transferred from ResClasses 
##
#M  Comm( [ <elm1>, <elm2> ] ) . . .  for arguments enclosed in list brackets
##
InstallOtherMethod( Comm,
                    "for arguments enclosed in list brackets (ResClasses)",
                    true, [ IsList ], 0, LeftNormedComm );

#############################################################################
##  this function has been transferred from ResClasses 
##
#M  IsCommuting( <a>, <b> ) . . . . . . . . . . . . . . . . . fallback method
##
InstallMethod( IsCommuting,
               "fallback method (ResClasses)", IsIdenticalObj,
               [ IsMultiplicativeElement, IsMultiplicativeElement ], 0,
               function ( a, b ) return a*b = b*a; end ); 

#############################################################################
##  this function has been transferred from ResClasses 
##
#M  UpperFittingSeries( <G> ) . . . . . . . . . . . . . . . .  default method
##
InstallMethod( UpperFittingSeries, "default method", true, [ IsGroup ], 0,

  function ( G )

    local  series, F, phi;

    if IsTrivial(FittingSubgroup(G)) then return [ TrivialSubgroup(G) ]; fi;
    F := FittingSubgroup(G); series := [ TrivialSubgroup(G), F ];
    while F <> G do
      phi := NaturalHomomorphismByNormalSubgroup(G,F);
      F := PreImage(phi,FittingSubgroup(Image(phi)));
      if series[Length(series)] = F then break; fi;
      Add(series,F);
    od;
    return series;
  end );

#############################################################################
##  this function has been transferred from ResClasses 
##
#M  LowerFittingSeries( <G> ) . . . . . . . . . . . . . . . .  default method
##
InstallMethod( LowerFittingSeries, "default method", true, [ IsGroup ], 0,

  function ( G )

    local  series, F;

    series := [ G ]; F := G;
    while not IsTrivial(F) do
      F := Reversed(LowerCentralSeries(F))[1];
      if series[Length(series)] = F then break; fi;
      Add(series,F);
    od;
    return series;
  end );

#############################################################################
##  this function has been transferred from ResClasses 
##
#M  FittingLength( <G> ) . . . . . . . . . . . . . . . . . . . default method
##
InstallMethod( FittingLength, "default method", true, [ IsGroup ], 0,

  function ( G )
    if not IsSolvableGroup(G) then return infinity; fi;
    if   HasUpperFittingSeries(G)
    then return Length(UpperFittingSeries(G)) - 1;
    else return Length(LowerFittingSeries(G)) - 1; fi;
  end );

#############################################################################
##  this function has been transferred from RCWA
##
#F  ListOfPowers( <g>, <exp> ) . . . . . .  list of powers <g>^1 .. <g>^<exp>
##
BindGlobal( "ListOfPowers",

  function ( g, exp )

    local  powers, n;

    powers := [g];
    for n in [2..exp] do Add(powers,powers[n-1]*g); od;
    return powers;
  end );

#############################################################################
##  this function has been transferred from RCWA
##
#M  GeneratorsAndInverses( <D> ) list of generators of <D> and their inverses
#M  GeneratorsAndInverses( <G> ) . . . . . . . . . . . . . . . . . for groups
##
InstallMethod( GeneratorsAndInverses, "for groups", true, [ IsGroup ], 0, 
    G -> Concatenation( GeneratorsOfGroup(G),
                  List( GeneratorsOfGroup(G), g->g^-1 ) ) );

#############################################################################
##
#E  groups.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

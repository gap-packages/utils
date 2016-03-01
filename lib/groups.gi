#############################################################################
##
#W  groups.gi                 GAP4 package `Utils'                 Stefan Kohl
##
#Y  Copyright (C) 2015-2016, The GAP Group 

if OKtoReadFromUtils( "ResClasses" ) then

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

fi; 

if OKtoReadFromUtilsSpec( "ResClasses", "3.9" ) then 

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

fi; 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  this function has been transferred from RCWA
##
#F  ListOfPowers( <g>, <exp> ) . . . . . .  list of powers <g>^1 .. <g>^<exp>
##
InstallGlobalFunction(  ListOfPowers,

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
##  this function has been transferred from RCWA
##
#F  ReducedWordByOrdersOfGenerators( <w>, <gensords> )
##
InstallGlobalFunction(  ReducedWordByOrdersOfGenerators,

  function ( w, gensords )

    local  ext, fam, i;

    fam := FamilyObj(w);
    ext := ShallowCopy(ExtRepOfObj(w));
    for i in [1,3..Length(ext)-1] do
      if gensords[ext[i]] < infinity then
        ext[i+1] := ext[i+1] mod gensords[ext[i]];
        if   ext[i+1] > gensords[ext[i]]/2
        then ext[i+1] := ext[i+1] - gensords[ext[i]]; fi;
      fi;
    od;
    return ObjByExtRep(fam,ext);
  end );

#############################################################################
##  this function has been transferred from RCWA
##
#M  NormalizedRelator( <w>, <gensords> )
##
InstallMethod( NormalizedRelator,
               "for a word and a list of orders of generators", ReturnTrue,
               [ IsAssocWord, IsList ], 0,

  function ( w, gensords )

    local  c, old, twice, words, min, max, start, i, j;

    c := ShallowCopy(ExtRepOfObj(w));
    repeat
      old := ShallowCopy(c);
      for i in [2,4..Length(c)] do
        if   gensords[c[i-1]] < infinity
        then c[i] := c[i] mod gensords[c[i-1]]; fi;
      od;
      c := ShallowCopy(ExtRepOfObj(ObjByExtRep(FamilyObj(w),c)));
      if c = [] then return One(w); fi;
      min   := Minimum(c{[1,3..Length(c)-1]});
      start := Filtered([1,3..Length(c)-1],i->c[i]=min);
      max   := Maximum(c{start+1});
      start := Filtered(start,i->c[i+1]=max);
      twice := Concatenation(c,c);
      words := List(start,i->twice{[i..i+Length(c)-1]});
      SortParallel(List(words,v->[v{[1,3..Length(v)-1]},
                                  v{[2,4..Length(v)]}]),words);
      c := words[1];
    until c = old;
    w := ObjByExtRep(FamilyObj(w),c);
    return w;
  end );

fi; 

#############################################################################
##
#E  groups.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

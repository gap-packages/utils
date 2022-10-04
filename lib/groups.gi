#############################################################################
##
#W  groups.gi                 GAP4 package `Utils'                Stefan Kohl
##
#Y  Copyright (C) 2015-2022, The GAP Group 

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
##  temporary methods for SubdirectProductWithEmbeddings 
##  
InstallGlobalFunction(SubdirectProductWithEmbeddings,function(G,H,ghom,hhom)
local iso;
  if ( Range( ghom, G ) <> Range( hhom, H ) ) or 
     ( Image( ghom, G ) <> Image( hhom, H ) ) then
        Error("the image groups are not the same");
  fi;
  if not ( IsPermGroup(G) and IsPermGroup(H) ) or 
         ( IsPcGroup(G) and IsPcGroup(H) ) then 
        Error("methods only supplied forperm groups or pc groups"); 
  fi; 
  return SubdirectProductWithEmbeddingsOp( G, H, ghom, hhom );
end);

#############################################################################
##
#M  SubdirectProductWithEmbeddingsOp( <G>, <H>, <ghom>, <hhom> )
##
InstallMethod( SubdirectProductWithEmbeddingsOp,"groups", true,
  [ IsGroup, IsGroup, IsGroupHomomorphism, IsGroupHomomorphism ], 0,
function( G, H, ghom, hhom )
local gc,hc,S,info;
  # try to enforce a common representation
  if not (IsFinite(G) and IsFinite(H)) then
    TryNextMethod();
  fi;
  if IsSolvableGroup(G) and IsSolvableGroup(H) and
    not (IsPcGroup(G) and IsPcGroup(H)) then
    # enforce pc groups
    gc:=IsomorphismPcGroup(G);
    hc:=IsomorphismPcGroup(H);
  elif not (IsPermGroup(G) and IsPermGroup(H)) then
    # enforce perm groups
    gc:=IsomorphismPermGroup(G);
    hc:=IsomorphismPermGroup(H);
  else
    TryNextMethod();
  fi;
  ghom := InverseGeneralMapping(gc)*ghom;
  hhom := InverseGeneralMapping(hc)*hhom;
  # the ...Op is installed for `IsGroupHomomorphism'. So we have to enforce
  # the filter to be set.
  if not IsGroupHomomorphism(ghom) or not IsGroupHomomorphism(hhom) then
    Error("mappings are not homomorphisms");
  fi;
  S:=SubdirectProductWithEmbeddingsOp(Image(gc,G),Image(hc,H),ghom,hhom);
  info:=rec(groups:=[G,H],
	    homomorphisms:=[ghom,hhom],
	    projections:=[Projection(S,1)*InverseGeneralMapping(gc),
			  Projection(S,2)*InverseGeneralMapping(hc)]);
  S:=Group(GeneratorsOfGroup(S));
  SetSubdirectProductWithEmbeddingsInfo(S,info);
  return S;
end);

#############################################################################
##
#M  Projection( <S>, <i> )  . . . . . . . . . . . . . . . . . make projection
##
InstallMethod( Projection,"pc subdirect product", true,
      [ IsGroup and HasSubdirectProductWithEmbeddingsInfo, IsPosInt ], 0,
function( S, i )
local   prj, info;
  if not i in [1,2] then
    Error("only 2 embeddings");
  fi;
  info := SubdirectProductWithEmbeddingsInfo( S );
  if not IsBound(info.projections[i]) then
    TryNextMethod();
  fi;
  return info.projections[i];
end);

#############################################################################
##
#M  Size( <S> ) . . . . . . . . . . . . . . . . . . . .  of subdirect product
##
InstallMethod( Size,"subdirect product", true,
  [ IsGroup and HasSubdirectProductWithEmbeddingsInfo ], 0,
    function( S )
    local info;
    info := SubdirectProductWithEmbeddingsInfo( S );
    return Size( info.groups[ 1 ] ) * Size( info.groups[ 2 ] )
           / Size( ImagesSource( info.homomorphisms[ 1 ] ) );
end );

############################################################################# 
##  methods copied from gprdperm.gi 
##  
#############################################################################
##
#M  SubdirectProductWithEmbeddingsOp( <G1>, <G2>, <phi1>, <phi2> )  
##
InstallMethod( SubdirectProductWithEmbeddingsOp, "permgroup", true,
  [ IsPermGroup, IsPermGroup, IsGroupHomomorphism, IsGroupHomomorphism ], 0,
    function( G1, G2, phi1, phi2 )
    local   S,          # subdirect product of <G1> and <G2>, result
            gens,       # generators of <S>
            D,          # direct product of <G1> and <G2>
            emb1, emb2, # embeddings of <G1> and <G2> into <D>
            info, Dinfo,# info records
            gen;        # one generator of <G1> or kernel of <phi2>

    # make the direct product and the embeddings
    D := DirectProduct( G1, G2 );
    emb1 := Embedding( D, 1 );
    emb2 := Embedding( D, 2 );
    
    # the subdirect product is generated by $(g_1,x_{g_1})$ where $g_1$ loops
    # over the  generators of $G_1$  and $x_{g_1} \in   G_2$ is abitrary such
    # that $g_1^{phi_1} = x_{g_1}^{phi_2}$ and by $(1,k_2)$ where $k_2$ loops
    # over the generators of the kernel of $phi_2$.
    gens := [];
    for gen  in GeneratorsOfGroup( G1 )  do
        Add( gens, gen^emb1 * PreImagesRepresentativeNC(phi2,gen^phi1)^emb2 );
    od;
    for gen in GeneratorsOfGroup(
                   KernelOfMultiplicativeGeneralMapping( phi2 ) )  do
        Add( gens, gen ^ emb2 );
    od;

    # and make the subdirect product
    S := GroupByGenerators( gens );
    SetParent( S, D );

    Dinfo := DirectProductInfo( D );
    info := rec( groups := [G1, G2],
                 homomorphisms := [phi1, phi2],
                 olds  := Dinfo.olds,
                 news  := Dinfo.news,
                 perms := Dinfo.perms,
                 projections := [] );
    SetSubdirectProductWithEmbeddingsInfo( S, info );
    return S;
end );

#############################################################################
##
#R  IsProjectionSubdirectProductWithEmbeddingsPermGroup( <hom> )  .  projection onto factor
##
DeclareRepresentation( "IsProjectionSubdirectProductWithEmbeddingsPermGroup",
      IsAttributeStoringRep and IsComponentObjectRep and
      IsGroupHomomorphism and IsSurjective and
      IsSPGeneralMapping, [ "component" ] );

#############################################################################
##
#M  Projection( <S>, <i> )  . . . . . . . . . . . . . . . . . make projection
##
InstallMethod( Projection,"perm subdirect product",true,
      [ IsPermGroup and HasSubdirectProductWithEmbeddingsInfo,
        IsPosInt ], 0,
    function( S, i )
    local   prj, info;
    info := SubdirectProductWithEmbeddingsInfo( S );
    if IsBound( info.projections[i] ) then return info.projections[i]; fi;
    
    prj := Objectify( NewType( GeneralMappingsFamily( PermutationsFamily,
                                                      PermutationsFamily ),
                   IsProjectionSubdirectProductWithEmbeddingsPermGroup ),
                   rec( component := i ) );
    SetSource( prj, S );
    info.projections[i] := prj;
    SetSubdirectProductWithEmbeddingsInfo( S, info );
    return prj;
end );

#############################################################################
##
#M  Range( <prj> )  . . . . . . . . . . . . . . . . . . . . . . of projection
##
InstallMethod( Range,"perm subdirect product projection",
  true, [ IsProjectionSubdirectProductWithEmbeddingsPermGroup ], 0,
    prj -> SubdirectProductWithEmbeddingsInfo( Source( prj ) ).groups[ prj!.component ] );

#############################################################################
##
#M  ImagesRepresentative( <prj>, <g> )  . . . . . . . . . . . . of projection
##
InstallMethod( ImagesRepresentative,"perm subdirect product projection",
  FamSourceEqFamElm,
        [ IsProjectionSubdirectProductWithEmbeddingsPermGroup,
          IsMultiplicativeElementWithInverse ], 0,
    function( prj, g )
    local info;
    info := SubdirectProductWithEmbeddingsInfo( Source( prj ) );
    return RestrictedPermNC( g, info.news[ prj!.component ] )
           ^ ( info.perms[ prj!.component ] ^ -1 );
end );

#############################################################################
##
#M  PreImagesRepresentativeNC( <prj>, <g> ) . . . . . . . . . . of projection
##
InstallMethod( PreImagesRepresentativeNC,"perm subdirect product projection", 
        FamRangeEqFamElm,
        [ IsProjectionSubdirectProductWithEmbeddingsPermGroup,
          IsMultiplicativeElementWithInverse ], 0,
    function( prj, img )
    local   S,
            elm,        # preimage of <img> under <prj>, result
            info,       # info record
            phi1, phi2; # homomorphisms of components

    S := Source( prj );
    info := SubdirectProductWithEmbeddingsInfo( S );
    
    # get the homomorphism
    phi1 := info.homomorphisms[1];
    phi2 := info.homomorphisms[2];

    # compute the preimage
    if 1 = prj!.component  then
        elm := img                                      ^ info.perms[1]
             * PreImagesRepresentativeNC(phi2,img^phi1) ^ info.perms[2];
    else
        elm := img                                      ^ info.perms[2]
             * PreImagesRepresentativeNC(phi1,img^phi2) ^ info.perms[1];
    fi;

    # return the preimage
    return elm;
end );

#############################################################################
##
#M  KernelOfMultiplicativeGeneralMapping( <prj> ) . . . . . . . of projection
##
InstallMethod( KernelOfMultiplicativeGeneralMapping,
    "perm subdirect product projection",true,
    [ IsProjectionSubdirectProductWithEmbeddingsPermGroup ], 0,
    function( prj )
    local   D,  i, info;
    
    D := Source( prj );
    info := SubdirectProductWithEmbeddingsInfo( D );
    i := 3 - prj!.component;
    return SubgroupNC( D, OnTuples
           ( GeneratorsOfGroup( KernelOfMultiplicativeGeneralMapping(
                                    info.homomorphisms[ i ] ) ),
             info.perms[ i ] ) );
end );


#############################################################################
##
#M  ViewObj( <prj> )  . . . . . . . . . . . . . . . . . . . . view projection
##
InstallMethod( ViewObj,
    "for projection from subdirect product",
    true,
    [ IsProjectionSubdirectProductWithEmbeddingsPermGroup ], 0,
    function( prj )
    Print( Ordinal( prj!.component ), " projection of " );
    View( Source( prj ) );
end );


#############################################################################
##
#M  PrintObj( <prj> ) . . . . . . . . . . . . . . . . . . .  print projection
##
InstallMethod( PrintObj,
    "for projection from subdirect product",
    true,
    [ IsProjectionSubdirectProductWithEmbeddingsPermGroup ], 0,
    function( prj )
    Print( "Projection( ", Source( prj ), ", ", prj!.component, " )" );
end );

############################################################################# 
##  method copied from grpdpc.gi 
## 
#############################################################################
##
#M  SubdirectProductWithEmbeddingsOp( <G1>, <G2>, <phi1>, <phi2> )
##
InstallMethod( SubdirectProductWithEmbeddingsOp,"pcgroup", true,
  [ IsPcGroup, IsPcGroup, IsGroupHomomorphism, IsGroupHomomorphism ], 0,
function( G, H, gh, hh )
local pg,ph,kg,kh,ig,ih,mg,mh,S,info;
  pg:=Pcgs(G);
  ph:=Pcgs(H);
  kg:=KernelOfMultiplicativeGeneralMapping(gh);
  kh:=KernelOfMultiplicativeGeneralMapping(hh);
  ig:=InducedPcgs(pg,kg);
  ih:=InducedPcgs(ph,kh);
  mg:=pg mod ig;
  mh:=List(mg,i->PreImagesRepresentativeNC(hh,Image(gh,i)));
  pg:=Concatenation(mg,ig,List(ih,i->One(G)));
  ph:=Concatenation(mh,List(ig,i->One(H)),ih);
  S:=SubdirProdPcGroups(G,pg,H,ph);
  pg:=GroupHomomorphismByImagesNC(S[1],G,S[2],pg);
  ph:=GroupHomomorphismByImagesNC(S[1],H,S[2],ph);
  S:=S[1];
  info:=rec(groups:=[G,H],
	    homomorphisms:=[gh,hh],
	    projections:=[pg,ph]);
  SetSubdirectProductWithEmbeddingsInfo(S,info);
  return S;
end);


#############################################################################
##
#E  groups.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

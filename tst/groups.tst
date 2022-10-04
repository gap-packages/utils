#@local  A, a, ac9, aq8, b, c, c1, c2, c2c6, c3, c4, c4c3, c6, c9
#@local  cp1, cp2, cp3, d, D12, d8, data, dp, epi, f, f1, f2, G, g
#@local  g1, g2, g3, genA, gens, i, idcopy, idem, idemc2, idemim, idemim2
#@local  im2, image2, images, imi, info, info2, info3, lc1, lc2, lc3, lc4
#@local  len, lfs, ok, Pfi, phi, q8, rc1, rc4, s3, S4, s4, UFS, ufs

##############################################################################
##
#W  groups.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2022, The GAP Group 
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 5.1.1 
gap> Comm( [ (1,2), (2,3) ] );
(1,2,3)
gap> Comm( [(1,2),(2,3),(3,4),(4,5),(5,6)] );
(1,5,6)
gap> Comm(Comm(Comm(Comm((1,2),(2,3)),(3,4)),(4,5)),(5,6));  ## the same
(1,5,6)

## SubSection 5.1.2 
gap> D12 := DihedralGroup( 12 );
<pc group of size 12 with 3 generators>
gap> SetName( D12, "D12" ); 
gap> a := D12.1;;  b := D12.2;;  
gap> IsCommuting( a, b );
false

## SubSection 5.1.3 
gap> ListOfPowers( 2, 20 );
[ 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 
  65536, 131072, 262144, 524288, 1048576 ]
gap> ListOfPowers( (1,2,3)(4,5), 12 );
[ (1,2,3)(4,5), (1,3,2), (4,5), (1,2,3), (1,3,2)(4,5), (), (1,2,3)(4,5), 
  (1,3,2), (4,5), (1,2,3), (1,3,2)(4,5), () ]
gap> ListOfPowers( D12.2, 6 );
[ f2, f3, f2*f3, f3^2, f2*f3^2, <identity> of ... ]

## SubSection 5.1.4 
gap> GeneratorsAndInverses( D12 );
[ f1, f2, f3, f1, f2*f3^2, f3^2 ]
gap> GeneratorsAndInverses( SymmetricGroup(5) );     
[ (1,2,3,4,5), (1,2), (1,5,4,3,2), (1,2) ]

## SubSection 5.1.5 
gap> UFS := UpperFittingSeries( D12 );;
gap> Set( GeneratorsOfGroup( UFS[2] ) );  
[ f3, f2*f3 ]
gap> Set( GeneratorsOfGroup( UFS[3] ) );  
[ f1, f3, f2*f3 ]
gap>  LowerFittingSeries( D12 ); 
[ D12, Group([ f3 ]), Group([  ]) ]
gap> FittingLength( D12 );
2
gap> S4 := SymmetricGroup( 4 );;
gap> ufs := UpperFittingSeries( S4 );;
gap> List( ufs, StructureDescription );
[ "1", "C2 x C2", "A4", "S4" ]
gap> lfs := LowerFittingSeries( S4 );;
gap> List( lfs, StructureDescription );
[ "S4", "A4", "C2 x C2", "1" ]
gap> FittingLength( S4);
3


## SubSection 5.2.1 
gap> lc1 := LeftCoset( (1,2,3), Group( [ (1,2), (3,4) ] ) ); 
LeftCoset((1,2,3),Group([ (1,2), (3,4) ]))
gap> Representative( lc1 );
(1,2,3)
gap> ActingDomain( lc1 );
Group([ (1,2), (3,4) ])
gap> AsSet( lc1 );
[ (2,3), (2,4,3), (1,2,3), (1,2,4,3) ]
gap> (1,2,3) in lc1;
true
gap> lc2 := (2,4,3) * lc1;   
LeftCoset((1,2,4),Group([ (1,2), (3,4) ]))
gap> lc3 := lc1^(2,3,4);;
gap> lc2 = lc3;            
true

## SubSection 5.2.2 
gap> rc1 := Inverse( lc1 ); 
RightCoset(Group([ (1,2), (3,4) ]),(1,3,2))
gap> rc4 := RightCoset( Group( (1,2), (2,3) ), (3,4) ); 
RightCoset(Group([ (1,2), (2,3) ]),(3,4))
gap> lc4 := Inverse( rc4 );
LeftCoset((3,4),Group([ (1,2), (2,3) ]))
gap> Intersection( lc2, lc4 );
[ (2,3,4), (1,2,3,4) ]

## SubSection 5.3.1 
gap> G := Group( (1,2,3), (3,4,5), (5,6,7), (7,8,9) );;
gap> phi := EpimorphismByGenerators( FreeGroup("a","b","c","d"), G );
[ a, b, c, d ] -> [ (1,2,3), (3,4,5), (5,6,7), (7,8,9) ]
gap> PreImagesRepresentativeNC( phi, (1,2,3,4,5,6,7,8,9) );
d*c*b*a
gap> a := G.1;; b := G.2;; c := G.3;; d := G.4;;
gap> d*c*b*a;
(1,2,3,4,5,6,7,8,9)
gap> ## note that it is easy to produce nonsense: 
gap> epi := EpimorphismByGenerators( Group((1,2,3)), Group((8,9)) );
Warning: calling GroupHomomorphismByImagesNC without checks
[ (1,2,3) ] -> [ (8,9) ]
gap> IsGroupHomomorphism( epi );
true
gap> Image(epi,(1,2,3));                                            
()
gap> Image(epi,(1,3,2));
(8,9)

## SubSection 5.3.2
gap> s4 := Group( (1,2),(2,3),(3,4) );;
gap> s3 := Group( (5,6),(6,7) );;
gap> c3 := Subgroup( s3, [ (5,6,7) ] );;
gap> f := GroupHomomorphismByImages( s4, s3, 
>             [(1,2),(2,3),(3,4)], [(5,6),(6,7),(5,6)] );; 
gap> i := GroupHomomorphismByImages( c3, s3, [(5,6,7)], [(5,6,7)] );; 
gap> Pfi := Pullback( f, i );
Group([ (2,3,4)(5,7,6), (1,2)(3,4) ])
gap> StructureDescription( Pfi );
"A4"
gap> info := PullbackInfo( Pfi );
rec( directProduct := Group([ (1,2), (2,3), (3,4), (5,6,7) ]), 
  projections := [ [ (2,3,4)(5,7,6), (1,2)(3,4) ] -> [ (2,3,4), (1,2)(3,4) ], 
      [ (2,3,4)(5,7,6), (1,2)(3,4) ] -> [ (5,7,6), () ] ] )
gap> g := (1,2,3)(5,6,7);; 
gap> ImageElm( info!.projections[1], g );
(1,2,3)
gap> ImageElm( info!.projections[2], g );
(5,6,7) 
gap> dp := info!.directProduct;; 
gap> a := ImageElm( Embedding( dp, 1 ), (1,4,3) );; 
gap> b := ImageElm( Embedding( dp, 2 ), (5,7,6) );; 
gap> a*b in Pfi;
true

## SubSection 5.3.3
gap> g1 := DihedralGroup( 8 );
<pc group of size 8 with 3 generators>
gap> c1 := Centre( g1 );
Group([ f3 ])
gap> cp1 := CentralProduct( g1, g1, c1, IdentityMapping( c1 ) );
Group([ f1, f2, f5, f3, f4, f5 ])
gap> IdGroup( cp1 ) = IdGroup( ExtraspecialGroup( 2^5, "+" ) );
true
gap> g2 := QuaternionGroup( 8 );
<pc group of size 8 with 3 generators>
gap> c2 := Centre( g2 );
Group([ y2 ])
gap> cp2 := CentralProduct( g2, g2, c2, IdentityMapping( c2 ) );
Group([ f1, f2, f5, f3, f4, f5 ])
gap> IdGroup( cp2 ) = IdGroup( ExtraspecialGroup( 2^5, "+" ) );
true
gap> info2 := CentralProductInfo( cp2 );
rec( phi := IdentityMapping( Group([ y2 ]) ), 
  projection := [ f1, f2, f3, f4, f5, f6 ] -> [ f1, f2, f5, f3, f4, f5 ] )
gap> Source( Embedding( Source( info2.projection ), 1 ) ) = g2;
true
gap> g3 := SymmetricGroup( 3 );
Sym( [ 1 .. 3 ] )
gap> c3 := TrivialSubgroup( g3 );
Group(())
gap> cp3 := CentralProduct( g3, g3, c3, IdentityMapping( c3 ) );
Group([ (1,2,3), (1,2), (4,5,6), (4,5) ])
gap> info3 := CentralProductInfo( cp3 );
rec( phi := IdentityMapping( Group(()) ), 
  projection := IdentityMapping( Group([ (1,2,3), (1,2), (4,5,6), (4,5) ]) ) )
gap> Source( Embedding( Source( info3.projection ), 1 ) ) = g3;
true

## SubSection 5.3.4
gap> gens := [ (1,2,3,4), (1,2)(3,4) ];; 
gap> d8 := Group( gens );;
gap> SetName( d8, "d8" );
gap> c2 := Subgroup( d8, [ (2,4) ] );;
gap> idemc2 := IdempotentEndomorphismsWithImage( gens, c2 );;
gap> idcopy := [ [ (), (2,4) ], [ (2,4), () ] ];; 
gap> Sort( idemc2 );
gap> Sort( idcopy );
gap> idemc2 = idcopy;
true
gap> ## depending on packages loaded, the order of images can vary 
gap> ## so we introduce a convoluted way of checking the images 
gap> data := IdempotentEndomorphismsData( d8 );;
gap> data!.gens;
[ (1,2,3,4), (1,2)(3,4) ]
gap> images := data!.images;; 
gap> len := Length( images );
6 
gap> image2 := [ [ [ (), () ] ], [ [ (), (2,4) ], [ (2,4), () ] ], 
>  [ [ (), (1,3) ], [ (1,3), () ] ], 
>  [ [ (), (1,2)(3,4) ], [ (1,2)(3,4), (1,2)(3,4) ] ], 
>  [ [ (), (1,4)(2,3) ], [ (1,4)(2,3), (1,4)(2,3) ] ], 
>  [ [ (1,2,3,4), (1,2)(3,4) ] ] ];;
gap> ok := true;;
gap> ## new in gapdev - the test 'im in im2' is parsed before the for loop 
gap> ## so that im2 is an 'unbound global variable' if not declared first 
gap> im2 := [ ];;
gap> for i in [1..len] do
>        imi := images[i]; 
>        im2 := image2[i]; 
>        if not ForAll( imi, im -> ( im in im2 ) ) then  
>            ok := false; 
>        fi; 
>    od;
gap> ok; 
true
gap> List( images, L -> Length(L) );
[ 1, 2, 2, 2, 2, 1 ]
gap> idem := IdempotentEndomorphisms( d8 );;
gap> idemim := List( idem, m -> MappingGeneratorsImages(m)[2] );; 
gap> idemim2 := 
> [ [ (), () ], [ (), (2,4) ], [ (2,4), () ], [ (), (1,3) ], [ (1,3), () ], 
>   [ (), (1,2)(3,4) ], [ (1,2)(3,4), (1,2)(3,4) ], [ (), (1,4)(2,3) ], 
>   [ (1,4)(2,3), (1,4)(2,3) ], [ (1,2,3,4), (1,2)(3,4) ] ];; 
gap> ForAll( idemim, m -> ( m in idemim2 ) ); 
true

## SubSection 5.3.5
gap> c4 := Group( (1,2,3,4) );; 
gap> c2 := Group( (5,6) );; 
gap> f1 := GroupHomomorphismByImages( c4, c2, [(1,2,3,4)], [(5,6)] );;
gap> c3 := Group( (1,2,3) );; 
gap> c6 := Group( (1,2,3,4,5,6) );; 
gap> f2 := GroupHomomorphismByImages( c3, c6, [(1,2,3)], [(1,3,5)(2,4,6)] );; 
gap> c4c3 := DirectProduct( c4, c3 ); 
Group([ (1,2,3,4), (5,6,7) ])
gap> c2c6 := DirectProduct( c2, c6 ); 
Group([ (1,2), (3,4,5,6,7,8) ])
gap> f := DirectProductOfFunctions( c4c3, c2c6, f1, f2 ); 
[ (1,2,3,4), (5,6,7) ] -> [ (1,2), (3,5,7)(4,6,8) ]
gap> ImageElm( f, (1,4,3,2)(5,7,6) ); 
(1,2)(3,7,5)(4,8,6)

## SubSection 5.3.6
gap> c9 := Group( (1,2,3,4,5,6,7,8,9) );; 
gap> ac9 := AutomorphismGroup( c9 );; 
gap> q8 := QuaternionGroup( IsPermGroup, 8 );;
gap> aq8 := AutomorphismGroup( q8 );;
gap> A := DirectProductOfAutomorphismGroups( ac9, aq8 );
<group with 5 generators>
gap> genA := GeneratorsOfGroup( A );;
gap> G := Source( genA[1] );
Group([ (1,2,3,4,5,6,7,8,9), (10,14,12,16)(11,17,13,15), (10,11,12,13)
(14,15,16,17) ])
gap> a := genA[1]*genA[5];  
[ (1,2,3,4,5,6,7,8,9), (10,14,12,16)(11,17,13,15), (10,11,12,13)(14,15,16,17) 
 ] -> [ (1,3,5,7,9,2,4,6,8), (10,16,12,14)(11,15,13,17), 
  (10,11,12,13)(14,15,16,17) ]
gap> ImageElm( a, (1,9,8,7,6,5,4,3,2)(10,14,12,16)(11,17,13,15) );
(1,8,6,4,2,9,7,5,3)(10,16,12,14)(11,15,13,17)

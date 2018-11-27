##############################################################################
##
#W  groups.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2018, The GAP Group 
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
gap> UpperFittingSeries( D12 );  LowerFittingSeries( D12 );
[ Group([  ]), Group([ f3, f2*f3 ]), Group([ f3, f2*f3, f1 ]) ]
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
gap> G := Group( (1,2,3), (3,4,5), (5,6,7), (7,8,9) );;
gap> phi := EpimorphismByGenerators( FreeGroup("a","b","c","d"), G );
[ a, b, c, d ] -> [ (1,2,3), (3,4,5), (5,6,7), (7,8,9) ]
gap> PreImagesRepresentative( phi, (1,2,3,4,5,6,7,8,9) );
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

## SubSection 5.3.1
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

#############################################################################
##
#E  groups.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

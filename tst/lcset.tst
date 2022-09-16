#@local  a, b, d, f, g, h, H1, H2, H3, K1, K2, K3, lc1, lc4, M, matcyc, rc5, s 

#############################################################################
##  adapted from gapdev/tst/tstinstall/cset.tst for left cosets 
## 
##  test of group intersection and LeftCoset
##
gap> START_TEST("lcset.tst");

# basic coset tests
gap> LeftCoset( (1,2), Group([(1,2,3),(2,3,4)]) ) 
>    = LeftCoset( (2,3), Group([(1,2,3),(2,3,4)]) );
true
gap> () in LeftCoset( (1,2), Group([(1,2,3,4)]) );
false
gap> (1,2) in LeftCoset( (5,6), SymmetricGroup(12) );
true
gap> Length( LeftCosets( SymmetricGroup(5), AlternatingGroup(4) ) );
10
gap> (1,2,3) * LeftCoset( (), AlternatingGroup(4) ) 
>    = LeftCoset( (), AlternatingGroup(4) );
true
gap> IsBiCoset( LeftCoset( (1,2), AlternatingGroup(6) ) );
true
gap> IsBiCoset( LeftCoset( (1,7), AlternatingGroup(6) ) );
false
gap> IsLeftCoset( LeftCoset( (1,2,3), MathieuGroup(12) ) );
true

# test intersecting permutation cosets 
gap> H1 := Group( [ (), (2,7,6)(3,4,5), (1,2,7,5,6,4,3) ] );; 
gap> H2 := Group( [ (1,2,3,4,5,6,7), (5,6,7) ] );; 
gap> H3 := Group( [ (1,2,3,4,5,6,8), (1,3,2,6,4,5), (1,6)(2,3)(4,5)(7,8) ] );; 
gap> AsSet( LeftCoset( (1,5,7,3)(4,6), H1 ) ) = 
>    Intersection( LeftCoset( (3,6)(4,7), H2 ), 
>                  LeftCoset( (1,5,3,8,6,7), H3 ) );
true
gap> AsSet( LeftCoset( (1,2,5,6,7,4,3,8), Group(()) ) ) =
>    Intersection( LeftCoset( (1,5,6,7)(3,8,4), 
>             Group( [ (1,4)(2,5), (1,3,5)(2,4,6), (1,5)(2,4)(3,6) ] ) ),
>                 LeftCoset( (1,2,6,8)(3,7), 
>             Group( [ (3,4), (5,6,7,8), (5,6) ] ) ) );
true
gap> [] = Intersection( LeftCoset( (), SymmetricGroup(4) ), 
>         LeftCoset( (4,7), SymmetricGroup([3..6]) ) );
true
gap> [] = Intersection( LeftCoset( (4,5), Group( [ (1,2,3,4,5) ] ) ), 
>         LeftCoset( (), AlternatingGroup(4) ) );
true
gap> AsSet( LeftCoset( (7,9), SymmetricGroup([3..5]) ) ) =
>    Intersection( LeftCoset( (1,2)(7,9), SymmetricGroup(5) ),
>                  LeftCoset( (7,9), SymmetricGroup([3..7]) ) );
true
gap> [] = Intersection( LeftCoset( (1,4)(3,5), Group([(1,2,3,4,5)]) ), 
>                       LeftCoset( (), SymmetricGroup(3) ) );
true
gap> AsSet( LeftCoset( (4,5), Group( [(5,6)] ) ) ) =
>    Intersection( LeftCoset( (), SymmetricGroup(6) ),
>                  LeftCoset( (4,5), SymmetricGroup([5..8]) ) );
true
gap> AsSet( LeftCoset( (1,4,5), SymmetricGroup(5) ) ) =
>    Intersection( LeftCoset( (), SymmetricGroup(5) ),
>                  LeftCoset( (1,2), SymmetricGroup(5) ) );
true
gap> [] =
>    Intersection( LeftCoset( (1,2), Group( (1,2,3,4,5) ) ),
>                  LeftCoset( (), Group( (1,2,3,5,4) ) ) );
true
gap> [] =
>    Intersection( LeftCoset( (1,2,3), Group( (1,2,3,4,5) ) ),
>                  LeftCoset( (), Group( (1,2,3,5,4) ) ) );
true
gap> AsSet( LeftCoset( (1,2), Group( [ (1,2,3,5,4) ] ) ) ) =
>    Intersection( LeftCoset( (), SymmetricGroup(7) ),
>                  LeftCoset( (1,2), Group( (1,2,3,5,4) ) ) );
true
gap> [] =
>    Intersection( LeftCoset( (), SymmetricGroup([3..7]) ),
>                  LeftCoset( (1,2), Group( (1,2,3,5,4) ) ) );
true

# test trivial cases
gap> Intersection( LeftCoset( (), Group([],()) ), 
>                  LeftCoset( (1,2), Group([],()) ) ) = [];
true
gap> Intersection( LeftCoset( (), Group( (1,2,3) ) ), 
>                  LeftCoset( (1,2), Group( (1,2,3) ) ) ) = [];
true
gap> Intersection( LeftCoset( (), AlternatingGroup(6) ), 
>                  LeftCoset( (1,2), AlternatingGroup(6) ) ) = [];
true
gap> Intersection( LeftCoset( (1,2), AlternatingGroup([1..5]) ), 
>                  LeftCoset( (1,2), AlternatingGroup([6..10]) ) ) 
>    = AsSet( LeftCoset( (1,2), Group(()) ) );
true

#coset of pc-group 
gap> d := DihedralGroup( 24 );
<pc group of size 24 with 4 generators>
gap> List( GeneratorsOfGroup(d), x -> Order(x) );
[ 2, 12, 6, 3 ]
gap> s := Subgroup( d, [ d.1, d.4 ] );;  
gap> SetName( s, "s" );
gap> lc4 := LeftCoset( d.2, s );      
LeftCoset(<object>,s)
gap> AsSet( lc4 );
[ f2, f2*f4, f1*f2*f3, f2*f4^2, f1*f2*f3*f4, f1*f2*f3*f4^2 ]
gap> d.2 * d.4 in lc4;
true

# coset of fp-group 
gap> f := FreeGroup(2);;  a := f.1;;  b := f.2;;
gap> g := f / [ a^5, b^4, a*b*a^2*b^3 ]; 
<fp group on the generators [ f1, f2 ]>
gap> Size(g);
20
gap> h := Subgroup( g, [g.1] );; 
gap> SetName( h, "C5" ); 
gap> rc5 := LeftCoset( g.2, h );
LeftCoset(<object>,C5)
gap> AsSet( rc5 );
[ f2, f2*f1, f2*f1^2, f2*f1^3, f2*f1^4 ]

# test intersection non-permutation cosets 
gap> K1 := Group( [ [[-1,0],[0,-1]] ] );;
gap> K2 := Group( [ [[-1,0],[0,1]], [[0,1],[1,0]] ] );; 
gap> K3 := Group( [ - IdentityMat(2) ] );; 
gap> AsSet( LeftCoset( [ [0,1],[1,0] ], K1 ) ) =
>    Intersection( LeftCoset( IdentityMat(2), K2 ),
>                  LeftCoset( [[0,1],[1,0]], K1 ) );
true
gap> AsSet( LeftCoset( [[0,1],[1,0]], K3 ) ) =
>    Intersection( LeftCoset( [[0,-1],[-1,0]], K3 ),
>                  LeftCoset( [[0,1],[1,0]], K3 ) );
true
gap> matcyc := CyclicGroup( IsMatrixGroup, GF(3), 4 );; 
gap> M := GeneratorsOfGroup( matcyc )[1];;
gap> lc1 := LeftCoset( M^2, matcyc );;
gap> Representative(lc1);
[ [ 0*Z(3), 0*Z(3), Z(3)^0, 0*Z(3) ], [ 0*Z(3), 0*Z(3), 0*Z(3), Z(3)^0 ], 
  [ Z(3)^0, 0*Z(3), 0*Z(3), 0*Z(3) ], [ 0*Z(3), Z(3)^0, 0*Z(3), 0*Z(3) ] ]

#
gap> STOP_TEST("lcset.tst", 1);

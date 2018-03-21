gap> START_TEST( "genalg.tst" );
gap> A := GroupRing( GF(5), DihedralGroup(4) );
<algebra-with-one over GF(5), with 2 generators>
gap> GeneratorsOfAlgebra(A);
[ (Z(5)^0)*<identity> of ..., (Z(5)^0)*f1, (Z(5)^0)*f2 ]
gap> A := GroupRing( GF(2), DihedralGroup(4) );
<algebra-with-one over GF(2), with 2 generators>
gap> GeneratorsOfAlgebra(A);                   
[ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1, (Z(2)^0)*f2 ]
gap> B := AugmentationIdeal(A);
<two-sided ideal in <algebra-with-one over GF(2), with 2 generators>, 
  (dimension 3)>
gap> GeneratorsOfAlgebra(B);   
[ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, 
  (Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]
gap> C := GroupRing( GF(2), SmallGroup( 4, 2 ) );
<algebra-with-one over GF(2), with 2 generators>
gap> GeneratorsOfAlgebra(C);                     
[ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1, (Z(2)^0)*f2 ]
gap> D := AugmentationIdeal(C);
<two-sided ideal in <algebra-with-one over GF(2), with 2 generators>, 
  (dimension 3)>
gap> GeneratorsOfAlgebra(D);   
[ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, 
  (Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]
gap> STOP_TEST( "genalg.tst", 10000 );

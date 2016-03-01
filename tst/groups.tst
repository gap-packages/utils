##############################################################################
##
#W  groups.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2016, The GAP Group   
##  

## SubSection 4.1.1 
gap> D12 := DihedralGroup( 12 );  SetName( D12, "D12" ); 
<pc group of size 12 with 3 generators>
gap> a := D12.1;;  b := D12.2;;  
gap> IsCommuting( a, b );
false

## SubSection 4.1.2 
gap> ListOfPowers( D12.2, 6 );
[ f2, f3, f2*f3, f3^2, f2*f3^2, <identity> of ... ]

## SubSection 4.1.3 
gap> GeneratorsAndInverses( D12 );
[ f1, f2, f3, f1, f2*f3^2, f3^2 ]

## SubSection 4.1.4 
gap> UpperFittingSeries( D12 );
[ Group([  ]), Group([ f3, f2*f3 ]), Group([ f3, f2*f3, f1 ]) ]
gap> LowerFittingSeries( D12 );
[ D12, Group([ f3 ]), Group([  ]) ]
gap> FittingLength( D12 );
2

## SubSection 4.2.2 
gap> G := Group((1,2,3,4),(3,4));;
gap> H := Group((6,7),(7,8));;    
gap> e1 := EpimorphismByGenerators(G,H);
[ (1,2,3,4), (3,4) ] -> [ (6,7), (7,8) ]
gap> ## note that this is just an abbreviation for: 
gap> e2 := GroupHomomorphismByImages( G, H, 
>              GeneratorsOfGroup(G), GeneratorsOfGroup(H) );;
gap> e1 = e2; 
true
gap> ## but the following is nonsense: 
gap> e0 := EpimorphismByGenerators( Group((1,2,3)), Group((8,9)) );
[ (1,2,3) ] -> [ (8,9) ]
gap> IsGroupHomomorphism(e0);
true

#############################################################################
##
#E  groups.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

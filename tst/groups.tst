##############################################################################
##
#W  groups.tst                  Utils Package                    
##
##  version 0.21, 02/02/2016   
##
#Y  Copyright (C) 2015-2016, The GAP Group,   
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

#############################################################################
##
#E  groups.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

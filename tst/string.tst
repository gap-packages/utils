##############################################################################
##
#W  string.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2016, The GAP Group 
##  

gap> UtilsLoadingComplete;
true

## SubSection 2.3.1 

gap> D12 := DihedralGroup( 12 ); 
<pc group of size 12 with 3 generators>
gap> BlankFreeString( D12 );     
"Group([f1,f2,f3])"
gap> S5 := SymmetricGroup( 5 );
Sym( [ 1 .. 5 ] )
gap> BlankFreeString( S5 );    
"SymmetricGroup([1..5])"

## SubSection 2.3.2 

gap> StringDotSuffix( "file.ext" );
"ext"
gap> StringDotSuffix( "file.ext.bak" );
"bak"
gap> StringDotSuffix( "file." );
""
gap> StringDotSuffix( "Hello" );   
fail


#############################################################################
##
#E  string.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

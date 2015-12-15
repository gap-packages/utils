##############################################################################
##
#W  string.tst                  Utils Package                    
##
##  version 0.13, 15/12/2015   
##
#Y  Copyright (C) 2015, The GAP Group, 
##  

## SubSection 2.3.1 

gap> D12 := DihedralGroup( 12 ); 
<pc group of size 12 with 3 generators>
gap> BlankFreeString( D12 );     
"Group([f1,f2,f3])"
gap> S5 := SymmetricGroup( 5 );
Sym( [ 1 .. 5 ] )
gap> BlankFreeString( S5 );    
"SymmetricGroup([1..5])"
gap> S := "Hello\!\, What's yours\?\, Goodbye\!";
"Hello!, What's yours?, Goodbye!"
gap> QuotesStripped(S);                          
"Hello!, What's yours?, Goodbye!"

## SubSection 2.3.2 

gap> StringDotSuffix( "file.ext" );
"ext"
gap> StringDotSuffix( "Hello" );   
fail


#############################################################################
##
#E  string.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

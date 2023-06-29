#@local  r, defaults, PrintDimensions, mydim

##############################################################################
##
#W  record.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2022, The GAP Group 
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 8.1.1 
gap> r := rec( a := 1, b := 2, c := 3 );;                                      
gap> AssignGlobals( r );
The following global variables have been assigned:
[ "a", "b", "c" ]
gap> [ a, b, c ];
[ 1, 2, 3 ]

## SubSection 8.2.1 
gap> defaults := rec( a := 1, b := 2, c := 3 );;
gap> OptionRecordWithDefaults( defaults, rec( a := 6) );
rec( a := 6, b := 2, c := 3 )
gap> OptionRecordWithDefaults( defaults, rec( b := 7, c := 8 ) );
rec( a := 1, b := 7, c := 8 )
gap> OptionRecordWithDefaults( defaults, [ ] );
rec( a := 1, b := 2, c := 3 )
gap> OptionRecordWithDefaults( defaults, [ rec( c := 8 ) ] );
rec( a := 1, b := 2, c := 8 )
gap> OptionRecordWithDefaults( defaults, rec( d := 9 ) );
Error, Unknown option: d
gap> OptionRecordWithDefaults( defaults, [ rec( b := 7 ), rec( c := 8 ) ] );
Error, Too many arguments for function
gap> OptionRecordWithDefaults( defaults, 5 );
Error, Options should be a record
gap> OptionRecordWithDefaults( defaults, [6,7,8] );
Error, Too many arguments for function

gap> PrintDimensions := function( arg ) 
>        local nargs, dim, order, V, L, len, K, i; 
>        nargs := Length( arg ); 
>        dim := [ arg[1]!.height, arg[1]!.width, arg[1]!.depth ]; 
>        order := rec( h := 1, w := 2, d := 3 ); 
>        V := [ "height", "width", "depth" ]; 
>        if ( nargs > 1 ) and IsRecord( arg[2] ) then 
>            order := OptionRecordWithDefaults( order, arg[2] ); 
>        fi; 
>        L := [ order!.h, order!.w, order!.d ]; 
>        len := Length( L );
>        K := [ 1..len ]; 
>        SortParallel( L, K ); 
>        Print( "dimensions: " ); 
>        Print( V[K[1]], " = ", dim[K[1]], ", " );
>        Print( V[K[2]], " = ", dim[K[2]], ", " );
>        Print( V[K[3]], " = ", dim[K[3]], "\n" );
>    end;;

gap> mydim := rec( height := 45, width := 31, depth := 17 ); 
rec( depth := 17, height := 45, width := 31 )
gap> PrintDimensions( mydim );
dimensions: height = 45, width = 31, depth = 17
gap> PrintDimensions( mydim, rec( h:=3, w:=1, d:=2 ) );
dimensions: width = 31, depth = 17, height = 45

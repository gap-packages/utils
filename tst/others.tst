##############################################################################
##
#W  others.tst                   Utils Package                    
##
#Y  Copyright (C) 2015-2018, The GAP Group 
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

## SubSection 7.1.1 
gap> dir := DirectoriesPackageLibrary( "example", "tst" );;
gap> FindMatchingFiles( dir, [ "" ], [ "g", "tst" ] );            
[ "hello.tst", "recipe.tst", "testall.g" ]
gap> dir := DirectoriesPackageLibrary( "utils" );;         
gap> FindMatchingFiles( dir, [ "" ], [ "gd", "gi" ] ); 
[ "files.gd", "files.gi", "groups.gd", "groups.gi", "latex.gd", "latex.gi", 
  "lists.gd", "lists.gi", "magma.gd", "magma.gi", "maps.gd", "maps.gi", 
  "number.gd", "number.gi", "print.gd", "print.gi", "record.gd", "record.gi", 
  "start.gd", "string.gd", "string.gi" ]
gap> dirname := Filename( dir[1], "tmp/" );;
gap> CreateDirIfMissing( dirname );
true
gap> filename := Concatenation( dirname, "hello.log" );;
gap> LogTo( filename );
gap> Print( "hello\n" );
hello
gap> LogTo();                                    
gap> FindMatchingFiles( dir, [ "tmp" ], [ "log" ] );
[ "tmp/hello.log" ]

## SubSection 7.3.1 
gap> IntOrInfinityToLaTeX( 10^3 );
"1000"
gap> IntOrInfinityToLaTeX( infinity );
"\\infty"

## SubSection 7.3.2 
gap> LaTeXStringFactorsInt( Factorial(12) );
"2^{10} \\cdot 3^5 \\cdot 5^2 \\cdot 7 \\cdot 11"

## SubSection 7.5.1 
gap> ConvertToMagmaInputString( Group( (1,2,3,4,5), (3,4,5) ) );
"PermutationGroup<5|(1,2,3,4,5),\n(3,4,5)>;\n"
gap> ConvertToMagmaInputString( Group( (1,2,3,4,5) ), "c5" );        
"c5:=PermutationGroup<5|(1,2,3,4,5)>;\n"
gap> ConvertToMagmaInputString( DihedralGroup( IsPcGroup, 10 ) );
"PolycyclicGroup< f1,f2 |\nf1^2,\nf2^5,\nf2^f1 = f2^4\n>;\n"
gap> M := GL(2,5);;  Size(M); 
480
gap> s1 := ConvertToMagmaInputString( M );
"F := GF(5);\nP := GL(2,F);\ngens := [\nP![2,0,0,1],\nP![4,1,4,0]\n];\nsub<P |\
 gens>;\n"
gap> Print( s1 );
F := GF(5);
P := GL(2,F);
gens := [
P![2,0,0,1],
P![4,1,4,0]
];
sub<P | gens>;
gap> n1 := [ [ Z(9)^0, Z(9)^0 ], [ Z(9)^0, Z(9) ] ];;
gap> n2 := [ [ Z(9)^0, Z(9)^3 ], [ Z(9)^4, Z(9)^2 ] ];;
gap> N := Group( n1, n2 );;  Size( N );
5760
gap> s2 := ConvertToMagmaInputString( N, "gpN" );;
gap> Print( s2 );
F := GF(3^2);
P := GL(2,F);
w := PrimitiveElement(F);
gens := [
P![ 1, 1, 1,w^1],
P![ 1,w^3, 2,w^2]
];
gpN := sub<P | gens>;

#############################################################################
##
#E  others.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

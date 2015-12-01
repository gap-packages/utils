#############################################################################
##
#W  string.gi                 GAP4 package `Utils'                Stefan Kohl
##
##  version 0.12, 01/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

#############################################################################
##  this method transferred from ResClasses 
##
#M  ViewString( <z> ) . . . . . . . . . . . . . .  for a finite field element
#M  ViewString( <s> ) . . . . . . . . . . . . . . . . . . . . .  for a string
##
InstallMethod( ViewString, "for a finite field element (ResClasses)", true,
               [ IsFFE and IsInternalRep ], 0, String );

#############################################################################
##  this method transferred from ResClasses 
##
#M  ViewString( <P> ) . . . . for a univariate polynomial over a finite field
##
InstallMethod( ViewString,
               "for univariate polynomial over finite field (ResClasses)",
               true, [ IsUnivariatePolynomial ], 0,

  function ( P )

    local  str, R, F, coeffs, coeffstrings, coeffintstrings, i;

    if   ValueGlobal("GF_Q_X_RESIDUE_CLASS_UNIONS_FAMILIES") = []
    then TryNextMethod(); fi;

    str := String(P);

    R := DefaultRing(P);
    F := LeftActingDomain(R);
    if not IsFinite(F) then TryNextMethod(); fi;
    if not IsPrimeField(F) then return str; fi;

    coeffs          := CoefficientsOfUnivariateLaurentPolynomial(P)[1];
    coeffs          := Concatenation(coeffs,[Zero(F),One(F)]);
    coeffstrings    := List(coeffs,String);
    coeffintstrings := List(List(coeffs,Int),String);

    for i in [1..Length(coeffstrings)] do
      str := ReplacedString(str,coeffstrings[i],coeffintstrings[i]);
    od;

    return str;
  end );

#############################################################################
##  this function transferred from ResClasses 
##
#F  BlankFreeString( <obj> ) . . . . . . . . . . . . .  string without blanks
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "BlankFreeString" )] = 0 ) then 

InstallGlobalFunction( BlankFreeString,

  function ( obj )

    local  str;

    str := String(obj);
    RemoveCharacters(str," ");
    return str;
  end );

fi;

#############################################################################
##  this function transferred from ResClasses 
##
#F  QuotesStripped( <str> ) . . . . . . . . . . . . . . string without quotes
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "QuotesStripped" )] = 0 ) then 

InstallGlobalFunction( QuotesStripped,

  function ( str )
    RemoveCharacters(str,"\"");
    return str;
  end );

fi;

#############################################################################
##
#E  string.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

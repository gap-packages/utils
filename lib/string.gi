#############################################################################
##
#W  string.gi                 GAP4 package `Utils'                Stefan Kohl
##
##  version 0.21, 02/02/2016 
##
#Y  Copyright (C) 2016, The GAP Group, 

if OKtoReadFromUtils( "ResClasses" ) then
Print( "reading ResClasses functions from string.gi\n" ); 

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
InstallGlobalFunction( BlankFreeString,

  function ( obj )

    local  str;

    str := String(obj);
    RemoveCharacters(str," ");
    return str;
  end );

#############################################################################
##  this function transferred from ResClasses 
##
#F  QuotesStripped( <str> ) . . . . . . . . . . . . . . string without quotes
##
InstallGlobalFunction( QuotesStripped,

  function ( str )
    RemoveCharacters(str,"\"");
    return str;
  end );

fi; 

#############################################################################
##  this function transferred from AutoDoc 
##
#O  StringDotSuffix( <str> ), but originally 
#F  AUTODOC_GetSuffix( <str> ) 
##
InstallMethod( StringDotSuffix, "for a string containing a dot", true, 
    [ IsString ], 0, 
function(str)
    local i;
    i := Length(str);
    while i > 0 and str[i] <> '.' do 
        i := i - 1; 
    od;
    if i = 0 then 
        return fail; 
    fi;
    return str{[i+1..Length(str)]};
end );

#############################################################################
##
#E  string.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

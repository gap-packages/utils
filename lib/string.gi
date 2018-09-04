#############################################################################
##
#W  string.gi                 GAP4 package `Utils'          Sebastian Gutsche
##                                                                 Stefan Kohl
##                                                          
#Y  Copyright (C) 2015-2016, The GAP Group 

#############################################################################
##  this function has been transferred from ResClasses 
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
##  this function has been copied from AutoDoc 
##  and was originally named AUTODOC_GetSuffix 
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

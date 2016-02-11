#############################################################################
##
#W  string.gi                 GAP4 package `Utils'          Sebastian Gutsche
##                                                          
##  version 0.25, 11/02/2016 
##
#Y  Copyright (C) 2016, The GAP Group, 

if OKtoReadFromUtils( "ResClasses" ) then
Print( "reading ResClasses functions from string.gi\n" ); 

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

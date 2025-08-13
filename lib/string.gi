#############################################################################
##
#W  string.gi                 GAP4 package `Utils'          Sebastian Gutsche
##                                                                 Stefan Kohl
##                                                          
#Y  Copyright (C) 2015-2025, The GAP Group 

#############################################################################
##  this function has been transferred from ResClasses 
##
#F  BlankFreeString( <obj> ) . . . . . . . . . . . . .  string without blanks
##
BindGlobal( "BlankFreeString",

  function ( obj )

    local  str;

    str := String(obj);
    RemoveCharacters(str," ");
    return str;
  end );

#############################################################################
##
#E  string.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

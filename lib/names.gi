#############################################################################
##
#W  names.gi                  GAP4 package `XMod'               Chris Wensley
##
##  version 0.12, 01/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

##  check which global functions are already declared (installed): 

for i in [1..Length(UTILS_FUNCTION_NAMES)] do 
    if ( UTILS_FUNCTION_NAMES[i] in GLOBAL_FUNCTION_NAMES ) then 
        UTILS_FUNCTION_STATUS[i] := 1; 
    fi;
od;

#############################################################################
##
#E  names.gi . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here

##############################################################################
##
#W  record.gi                   GAP4 package `Utils'         Sebastian Gutsche
##                                                           Max Horn
##  version 0.16, 21/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

#############################################################################
##  this method transferred from AutoDoc, was AUTODOC_WriteOnce 
##
#M  BindInRecordIfMissing( <rec>, <name>, <val> ) 
##
InstallGlobalFunction( BindInRecordIfMissing, 
    function( record, name, val )
    
    if not IsBound( record.(name) ) then    
        record.(name) := val; 
    fi;
end );


#############################################################################
##
#E  record.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

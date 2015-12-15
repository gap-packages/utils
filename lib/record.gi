##############################################################################
##
#W  record.gi                   GAP4 package `Utils'         Sebastian Gutsche
##                                                           Max Horn
##  version 0.13, 15/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

#############################################################################
##  this method transferred from AutoDoc
##
#M  WriteOnceInRecord( <rec>, <name>, <val> ) . only if position not yet bound
##
InstallGlobalFunction( WriteOnceInRecord, 
    function( record, name, val )
    
    if not IsBound( record.(name) ) then    
        record.(name) := val; 
    fi;
end );


#############################################################################
##
#E  record.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

#############################################################################
##
#W  others.gi                  GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2016, The GAP Group 


#############################################################################
##  this function has not been transferred from another package 
##
#M  PrintApplicableMethod( <fn>, <params> ) . for function and parameter list
##
InstallGlobalFunction( PrintApplicableMethod, 

function( arg ) 

    local  nargs, f, L, meth, name, j, k; 

    nargs := Length( arg ); 
    if not ( nargs in [2,4] ) then 
        Error( "Usage: PrintApplicableMethod( fn, params [, 0, n ] );" );
    fi; 
    f := arg[1]; 
    if not IsOperation( f ) then 
        Print( "this function is not an operation\n" ); 
    else 
        L := arg[2]; 
        if ( nargs = 2 ) then 
            meth := ApplicableMethod( f, L ); 
        elif ( ( nargs = 4 ) and ( arg[3] = 0 ) ) then 
            meth := ApplicableMethod( f, L, 0, arg[4] ); 
        else 
            Error( "Usage: PrintApplicableMethod( fn, params [, 0, n ] );" );
        fi; 
        if ( meth = fail ) then 
            Print( "ApplicableMethod returns fail\n" ); 
        else 
            name := FilenameFunc( meth ); 
            if ( name = fail ) then 
                Print( "FilenameFunc returns fail: kernel/compiled code?\n" );
            else 
                j := StartlineFunc( meth ); 
                k := EndlineFunc( meth );
                Print( "this method is contained in lines [", j, ",", k, "]" );
                Print( " of file:\n    ", name, "\n" ); 
                Print( meth ); 
            fi;
        fi;
    fi;
end );

#############################################################################
##
#E  others.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

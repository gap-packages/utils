#############################################################################
##
#W  app-meth.gi                GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2018, The GAP Group 

##  these functions are an attempt to replace GAP's ApplicableMethod

#############################################################################
##
#M  ApplicableMethodResetUtils(  ) unbind fields in APPLICABLE_METHODS_RECORD
##
InstallGlobalFunction( ApplicableMethodResetUtils, 

function(  ) 
    if not APPLICABLE_METHODS_RECORD.reset then 
        Unbind( APPLICABLE_METHODS_RECORD.arguments ); 
        Unbind( APPLICABLE_METHODS_RECORD.lenmeth ); 
        Unbind( APPLICABLE_METHODS_RECORD.methods ); 
        Unbind( APPLICABLE_METHODS_RECORD.name ); 
        Unbind( APPLICABLE_METHODS_RECORD.needs ); 
        Unbind( APPLICABLE_METHODS_RECORD.valid ); 
        APPLICABLE_METHODS_RECORD.reset := true; 
    fi; 
end );

#############################################################################
##
#M  ApplicableMethodPrintLevelUtils( ) set APPLICABLE_METHODS_RECORD.printlevel
##
InstallGlobalFunction( ApplicableMethodPrintLevelUtils, 

function( val ) 
    if not IsPosRat( val ) then 
        Error( "print level should be one of {1,2,3,4}" ); 
    fi; 
    if ( val > 4 ) then 
        Print( "#I  use PrintApplicableMethodUtils to print the code\n" ); 
        return; 
    fi; 
    APPLICABLE_METHODS_RECORD.printlevel := val; 
end );

#############################################################################
##
#M  ApplicableMethodSetupUtils( <fn>, <params> )  for function and parameters
##
InstallGlobalFunction( ApplicableMethodSetupUtils, 

function( arg )

    local oper, name, isconstructor, obj, leno, i, flags, fams, methods, lenm, 
          numm, needs, k, nam, val, code, flag, j, flag2, need, has, lenv; 

    ApplicableMethodResetUtils( ); 
    APPLICABLE_METHODS_RECORD.valid := [ ]; 
    APPLICABLE_METHODS_RECORD.arguments := arg; 
    if ( Length( arg ) < 2 ) or not IsList( arg[2] ) 
                             or not IsFunction( arg[1] ) then 
        Error( "usage: ApplicableMethodSetupUtils( <opr>, <arglist> )" );
    fi;
    ##  specifying the default print level as 1 
    if not IsBound( APPLICABLE_METHODS_RECORD.printlevel ) then 
        APPLICABLE_METHODS_RECORD.printlevel := 1; 
    fi; 
    oper := arg[1];
    name := NameFunction( oper ); 
    isconstructor := IS_CONSTRUCTOR( oper );
    if not IsOperation( oper ) then 
        if IsFunction( oper ) then 
            Print( "#I  ", name, " is a function, not an operation\n" ); 
            APPLICABLE_METHODS_RECORD.reset := false; 
            APPLICABLE_METHODS_RECORD.name := name; 
        fi; 
        return; 
    fi;
    obj := ShallowCopy( arg[2] );
    leno := Length( obj );
    for i in [1..leno] do
        if ( ( i = 1 ) and isconstructor ) then
            obj[i] := obj[i];
        else
            obj[i] := TypeObj( obj[i] );
        fi;
    od;

    # get families and filters
    flags := [ ];
    fams := [ ];
    for i in obj do
        if IsFilter(i) then
            Add( flags, FLAGS_FILTER(i) );
            Add( fams, fail );
        elif IsType(i) then
            Add( flags, i![2] );
            Add( fams, i![1] );
        else
            Error( "wrong kind of argument" );
        fi;
    od;
    if ForAny( fams, i -> i=fail ) then  #? fail in fams
        fams := fail;
        Info( InfoWarning, 1, "Family predicate cannot be tested" );
    fi;
    methods := METHODS_OPERATION( oper, leno );
    lenm := 4+leno;                   # length of one entry
    numm := Length( methods )/lenm;   # number of methods 
    needs := [ ]; 
    for i in [1..numm] do 
        k := lenm*(i-1);
        nam := methods[k+leno+4];
        val := methods[k+leno+3];
        code := methods[k+leno+2];
        flag := true;
        j := 1; 
        while ( j <= leno ) do 
            if j=1 and isconstructor then
                flag2 := IS_SUBSET_FLAGS( methods[k+1+j], flags[j] );
            else
                flag2 := IS_SUBSET_FLAGS( flags[j], methods[k+1+j] );
            fi;
            flag := flag and flag2;
                need := NamesFilter( methods[lenm*(i-1)+1+j] );
                has := NamesFilter( flags[j] ); 
                if j=1 and isconstructor then
                else
                    has := NamesFilter( flags[j] );
                fi; 
                Add( needs, Filtered( need, n -> not n in has ) ); 
            j := j+1;
        od;
        if flag then 
            Add( APPLICABLE_METHODS_RECORD.valid, i ); 
        fi;
    od; 
    lenv := Length( APPLICABLE_METHODS_RECORD.valid ); 
    APPLICABLE_METHODS_RECORD.methods := methods; 
    APPLICABLE_METHODS_RECORD.lenmeth := lenm; 
    APPLICABLE_METHODS_RECORD.needs := needs; 
    APPLICABLE_METHODS_RECORD.reset := false; 
    APPLICABLE_METHODS_RECORD.name := name; 
end);

#############################################################################
##
#M  ApplicableMethodUtils( <fn>, <params> [, <nr>] ) . . for fn and parameters
##
InstallGlobalFunction( ApplicableMethodUtils, 

function( arg )

    local oper, isconstructor, obj, i, nr, verbos, leno, empty, name, 
          valid, lenv, lenm, methods, needs, numm, lent, range, 
          m1, m2, pos, code, file, j, k, l, need; 

    if ( ( Length( arg ) < 2 ) or not IsList( arg[2] ) 
         or not IsFunction( arg[1] ) ) then
        Error("usage: ApplicableMethodUtils( <opr>, <arglist> [,<nr>] ] )" );
    fi; 
    oper := arg[1]; 
    isconstructor := IS_CONSTRUCTOR( oper );
    if ( not IsOperation( oper ) and IsFunction( oper ) ) then 
        file := FilenameFunc( oper ); 
        Print( "#I  This function starts at the following file and line number:\n" );
        Print( "#I  ", file, ":", StartlineFunc( oper ), "\n" );
        return oper;
    fi; 
    obj := ShallowCopy( arg[2] );
    for i in [1..Length(obj)] do
        if i=1 and IS_CONSTRUCTOR(arg[1]) then
            obj[i] := obj[i];
        else
            obj[i] := TypeObj( obj[i] );
        fi;
    od;
    if Length( arg ) > 2 then
        if IsPosInt( arg[3] ) then 
            nr := arg[3]; 
        elif ( arg[3] = "all" ) then 
            nr := -1; 
        else
            Error( "third argument not a positive integer, nor \"all\"" );
        fi;
    else
        nr := 1;
    fi;
    if IsBound( APPLICABLE_METHODS_RECORD.printlevel ) then 
        verbos := APPLICABLE_METHODS_RECORD.printlevel; 
    else
        verbos := 1;
    fi;
    leno := Length( obj );
    empty := ListWithIdenticalEntries( leno, [ ] );
    if APPLICABLE_METHODS_RECORD.reset then 
        ApplicableMethodSetupUtils( oper, arg[2] ); 
    else
        name := APPLICABLE_METHODS_RECORD.name; 
        if ( ( name <> NameFunction( oper ) ) or 
             ( arg <> APPLICABLE_METHODS_RECORD.arguments ) ) then 
            ApplicableMethodResetUtils( ); 
            ApplicableMethodSetupUtils( arg[1], arg[2] ); 
        fi;        
    fi; 
    name := APPLICABLE_METHODS_RECORD.name; 
    Print("#I  Searching Methods for ", name, " with ", leno, " arguments:\n" );
    valid := APPLICABLE_METHODS_RECORD.valid; 
    lenv := Length( valid ); 
    if ( nr > lenv ) then 
        if ( lenv = 0 ) then 
            Print( "#I  there are no applicable methods\n" ); 
        else 
            Print( "#I  fourth parameter greater than the number ", 
                   lenv, " of applicable methods" ); 
        fi;
        return; 
    fi; 
    lenm := APPLICABLE_METHODS_RECORD.lenmeth; 
    methods := APPLICABLE_METHODS_RECORD.methods; 
    needs := APPLICABLE_METHODS_RECORD.needs; 
    numm := Length( methods )/lenm; 
    lent := 4+leno;  #length of one entry 
    Print( "#I  ", name, " has ", numm, " methods\n" ); 
    Print( "#I  of which ", lenv, " are satisfied by the input.\n" ); 
    ## determine the range [m1..m2] of the methods to be printed 
    if ( nr = -1 ) then 
        range := valid; 
    else 
        m2 := valid[nr]; 
        if ( verbos = 1 ) then 
            m1 := m2; 
        else
            if ( nr = 1 ) then 
                m1 := 1;  
            else 
                m1 := valid[nr-1]+1; 
            fi; 
        fi; 
        range := [m1..m2]; 
    fi;
    for i in range do 
        pos := i*lenm; 
        Print( "#I Method: ", i, ",  value: ", methods[pos-1] ); 
        if ( i in valid ) then 
            Print( ",  is applicable method #", Position( valid, i ), ".\n" ); 
        else 
            Print( "\n" ); 
        fi;  
        Print( "#I  ", methods[pos], "\n" );
        code := methods[pos-2]; 
        file := FilenameFunc( code ); 
        if ( file <> fail ) then 
            Print( "#I  at: ", FilenameFunc( code ), 
                   ":", StartlineFunc( code ), "\n" ); 
        fi;
        if ( verbos > 2 ) then 
            if ( verbos = 3 ) then
                k := 1; 
            else 
                k := leno; 
            fi; 
            l := (i-1)*leno; 
            need := needs{[l+1..l+leno]}; 
            if ( need <> empty ) then 
                for j in [1..k] do 
                    Print( "#I  arg ", j, " needs ", need[j], "\n" );
                od; 
            fi;
        fi; 
    od;
    return code;
end);

#############################################################################
##
#M  PrintApplicableMethodUtils( <fn>, <params> ) . for fn and parameter list
##
InstallGlobalFunction( PrintApplicableMethodUtils, 

function( arg ) 

    local nargs, oper, L, i, nr, name, valid, lenm, methods, pos, 
          code, file, numm, lenv; 

    nargs := Length( arg ); 
    if not ( nargs in [2,3] ) then 
        Error( "Usage: PrintApplicableMethodUtils( oper, params [, n ] );" );
    fi; 
    oper := arg[1]; 
    L := ShallowCopy( arg[2] );
    for i in [1..Length(L)] do
        if ( ( i = 1 ) and IS_CONSTRUCTOR( arg[1] ) ) then
            L[i] := L[i];
        else
            L[i] := TypeObj( L[i] );
        fi;
    od;
    if ( nargs = 2 ) then 
        nr := 1; 
    else 
        nr := arg[3]; 
        if not IsPosInt( nr ) then 
            Error( "third argument should be a positive integer" ); 
        fi; 
    fi; 
    if APPLICABLE_METHODS_RECORD.reset then 
        ApplicableMethodSetupUtils( arg[1], arg[2] ); 
    else
        name := APPLICABLE_METHODS_RECORD.name; 
        if ( ( name <> NameFunction( oper ) ) or 
             ( arg <> APPLICABLE_METHODS_RECORD.arguments ) ) then 
            ApplicableMethodSetupUtils( arg[1], arg[2] ); 
        fi;        
    fi; 
    name := APPLICABLE_METHODS_RECORD.name;
    if ( not IsOperation( oper ) and IsFunction( oper ) ) then 
        file := FilenameFunc( oper ); 
    else 
        valid := APPLICABLE_METHODS_RECORD.valid; 
        lenm := APPLICABLE_METHODS_RECORD.lenmeth; 
        if ( nr > Length( valid ) ) then 
            Print( "#I  there are only ", Length( valid ), " valid methods\n" ); 
            return; 
        fi;
        methods := APPLICABLE_METHODS_RECORD.methods; 
        pos := valid[nr]*lenm - 2; 
        code := methods[pos]; 
        file := FilenameFunc( code ); 
        numm := Length( methods )/lenm;
        lenv := Length( valid );
        Print( "#I  ", name, " has ", numm, " methods\n" ); 
        Print( "#I  of which ", lenv, " are satisfied by the input.\n" ); 
    fi;
    if ( file <> fail ) then 
        if ( not IsOperation( oper ) and IsFunction( oper ) ) then 
            Print( "#I  This function starts at the following file and line number:\n" );
            Print( "#I  ", file, ":", StartlineFunc( oper ), "\n" );
            Print( oper );
        else 
            Print( "#I  This method starts at the following file and line number:\n" );
            Print( "#I  ", file, ":", StartlineFunc( code ), "\n" ); 
            Print( code );
        fi; 
    fi;
end );

#############################################################################
##
#E  app-meth.gi . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

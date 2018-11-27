##############################################################################
##
#W  record.gi                   GAP4 package `Utils'         Sebastian Gutsche
##                                                           Max Horn
##                                                           Stefan Kohl 
#Y  Copyright (C) 2015-2018, The GAP Group 

#############################################################################
##  this function has been transferred from RCWA
##
#F  AssignGlobals( <record> )
##
##  This auxiliary function assigns the record components of <record>
##  to global variables with the same names.
##
InstallGlobalFunction( AssignGlobals,

  function ( record )

    local  names, name;

    names := RecNames(record);
    for name in names do
      if IsBoundGlobal(name) then
        if IsReadOnlyGlobal(name)
        then
          MakeReadWriteGlobal(name);
          Info(InfoWarning,1,"The read-only global variable ",name,
                             " has been overwritten.");
        else
          Info(InfoUtils,1,"The global variable ",name,
                          " has been overwritten.");
        fi;
        UnbindGlobal(name);
      fi;
      BindGlobal(name,record.(name));
      MakeReadWriteGlobal(name);
    od;
    Print("The following global variables have been assigned:\n",
          Set(names),"\n");
  end );

#############################################################################
##
#E  record.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

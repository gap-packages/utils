##############################################################################
##
#W  start.gd                    GAP4 package `Utils'             Chris Wensley
##
##  version 0.25, 11/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

DeclareInfoClass( "InfoUtils" );

##  these version numbers refer to the latest package releases 
##  containing the code which is to be transferred 

UtilsPackageVersions := 
  [ "autodoc",     "2016.01.31", 
    "gpd",         "1.45",
    "resclasses",  "4.1.9", 
    "rcwa",        "4.0.9", 
    "xmod",        "2.55" 
  ];

#############################################################################
##
#F  OKtoReadFromUtils( <name> ) . . . tests whether name still contains the 
##                                    code to be transferred to Utils 
##
BIND_GLOBAL( "OKtoReadFromUtils", function( Name ) 
    local  name, ver, ver0, pos, ok; 

    name := LowercaseString( Name ); 
    pos := Position( UtilsPackageVersions, name ); 
    if ( pos = fail ) then 
        Error( "package 'name' not in the list UtilsPackageVersions" ); 
    fi; 
    ver0 := UtilsPackageVersions[ pos+1 ];  
    ver := InstalledPackageVersion( name ); 
    ok := ( ( ver = fail )         ## name is not installed on the system 
            or ( ver > ver0 ) );   ## name still contains the code 
    return ok; 
end );

#############################################################################
##
#E  start.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

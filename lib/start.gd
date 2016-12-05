##############################################################################
##
#W  start.gd                    GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2016, The GAP Group 

DeclareInfoClass( "InfoUtils" );

##  these version numbers refer to the latest package releases 
##  containing the code which is to be transferred 

UtilsPackageVersions := 
  [ "autodoc",     "2016.01.31", 
    "resclasses",  "4.2.5",         ## latest is 4.2.0, 02/03/16 
    "rcwa",        "4.1.5",         ## latest is 4.1.0, 02/03/16 
    "qpa",         "1.25",
    "xmod",        "2.55" 
  ];

##  functions being transferred cannot be used until the Home packages have  
##  been loaded: when this has been done the following variable is set true 

UtilsLoadingComplete := false; 

#############################################################################
##
#F  OKtoReadFromUtils( <name> ) . . . tests whether name still contains the 
##                                    code to be transferred to Utils 
#F  OKtoReadFromUtilsSpec( <name>, <oldver> ) . . . special case of above 
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

BIND_GLOBAL( "OKtoReadFromUtilsSpec", function( Name, oldver ) 
    local  name, ver, pos, ok; 

    name := LowercaseString( Name ); 
    pos := Position( UtilsPackageVersions, name ); 
    if ( pos = fail ) then 
        Error( "package 'name' not in the list UtilsPackageVersions" ); 
    fi; 
    ver := InstalledPackageVersion( name ); 
    ok := ( ( ver = fail )           ## name is not installed on the system 
            or ( ver > oldver ) );   ## name still contains the code 
    return ok; 
end );

#############################################################################
##
#E  start.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

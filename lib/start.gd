##############################################################################
##
#W  start.gd                    GAP4 package `Utils'             Chris Wensley
##
#Y  Copyright (C) 2015-2022, The GAP Group 

DeclareInfoClass( "InfoUtils" );

##  these version numbers refer to the latest package releases 
##  containing the code which is to be transferred 

UtilsPackageVersions := 
  [ "autodoc",     "2016.01.31",    ## latest is 2017.09.08
    "resclasses",  "4.2.5",         ## latest is 4.7.1, 18/12/17 
    "rcwa",        "4.1.5"          ## latest is 4.6.2, 26/06/18 
  ];
##  (04/09/18) removed QPA from this list - no functions transferred 
##  (02/06/18) removed xmod from this list 
##  functions being transferred cannot be used until the Home packages have  
##  been loaded: when this has been done the following variable is set true 

UtilsLoadingComplete := false; 

#############################################################################
##
#F  OKtoReadFromUtils( <name> ) . . . tests whether name still contains the 
##                                    code to be transferred to Utils 
#F  OKtoReadFromUtilsSpec( <name>, <oldver> ) . . . special case of above 
##
BindGlobal( "OKtoReadFromUtils", function( Name ) 
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

BindGlobal( "OKtoReadFromUtilsSpec", function( Name, oldver ) 
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

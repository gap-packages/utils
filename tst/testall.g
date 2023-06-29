############################################################################
##
#W  testall.g                   Utils Package                  Chris Wensley
##
#Y  Copyright (C) 2015-2023, The GAP Group 
##  

LoadPackage( "utils" ); 

##  first make sure that, if the transferred code has not been read, 
##  then the appropriate packages are loaded. 

if not UtilsLoadingComplete then 
    ReadPackage( "utils", "tst/loadall.g" ); 
fi; 

dir := DirectoriesPackageLibrary( "utils", "tst" );
TestDirectory(dir, rec(exitGAP := true,
    testOptions:=rec(compareFunction := "uptowhitespace")));

FORCE_QUIT_GAP(1);

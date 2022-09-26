##############################################################################
##
#W  testall.g                   Utils Package                    Chris Wensley
##
#Y  Copyright (C) 2015-2022, The GAP Group 
##  

LoadPackage( "utils" ); 

##  first make sure that, if the transferred code has not been read, 
##  then the appropriate packages are loaded. 

if not UtilsLoadingComplete then 
    ReadPackage( "utils", "tst/loadall.g" ); 
fi; 

dir := DirectoriesPackageLibrary("utils","tst");
TestDirectory(dir, rec(exitGAP := true,
    testOptions:=rec(compareFunction := "uptowhitespace")));

## download.tst now in tst-spec/ should only be run in early GAP versions 
v := GAPInfo.Version; 
if not CompareVersionNumbers( v, "4.13.0" ) then 
    dir := DirectoriesPackageLibrary("utils","tst-spec");
    TestDirectory(dir, rec(exitGAP := true,
        testOptions:=rec(compareFunction := "uptowhitespace")));
fi; 

FORCE_QUIT_GAP(1);

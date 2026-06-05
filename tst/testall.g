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

tstdir:= DirectoriesPackageLibrary( "utils", "tst" );
tstfile:= Filename( tstdir[1], "utils01.tst" );
tstdir:= Filename( tstdir, "" );
if IsWritableFile( tstdir ) and
   ( IsWritableFile( tstfile ) or not IsExistingFile( tstfile ) ) then
  # Create/update the testfiles containing the manual examples.
  # (The "nopdf" option informs AutoDoc that it can skip generating
  # PDF files, which makes this much faster)
  ReadPackage( "utils", "makedoc.g" : nopdf );
elif not IsExistingFile( tstfile ) then
  Print( "The testfiles with manual examples are missing ",
         "and cannot get written.\n" );
  QUIT_GAP(1);
fi;

dir := DirectoriesPackageLibrary( "utils", "tst" );
TestDirectory(dir, rec(exitGAP := true,
    testOptions:=rec(compareFunction := "uptowhitespace")));

FORCE_QUIT_GAP(1);

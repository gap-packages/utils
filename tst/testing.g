##############################################################################
##
#W  testing.g                   Utils Package                    Chris Wensley
##
#Y  Copyright (C) 2015-2019, The GAP Group 
##  

LoadPackage( "utils" ); 

##  first make sure that, if the transferred code has not been read, 
##  then the appropriate packages are loaded. 

if not UtilsLoadingComplete then 
    ReadPackage( "utils", "tst/loadall.g" ); 
fi; 

len := Length( UtilsPackageVersions ); 
j := 0; 
while ( j < len ) do 
    j := j+1; 
    name := UtilsPackageVersions[j]; 
    if not OKtoReadFromUtils( name ) then 
        LoadPackage( name ); 
    fi; 
    j := j+1;
od; 

pkgname := "utils";
pkgdir := DirectoriesPackageLibrary( pkgname, "tst" );
testfiles := 
        [ "print.tst",    "lists.tst",   "number.tst", "groups.tst", 
          "iterator.tst", "record.tst",  "others.tst" ];
testresult:=true;
for ff in testfiles do
    fn := Filename( pkgdir, ff );
    Print( "#I  Testing ", fn, "\n" );
    if not Test( fn, rec(compareFunction := "uptowhitespace", 
                            showProgress := true ) ) then
        testresult:=false;
    fi;
od;
if testresult then
    Print("#I  No errors detected while testing package ", pkgname, "\n");
else
    Print("#I  Errors detected while testing package ", pkgname, "\n");
fi;

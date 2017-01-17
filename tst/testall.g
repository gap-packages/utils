##############################################################################
##
#W  testall.g                   Utils Package                    Chris Wensley
##
#Y  Copyright (C) 2015-2017, The GAP Group 
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

TestMyPackage := function( pkgname )
    local  pkgdir, testfiles, testresult, ff, fn;
    LoadPackage( pkgname );
    pkgdir := DirectoriesPackageLibrary( pkgname, "tst" );

    # Arrange chapters as required
    testfiles := 
        [ "lists.tst", 
          "string.tst", 
          "number.tst", 
          "groups.tst", 
          "record.tst", 
          "others.tst" ];

    testresult:=true;
    for ff in testfiles do
        fn := Filename( pkgdir, ff );
        Print( "#I  Testing ", fn, "\n" );
        if not Test( fn, rec(compareFunction := "uptowhitespace") ) then
            testresult:=false;
        fi;
    od;
    if testresult then
        Print("#I  No errors detected while testing package ", pkgname, "\n");
    else
        Print("#I  Errors detected while testing package ", pkgname, "\n");
    fi;
end;

Print( "\n#I  Test output starts here" ); 
Print( "\n#I  =======================\n" );
##  Set the name of the package here
TestMyPackage( "utils" );

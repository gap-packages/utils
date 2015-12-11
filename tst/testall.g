##############################################################################
##
#W  testall.g                   Utils Package                    Chris Wensley
##
##  version 0.12, 03/12/2015   
##
#Y  Copyright (C) 2015, The GAP Group, 
##  

TestMyPackage := function( pkgname )
    local  pkgdir, testfiles, testresult, ff, fn;
    LoadPackage( pkgname );
    pkgdir := DirectoriesPackageLibrary( pkgname, "tst" );
    # Arrange chapters as required
    testfiles := 
        [ "lists.tst", "number.tst", "groups.tst", "others.tst" ];
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

##  Set the name of the package here
TestMyPackage( "utils" );

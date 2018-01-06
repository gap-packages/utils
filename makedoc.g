##  makedoc.g for the package Utils 
##  This builds the documentation of the Utils package. 
##  Needs: GAPDoc package, latex, pdflatex, mkindex
##  call this with GAP from within the package root directory 
##  
LoadPackage( "GAPDoc" );

if fail = LoadPackage("AutoDoc", ">= 2017.09.08") then
    Error("AutoDoc is required: version at least 2017.09.08");
fi;

AutoDoc( rec( 
    scaffold := rec(
        ## MainPage := false, 
        includes := [ "intro.xml", "lists.xml", "number.xml", "groups.xml", 
                      "record.xml", "others.xml", "transfer.xml" ],
        entities := rec( 
            AutoDoc := "<Package>AutoDoc</Package>",
            ResClasses := "<Package>ResClasses</Package>",
            RCWA := "<Package>RCWA</Package>",
            XMod := "<Package>XMod</Package>",
            Home := "<Package>Home</Package>",
            Magma := "<M>{\\sf Magma}</M>",
            MathJax := "<M>{\\sf MathJax}</M>"
        )
    )
));

# Create VERSION file for "make towww"
PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version );

QUIT;

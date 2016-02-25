##  makedoc.g for package Utils, version 25/02/16 
##  This builds the documentation of the Utils package. 
##  Needs: GAPDoc package, latex, pdflatex, mkindex
##  
LoadPackage( "GAPDoc" );

UtilsDoc := Filename( DirectoriesPackageLibrary( "Utils", "doc" ), "" );

MakeGAPDocDoc( UtilsDoc,  # path to the directory containing the main file
               "utils",   # the name of the main file (without extension)
                          # list of (probably source code) files relative 
                          # to path which contain pieces of documentation 
                          # which must be included in the document
               [ "../PackageInfo.g" ], 
               "Utils",   # the name of the book used by GAP's online help
    GAPInfo.RootPaths[3], # optional: relative path to the main GAP root 
                          # directory to produce HTML files with relative 
                          # paths to external books.
               "MathJax"  # optional: use "MathJax", "Tth" and/or "MathML"
                          # to produce additional variants of HTML files
               );; 

# Copy the *.css and *.js files from the styles directory of the GAPDoc 
# package into the directory containing the package manual.
CopyHTMLStyleFiles( UtilsDoc );

# Create the manual.lab file which is needed if the main manuals or another 
# package is referring to your package
GAPDocManualLab( "Utils" );; 

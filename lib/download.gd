##############################################################################
##
#W  download.gd                 GAP4 package `Utils'             Thomas Breuer
##
#Y  Copyright (C) 2022, The GAP Group

#############################################################################
##  This function is intended to be used instead of similar ones from
##  various packages (AtlasRep, FactInt, GAPDoc, PackageManager,
##  StandardFF, ...)
##  
#O  Download( <url>[, <opt>] ) 
##  
DeclareOperation( "Download", [ IsString ] );
DeclareOperation( "Download", [ IsString, IsRecord ] );


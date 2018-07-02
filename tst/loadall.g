##############################################################################
##
#W  loadall.g                   Utils Package                    Chris Wensley
##
#Y  Copyright (C) 2015-2016, The GAP Group 
##  

##  first make sure that, if the transferred code has not been read, 
##  then the appropriate packages are loaded. 

if not UtilsLoadingComplete then 
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
    UtilsLoadingComplete := true; 
fi;

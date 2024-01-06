#############################################################################
##
#W  init.g                 GAP package `Utils'                  Chris Wensley
##
#Y  Copyright (C) 2015-2023, The GAP Group,  
##

if not IsBound( PreImagesRepresentativeNC ) then 
    BindGlobal( "PreImagesRepresentativeNC", PreImagesRepresentative ); 
fi; 
if not IsBound( IsMatrixOrMatrixObj ) then 
    BindGlobal( "IsMatrixOrMatrixObj", IsMatrix ); 
fi; 
if not IsBound( MutableCopyMatrix ) then 
    BindGlobal( "MutableCopyMatrix", ShallowCopy ); 
fi; 

##  read the function declarations

ReadPackage( "utils", "lib/start.gd" );

ReadPackage( "utils", "lib/files.gd" );
ReadPackage( "utils", "lib/groups.gd" );
ReadPackage( "utils", "lib/iterator.gd" );
ReadPackage( "utils", "lib/latex.gd" );
ReadPackage( "utils", "lib/lcset.gd" );
ReadPackage( "utils", "lib/lists.gd" );
ReadPackage( "utils", "lib/magma.gd" );
ReadPackage( "utils", "lib/maps.gd" );
ReadPackage( "utils", "lib/matrix.gd" );
ReadPackage( "utils", "lib/number.gd" );
ReadPackage( "utils", "lib/print.gd" );
ReadPackage( "utils", "lib/record.gd" );
ReadPackage( "utils", "lib/string.gd" ); 
if not IsBound( Download ) then
    ReadPackage( "utils", "lib/download.gd" );
    BindGlobal("DOWNLOAD_FROM_UTILS", true);
fi;

##############################################################################
##
#W  cache.gd                    GAP4 package `Utils'               Stefan Kohl
##
##  version 0.21, 29/01/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

#############################################################################
##
#S  A simple caching facility. 
##
#############################################################################

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  these functions transferred from ResClasses 
##
#F  SetupCache( <name>, <size> )
#F  PutIntoCache( <name>, <key>, <value> )
#F  FetchFromCache( <name>, <key> )
##
##  A simple caching facility:
##
##  - The function `SetupCache' creates an empty cache named <name> for
##    at most <size> values.
##  - The function `PutIntoCache' puts the entry <value> with key <key>
##    into the cache named <name>.
##  - The function `FetchFromCache' picks the entry with key <key> from
##    the cache named <name>, and returns fail if no such entry exists.
##
DeclareGlobalFunction( "SetupCache" );
DeclareGlobalFunction( "PutIntoCache" );
DeclareGlobalFunction( "FetchFromCache" );

fi;

#############################################################################
##
#E  cache.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

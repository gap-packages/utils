##############################################################################
##
#W  cache.gd                    GAP4 package `Utils'               Stefan Kohl
##
##  version 0.12, 01/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

#############################################################################
##
#S  A simple caching facility. 
##
#############################################################################

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



#############################################################################
##
#E  cache.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

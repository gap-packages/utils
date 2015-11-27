##############################################################################
##
#W  cache.gd                    GAP4 package `Utils'             Chris Wensley
##
##  version 0.11, 27/11/2015 
##
#Y  Copyright (C) 2015, Chris Wensley et al,  
#Y  School of Computer Science, Bangor University, U.K. 

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

#############################################################################
##
#W  cache.gi                  GAP4 package `Utils'              Chris Wensley
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
##  this function transferred from ResClasses 
##
#F  SetupCache( <name>, <size> )
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "SetupCache" )] = 0 ) then 

InstallGlobalFunction( SetupCache,
                       function ( name, size )
                         BindGlobal(name,[[size,-1,fail]]);
                       end );
fi;

#############################################################################
##  this function transferred from ResClasses 
##
#F  PutIntoCache( <name>, <key>, <value> )
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "PutIntoCache" )] = 0 ) then 

InstallGlobalFunction( PutIntoCache,

  function ( name, key, value )

    local  cache, pos, i;

    cache := ValueGlobal(name);
    MakeReadWriteGlobal(name);
    pos := Position(List(cache,t->t[1]),key,1);
    if pos = fail then Add(cache,[key,0,value]);
                  else cache[pos][2] := 0; fi;
    for i in [2..Length(cache)] do
      cache[i][2] := cache[i][2] + 1;
    od;
    Sort(cache,function(t1,t2) return t1[2]<t2[2]; end);
    if   Length(cache) > cache[1][1]+1
    then cache := cache{[1..cache[1][1]+1]}; fi;
    MakeReadOnlyGlobal(name);
  end );

fi; 

#############################################################################
##  this function transferred from ResClasses 
##
#F  FetchFromCache( <name>, <key> )
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "FetchFromCache" )] = 0 ) then 

InstallGlobalFunction( "FetchFromCache",

  function ( name, key )

    local  cache, pos, i;

    cache := ValueGlobal(name);
    pos   := Position(List(cache,t->t[1]),key,1);
    if IsInt(pos) then
      MakeReadWriteGlobal(name);
      cache[pos][2] := 0;
      for i in [2..Length(cache)] do
        cache[i][2] := cache[i][2] + 1;
      od;
      MakeReadOnlyGlobal(name);
      return cache[pos][3];
    fi;
    return fail;
  end );

fi; 

#############################################################################
##
#E  cache.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

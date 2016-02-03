#############################################################################
##
#W  cache.gi                  GAP4 package `Utils'                Stefan Kohl
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
Print( "reading ResClasses functions from cache.gi\n" ); 

#############################################################################
##  this function transferred from ResClasses 
##
#F  SetupCache( <name>, <size> )
##
InstallGlobalFunction( SetupCache,
                       function ( name, size )
                         BindGlobal(name,[[size,-1,fail]]);
                       end );

#############################################################################
##  this function transferred from ResClasses 
##
#F  PutIntoCache( <name>, <key>, <value> )
##
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

#############################################################################
##  this function transferred from ResClasses 
##
#F  FetchFromCache( <name>, <key> )
##
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

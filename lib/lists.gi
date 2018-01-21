#############################################################################
##
#W  lists.gi                  GAP4 package `Utils'                Stefan Kohl
##                                                              Chris Wensley
##
#Y  Copyright (C) 2015-2018, The GAP Group 

if OKtoReadFromUtils( "XMod" ) then

#############################################################################
##  this function has been transferred from XMod 
##
#M  PrintListOneItemPerLine( <list> )
##
InstallMethod( PrintListOneItemPerLine, "generic method for lists", 
    true, [ IsList ], 0,
function( L )

    local  len, i;

    len := Length( L );
    if ( len < 2 ) then
        Print( L, "\n" );
    else
        Print( "[ " );
        for i in [1..len-1] do
            if IsBound( L[i] ) then
                Print( L[i], ",\n  " );
            else
                Print( "," );
            fi;
        od;
        Print( L[len], "\n  ]\n" );
    fi;
end );

fi; 

#############################################################################
##  this function has been transferred from XMod and renamed 
##
#M  PrintOneItemPerLine( <arg> )
#M  PrintIteratorOneItemPerLine( <iterator> )
##
InstallGlobalFunction( PrintOneItemPerLine, 

function( arg )

    local obj;

    obj := arg[1]; 
    if IsList( obj ) then 
        PrintListOneItemPerLine( obj ); 
    elif IsIterator( obj ) then 
        PrintIteratorOneItemPerLine( obj ); 
    else 
        PrintIteratorOneItemPerLine( Iterator( obj ) ); 
    fi;
end );

InstallMethod( PrintIteratorOneItemPerLine, "generic method for iterators", 
    true, [ IsIterator ], 0,
function( iter )

    local  it, x;

    it := ShallowCopy( iter );
    for x in it do 
        Print( x, "\n" ); 
    od;
end );

#############################################################################
##  these operations have not been transferred from any other package  
##
#M  PrintSelection( <args> )
#M  PrintSelectionFromList( <list>, <first>, <step> )
#M  PrintSelectionFromIterator( <iterator>, <first>, <last> )
##
InstallGlobalFunction( "PrintSelection", 

function( arg ) 

    local  nargs, obj, first, step, L, ok; 

    nargs := Length( arg ); 
    obj := arg[1]; 
    if ( nargs = 2 ) then 
        L := arg[2]; 
        if IsList( L ) then 
            ok := ForAll( L, n -> IsPosInt(n) ); 
            if not ok then 
                Error( "L must only contain positive integers" ); 
            fi; 
            if IsList( obj ) then 
                PrintSelectionFromListByList( obj, L ); 
            elif IsIterator( obj ) then 
                PrintSelectionFromIteratorByList( obj, L ); 
            else 
                PrintSelectionFromIteratorByList( Iterator( obj ), L ); 
            fi;
        else 
            Error( "second argument not a list" ); 
        fi;
    elif ( nargs = 3 ) then 
        first := arg[2]; 
        step := arg[3]; 
        if IsList( obj ) then 
            PrintSelectionFromList( obj, first, step ); 
        elif IsIterator( obj ) then 
            PrintSelectionFromIterator( obj, first, step ); 
        else 
            PrintSelectionFromIterator( Iterator( obj ), first, step ); 
        fi; 
    fi; 
end ); 

InstallMethod( PrintSelectionFromList, "generic method for lists", 
    true, [ IsList, IsPosInt, IsPosInt ], 0,
function( L, first, step )

    local  len, i;

    len := Length( L );
    if ( first <= len ) then 
        Print( first, " : ", L[first], "\n" ); 
        len := len-first; 
        i := first; 
        while ( len >= step ) do 
            i := i+step; 
            Print( i, " : ", L[i], "\n" ); 
            len := len-step; 
        od;
    fi; 
end );

InstallOtherMethod( PrintSelectionFromIterator, "generic method for iterators", 
    true, [ IsIterator, IsPosInt, IsPosInt ], 0,
function( iter0, first, step )

    local  iter, pos, i, x;

    iter := ShallowCopy( iter0 ); 
    i := 0; 
    while( ( i < first ) and not IsDoneIterator( iter ) ) do 
        i := i+1;
        x := NextIterator( iter ); 
    od; 
    pos := first; 
    Print( pos, " : ", x, "\n" );
    while not IsDoneIterator( iter ) do 
        i := 0;
        while( ( i < step ) and not IsDoneIterator( iter ) ) do 
            i := i+1;
            x := NextIterator( iter ); 
        od; 
        if ( i = step ) then 
            pos := pos + step; 
            Print( pos, " : ", x, "\n" );
        fi;
    od;
end );

InstallMethod( PrintSelectionFromListByList, "generic method for lists", 
    true, [ IsList, IsList ], 0,
function( L, posL )

    local  len, i;

    len := Length( L );
    for i in [1..len] do 
        if ( i in posL ) then 
            Print( i, " : ", L[i], "\n" );
        fi; 
    od; 
end );

InstallMethod( PrintSelectionFromIteratorByList, "generic method for iterators", 
    true, [ IsIterator, IsList ], 0,
function( iter0, posL )

    local  iter, i, x;

    iter := ShallowCopy( iter0 ); 
    i := 0; 
    for x in iter do 
        i := i+1;
        if ( i in posL ) then 
            Print( i, " : ", x, "\n" );
        fi; 
    od; 
end );


if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  these functions have been transferred from ResClasses 
##
#F  DifferencesList( <list> ) . . . . differences of consecutive list entries
#F  QuotientsList( <list> ) . . . . . . quotients of consecutive list entries
#F  FloatQuotientsList( <list> )  . . . . . . . . . . . . dito, but as floats
##

InstallGlobalFunction( DifferencesList,
    list -> List( [ 2..Length(list) ],
                  pos -> list[ pos ] - list[ pos-1 ] ) );

InstallGlobalFunction( QuotientsList, 
    function( list ) 
    local  len, pos, quot;
    len := Length( list ); 
    quot := ListWithIdenticalEntries( len-1, 0 ); 
    for pos in [1..len-1] do 
        if IsZero( list[pos] ) then 
            quot[pos] := fail; 
        else 
            quot[pos] := list[pos+1]/list[pos]; 
        fi; 
    od;
    return quot;
    end );

InstallGlobalFunction( FloatQuotientsList,
    list -> List( QuotientsList( list ), Float ) );

#############################################################################
##  this function has been transferred from ResClasses 
##
#M  RandomCombination( S, k ) . . . . . . . . . . . . . . . .  default method
##
InstallMethod( RandomCombination, "default method",
               ReturnTrue, [ IsListOrCollection, IsPosInt ],

  function ( S, k )

    local  c, elm, i;

    if k > Size(S) then return fail; fi;
    c := [];
    for i in [1..k] do
      repeat
        elm := Random(S);
      until not elm in c;
      Add(c,elm);
    od;
    return Set(c);
  end );

fi; 

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  this function has been transferred from RCWA 
##
#F  SearchCycle( <list> ) .  a utility function for detecting cycles in lists
##
InstallGlobalFunction( SearchCycle,

  function ( list )

    local  preperiod, cycle, startpos, mainpart, mainpartdiffs,
           elms, inds, min, n, d, i, j;

    n        := Length(list);
    mainpart := list{[Int(n/3)..n]};
    elms     := Set(mainpart);
    cycle    := [elms[1]];
    startpos := Filtered(Positions(list,elms[1]),i->i>n/3);
    if Length(elms) = 1 then
      if ValueOption("alsopreperiod") <> true then return cycle; else
        i := Length(list);
        repeat i := i - 1; until i = 0 or list[i] <> elms[1];
        preperiod := list{[1..i]};
        return [preperiod,cycle];
      fi;
    fi;
    i := 0;
    repeat
      i := i + 1;
      inds := Intersection(startpos+i,[1..n]);
      if inds = [] then return fail; fi;
      min := Minimum(list{inds});
      Add(cycle,min);
      startpos := Filtered(startpos,j->j+i<=n and list[j+i]=min);
      if Length(startpos) <= 1 then return fail; fi;
      mainpartdiffs := DifferencesList(Intersection(startpos,[Int(n/3)..n]));
      if mainpartdiffs = [] then return fail; fi;
      d := Maximum(mainpartdiffs); 
    until Length(cycle) = d;
    if    Minimum(startpos) > n/2
       or n-Maximum(startpos)-d+1 > d
       or list{[Maximum(startpos)+d..n]}<>cycle{[1..n-Maximum(startpos)-d+1]}
    then return fail; fi;
    if ValueOption("alsopreperiod") <> true then return cycle; else
      i := Minimum(startpos) + Length(cycle);
      repeat
        i := i - Length(cycle);
      until i <= 0 or list{[i..i+Length(cycle)-1]} <> cycle;
      preperiod := list{[1..i+Length(cycle)-1]};
      return [preperiod,cycle];
    fi;
  end );

fi;

#############################################################################
##
#E  lists.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

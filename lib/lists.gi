#############################################################################
##
#W  lists.gi                  GAP4 package `Utils'                Stefan Kohl
##                                                              Chris Wensley
##
#Y  Copyright (C) 2015-2017, The GAP Group 

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

if OKtoReadFromUtils( "QPA" ) then

#############################################################################
##  these functions have been transferred from QPA 
##
#M  PositionsNonzero( <list> )
##
InstallMethod( PositionsNonzero, "for a list", [ IsList ],
function( list )
    return PositionsProperty( list, 
               function( x ) 
                   return not IsZero( x ); 
               end );
end );

InstallMethod( NullList, "for a positive integer and a ring",
    [ IsPosInt, IsRing ],
function( length, ring )
    return NullMat( 1, length, ring )[ 1 ];
end );

fi; 

#############################################################################
##
#E  lists.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

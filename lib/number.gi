#############################################################################
##
#W  number.gi                 GAP4 package `Utils'                Stefan Kohl 
##
#Y  Copyright (C) 2015-2018, The GAP Group 

#############################################################################
##  this function has been transferred from RCWA 
##
#F  AllSmoothIntegers( <maxp>, <maxn> )
#F  AllSmoothIntegers( <primes>, <maxn> )
##
InstallGlobalFunction( AllSmoothIntegers,

  function ( maxp, maxn )

    local  extend, nums, primes, p;

    extend := function ( n, mini )

      local  i;

      if n > maxn then return; fi;
      Add(nums,n);
      for i in [mini..Length(primes)] do
        extend(primes[i]*n,i);
      od;
    end;

    if   IsInt(maxp)
    then primes := Filtered([2..maxp],IsPrimeInt);
    elif IsList(maxp) and ForAll(maxp,p->IsInt(p) and IsPrimeInt(p))
    then primes := maxp;
    else return fail; fi;
    if not IsPosInt(maxn) then return fail; fi;

    nums := [];
    extend(1,1);
    return Set(nums);
  end );

#############################################################################
##  this function has been transferred from RCWA
##
#F  NextProbablyPrimeInt( <n> ) . . next integer passing `IsProbablyPrimeInt'
##
InstallGlobalFunction( NextProbablyPrimeInt,

  function ( n )
    if   -3 = n            then n := -2;
    elif -3 < n  and n < 2 then n :=  2;
    elif n mod 2 = 0       then n := n+1;
    else                        n := n+2;
    fi;
    while not IsProbablyPrimeInt(n) do
        if n mod 6 = 1 then n := n+4;
        else                n := n+2;
        fi;
    od;
    return n;
  end );

#############################################################################
##  this function has been transferred from RCWA 
##
#F  RestrictedPartitionsWithoutRepetitions( <n>, <S> )
##
##  Given a positive integer n and a set of positive integers S, this func-
##  tion returns a list of all partitions of n into distinct elements of S.
##  The only difference to `RestrictedPartitions' is that no repetitions are
##  allowed.
##
InstallGlobalFunction( RestrictedPartitionsWithoutRepetitions,

  function ( n, S )

    local  look, comps;

    look := function ( comp, remaining_n, remaining_S )

      local  newcomp, newremaining_n, newremaining_S, part, l;

      l := Reversed(remaining_S);
      for part in l do
        newcomp        := Concatenation(comp,[part]);
        newremaining_n := remaining_n - part;
        if newremaining_n = 0 then Add(comps,newcomp);
        else
          newremaining_S := Set(Filtered(remaining_S,
                                         s->s<part and s<=newremaining_n));
          if newremaining_S <> [] then
            look(newcomp,newremaining_n,newremaining_S);
          fi;
        fi;
      od;
    end;

    comps := [];
    look([],n,S);
    return comps;
  end );

#############################################################################
##  this function has been transferred from RCWA 
##
#F  PrimeNumbersIterator(  )
#F  PrimeNumbersIterator( chunksize )
##
InstallGlobalFunction( PrimeNumbersIterator,

  function ( arg )

    local  next, copy, chunksize, maxdiv, nrdivs, offset;

    if   Length(arg) >= 1 and IsPosInt(arg[1])
    then chunksize := Maximum(arg[1],100); # must be bigger than largest
    else chunksize := 10000000; fi;        # prime gap in range looped over

    maxdiv     := RootInt(chunksize);
    offset     := List(Filtered([2..maxdiv],IsPrimeInt),p->[p,0]);
    nrdivs     := Length(offset);

    return IteratorByFunctions( rec( 

      NextIterator := function ( iter )
        local  sieve, range, p, q, pos, endpos, maxdiv_old, maxdiv, i, j;
        if iter!.index = 0 then
          sieve := ListWithIdenticalEntries(iter!.chunksize,0);
          if iter!.n = 0 then sieve[1] := 1; fi;
          for i in [1..iter!.nrdivs] do
            p := iter!.offset[i][1];
            if p > iter!.n then pos := 2 * p;
            else pos := iter!.offset[i][2]; 
            fi;
            if pos = 0 then pos := p; fi;
            endpos := pos + Int((iter!.chunksize-pos)/p) * p;
            if pos <= iter!.chunksize then
              range := [pos,pos+p..endpos];
              if IsRangeRep(range) then
                ADD_TO_LIST_ENTRIES_PLIST_RANGE(sieve,range,1);
              else
                for j in range do sieve[j] := sieve[j] + 1; od;
              fi;
            fi;
            if endpos <= iter!.chunksize then
              iter!.offset[i][2] := endpos + p - iter!.chunksize;
            else
              iter!.offset[i][2] := iter!.offset[i][2] - iter!.chunksize;
            fi;
          od;
          iter!.primepos := Positions(sieve,0);
        fi;
        iter!.index := iter!.index + 1;
        p := iter!.n + iter!.primepos[iter!.index];
        iter!.p := p;
        iter!.pi := iter!.pi + 1;
        if iter!.index = Length(iter!.primepos) then
          iter!.index := 0;
          iter!.n := iter!.n + iter!.chunksize;
          maxdiv_old := iter!.maxdiv;
          iter!.maxdiv := RootInt(iter!.n + iter!.chunksize);
          for q in Filtered([maxdiv_old+1..iter!.maxdiv],IsPrimeInt) do
            Add(iter!.offset,[q,(q-iter!.n) mod q]);
          od;
          iter!.nrdivs := Length(iter!.offset);
        fi;
        return p;
      end,

      ShallowCopy := function ( iter )
        return rec( chunksize  := iter!.chunksize,
                    n          := iter!.n,
                    p          := iter!.p,
                    pi         := iter!.pi,
                    index      := iter!.index,
                    primepos   := ShallowCopy(iter!.primepos),
                    nrdivs     := iter!.nrdivs,
                    maxdiv     := iter!.maxdiv,
                    offset     := StructuralCopy(iter!.offset) );
        end,

      IsDoneIterator := ReturnFalse,
      chunksize      := chunksize,
      n              := 0,
      p              := 0,
      pi             := 0,
      index          := 0,
      primepos       := [],
      nrdivs         := nrdivs,
      maxdiv         := maxdiv,
      offset         := offset ) );
  end );

#############################################################################
##  this function has been transferred from RCWA 
##
#M  AllProducts( <D>, <k> ) . . all products of <k>-tuples of elements of <D>
#M  AllProducts( <l>, <k> ) . . . . . . . . . . . . . . . . . . . . for lists
##
InstallMethod( AllProducts,
               "for lists (RCWA)", ReturnTrue, [ IsList, IsPosInt ], 0,
               function(l,k) return List(Tuples(l,k),Product); end );

#############################################################################
##
#E  number.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

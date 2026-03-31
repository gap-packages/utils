#############################################################################
##
#W  gslp.gi              GAP 4 package utils                    Thomas Breuer
##


#############################################################################
##
#V  GeneralizedStraightLineProgramsFamily
#V  GeneralizedStraightLineProgramsDefaultType
##
BindGlobal( "GeneralizedStraightLineProgramsFamily",
    NewFamily( "GeneralizedStraightLineProgramsFamily",
        IsGeneralizedStraightLineProgram ) );

BindGlobal( "GeneralizedStraightLineProgramsDefaultType",
    NewType( GeneralizedStraightLineProgramsFamily,
             IsGeneralizedStraightLineProgram and IsAttributeStoringRep ) );


#############################################################################
##
#F  GeneralizedStraightLineProgram( <lines>[, <nrgens>] )
#F  GeneralizedStraightLineProgram( <kind>, <list> )
##
InstallGlobalFunction( GeneralizedStraightLineProgram,
    function( arg )
    local kind, list, data, i, nin, nout;

    if Length( arg ) = 1 or
       ( Length( arg ) = 2 and not IsString( arg[1] ) ) then
      # Delegate to `StraightLineProgram'.
      return CallFuncList( StraightLineProgram, arg );
    elif Length( arg ) <> 2 then
      Error( "usage: GeneralizedStraightLineProgram( <lines>[, <nrgens>] )",
             " or GeneralizedStraightLineProgram( <kind>, <list> )" );
    fi;

    kind:= arg[1];
    list:= arg[2];

    if not IsList( list ) or IsEmpty( list ) then
      Error( "<list> must be a nonempty list" );
    fi;

    data:= ShallowCopy( list );
    for i in [ 1 .. Length( data ) ] do
      if not IsGeneralizedStraightLineProgram( data[i] ) then
        data[i]:= CallFuncList( GeneralizedStraightLineProgram, data[i] );
      fi;
    od;

    if kind = "union" then
      # Check that the inputs are compatible.
      nin:= NrInputsOfGeneralizedStraightLineProgram( data[1] );
      nout:= NrOutputsOfGeneralizedStraightLineProgram( data[1] );
      for i in [ 2 .. Length( data ) ] do
        if NrInputsOfGeneralizedStraightLineProgram( data[i] ) <> nin then
          Error( "all entries of <list> must have the same input number" );
        fi;
        nout:= nout + NrOutputsOfGeneralizedStraightLineProgram( data[i] );
      od;
    elif kind = "compose" then
      # Check that the inputs are compatible.
      nin:= NrOutputsOfGeneralizedStraightLineProgram( data[1] );
      for i in [ 2 .. Length( data ) ] do
        if NrInputsOfGeneralizedStraightLineProgram( data[i] ) <> nin then
          Error( "inputs and outputs for <list> are not compatible" );
        fi;
        nin:= NrOutputsOfGeneralizedStraightLineProgram( data[i] );
      od;
      nout:= nin;
      nin:= NrInputsOfGeneralizedStraightLineProgram( data[1] );
    else
      Error( "<kind> must be one of \"union\", \"compose\"" );
    fi;

    return ObjectifyWithAttributes( rec(),
        GeneralizedStraightLineProgramsDefaultType,
        DataOfGeneralizedStraightLineProgram, [ kind, data ],
        NrInputsOfGeneralizedStraightLineProgram, nin,
        NrOutputsOfGeneralizedStraightLineProgram, nout );
    end );


#############################################################################
##
#M  NrOutputsOfGeneralizedStraightLineProgram( <gslp> )
##
InstallMethod( NrOutputsOfGeneralizedStraightLineProgram,
    [ "IsGeneralizedStraightLineProgram" ],
    function( gslp )
    local data;

    if IsStraightLineProgram( gslp ) then
      # The value is in general not set in the construction.
      data:= Last( LinesOfStraightLineProgram( gslp ) );
      if ForAll( data, IsList ) then
        return Length( data );
      else
        return 1;
      fi;
    else
      # The value should get set in the construction.
      Error( "attribute value got lost?" );
    fi;
    end );


#############################################################################
##
#M  ResultOfGeneralizedStraightLineProgram( <gslp>, <gens> )
##
InstallMethod( ResultOfGeneralizedStraightLineProgram,
    [ "IsGeneralizedStraightLineProgram", "IsHomogeneousList" ],
    function( gslp, gens )
    local data, result, prg;

    # We may assume that the 'IsStraightLineProgram' method has higher rank.
    Assert( 1, not IsStraightLineProgram( gslp ) );

    data:= DataOfGeneralizedStraightLineProgram( gslp );
    if data[1] = "union" then
      result:= Concatenation( List( data[2],
                 x -> ResultOfGeneralizedStraightLineProgram( x, gens ) ) );
    else
      result:= gens;
      for prg in data[2] do
        result:= ResultOfGeneralizedStraightLineProgram( prg, result );
      od;
    fi;

    return result;
    end );


#############################################################################
##
#M  EquivalentStraightLineProgram( <gslp> )
##
InstallMethod( EquivalentStraightLineProgram,
    [ "IsGeneralizedStraightLineProgram" ],
    function( gslp )
    local data, result, i;

    if IsStraightLineProgram( gslp ) then
      return gslp;
    fi;

    data:= DataOfGeneralizedStraightLineProgram( gslp );
    if data[1] = "union" then
      result:= IntegratedStraightLineProgram(
                   List( data[2], EquivalentStraightLineProgram ) );
    else
      data:= data[2];
      result:= EquivalentStraightLineProgram( data[1] );
      for i in [ 2 .. Length( data ) ] do
        result:= CompositionOfStraightLinePrograms(
                     EquivalentStraightLineProgram( data[i] ), result );
      od;
    fi;
    return result;
    end );


#############################################################################
##
#M  ViewString( <gslp> )
#M  String( <gslp> )
##
##  We want that 'View' shows '<generalized straight line program>',
##  and that 'Print' shows GAP readable information.
##  (See '?Recommendations for the implementation' for the background.)
##
InstallMethod( ViewString,
    [ "IsGeneralizedStraightLineProgram" ],
    gslp -> "<generalized straight line program>" );

InstallMethod( ViewString,
    [ "IsStraightLineProgram" ],
    slp -> "<straight line program>" );
#T eventually move this to the GAP library

InstallMethod( String,
    [ "IsGeneralizedStraightLineProgram" ],
    function( gslp )
    local data;

    data:= DataOfGeneralizedStraightLineProgram( gslp );
    return Concatenation( "GeneralizedStraightLineProgram( \"",
               data[1], "\", [ ",
               JoinStringsWithSeparator( List( data[2], String ), ", " ),
               " ] )" );
    end );

InstallMethod( String,
    [ "IsStraightLineProgram" ],
    slp -> Concatenation( "StraightLineProgram( ",
               String( LinesOfStraightLineProgram( slp ) ), ", ",
               String( NrInputsOfStraightLineProgram( slp ) ), " )" ) );
#T eventually move this to the GAP library


#############################################################################
##
#M  IsInternallyConsistent( <gslp> )
##
##  <#GAPDoc Label="IsInternallyConsistent_gslp"> 
##  <ManSection>
##  <Meth Name="IsInternallyConsistent" Arg='gslp'
##   Label="for gen. straight line program"/>
##      
##  <Description>
##  For a generalized straight line program <A>gslp</A>,
##  it is checked whether all (generalized) straight line programs
##  from which <A>gslp</A> is built are internally consistent,
##  and whether their numbers of inputs and outputs are consistent and
##  compatible with the numbers of inputs and outputs of <A>gslp</A>.
##  <P/>
##  <Example><![CDATA[
##  gap> gslp:= GeneralizedStraightLineProgram( "union",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );;
##  gap> IsInternallyConsistent( gslp );
##  true
##  gap> gslp:= GeneralizedStraightLineProgram( "compose",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );;
##  gap> IsInternallyConsistent( gslp );
##  true
##  ]]></Example>
##  </Description>
##  </ManSection> 
##  <#/GAPDoc> 
##
InstallMethod( IsInternallyConsistent,
    [ "IsGeneralizedStraightLineProgram" ],
    function( gslp )
    local data, nrinp, constit;

    if IsStraightLineProgram( gslp ) then
      TryNextMethod();
    fi;
    data:= DataOfGeneralizedStraightLineProgram( gslp );
    if data[1] = "union" then
      nrinp:= NrInputsOfGeneralizedStraightLineProgram( gslp );
      return ForAll( data[2], x -> IsInternallyConsistent( x ) and
                 NrInputsOfGeneralizedStraightLineProgram( x ) = nrinp );
    elif data[1] = "compose" then
      nrinp:= NrInputsOfGeneralizedStraightLineProgram( gslp );
      for constit in data[2] do
        if ( not IsInternallyConsistent( constit ) ) or
           NrInputsOfGeneralizedStraightLineProgram( constit ) <> nrinp then
          return false;
        fi;
        nrinp:= NrOutputsOfGeneralizedStraightLineProgram( constit );
      od;
      return true;
    else
      return false;
    fi;
    end );


#############################################################################
##
#E


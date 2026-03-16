#############################################################################
##
#W  gslp.gd              GAP 4 package CTBlocks                 Thomas Breuer
##
##  A remark on the name <Q>generalized straight line program</Q>:
##  We could have taken the viewpoint that these objects are the ones that
##  one wants to deal with,
##  and that they should therefore be called <Q>straight line program</Q>,
##  whereas &GAP;'s straight line programs could be called
##  <Q>special straight line programs</Q>,
##  However,
##  several functions are applicable to &GAP;'s straight line programs
##  (such as <Ref Func="IntermediateResultOfSLP" BookName="ref"/>)
##  for which we do not intend to provide methods applicable to
##  our generalized straight line programs.
##  <#/GAPDoc>
##


#############################################################################
##
#C  IsGeneralizedStraightLineProgram( <obj> )
##
##  <#GAPDoc Label="IsGeneralizedStraightLineProgram">
##  <ManSection>
##  <Filt Name="IsGeneralizedStraightLineProgram" Arg='obj' Type='category'/>
##
##  <Description>
##  Each generalized straight line program in &GAP; lies in the category
##  <Ref Filt="IsGeneralizedStraightLineProgram"/>.
##  Examples are straight line programs, that is, objects in the category
##  <Ref Filt="IsStraightLineProgram" BookName="ref"/>.
##  <P/>
##  <Example><![CDATA[
##  gap> gslp:= GeneralizedStraightLineProgram( "union",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  gap> IsGeneralizedStraightLineProgram( gslp );
##  true
##  gap> slp:= StraightLineProgram( [[[1,2]]], 1 );
##  <straight line program>
##  gap> IsGeneralizedStraightLineProgram( slp );
##  true
##  gap> IsGeneralizedStraightLineProgram( [ slp, slp ] );
##  false
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsGeneralizedStraightLineProgram", IsObject );

InstallTrueMethod( IsGeneralizedStraightLineProgram, IsStraightLineProgram );


#############################################################################
##
#A  DataOfGeneralizedStraightLineProgram( <gslp> )
##
##  <#GAPDoc Label="DataOfGeneralizedStraightLineProgram">
##  <ManSection>
##  <Attr Name="DataOfGeneralizedStraightLineProgram" Arg='gslp'/>
##
##  <Description>
##  For a generalized straight line program <A>gslp</A> that is <E>not</E>
##  a straight line program,
##  <Ref Attr="DataOfGeneralizedStraightLineProgram"/> returns a list of
##  length two,
##  the first entry being either <C>"union"</C> or <C>"compose"</C>
##  and the second being the list of defining generalized straight line
##  programs.
##  <P/>
##  If <A>gslp</A> is a straight line program then this attribute is not
##  set in <A>gslp</A>.
##  There is no default method to compute the value if it is not stored.
##  <P/>
##  <Example><![CDATA[
##  gap> gslp:= GeneralizedStraightLineProgram( "union",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  gap> DataOfGeneralizedStraightLineProgram( gslp );
##  [ "union", [ <straight line program>, <straight line program> ] ]
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DataOfGeneralizedStraightLineProgram",
    IsGeneralizedStraightLineProgram );


#############################################################################
##
#A  NrInputsOfGeneralizedStraightLineProgram( <gslp> )
##
##  <#GAPDoc Label="NrInputsOfGeneralizedStraightLineProgram">
##  <ManSection>
##  <Attr Name="NrInputsOfGeneralizedStraightLineProgram" Arg='gslp'/>
##
##  <Description>
##  For a generalized straight line program <A>gslp</A>, this function
##  returns the number of generators that are needed as input.
##  <P/>
##  If <A>gslp</A> is a straight line program then it may be necessary that
##  the value is set in the construction of <A>gslp</A>,
##  see <Ref Attr="NrInputsOfStraightLineProgram" BookName="ref"/>.
##  If <A>gslp</A> is not a straight line program then the value is
##  determined by the (generalized) straight line programs from which
##  <A>gslp</A> is constructed.
##  <P/>
##  <Example><![CDATA[
##  gap> NrInputsOfGeneralizedStraightLineProgram(
##  >        GeneralizedStraightLineProgram( "union",
##  >            [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] ) );
##  1
##  ]]></Example>
##  <P/>
##  In order to avoid the introduction of unnecessary filters,
##  we define <Ref Attr="NrInputsOfGeneralizedStraightLineProgram"/> just as
##  a synonym of <Ref Attr="NrInputsOfStraightLineProgram" BookName="ref"/>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareSynonymAttr( "NrInputsOfGeneralizedStraightLineProgram",
    NrInputsOfStraightLineProgram );


#############################################################################
##
#A  NrOutputsOfGeneralizedStraightLineProgram( <gslp> )
##
##  <#GAPDoc Label="NrOutputsOfGeneralizedStraightLineProgram">
##  <ManSection>
##  <Attr Name="NrOutputsOfGeneralizedStraightLineProgram" Arg='gslp'/>
##
##  <Description>
##  For a generalized straight line program <A>gslp</A>, this function
##  returns the number of elements returned by
##  <Ref Oper="ResultOfGeneralizedStraightLineProgram"/> when <A>gslp</A>
##  is evaluated.
##  <P/>
##  Note that the &GAP; library does not define a corresponding attribute
##  for straight line programs.
##  <P/>
##  <Example><![CDATA[
##  gap> NrOutputsOfGeneralizedStraightLineProgram(
##  >        GeneralizedStraightLineProgram( "union",
##  >            [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] ) );
##  2
##  gap> NrOutputsOfGeneralizedStraightLineProgram(
##  >        GeneralizedStraightLineProgram( "compose",
##  >            [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] ) );
##  1
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NrOutputsOfGeneralizedStraightLineProgram",
    IsGeneralizedStraightLineProgram );


#############################################################################
##
#F  GeneralizedStraightLineProgram( <lines>[, <nrgens>] )
#F  GeneralizedStraightLineProgram( <kind>, <list> )
##
##  <#GAPDoc Label="GeneralizedStraightLineProgram">
##  <ManSection>
##  <Heading>GeneralizedStraightLineProgram</Heading>
##  <Func Name="GeneralizedStraightLineProgram" Arg='lines[, nrgens]'
##   Label="for a list of lines (and the number of generators)"/>
##  <Func Name="GeneralizedStraightLineProgram" Arg='kind, list'
##   Label="for kind and list"/>
##
##  <Description>
##  In the first form, <A>lines</A> must be a list of lists that defines
##  a unique straight line program
##  (see&nbsp;<Ref Func="IsStraightLineProgram" BookName="ref"/>);
##  in this case <Ref Func="GeneralizedStraightLineProgram"
##  Label="for a list of lines (and the number of generators)"/> delegates to
##  <Ref Func="StraightLineProgram" BookName="ref"
##  Label="for a list of lines (and the number of generators)"/>.
##  <P/>
##  In the second form, <A>kind</A> must be one of the strings <C>"union"</C>
##  or <C>"compose"</C>, and <A>list</A> must be a nonempty list such that
##  each of its entries is either a gslp or a list <M>l</M>, say,
##  such that <Ref Func="CallFuncList" BookName="ref"/>
##  applied to <Ref Func="GeneralizedStraightLineProgram"
##  Label="for a list of lines (and the number of generators)"/> and
##  <C>l</C> returns a gslp.
##  <P/>
##  <Example><![CDATA[
##  gap> GeneralizedStraightLineProgram( [[[1,2]]], 1 );
##  <straight line program>
##  gap> GeneralizedStraightLineProgram( "union",
##  > [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  gap> GeneralizedStraightLineProgram( "compose",
##  > [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GeneralizedStraightLineProgram" );


#############################################################################
##
#O  ResultOfGeneralizedStraightLineProgram( <gslp>, <gens> )
##
##  <#GAPDoc Label="ResultOfGeneralizedStraightLineProgram">
##  <ManSection>
##  <Oper Name="ResultOfGeneralizedStraightLineProgram" Arg='gslp, gens'/>
##
##  <Description>
##  <Ref Oper="ResultOfGeneralizedStraightLineProgram"/> evaluates the
##  generalized straight line program
##  (see&nbsp;<Ref Func="IsGeneralizedStraightLineProgram"/>) <A>gslp</A>
##  at the group elements in the list <A>gens</A>, as follows.
##  <P/>
##  <List>
##  <Item>
##      If <A>gslp</A> is a straight line program then the value of
##      <Ref Oper="ResultOfStraightLineProgram" BookName="ref"/> is returned.
##  </Item>
##  <Item>
##      If <A>gslp</A> is of <Q>union</Q> kind then
##      <Ref Oper="ResultOfGeneralizedStraightLineProgram"/> is applied to
##      each of the involved generalized straight line programs, with
##      second argument <A>gens</A>, and the concatenation of the results
##      is returned.
##  </Item>
##  <Item>
##      If <A>gslp</A> is of <Q>compose</Q> kind then
##      <Ref Oper="ResultOfGeneralizedStraightLineProgram"/> is first called
##      with the first involved generalized straight line program and
##      <A>gens</A>,
##      then the operation is called with the second involved
##      generalized straight line program and the result of this call,
##      and so on; the last such result is returned.
##  </Item>
##  </List>
##  <P/>
##  <Example><![CDATA[
##  gap> gens:= [ (1,2,3,4,5,6) ];;
##  gap> gslp:= GeneralizedStraightLineProgram( "union",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  gap> ResultOfGeneralizedStraightLineProgram( gslp, gens );
##  [ (1,3,5)(2,4,6), (1,4)(2,5)(3,6) ]
##  gap> gslp:= GeneralizedStraightLineProgram( "compose",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  gap> ResultOfGeneralizedStraightLineProgram( gslp, gens );
##  [ () ]
##  ]]></Example>
##  <P/>
##  In order to avoid the introduction of unnecessary operations,
##  we define <Ref Oper="ResultOfGeneralizedStraightLineProgram"/> just as
##  a synonym of <Ref Oper="ResultOfStraightLineProgram" BookName="ref"/>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareSynonym( "ResultOfGeneralizedStraightLineProgram",
    ResultOfStraightLineProgram );

DeclareOperation( "ResultOfGeneralizedStraightLineProgram",
    [ IsGeneralizedStraightLineProgram, IsHomogeneousList ] );


#############################################################################
##
#A  EquivalentStraightLineProgram( <gslp> )
##
##  <#GAPDoc Label="EquivalentStraightLineProgram">
##  <ManSection>
##  <Attr Name="EquivalentStraightLineProgram" Arg='gslp'/>
##
##  <Description>
##  For a generalized straight line program <A>gslp</A>,
##  <Ref Attr="EquivalentStraightLineProgram"/> returns
##  a straight line program such that evaluating <A>gslp</A> and this
##  straight line program with
##  <Ref Func="ResultOfGeneralizedStraightLineProgram"/> yields the same
##  output, for any list of input elements.
##  <P/>
##  <Example><![CDATA[
##  gap> gslp:= GeneralizedStraightLineProgram( "union",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  gap> slp:= EquivalentStraightLineProgram( gslp );
##  <straight line program>
##  gap> Display( slp );
##  # input:
##  r:= [ g1 ];
##  # program:
##  # return values:
##  [ r[1]^2, r[1]^3 ]
##  gap> gslp:= GeneralizedStraightLineProgram( "compose",
##  >               [ [ [[[1,2]]], 1 ], [ [[[1,3]]], 1 ] ] );
##  <generalized straight line program>
##  gap> slp:= EquivalentStraightLineProgram( gslp );
##  <straight line program>
##  gap> Display( slp );
##  # input:
##  r:= [ g1 ];
##  # program:
##  r[2]:= r[1]^2;
##  r[1]:= r[2];
##  # return values:
##  [ r[1]^3 ]
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "EquivalentStraightLineProgram",
    IsGeneralizedStraightLineProgram );


#############################################################################
##
#E


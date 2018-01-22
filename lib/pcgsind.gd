#############################################################################
##
#W  pcgsind.gd                  GAP Library                      Frank Celler
##
##
#Y  Copyright (C)  1996,  Lehrstuhl D für Mathematik,  RWTH Aachen,  Germany
#Y  (C) 1998 School Math and Comp. Sci., University of St Andrews, Scotland
#Y  Copyright (C) 2002 The GAP Group
##
##  This  file  contains  the operations   for  induced polycylic  generating
##  systems.
##

#############################################################################
##
#C  IsInducedPcgs(<pcgs>)
##
##  <#GAPDoc Label="IsInducedPcgs">
##  <ManSection>
##  <Filt Name="IsInducedPcgs" Arg='pcgs' Type='Category'/>
##
##  <Description>
##  The category of induced pcgs. This a subcategory of pcgs.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsInducedPcgs", IsPcgs );


#############################################################################
##
#O  InducedPcgsByPcSequence( <pcgs>, <pcs> )
#O  InducedPcgsByPcSequenceNC( <pcgs>, <pcs>[, <depths>] )
##
##  <#GAPDoc Label="InducedPcgsByPcSequence">
##  <ManSection>
##  <Oper Name="InducedPcgsByPcSequence" Arg='pcgs, pcs'/>
##  <Oper Name="InducedPcgsByPcSequenceNC" Arg='pcgs, pcs[, depths]'/>
##
##  <Description>
##  If <A>pcs</A> is a list of elements that form an induced pcgs
##  with respect to <A>pcgs</A> this operation returns an induced pcgs
##  with these elements.
##  <P/>
##  In the third version, the depths of <A>pcs</A> with respect to
##  <A>pcgs</A> can be given (they are computed anew otherwise).
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "InducedPcgsByPcSequence", [ IsPcgs, IsList ] );
DeclareOperation( "InducedPcgsByPcSequenceNC", [ IsPcgs, IsList ] );

#############################################################################
##
#A  LeadCoeffsIGS( <igs> )
##
##  <#GAPDoc Label="LeadCoeffsIGS">
##  <ManSection>
##  <Attr Name="LeadCoeffsIGS" Arg='igs'/>
##
##  <Description>
##  This attribute is used to store leading coefficients with respect to the
##  parent pcgs. the <A>i</A>-th entry &ndash;if bound&ndash; is the leading
##  exponent of the element of <A>igs</A> that has depth <A>i</A> in the
##  parent.
##  (It cannot be assigned to a component in the object created by
##  <Ref Func="InducedPcgsByPcSequenceNC"/> as the
##  permutation group methods call it from within the postprocessing,
##  before this postprocessing however no coefficients may be computed.)
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "LeadCoeffsIGS", IsInducedPcgs );


#############################################################################
##
#O  InducedPcgsByPcSequenceAndGenerators( <pcgs>, <ind>, <gens> )
##
##  <#GAPDoc Label="InducedPcgsByPcSequenceAndGenerators">
##  <ManSection>
##  <Oper Name="InducedPcgsByPcSequenceAndGenerators" Arg='pcgs, ind, gens'/>
##
##  <Description>
##  returns an induced pcgs with respect to <A>pcgs</A> of the subgroup
##  generated by <A>ind</A> and <A>gens</A>.
##  Here <A>ind</A> must be an induced pcgs with respect to
##  <A>pcgs</A> (or a list of group elements that form such an igs)
##  and it will be used as initial sequence for the computation.
##
##  <Example><![CDATA[
##  gap> G := Group( (1,2,3,4),(1,2) );;  P := Pcgs(G);;
##  gap> I := InducedPcgsByGenerators( P, [(1,2,3,4)] );
##  Pcgs([ (1,2,3,4), (1,3)(2,4) ])
##  gap> J := InducedPcgsByPcSequenceAndGenerators( P, I, [(1,2)] );
##  Pcgs([ (1,2,3,4), (2,4,3), (1,4)(2,3), (1,3)(2,4) ])
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation(
    "InducedPcgsByPcSequenceAndGenerators",
    [ IsPcgs, IsList, IsList ] );


#############################################################################
##
#O  InducedPcgsByGenerators( <pcgs>, <gens> )
#O  InducedPcgsByGeneratorsNC( <pcgs>, <gens> )
##
##  <#GAPDoc Label="InducedPcgsByGenerators">
##  <ManSection>
##  <Oper Name="InducedPcgsByGenerators" Arg='pcgs, gens'/>
##  <Oper Name="InducedPcgsByGeneratorsNC" Arg='pcgs, gens'/>
##
##  <Description>
##  returns an induced pcgs with respect to <A>pcgs</A>
##  for the subgroup generated by <A>gens</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "InducedPcgsByGenerators", [ IsPcgs, IsCollection ] );
DeclareOperation( "InducedPcgsByGeneratorsNC", [ IsPcgs, IsCollection ] );


#############################################################################
##
#O  InducedPcgsByGeneratorsWithImages( <pcgs>, <gens>, <imgs> )
##
##  <ManSection>
##  <Oper Name="InducedPcgsByGeneratorsWithImages" Arg='pcgs, gens, imgs'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##
DeclareOperation(
    "InducedPcgsByGeneratorsWithImages",
    [ IsPcgs, IsCollection, IsCollection ] );

#############################################################################
##
#O  CanonicalPcgsByGeneratorsWithImages( <pcgs>, <gens>, <imgs> )
##
##  <#GAPDoc Label="CanonicalPcgsByGeneratorsWithImages">
##  <ManSection>
##  <Oper Name="CanonicalPcgsByGeneratorsWithImages" Arg='pcgs, gens, imgs'/>
##
##  <Description>
##  computes a canonical, <A>pcgs</A>-induced pcgs for the span of
##  <A>gens</A> and simultaneously does the same transformations on
##  <A>imgs</A>, preserving thus a correspondence between <A>gens</A> and
##  <A>imgs</A>.
##  This operation is used to represent homomorphisms from a pc group.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation(
    "CanonicalPcgsByGeneratorsWithImages",
    [ IsPcgs, IsCollection, IsCollection ] );


#############################################################################
##
#O  AsInducedPcgs( <parent>, <pcs> )
##
##  <ManSection>
##  <Oper Name="AsInducedPcgs" Arg='parent, pcs'/>
##
##  <Description>
##  Obsolete function, potentially erraneous. DO NOT USE!
##  returns an induced pcgs with <A>parent</A> as parent pcgs and to the
##  sequence of elements <A>pcs</A>.
##  </Description>
##  </ManSection>
##
DeclareOperation(
    "AsInducedPcgs",
    [ IsPcgs, IsList ] );


#############################################################################
##
#A  ParentPcgs( <pcgs> )
##
##  <#GAPDoc Label="ParentPcgs">
##  <ManSection>
##  <Attr Name="ParentPcgs" Arg='pcgs'/>
##
##  <Description>
##  returns the pcgs by which <A>pcgs</A> was induced.
##  If <A>pcgs</A> was not induced, it simply returns <A>pcgs</A>.
##  <Example><![CDATA[
##  gap> G := Group( (1,2,3,4),(1,2) );;
##  gap> P := Pcgs(G);;
##  gap> K := InducedPcgsByPcSequence( P, [(1,2,3,4),(1,3)(2,4)] );
##  Pcgs([ (1,2,3,4), (1,3)(2,4) ])
##  gap> ParentPcgs( K );
##  Pcgs([ (3,4), (2,4,3), (1,4)(2,3), (1,3)(2,4) ])
##  gap> IsInducedPcgs( K );
##  true
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ParentPcgs", IsInducedPcgs );


#############################################################################
##
#A  CanonicalPcgs( <pcgs> )
##
##  <#GAPDoc Label="CanonicalPcgs">
##  <ManSection>
##  <Attr Name="CanonicalPcgs" Arg='pcgs'/>
##
##  <Description>
##  returns the canonical pcgs corresponding to the induced pcgs <A>pcgs</A>.
##  <Example><![CDATA[
##  gap> G := Group((1,2,3,4),(5,6,7));
##  Group([ (1,2,3,4), (5,6,7) ])
##  gap> P := Pcgs(G);
##  Pcgs([ (5,6,7), (1,2,3,4), (1,3)(2,4) ])
##  gap> I := InducedPcgsByPcSequence(P, [(5,6,7)*(1,3)(2,4),(1,3)(2,4)] );
##  Pcgs([ (1,3)(2,4)(5,6,7), (1,3)(2,4) ])
##  gap> CanonicalPcgs(I);
##  Pcgs([ (5,6,7), (1,3)(2,4) ])
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CanonicalPcgs", IsInducedPcgs );


#############################################################################
##
#P  IsCanonicalPcgs( <pcgs> )
##
##  <#GAPDoc Label="IsCanonicalPcgs">
##  <ManSection>
##  <Prop Name="IsCanonicalPcgs" Arg='pcgs'/>
##
##  <Description>
##  An induced pcgs is canonical if the matrix of the exponent vectors of
##  the elements of <A>pcgs</A> with respect to the <Ref Func="ParentPcgs"/>
##  value of <A>pcgs</A> is in Hermite normal form
##  (see <Cite Key="SOGOS"/>). While a subgroup can have various
##  induced pcgs with respect to a parent pcgs a canonical pcgs is unique.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsCanonicalPcgs", IsInducedPcgs );
InstallTrueMethod( IsInducedPcgs, IsCanonicalPcgs );

#############################################################################
##
#P  IsParentPcgsFamilyPcgs( <pcgs> )
##
##  <#GAPDoc Label="IsParentPcgsFamilyPcgs">
##  <ManSection>
##  <Prop Name="IsParentPcgsFamilyPcgs" Arg='pcgs'/>
##
##  <Description>
##  This property indicates that the pcgs <A>pcgs</A> is induced with respect
##  to a family pcgs.
##  <P/>
##  This property is needed to distinguish between different independent 
##  polycyclic generating sequences which a pc group may have, since
##  the elementary operations for a non-family pcgs may not be as efficient 
##  as the elementary operations for the family pcgs.
##  <P/>
##  This can have a significant influence on the performance of algorithms
##  for polycyclic groups.
##  Many algorithms require a pcgs that corresponds to an
##  elementary abelian series
##  (see&nbsp;<Ref Func="PcgsElementaryAbelianSeries" Label="for a group"/>)
##  or even a special pcgs (see&nbsp;<Ref Sect="Special Pcgs"/>).
##  If the family pcgs has the required
##  properties, it will be used for these purposes, if not &GAP; has to work
##  with respect to a new pcgs which is <E>not</E> the family pcgs and thus
##  takes longer for elementary calculations like
##  <Ref Func="ExponentsOfPcElement"/>.
##  <P/>
##  Therefore, if the family pcgs chosen for arithmetic is not of importance
##  it might be worth to <E>change</E> to another, nicer, pcgs to speed up
##  calculations.
##  This can be achieved, for example, by using the 
##  <Ref Func="Range" Label="of a general mapping"/> value
##  of the isomorphism obtained by <Ref Func="IsomorphismSpecialPcGroup"/>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsParentPcgsFamilyPcgs", IsInducedPcgs,
  20 # we want this to be larger than filters like `PrimeOrderPcgs'
     # (cf. rank for `IsFamilyPcgs' in pcgsind.gd)
  );
InstallTrueMethod( IsInducedPcgs, IsParentPcgsFamilyPcgs );

#############################################################################
##
#A  ElementaryAbelianSubseries( <pcgs> )
##
##  <ManSection>
##  <Attr Name="ElementaryAbelianSubseries" Arg='pcgs'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##
DeclareAttribute(
    "ElementaryAbelianSubseries",
    IsPcgs );



#############################################################################
##
#O  CanonicalPcElement( <ipcgs>, <elm> )
##
##  <#GAPDoc Label="CanonicalPcElement">
##  <ManSection>
##  <Oper Name="CanonicalPcElement" Arg='ipcgs, elm'/>
##
##  <Description>
##  reduces <A>elm</A> at the induces pcgs <A>ipcgs</A> such that the
##  exponents of the reduced result <A>r</A> are zero at the depths
##  for which there are generators in <A>ipcgs</A>.
##  Elements, whose quotient lies in the group generated by
##  <A>ipcgs</A> yield the same canonical element.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CanonicalPcElement", [ IsInducedPcgs, IsObject ] );


#############################################################################
##
#O  SiftedPcElement( <pcgs>, <elm> )
##
##  <#GAPDoc Label="SiftedPcElement">
##  <ManSection>
##  <Oper Name="SiftedPcElement" Arg='pcgs, elm'/>
##
##  <Description>
##  sifts <A>elm</A> through <A>pcgs</A>, reducing it if the depth is the
##  same as the depth of one of the generators in <A>pcgs</A>.
##  Thus the identity is returned if <A>elm</A> lies in the group generated
##  by <A>pcgs</A>.
##  <A>pcgs</A> must be an induced pcgs (see section 
##  <Ref Sect="Subgroups of Polycyclic Groups - Induced Pcgs"/>) 
##  and <A>elm</A> must lie in the span of the parent of <A>pcgs</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation(
    "SiftedPcElement",
    [ IsInducedPcgs, IsObject ] );


#############################################################################
##
#O  HomomorphicCanonicalPcgs( <pcgs>, <imgs> )
##
##  <ManSection>
##  <Oper Name="HomomorphicCanonicalPcgs" Arg='pcgs, imgs'/>
##
##  <Description>
##  It is important that <A>imgs</A> are the images of an induced generating
##  system in their natural order, i. e. they must not be sorted according to
##  their depths in the new group, they must be sorted according to their
##  depths in the old group.
##  </Description>
##  </ManSection>
##
DeclareOperation(
    "HomomorphicCanonicalPcgs",
    [ IsPcgs, IsList ] );


#############################################################################
##
#O  HomomorphicInducedPcgs( <pcgs>, <imgs> )
##
##  <ManSection>
##  <Oper Name="HomomorphicInducedPcgs" Arg='pcgs, imgs'/>
##
##  <Description>
##  It is important that <A>imgs</A> are the images of an induced generating
##  system in their natural order, i. e. they must not be sorted according to
##  their depths in the new group, they must be sorted according to their
##  depths in the old group.
##  </Description>
##  </ManSection>
##
DeclareOperation(
    "HomomorphicInducedPcgs",
    [ IsPcgs, IsList ] );

#############################################################################
##
#O  CorrespondingGeneratorsByModuloPcgs( <mpcgs>, <imgs> )
##
##  <#GAPDoc Label="CorrespondingGeneratorsByModuloPcgs">
##  <ManSection>
##  <Func Name="CorrespondingGeneratorsByModuloPcgs" Arg='mpcgs, imgs'/>
##
##  <Description>
##  Let <A>mpcgs</A> be a modulo pcgs for a factor of a group <M>G</M>
##  and let <M>U</M> be a subgroup of <M>G</M> generated by <A>imgs</A>
##  such that <M>U</M> covers the factor for the modulo pcgs.
##  Then this function computes elements in <M>U</M> corresponding to the
##  generators of the modulo pcgs.
##  <P/>
##  Note that the computation of induced generating sets is not possible
##  for some modulo pcgs.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("CorrespondingGeneratorsByModuloPcgs");

#############################################################################
##
#F  NORMALIZE_IGS( <pcgs>, <list> )
##
##  <ManSection>
##  <Func Name="NORMALIZE_IGS" Arg='pcgs, list'/>
##
##  <Description>
##  Obsolete function, potentially erraneous. DO NOT USE!
##  </Description>
##  </ManSection>
##
DeclareGlobalFunction("NORMALIZE_IGS");


#############################################################################
##  
#E


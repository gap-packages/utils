# CHANGES log for the 'Utils' package

## 0.99 (2026-09-09)

For GAP 4.16.1.

 * (09/09/26) since now using AutoDoc to extract tests from the manual,
              many of the original tests are no longer needed, so removed.
 * (08/09/26) extensive changes to the Download function

## 0.98 (2026-08-04)

For GAP 4.16.0.

 * (04/08/26) changed Fitting series examples to just show StructureDescription

## 0.97 (2026-07-29)

For GAP 4.16.0.

 * (29/07/26) various CI updates, etc.

## 0.96 (2026-06-06)

For GAP 4.16.0.

 * (06/06/26) testall.g adjusted to fix issue in oscar-system/GAP.jl/pull/1379.

## 0.95 (2026-05-18)

For GAP 4.16.0.

 * (18/05/26) PR#93 - avoid using the Small Groups Libeary in examples/

## 0.94 (2026-04-30)

For GAP 4.16.0.

 * (31/03/26) added new Ch.10 Generalized Straight Line Programs (Thomas Breuer)

## 0.93 (2025-11-13)

For GAP 4.15.1.

 * (13/11/25) new release to fix the problem described in GAP issue 6164

## 0.92 (2025-09-11)

For GAP 4.14.0.

 * (10/09/25) support timeout in Download (Thomas Breuer)
              added new release mechanism: .github/workflows/release.yml

## 0.91 (2025-08-13)

For GAP 4.14.0.

 * (13/08/25) replaced DeclareGlobalFunction with DeclareGlobalName, etc.
              removed all code related to SubdirectProductWithEmbeddings

## 0.89 (2025-04-10)

For GAP 4.14.0.

 * (10/04/25) corrected creation of left cosets

## 0.87 (2024-10-20)

Ready for GAP 4.14.0.

 * (08/04/25) adjustments to magma.gi and others.tst
 * (20/10/24) fix tests and examples to new GAP website

## 0.86 (2024-05-16)

For GAP 4.13.1.

 * (16/05/24) there have been just two minor adjustments since version 0.85

## 0.85 (2024-01-23)

For GAP 4.12.2.

 * (08/01/24) avoid trivial function wrappers in List and ForAll 

## 0.84 (2023-09-11)

For GAP 4.12.2.

 * (11/09/23) changed manual and test for DirectSumDecompositionMatrices 

## 0.83 (2023-06-29)

For GAP 4.12.2.

 * (29/06/23) added DirectSumDecompositionMatrices 

## 0.82 (2023-02-09)

For GAP 4.12.2.

 * (23/12/22) changed email address, deleted institution 

## 0.81 (2022-12-04)

For GAP 4.12.1.

 * (17/11/22) removed (the dead) pcp option from PcGroupToMagmaFormat 
              so that the dependency on Polycyclic could be removed 
 * (21/10/22) added OptionRecordWithDefaults in 7.2 from Christopher Jefferson 
 * (04/10/22) declared PreImagesRepresentativeNC in init.g 

## 0.77 (2022-09-25)

For GAP 4.12.0.

 * (25/09/22) added Download operation by Thomas Breuer - new Chapter 8 

## 0.76 (2022-08-06)

For GAP 4.12.0.

 * (06/08/22) added LeftCoset operations 

## 0.74 (2022-07-09)

For GAP 4.11.1.

 * (07/07/22) Max Horn replaced BIND_GLOBAL with BindGlobal (transfer process) 
 * (05/07/22) CentralProduct added by Thomas Breuer 

## 0.72 (2021-11-16)

For GAP 4.10.1.

 * (06/04/21) Switch CI to use GitHub Actions: PR#37

## 0.69 (2019-11-29)

For GAP 4.10.2.

 * (22/11/19) added DirectProductOfAutomorphismGroups 
 * (19/11/19) added DirectProductOfFunctions 

## 0.67 (2019-09-04)

For GAP 4.10.2.

 * (04/09/19) accepted PR34 - changed example in 6.2.1 
 * (25/08/19) fixed typos with UnorderedPairsIterator in manual 

## 0.65 (2019-07-11)

For GAP 4.10.2.

 * (11/07/19) groups.tst fails in gapdev - temporary(?) fix 

## 0.64 (2019-06-17)

For GAP 4.10.1.

 * (14/06/19) added Iterators chapter: AllSubgroupsIterator
              CartesianIterator, UnorderedPairsIterator

## 0.63 (2019-05-29)

For GAP 4.10.1.

 * (28/05/19) added IdempotentEndomorphisms, IdempotentEndomorphismsData
 * (17/05/19) + AllIsomorphismsIterator, AllIsomorphismsNumber, AllIsomorphisms
 * (16/02/19) added License field in PackageInfo.g 

## 0.61 (2018-11-28)

For GAP 4.10.0.

 * (28/11/18) made ExponentOfPrime obsolete
 * (27/11/18) made several AutoDoc functions obsolete (they remain in AutoDoc): 
           FindMatchingFiles; CreateDirIfMissing; StringDotSuffix; SetIfMissing

## 0.59 (2018-10-04)

For GAP 4.9.3.

 * (04/10/18) made PrintApplicableMethod obsolete 

## 0.58 (2018-09-12)

For GAP 4.9.3.

 * (08/09/18) marked PrintOneItemPerLine as obsolete: use Perform(L,Display);
 * (07/09/18) marked ExponentOfPrime as obsolete: use PValuation 
 * (05/09/18) transferred code in combinat.g{d,i} to end of lists.g{d,i}
 * (04/09/18) removed all "if OKtoReadFomUtils( "RCWA" / "ResClasses" )"

## 0.57 (2018-06-02)

For GAP 4.9.1.

 * (02/06/18) new PrintSelection example due to diff with all packages loaded
              removed XMod from list of packages to be loaded 
 * (27/03/18) revised file tst/testing.g

## 0.54 (2018-02-12)

For GAP 4.9.0.

 * (22/01/18) PrintOneItemPerLine plus alternative method for iterators; added 
              function PrintSelection(L,first,step,last) for lists/iterators
 * (06/01/18) rebuilt the manual using the AutoDoc package 
 * (22/12/17) removed examples/ folder

## 0.49 (2017-12-05)

For GAP 4.8.8.

 * (05/12/17) removed QPA functions PositionsNonzero and NullList 
 * (21/11/17) changed record.tst so that 4r8 and dev give the same result 

## 0.48 (2017-09-14)

For GAP 4.8.8.

 * (14/09/17) fixes to the gh-pages folder so that README.md is displayed 
 * (12/09/17) corrected web addresses for Stefan and Frank
 * (04/07/17) README and CHANGES converted to README.md and CHANGES.md 

## 0.46 (2017-02-08)

For GAP 4.8.6.

 * (08/02/17) added Polycyclic as a needed package 
 * (07/02/17) added code for converting matrix groups to Magma strings 
 * (03/02/17) added code for converting perm- and pc-groups to Magma strings 
 * (02/02/17) copied `gaplog.css` to `utils/doc/` from RCWA archive 

## 0.44 (2017-01-17)

For GAP 4.8.6.

 * (08/12/16) added PositionsNonzero and NullList from QPA 
 * (05/12/16) added `tst/loadall.g` and adjusted `tst/testall.g`, `tst/*.tst` 
 * (14/11/16) issue #2 reopened by Max: EpimorphismByGeneratorsNC removed 

## 0.43 (2016-10-20)

For GAP 4.8.5.

 * (18/10/16) now using bibliography file `bib.xml` of type `bibxmlext.dtd`

## 0.41 (2016-05-25)

For GAP 4.8.3.

 * (25/05/16) fixed issue #8 : `git rm doc/appendix.xml` 
 * (17/03/16) added function PrintApplicableMethod 

## 0.40 (2016-03-17)

For GAP 4.8.3.

 * (17/03/16) moved transfer procedure to a new chapter in the manual 
 * (15/03/16) added fix to QuotientList requested by Stefan 
              added many manual examples supplied by Stefan 

## 0.39 (2016-03-04)

For GAP 4.8.2.

 * (04/03/16) corrected repeated "//" in `PackageInfo.g` 
 * (03/03/16) updated transfers from RCWA and ResClasses (Stefan's input) 
 * (26/02/16) updated README to show the release URL 
 * (25/02/16) New release to GitHub using ReleaseTools (GitHubPagesForGAP) 
              `makedocrel.g` renamed `makedoc.g` 
 * (17/02/16) Removed date/version information from file headers. 
 * (16/02/16) Moved PackageWWWHome to GitHub; 
              added OKtoReadFromUtilsSpec to deal with fns taken out early 
 * (12/02/16) Added warning to manual about the need to load packages. 
 * (11/02/16) BindInRecordIfMissing -> SetIfMissing (from AutoDoc) 
              moved a number of functions to `pending.g{d,i}` 
 * (10/02/16) adjustments due to new RCWA 4.0.0 and ResClasses 4.1.1

## 0.22 (2016-02-04)

For GAP 4.8.1.

 * (04/02/16) repository moved to gap-packages 

## 0.21 (2016-02-03)

For GAP 4.8.1.

 * (03/02/16) added several more functions from RCWA
 * (29/01/16) switching to a protocol based on Frank's suggestion:
              if TestPackageAvailability("Bla", ">=x.(y+1)") = fail then ... 

## 0.17 (2016-01-12)

For GAP 4.8.1.

 * (12/01/16) more edits to `oper.g` and `global.g` suggested by Chris J.

## 0.15 (2015-12-18)

For GAP 4.8.0.

 * (17/12/15) added more documentation to `global.g` and `oper.g` 

## 0.14 (2015-12-16)

For GAP 4.8.0.

 * (16/12/15) changed global lists in oper.g to GLOBAL_REDECLARATION_LIST, 
              GLOBAL_REDECLARATION_COUNT and GLOBAL_REINSTALLATION_LIST; 
              added functions (in `oper.g`) AllowGlobalRedeclaration and 
              AllowGlobalReinstallation; added GLOBAL_REBINDING_LIST and 
              AllowGlobalRebinding (in `global.g`) to cope with BIND_GLOBAL. 

## 0.13 (2015-12-15)

For GAP 4.8.0.

 * (15/12/15) added some functions from AutoDoc; packed up version 0.13 
 * (14/12/15) library file `oper.g` edited to prevent repeat declarations etc. 
 * (14/12/15) `names.g{d,i}` now `first.g{d,i}` with `last.gd` added, 
              containing UTILS_FUNCTION_NAMES and UTILS_FUNCTION_OPERS 

## 0.11 (2015-11-30)

For GAP 4.8.0.

 * (30/11/15) added tests and documentation for ResClasses functions 
 * (25/11/15) added `names.g{d,i}`, `tests.g{d,i}`
 * (25/11/15) added `sebastian.gi` to `lib/`
 * (24/11/15) added `rwca.g{d,i}` and `resclasses.g{d,i}` to `lib/` 
 * (24/11/15) added `combinat.g{d,i}` to `lib/` 

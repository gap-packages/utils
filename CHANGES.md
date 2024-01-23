# CHANGES log for the 'Utils' package

## Version 0.85 for GAP 4.12.2 (23/01/24) 
 * (08/01/24) avoid trivial function wrappers in List and ForAll 

## Version 0.84 for GAP 4.12.2 (11/09/23) 
 * (11/09/23) changed manual and test for DirectSumDecompositionMatrices 

## Version 0.83 for GAP 4.12.2 (29/06/23) 
 * (29/06/23) added DirectSumDecompositionMatrices 

## Version 0.82 for GAP 4.12.2 (09/02/23) 
 * (23/12/22) changed email address, deleted institution 

## Version 0.81 for GAP 4.12.1 (04/12/22) 
 * (17/11/22) removed (the dead) pcp option from PcGroupToMagmaFormat 
              so that the dependency on Polycyclic could be removed 
 * (21/10/22) added OptionRecordWithDefaults in 7.2 from Christopher Jefferson 
 * (04/10/22) declared PreImagesRepresentativeNC in init.g 

## Version 0.77 for GAP 4.12.0 (25/09/22) 
 * (25/09/22) added Download operation by Thomas Breuer - new Chapter 8 

## Version 0.76 for GAP 4.12.0 (06/08/22) 
 * (06/08/22) added LeftCoset operations 

## Version 0.74 for GAP 4.11.1 (09/07/22) 
 * (07/07/22) Max Horn replaced BIND_GLOBAL with BindGlobal (transfer process) 
 * (05/07/22) CentralProduct added by Thomas Breuer 

## Version 0.72 for GAP 4.10.1 (16/11/21) 
 * (06/04/21) Switch CI to use GitHub Actions: PR#37

## Version 0.69 for GAP 4.10.2 (29/11/19) 
 * (22/11/19) added DirectProductOfAutomorphismGroups 
 * (19/11/19) added DirectProductOfFunctions 

## Version 0.67 for GAP 4.10.2 (04/09/19) 
 * (04/09/19) accepted PR34 - changed example in 6.2.1 
 * (25/08/19) fixed typos with UnorderedPairsIterator in manual 

## Version 0.65 for GAP 4.10.2 (11/07/19) 
 * (11/07/19) groups.tst fails in gapdev - temporary(?) fix 

## Version 0.64 for GAP 4.10.1 (17/06/19) 
 * (14/06/19) added Iterators chapter: AllSubgroupsIterator
              CartesianIterator, UnorderedPairsIterator

## Version 0.63 for GAP 4.10.1 (29/05/19) 
 * (28/05/19) added IdempotentEndomorphisms, IdempotentEndomorphismsData
 * (17/05/19) + AllIsomorphismsIterator, AllIsomorphismsNumber, AllIsomorphisms
 * (16/02/19) added License field in PackageInfo.g 

## Version 0.61 for GAP 4.10.0 (28/11/18) 
 * (28/11/18) made ExponentOfPrime obsolete
 * (27/11/18) made several AutoDoc functions obsolete (they remain in AutoDoc): 
           FindMatchingFiles; CreateDirIfMissing; StringDotSuffix; SetIfMissing

## Version 0.59 for GAP 4.9.3 (04/10/18) 
 * (04/10/18) made PrintApplicableMethod obsolete 

## Version 0.58 for GAP 4.9.3 (12/09/18) 
 * (08/09/18) marked PrintOneItemPerLine as obsolete: use Perform(L,Display);
 * (07/09/18) marked ExponentOfPrime as obsolete: use PValuation 
 * (05/09/18) transferred code in combinat.g{d,i} to end of lists.g{d,i}
 * (04/09/18) removed all "if OKtoReadFomUtils( "RCWA" / "ResClasses" )"

## Version 0.57 for GAP 4.9.1 (02/06/18) 
 * (02/06/18) new PrintSelection example due to diff with all packages loaded
              removed XMod from list of packages to be loaded 
 * (27/03/18) revised file tst/testing.g

## Version 0.54 for GAP 4.9.0 (12/02/18) 
 * (22/01/18) PrintOneItemPerLine plus alternative method for iterators; added 
              function PrintSelection(L,first,step,last) for lists/iterators
 * (06/01/18) rebuilt the manual using the AutoDoc package 
 * (22/12/17) removed examples/ folder

## Version 0.49 for GAP 4.8.8 (05/12/17) 
 * (05/12/17) removed QPA functions PositionsNonzero and NullList 
 * (21/11/17) changed record.tst so that 4r8 and dev give the same result 

## Version 0.48 for GAP 4.8.8 (14/09/17) 
 * (14/09/17) fixes to the gh-pages folder so that README.md is displayed 
 * (12/09/17) corrected web addresses for Stefan and Frank
 * (04/07/17) README and CHANGES converted to README.md and CHANGES.md 

## Version 0.46 for GAP 4.8.6 (08/02/17) 
 * (08/02/17) added Polycyclic as a needed package 
 * (07/02/17) added code for converting matrix groups to Magma strings 
 * (03/02/17) added code for converting perm- and pc-groups to Magma strings 
 * (02/02/17) copied `gaplog.css` to `utils/doc/` from RCWA archive 

## Version 0.44 for GAP 4.8.6 (17/01/17) 
 * (08/12/16) added PositionsNonzero and NullList from QPA 
 * (05/12/16) added `tst/loadall.g` and adjusted `tst/testall.g`, `tst/*.tst` 
 * (14/11/16) issue #2 reopened by Max: EpimorphismByGeneratorsNC removed 

## Version 0.43 for GAP 4.8.5 (20/10/16) 
 * (18/10/16) now using bibliography file `bib.xml` of type `bibxmlext.dtd`

## Version 0.41 for GAP 4.8.3 (25/05/16) 
 * (25/05/16) fixed issue #8 : `git rm doc/appendix.xml` 
 * (17/03/16) added function PrintApplicableMethod 

## Version 0.40 for GAP 4.8.3 (17/03/16)
 * (17/03/16) moved transfer procedure to a new chapter in the manual 
 * (15/03/16) added fix to QuotientList requested by Stefan 
              added many manual examples supplied by Stefan 

## Version 0.39 for GAP 4.8.2 (04/03/16)
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

## Version 0.22 for GAP 4.8.1 (04/02/16)
 * (04/02/16) repository moved to gap-packages 

## Version 0.21 for GAP 4.8.1 (03/02/16)
 * (03/02/16) added several more functions from RCWA
 * (29/01/16) switching to a protocol based on Frank's suggestion:
              if TestPackageAvailability("Bla", ">=x.(y+1)") = fail then ... 

## Version 0.17 for GAP 4.8.1 (12/01/16)
 * (12/01/16) more edits to `oper.g` and `global.g` suggested by Chris J.

## Version 0.15 for GAP 4.8.0 (18/12/15)
 * (17/12/15) added more documentation to `global.g` and `oper.g` 

## Version 0.14 for GAP 4.8.0 (16/12/15)
 * (16/12/15) changed global lists in oper.g to GLOBAL_REDECLARATION_LIST, 
              GLOBAL_REDECLARATION_COUNT and GLOBAL_REINSTALLATION_LIST; 
              added functions (in `oper.g`) AllowGlobalRedeclaration and 
              AllowGlobalReinstallation; added GLOBAL_REBINDING_LIST and 
              AllowGlobalRebinding (in `global.g`) to cope with BIND_GLOBAL. 

## Version 0.13 for GAP 4.8.0 (15/12/15)
 * (15/12/15) added some functions from AutoDoc; packed up version 0.13 
 * (14/12/15) library file `oper.g` edited to prevent repeat declarations etc. 
 * (14/12/15) `names.g{d,i}` now `first.g{d,i}` with `last.gd` added, 
              containing UTILS_FUNCTION_NAMES and UTILS_FUNCTION_OPERS 

## Version 0.11 for GAP 4.8.0 (30/11/15)
 * (30/11/15) added tests and documentation for ResClasses functions 
 * (25/11/15) added `names.g{d,i}`, `tests.g{d,i}`
 * (25/11/15) added `sebastian.gi` to `lib/`
 * (24/11/15) added `rwca.g{d,i}` and `resclasses.g{d,i}` to `lib/` 
 * (24/11/15) added `combinat.g{d,i}` to `lib/` 

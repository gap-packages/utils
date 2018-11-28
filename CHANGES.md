# CHANGES log for the 'Utils' package

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

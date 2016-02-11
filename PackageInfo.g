#############################################################################
##
##  PackageInfo.g  file for the package Utils 
##

SetPackageInfo( rec(
PackageName := "Utils",
Subtitle := "Utility functions in GAP",

Version := "0.25",
Date := "11/02/2016",

##  duplicate these values for inclusion in the manual: 
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY UTILSVERSION "0.25">
##  <!ENTITY UTILSTARFILENAME "utils-0.25.tar.gz">
##  <!ENTITY UTILSHTMLFILENAME "utils.html">
##  <!ENTITY UTILSRELEASEDATE "11/02/2016">
##  <!ENTITY UTILSLONGRELEASEDATE "11th February 2016">
##  <!ENTITY UTILSCOPYRIGHTYEARS "2015-2016">
##  <#/GAPDoc>

PackageWWWHome := 
  "http://pages.bangor.ac.uk/~mas023/chda/utils/",

ArchiveURL := "http://pages.bangor.ac.uk/~mas023/chda/utils/utils-0.25", 
ArchiveFormats := ".tar.gz",

Persons := [
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "gutsche@mathematik.uni-kl.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    PostalAddress := Concatenation( [
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
  ),
  rec( 
    LastName      := "Kohl",
    FirstNames    := "Stefan",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "stefan@mcs.st-and.ac.uk",
    WWWHome       := "http://www.gap-system.org/DevelopersPages/StefanKohl/"
  ), 
  rec(
    LastName      := "Wensley",
    FirstNames    := "Christopher D.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "c.d.wensley@bangor.ac.uk",
    WWWHome       := "http://pages.bangor.ac.uk/~mas023/",
    PostalAddress := Concatenation( [
                       "Dr. C.D. Wensley\n",
                       "School of Computer Science\n",
                       "Bangor University\n",
                       "Dean Street\n",
                       "Bangor\n",
                       "Gwynedd LL57 1UT\n",
                       "UK"] ),
    Place         := "Bangor",
    Institution   := "Bangor University"
  )
],

Status := "deposited",
## CommunicatedBy := "  ",
## AcceptDate := "  ",

README_URL := 
  Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL := 
  Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

##  Optional:
##    - Type and the URL of the source code repository
##    - URL of the public issue tracker
##    - Support email address
SourceRepository :=
  rec( Type := "git", # must be one of "git", "hg", "svn", "cvs"
       URL  := "http://github.com/gap-packages/utils"),
IssueTrackerURL := "http://github.com/gap-packages/utils/issues",
SupportEmail := "c.d.wensley@bangor.ac.uk",

AbstractHTML :=
 "The <span class=\"pkgname\">Utils</span> package provides a collection \
  of utility functions gleaned from many packages.",

PackageDoc := rec(
  BookName  := "Utils",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Utility functions in GAP",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.8",
  NeededOtherPackages := [ ["GAPDoc", ">= 1.5.1"] ], 
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

BannerString := Concatenation( 
  "Loading Utils ", String( ~.Version ), " for GAP 4.8", 
  " - a collection of utility functions.\n"
),

Autoload := false,

TestFile := "tst/testall.g",

Keywords := [ ]

));

#############################################################################
##
##  PackageInfo.g  file for the package Utils 
##  Chris Wensley and Murat Alp 
##

SetPackageInfo( rec(
PackageName := "Utils",
Subtitle := "Crossed Modules and Cat1-Groups",

Version := "0.11",
Date := "12/11/2015",

##  duplicate these values for inclusion in the manual: 
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.11">
##  <!ENTITY TARFILENAME "utils-0.11.tar.gz">
##  <!ENTITY HTMLFILENAME "utils011.html">
##  <!ENTITY RELEASEDATE "12/11/2015">
##  <!ENTITY LONGRELEASEDATE "12th November 2015">
##  <!ENTITY COPYRIGHTYEARS "2015">
##  <#/GAPDoc>

PackageWWWHome := 
  "http://pages.bangor.ac.uk/~mas023/chda/utils/",

ArchiveURL := "http://pages.bangor.ac.uk/~mas023/chda/utils-0.11", 
ArchiveFormats := ".tar.gz",

Persons := [
  rec(
    LastName      := "Wensley",
    FirstNames    := "Christopher D.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "c.d.wensley@bangor.ac.uk",
    WWWHome       := "http://www.bangor.ac.uk/~mas023/",
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
  Concatenation( ~.PackageWWWHome, "README" ),
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
  LongTitle := "Utility functions collected together",
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

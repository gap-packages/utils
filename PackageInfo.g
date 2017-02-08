#############################################################################
##
##  PackageInfo.g  file for the package Utils 
##

SetPackageInfo( rec(
PackageName := "Utils",
Packagename := "utils", 
Subtitle := "Utility functions in GAP",

Version := "0.46",
Date := "08/02/2017",

##  duplicate these values for inclusion in the manual: 
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY UTILSVERSION "0.46">
##  <!ENTITY UTILSTARFILENAME "utils-0.46.tar.gz">
##  <!ENTITY UTILSHTMLFILENAME "utils.html">
##  <!ENTITY UTILSRELEASEDATE "08/02/2017">
##  <!ENTITY UTILSLONGRELEASEDATE "8th February 2017">
##  <!ENTITY UTILSCOPYRIGHTYEARS "2015-2017">
##  <#/GAPDoc>

##  Optional:
##    - Type and the URL of the source code repository
##    - URL of the public issue tracker
##    - Support email address
SourceRepository := rec( 
    Type := "git", # must be one of "git", "hg", "svn", "cvs"
    URL  := "https://github.com/gap-packages/utils" ),
IssueTrackerURL  := "http://github.com/gap-packages/utils/issues",
PackageWWWHome   := "https://gap-packages.github.io/utils", 
README_URL       := Concatenation( ~.PackageWWWHome, "/README" ), 
PackageInfoURL   := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ), 
ArchiveURL       := Concatenation( ~.SourceRepository.URL, 
                                   "/releases/download/v", ~.Version,
                                   "/", ~.Packagename, "-", ~.Version ),
ArchiveFormats := ".tar.gz .zip",
SupportEmail     := "c.d.wensley@bangor.ac.uk",

Persons := [
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "gutsche@mathematik.uni-kl.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
  ),
  rec(
    LastName      := "Horn",
    FirstNames    := "Max",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "max.horn@math.uni-giessen.de",
    WWWHome       := "http://www.quendi.de/math",
  ),
  rec(
    LastName      := "Hulpke",
    FirstNames    := "Alexander",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "hulpke@math.colostate.edu",
    WWWHome       := "http://www.math.colostate.edu/~hulpke",
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
    LastName      := "Lübeck",
    FirstNames    := "Frank",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "Frank.Luebeck@Math.RWTH-Aachen.De",
    WWWHome       := "http://www.math.rwth-aachen.de:8001/~Frank.Luebeck",
  ),
  rec( 
    LastName      := "Skartsæterhagen",
    FirstNames    := "Øystein",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "oysteini@math.ntnu.no",
    WWWHome       := "https://www.math.ntnu.no/~oysteini/"
  ), 
  rec(
    LastName      := "Wensley",
    FirstNames    := "Christopher D.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "c.d.wensley@bangor.ac.uk",
    WWWHome       := "http://pages.bangor.ac.uk/~mas023/",
    Place         := "Bangor",
    Institution   := "Bangor University"
  )
],

Status := "deposited",
## CommunicatedBy := "  ",
## AcceptDate := "  ",

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
  GAP := ">=4.8.6",
  NeededOtherPackages := [ ["GAPDoc", ">= 1.5.1"], ["Polycyclic", ">= 2.11" ] ], 
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

BannerString := Concatenation( 
  "Loading Utils ", String( ~.Version ), " for GAP 4.8", 
  " - a collection of utility functions.\n"
),

TestFile := "tst/testall.g",

Keywords := [ ]

));

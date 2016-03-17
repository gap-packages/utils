#############################################################################
##
##  PackageInfo.g  file for the package Utils 
##

SetPackageInfo( rec(
PackageName := "Utils",
Packagename := "utils", 
Subtitle := "Utility functions in GAP",

Version := "0.40",
Date := "17/03/2016",

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
  GAP := ">=4.8.2",
  NeededOtherPackages := [ ["GAPDoc", ">= 1.5.1"] ], 
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

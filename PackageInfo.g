#############################################################################
##
##  PackageInfo.g  file for the package Utils 
##

SetPackageInfo( rec(
<<<<<<< HEAD
Packagename := "utils", 
PackageName := "utils", 
Subtitle := "Utility functions in GAP",

Version := "0.47",
Date := "12/09/2017",

##  duplicate these values for inclusion in the manual: 
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY UTILSVERSION "0.47">
##  <!ENTITY UTILSTARFILENAME "utils-0.47.tar.gz">
##  <!ENTITY UTILSHTMLFILENAME "utils.html">
##  <!ENTITY UTILSRELEASEDATE "12/09/2017">
##  <!ENTITY UTILSLONGRELEASEDATE "12th September 2017">
##  <!ENTITY UTILSCOPYRIGHTYEARS "2015-2017">
##  <#/GAPDoc>

##  Optional:
##    - Type and the URL of the source code repository
##    - URL of the public issue tracker
##    - Support email address
SourceRepository := rec( 
    Type := "git", # must be one of "git", "hg", "svn", "cvs"
    URL  := "https://github.com/gap-packages/utils" ),
IssueTrackerURL  := "https://github.com/gap-packages/utils/issues",
PackageWWWHome   := "https://gap-packages.github.io/utils", 
README_URL       := Concatenation( ~.PackageWWWHome, "/README.md" ), 
PackageInfoURL   := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ), 
ArchiveURL       := Concatenation( ~.SourceRepository.URL, 
                                   "/releases/download/v", ~.Version,
                                   "/", ~.Packagename, "-", ~.Version ),
ArchiveFormats := ".tar.gz .zip",
SupportEmail     := "c.d.wensley@bangor.ac.uk",
=======

PackageName := "GitHubPagesForGAP",

Subtitle := "A GitHub Pages generator for GAP packages",
Version := "0.2",
Date := "04/02/2017", # dd/mm/yyyy format
>>>>>>> af2be477220cc9076ce801b09b61d376528ac6d9

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
<<<<<<< HEAD
=======
    PostalAddress := Concatenation(
                       "AG Algebra\n",
                       "Mathematisches Institut\n",
                       "Justus-Liebig-Universität Gießen\n",
                       "Arndtstraße 2\n",
                       "35392 Gießen\n",
                       "Germany" ),
    Place         := "Gießen",
    Institution   := "Justus-Liebig-Universität Gießen"
>>>>>>> af2be477220cc9076ce801b09b61d376528ac6d9
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
    WWWHome       := "https://www.gap-system.org/DevelopersPages/StefanKohl/"
  ), 
  rec(
    LastName      := "Lübeck",
    FirstNames    := "Frank",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "Frank.Luebeck@Math.RWTH-Aachen.De",
    WWWHome       := "http://www.math.rwth-aachen.de/~Frank.Luebeck",
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

<<<<<<< HEAD
AbstractHTML :=
 "The <span class=\"pkgname\">Utils</span> package provides a collection \
  of utility functions gleaned from many packages.",
=======
# The following are not strictly necessary in your own PackageInfo.g
# (in the sense that update.g only looks at the usual fields
# like PackageWWWHome, ArchiveURL etc.). But they are convenient
# if you use exactly the scheme for your package website that we propose.
GithubUser := "gap-system",
GithubRepository := ~.PackageName,
GithubWWW := Concatenation("https://github.com/", ~.GithubUser, "/", ~.GithubRepository),

PackageWWWHome := Concatenation("https://", ~.GithubUser, ".github.io/", ~.GithubRepository, "/"),
README_URL     := Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
# The following assumes you are using the Github releases system. If not, adjust
# it accordingly.
ArchiveURL     := Concatenation(~.GithubWWW,
                    "/releases/download/v", ~.Version, "/",
                    ~.GithubRepository, "-", ~.Version),

ArchiveFormats := ".tar.gz .tar.bz2",

AbstractHTML := 
  "This is a pseudo package that contains no actual\
  <span class=\"pkgname\">GAP</span> code. Instead, it is a template for other\
  GAP packages that allows to quickly setup GitHub Pages.",
>>>>>>> af2be477220cc9076ce801b09b61d376528ac6d9

PackageDoc := rec(
  BookName  := "Utils",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
<<<<<<< HEAD
  LongTitle := "Utility functions in GAP",
  Autoload  := true
=======
  LongTitle := "A GitHub Pages generator for GAP packages",
>>>>>>> af2be477220cc9076ce801b09b61d376528ac6d9
),

Dependencies := rec(
<<<<<<< HEAD
  GAP := ">=4.8.7",
  NeededOtherPackages := [ ["GAPDoc", ">= 1.5.1"], ["Polycyclic", ">= 2.11" ] ], 
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ]
=======
  GAP := ">=4.8.1",
  NeededOtherPackages := [
    ["GAPDoc", ">= 1.2"],
    ["IO", ">= 4.1"],
  ],
  SuggestedOtherPackages := [["orb", ">= 4.2"]],
  ExternalConditions := []
>>>>>>> af2be477220cc9076ce801b09b61d376528ac6d9
),

AvailabilityTest := ReturnTrue,

<<<<<<< HEAD
BannerString := Concatenation( 
  "Loading Utils ", String( ~.Version ), " for GAP 4.8", 
  " - a collection of utility functions.\n"
),
=======
Keywords := ["GitHub Pages", "GAP"]
>>>>>>> af2be477220cc9076ce801b09b61d376528ac6d9

TestFile := "tst/testall.g",

Keywords := [ ]

));

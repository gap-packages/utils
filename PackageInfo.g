#############################################################################
##
##  PackageInfo.g  file for the package Utils 
##

SetPackageInfo( rec(

PackageName := "utils", 
Subtitle := "Utility functions in GAP",
Version := "0.54",
Date := "12/02/2018",

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

SourceRepository := rec( 
    Type             := "git", 
    URL              := "https://github.com/gap-packages/utils" ),
    IssueTrackerURL  := "https://github.com/gap-packages/utils/issues",
    PackageWWWHome   := "https://gap-packages.github.io/utils", 
    README_URL       := Concatenation( ~.PackageWWWHome, "/README.md" ), 
    PackageInfoURL   := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ), 
    ArchiveURL       := Concatenation( ~.SourceRepository.URL, 
                                       "/releases/download/v", ~.Version,
                                       "/", ~.PackageName, "-", ~.Version ),
ArchiveFormats := ".tar.gz .zip", 


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
  GAP := ">=4.9.0",
  NeededOtherPackages := [ ["GAPDoc", ">= 1.6.1"], 
                           ["Polycyclic", ">= 2.11" ] ], 
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

Autoload := false, 

Keywords := [ ], 

BannerString := Concatenation( 
    "Loading Utils ", String( ~.Version ), " for GAP 4.9", 
  " - a collection of utility functions.\n"
),

TestFile := "tst/testall.g",

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2015-2018, The GAP Group. <P/>\n", 
            "The &Utils; package is free software; you can redistribute it ", 
            "and/or modify it under the terms of the GNU General ", 
            "Public License as published by the Free Software Foundation; ", 
            "either version 2 of the License, or (at your option) ", 
            "any later version.\n"
            ),
        Abstract := Concatenation( 
            "The &Utils; package provides a space for utility functions ", 
            "in a variety of &GAP; packages to be collected together ", 
            "into a single package.  In this way it is hoped that they will ", 
            "become more visible to package authors.\n", 
            "<P/>\n", 
            "Any package author who transfers a function to &Utils; ", 
            "will become an author of &Utils;.\n",    
            "<P/>\n", 
            "If deemed appropriate, functions may also be transferred ", 
            "from the main library.\n", 
            "<P/>\n", 
            "Bug reports, suggestions and comments are, of course, welcome.\n", 
            "Please contact the last author at ", 
            "<Email>c.d.wensley@bangor.ac.uk</Email> ", 
            "or submit an issue at the GitHub repository ",
            "<URL>https://github.com/gap-packages/utils/issues/</URL>.\n" 
            ), 
        Acknowledgements := Concatenation( 
            "This documentation was prepared with the ", 
            "&GAPDoc; <Cite Key='GAPDoc'/> and ", 
            "&AutoDoc; <Cite Key='AutoDoc'/> packages.<P/>\n", 
            "The procedure used to produce new releases uses the package ", 
            "<Package>GitHubPagesForGAP</Package> ", 
            "<Cite Key='GitHubPagesForGAP' /> ", 
            "and the package <Package>ReleaseTools</Package>.<P/>" 
            ),
    ) 
),

));

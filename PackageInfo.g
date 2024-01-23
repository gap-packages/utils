#############################################################################
##
##  PackageInfo.g  file for the package Utils 
##

SetPackageInfo( rec(

PackageName := "utils", 
Subtitle := "Utility functions in GAP",
Version := "0.85",
Date := "23/01/2024", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    LastName      := "Breuer",
    FirstNames    := "Thomas",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "sam@math.rwth-aachen.de",
    WWWHome       := "https://www.math.rwth-aachen.de/~Thomas.Breuer",
    Place         := "Aachen",
    Institution   := "Lehrstuhl für Algebra und Zahlentheorie, RWTH Aachen" 
  ),
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "gutsche@mathematik.uni-seigen.de",
    WWWHome       := "https://sebasguts.github.io/",
    Place         := "Seigen",
    Institution   := "University of Seigen"
  ),
  rec(
    LastName      := "Horn",
    FirstNames    := "Max",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "mhorn@rptu.de",
    WWWHome       := "https://github.com/mhorn",
  ),
  rec(
    LastName      := "Hulpke",
    FirstNames    := "Alexander",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "hulpke@math.colostate.edu",
    WWWHome       := "https://www.math.colostate.edu/~hulpke",
  ),
  rec(
    LastName      := "García-Sánchez",
    FirstNames    := "Pedro",
    IsAuthor      := true,
    IsMaintainer  := false,
    WWWHome       := "http://www.ugr.es/local/pedro",
    Email         := "pedro@ugr.es",
  ),
  rec(
    LastName      := "Jefferson",
    FirstNames    := "Christopher",
    IsAuthor      := true,
    IsMaintainer  := false,
    WWWHome       := "https://caj.host.cs.st-andrews.ac.uk/",
    Email         := "caj21@st-andrews.ac.uk",
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
    WWWHome       := "https://www.math.rwth-aachen.de/~Frank.Luebeck",
  ),
  rec(
    LastName      := "Wensley",
    FirstNames    := "Chris",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "cdwensley.maths@btinternet.com",
    WWWHome       := "https://github.com/cdwensley",
    Place         := "Llanfairfechan",
    Institution   := ""
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
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Utility functions in GAP",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.10.1",
  NeededOtherPackages := [ ], 
  SuggestedOtherPackages := [ [ "curlInterface", ">= 2.3.0" ] ],
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

Autoload := false, 

Keywords := [ ], 

BannerString := Concatenation( 
    "Loading Utils ", String( ~.Version ), " for GAP 4.12.1", 
  " - a collection of utility functions.\n"
),

TestFile := "tst/testall.g",

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2015-2024, The GAP Group. <P/>\n", 
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
            "<Email>cdwensley.maths@btinternet.com</Email> ", 
            "or submit an issue at the GitHub repository ",
            "<URL>https://github.com/gap-packages/utils/issues/</URL>.\n" 
            ), 
        Acknowledgements := Concatenation( 
            "This documentation was prepared using the ", 
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

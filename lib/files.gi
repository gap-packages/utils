#############################################################################
##
#W  files.gi                  GAP4 package `Utils'          Sebastian Gutsche
##                                                                   Max Horn
##                                                                Stefan Kohl
#Y  Copyright (C) 2015-2016, The GAP Group, 

#############################################################################
##  this function has been transferred from AutoDoc
##  it was originally named AUTODOC_CreatreDirIfMissing 
##  
##  Check whether the given directory exists; if not, attempt to create it.
##
#F  CreateDirIfMissing( <str> ) . . . . . . . . . . . . makes a new directory
##
InstallGlobalFunction( CreateDirIfMissing,

function(d)
    local tmp;
    if not IsDirectoryPath(d) then
        tmp := CreateDir(d); # Note: CreateDir is currently undocumented
        if tmp = fail then
            Error("Cannot create directory ", d, "\n",
                  "Error message: ", LastSystemError().message, "\n");
            return false;
        fi;
    fi;
    return true;
end );

#############################################################################
##  this function has been transferred from AutoDoc, 
##  it was originally named AUTODOC_FindMatchingFiles 
##  
##  Scan the given (by name) subdirs of a package dir for
##  files with one of the given extensions, and return the corresponding
##  filenames, as relative paths (relative to the package dir).
##
##  For example, the invocation
##    AUTODOC_FindMatchingFiles("AutoDoc", [ "gap/" ], [ "gi", "gd" ]);
##  might return a list looking like
##   [ "gap/AutoDocMainFunction.gd", "gap/AutoDocMainFunction.gi", ... ]
##
#F  FindMatchingFiles( <str> ) . . . . . . . . . . . . 
##
InstallGlobalFunction( FindMatchingFiles,

function (pkg, subdirs, extensions)
    local ok, d_rel, d, tmp, files, result;

    result := [];

    ok := IsString(pkg) and (DirectoriesPackageLibrary(pkg) <> [ ]) 
          and IsList(subdirs) and ForAll(subdirs, s->IsString(s)) 
          and IsList(extensions) and ForAll(extensions, s->IsString(s)); 
    if not ok then 
      Error("use FindMatchingFiles(packagename,list of subdirs,list of extns)");
    fi; 

    for d_rel in subdirs do
        # Get the absolute path to the directory inside the package...
        d := DirectoriesPackageLibrary( pkg, d_rel );
        if IsEmpty( d ) then
            continue;
        fi;
        d := d[1];
        # ... but also keep the relative path (such as "gap")
        d_rel := Directory( d_rel );

        files := DirectoryContents( d );
        Sort( files );
        for tmp in files do
            if not StringDotSuffix(tmp) in extensions then
                continue;
            fi;
            if not IsReadableFile( Filename( d, tmp ) ) then
                continue;
            fi;
            Add( result, Filename( d_rel, tmp ) );
        od;
    od;
    return result;
end );

if OKtoReadFromUtils( "RCWA" ) then

#############################################################################
##  this function has been transferred from RCWA
##
#F  Log2HTML ( logfilename ) . . . .  convert GAP logfile to XHTML 1.0 Strict
##
InstallGlobalFunction( Log2HTML,

  function ( logfilename )

    local  outputname, s1, s2, header, footer, pos,
           lastlf, nextlf, crlf, prompt;

    if ARCH_IS_UNIX() then crlf := 1; else crlf := 2; fi;
    header := Concatenation(
                "<?xml version = \"1.0\" encoding = \"ISO-8859-1\"?>\n\n",
                "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n",
                "                      \"http://www.w3.org/TR/xhtml1/DTD/",
                "xhtml1-strict.dtd\">\n<html>\n\n<head>\n  <title> ",
                logfilename, " </title>\n  <link rel = \"stylesheet\" ",
                "type = \"text/css\" href = \"gaplog.css\" />\n",
                "</head>\n\n<body>\n\n<pre class = \"logfile\">\n");
    footer := "</pre> </body> </html>";
    s1 := StringFile(logfilename);
    pos := PositionSublist(s1,"gap>"); prompt := "gap> ";
    s2 := ReplacedString(s1{[1..pos-1]},"<","&lt;");
    while pos <> fail do
      s2 := Concatenation(s2,"<em class = \"prompt\">",prompt,"</em>");
      s2 := Concatenation(s2,"<em class = \"input\">");
      nextlf := Position(s1,'\n',pos); prompt := "gap>";
      if nextlf = fail then nextlf := Length(s1); fi;
      s2 := Concatenation(s2,ReplacedString(s1{[pos+5..nextlf-crlf]},
                                            "<","&lt;"),"</em>");
      while nextlf < Length(s1) and s1[nextlf+1] = '>' do
        s2 := Concatenation(s2,"\n<em class = \"prompt\">></em>",
                            "<em class = \"input\">");
        lastlf := nextlf;
        nextlf := Position(s1,'\n',lastlf);
        if nextlf = fail then nextlf := Length(s1); fi;
        s2 := Concatenation(s2,ReplacedString(s1{[lastlf+2..nextlf-crlf]},
                                              "<","&lt;"),"</em>");
      od;
      s2 := Concatenation(s2,"\n");
      pos := PositionSublist(s1,"\ngap>",nextlf-1);
      if pos = fail then pos := Length(s1); fi;
      if pos > nextlf then
        s2 := Concatenation(s2,"<em class = \"output\">",
                            ReplacedString(s1{[nextlf+1..pos-crlf]},
                                           "<","&lt;"),"</em>\n");
      fi;
      if pos > Length(s1) - 3 then break; fi;
    od;
    s2 := Concatenation(header,s2,footer);
    logfilename := LowercaseString(logfilename); 
    if   PositionSublist(logfilename,".log") <> fail
    then outputname := ReplacedString(logfilename,".log",".html");
    elif PositionSublist(logfilename,".txt") <> fail
    then outputname := ReplacedString(logfilename,".txt",".html");
    else outputname := Concatenation(logfilename,".html"); fi;
    FileString(outputname,s2);
  end );

fi; 

#############################################################################
##
#E  files.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

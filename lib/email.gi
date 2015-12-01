#############################################################################
##
#W  email.gi                  GAP4 package `Utils'                Stefan Kohl
##
##  version 0.12, 01/12/2015 
##
#Y  Copyright (C) 2015, The GAP Group, 

#############################################################################
##  this function transferred from ResClasses 
##
#F  SendEmail( <sendto>, <copyto>, <subject>, <text> ) . . . . send an e-mail
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "SendEmail" )] = 0 ) then 

InstallGlobalFunction( SendEmail,

  function ( sendto, copyto, subject, text )

    local  sendmail, inp;

    sendto   := JoinStringsWithSeparator( sendto, "," );
    copyto   := JoinStringsWithSeparator( copyto, "," );
    sendmail := Filename( DirectoriesSystemPrograms(  ), "mail" );
    inp      := InputTextString( text );
    return Process( DirectoryCurrent(  ), sendmail, inp, OutputTextNone(  ),
                    [ "-s", subject, "-c", copyto, sendto ] );
  end );

fi;

#############################################################################
##  this function transferred from ResClasses 
##
#F  EmailLogFile( <addresses> ) . . .  send log file by e-mail to <addresses>
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "EmailLogFile" )] = 0 ) then 

InstallGlobalFunction( EmailLogFile, 

  function ( addresses )

    local  filename, logfile, selection, pos1, pos2;

    if ARCH_IS_UNIX() and IN_LOGGING_MODE <> false then
      if IsString(addresses) then 
        addresses := [addresses]; 
      fi;
      filename := USER_HOME_EXPAND(IN_LOGGING_MODE);
      logfile := ReadAll(InputTextFile(filename));
      if Length(logfile) > 2^16 then # Abbreviate output in long logfiles.
        selection := ""; pos1 := 1;
        repeat
          pos2 := PositionSublist(logfile,"gap> ",pos1);
          if pos2 = fail then pos2 := Length(logfile) + 1; fi;
          Append(selection,logfile{[pos1..Minimum(pos1+1024,pos2-1)]});
          if ( pos1 + 1024 < pos2 - 1 ) then
            Append(selection,
                   logfile{[pos1+1025..Position(logfile,'\n',pos1+1024)]});
            Append(selection,"                                    ");
            Append(selection,"[ ... ]\n");
          fi;
          pos1 := pos2;
        until pos2 >= Length(logfile);
        logfile := selection;
        if Length(logfile) > 2^16 then 
          logfile := logfile{[1..2^16]}; 
        fi;
      fi;
      return SendEmail(addresses,[],Concatenation("GAP logfile ",filename),
                       logfile);
    fi;
  end );

fi;

#############################################################################
##  this function transferred from ResClasses 
##
#F  DownloadFile( <url> ) . . . . . . . . . download a file from the internet
##
if ( UTILS_FUNCTION_STATUS[ 
    Position( UTILS_FUNCTION_NAMES, "DownloadFile" )] = 0 ) then 

InstallGlobalFunction( DownloadFile,

  function ( url )

    local  Download, host, path, slashpos, r;

    if IsBoundGlobal("SingleHTTPRequest") then 
        Download := ValueGlobal("SingleHTTPRequest");
    else 
        Info(InfoWarning,1,"DownloadFile: the IO package is not loaded.");
        return fail;
    fi;
    url := ReplacedString(url,"http://","");
    slashpos := Position(url,'/');
    host := url{[1..slashpos-1]};
    path := url{[slashpos..Length(url)]};
    r := Download(host,80,"GET",path,rec(),false,false);
    if r.statuscode = 0 then
        Info(InfoWarning,1,"Downloading ",url," failed: ",r.status);
        return fail;
    fi;
    return r.body;
  end );

fi; 

#############################################################################
##
#E  email.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

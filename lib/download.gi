##############################################################################
##
#W  download.gi                 GAP4 package `Utils'             Thomas Breuer
##
#Y  Copyright (C) 2022, The GAP Group

#############################################################################
##  
#M  Download( <url>[, <opt>] ) 
##  
##  Try to download the file described by the string <url>,
##  and return a record with the components 'success' ('true' or 'false'),
##  and 'result' (a string, only if 'success' is 'true'),
##  and 'error' (a string, only if 'success' is 'false').
##
##  Use the following tools (in this order).
##
##  - If the curlInterface package is available then call its
##    'DownloadURL' function.
##  - If the URL starts with 'http://' and if the IO package is available
##    then call the 'SingleHTTPRequest' function from this package.
##  - If a 'wget' executable is available then call it.
##  - If a 'curl' executable is available then call it.
##  
InstallMethod( Download,
    [ "IsString" ],
    url -> Download( url, rec() ) );

InstallMethod( Download,
    [ "IsString", "IsRecord" ],
    function( url, opt )
    local target, res, rurl, pos, domain, uri, tools, prgs, sh, tool, exec,
          outstream, args, code, logfile;

    if IsBound( opt.target ) and IsString( opt.target ) then
      target:= opt.target;
    else
      target:= fail;
    fi;

    # Try the curlInterface package.
    if IsBoundGlobal( "DownloadURL" ) then
      Info( InfoUtils, 2, "Download via DownloadURL (curlInterface)" );
      res:= ValueGlobal( "DownloadURL" )( url );
      if target <> fail then
        FileString( target, res.result );
        Unbind( res.result );
      fi;
      return res;
    fi;

    # Try the IO package.
    if StartsWith( url, "http://" ) and IsBoundGlobal( "SingleHTTPRequest" ) then
      Info( InfoUtils, 2, "Download via SingleHTTPRequest (IO)" );
      rurl:= ReplacedString( url, "http://", "" );
      pos:= Position( rurl, '/' );
      domain:= rurl{ [ 1 .. pos-1 ] };
      uri:= rurl{ [ pos .. Length( rurl ) ] };
      res:= ValueGlobal( "SingleHTTPRequest" )( domain, 80, "GET", uri, rec(), false, false );
      if res.statuscode >= 400 then
        Info( InfoWarning, 1, "Downloading ", url, " failed: ", res.status );
        return rec( success:= false,
                    error:= Concatenation( "HTTP error code ", res.statuscode ) );
      elif target <> fail then
        FileString( target, res.body );
        return rec( success:= true );
      else
        return rec( success:= true, result:= res.body );
      fi;
    fi;

    # Try wget and curl executables.
    tools:= [ [ "wget", ["--quiet", "-O", "-"] ],
              [ "curl", ["--silent", "-L", "--output", "-"] ] ];
    prgs:= DirectoriesSystemPrograms();
    sh:= Filename( prgs, "sh" );
    if sh <> fail and IsExecutableFile( sh ) then
      for tool in tools do
        exec:= Filename( prgs, tool[1] );
        if exec <> fail and IsExecutableFile( exec ) then
          res:= "";
          outstream:= OutputTextString( res, true );

          # Execute the command (capture both stdout and stderr).
          args:= JoinStringsWithSeparator( tool[2], " " );
          Append( args, " " );
          Append( args, url );
          Info( InfoUtils, 2, "Download via ", tool[1] );
          code:= Process( DirectoryCurrent(), sh, InputTextNone(), outstream,
                     [ "-c", Concatenation( exec, " ", args, " 2>&1" ) ] );
          CloseStream( outstream );
          if code = 0 then
            if target <> fail then
              FileString( target, res );
              return rec( success:= true );
            else
              return rec( success:= true, result:= res );
            fi;
          fi;
        fi;
      od;
    fi;

    return rec( success:= false, error:= "no method was applicable" );
    end );

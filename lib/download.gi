##############################################################################
##
#W  download.gi                 GAP4 package `Utils'             Thomas Breuer
##
#Y  Copyright (C) 2022, The GAP Group

#############################################################################
##
#V  Download_Methods
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
##  Note that currently the methods are *NOT* consistent in the case of
##  failures:
##
##  - The function 'SingleHTTPRequest' does not follow redirects as indicated
##    by HTTP status codes 301 and 302.
##    This happens for example if one asks for the file at
##    'http://www.gap-system.org/Packages/utils.html'.
##
BindGlobal( "Download_Methods", [] );

Add( Download_Methods, rec(
  name:= "via DownloadURL (from the curlInterface package)",
  isAvailable:= {} -> IsPackageLoaded( "curlInterface" ) and
                      CompareVersionNumbers(
                          InstalledPackageVersion( "curlInterface" ),
                          "2.3.0" ),
  download:= function( url, opt )
    local res;

    opt:= ShallowCopy( opt );
    if not IsBound( opt.failOnError ) then
      opt.failOnError:= true;
    fi;
    res:= ValueGlobal( "DownloadURL" )( url, opt );

    if res.success = true and
       IsBound( opt.target ) and IsString( opt.target ) then
      FileString( opt.target, res.result );
      Unbind( res.result );
    fi;
    return res;
  end ) );

Add( Download_Methods, rec(
  name:= "via SingleHTTPRequest (from the IO package)",
  isAvailable:= {} -> IsBoundGlobal( "SingleHTTPRequest" ),
  download:= function( url, opt )
    local rurl, pos, domain, uri, res;

    if not StartsWith( url, "http://" ) then
      return rec( success:= false, error:= "protocol is not http" );
    fi;

    rurl:= ReplacedString( url, "http://", "" );
    pos:= Position( rurl, '/' );
    domain:= rurl{ [ 1 .. pos-1 ] };
    uri:= rurl{ [ pos .. Length( rurl ) ] };
    if IsBound( opt.target ) and IsString( opt.target ) then
      res:= ValueGlobal( "SingleHTTPRequest" )( domain, 80, "GET", uri,
                rec(), false, opt.target );
    else
      res:= ValueGlobal( "SingleHTTPRequest" )( domain, 80, "GET", uri,
                rec(), false, false );
    fi;
    if res.statuscode = 0 then
      return rec( success:= false,
                  error:= res.status );
    elif res.statuscode >= 400 then
      return rec( success:= false,
                  error:= Concatenation( "HTTP error code ", res.statuscode ) );
    elif not ( IsBound( opt.target ) and IsString( opt.target ) ) then
      return rec( success:= true, result:= res.body );
    else
      return rec( success:= true );
    fi;
  end ) );

Add( Download_Methods, rec(
  name:= "via wget",
  isAvailable:= function()
    local exec;

    exec:= Filename( DirectoriesSystemPrograms(), "wget" );
    return exec <> fail and IsExecutableFile( exec );
  end,
  download:= function( url, opt )
    local res, outstream, exec, args, code;

    res:= "";
    outstream:= OutputTextString( res, true );
    exec:= Filename( DirectoriesSystemPrograms(), "wget" );
    if IsBound( opt.target ) and IsString( opt.target ) then
      args:= [ "--quiet", "-O", opt.target, url ];
    else
      args:= [ "--quiet", "-O", "-", url ];
    fi;
    if IsBound( opt.verifyCert ) and opt.verifyCert = false then
      Add( args, "--no-check-certificate" );
    fi;
    code:= Process( DirectoryCurrent(), exec, InputTextNone(), outstream, args );
    CloseStream( outstream );
    if code <> 0 then
      # wget may have created the target file; try to remove it
      if IsBound( opt.target ) and IsString( opt.target ) and
         IsExistingFile( opt.target ) and RemoveFile( opt.target ) <> true then
        Error( "Download cannot remove unwanted file ", opt.target );
      fi;
      return rec( success:= false,
                  error:= Concatenation( "Process returned ", String( code ) ) );
    elif not ( IsBound( opt.target ) and IsString( opt.target ) ) then
      return rec( success:= true, result:= res );
    else
      return rec( success:= true );
    fi;
  end ) );

Add( Download_Methods, rec(
  name:= "via curl",
  isAvailable:= function()
    local exec;

    exec:= Filename( DirectoriesSystemPrograms(), "curl" );
    return exec <> fail and IsExecutableFile( exec );
  end,
  download:= function( url, opt )
    local res, outstream, exec, args, code;

    res:= "";
    outstream:= OutputTextString( res, true );
    exec:= Filename( DirectoriesSystemPrograms(), "curl" );
    args:= [ "--silent", "-L", "--fail" ];
    if IsBound( opt.verifyCert ) and opt.verifyCert = false then
      Add( args, "-k" );
    fi;
    Add( args, "--output" );
    if IsBound( opt.target ) and IsString( opt.target ) then
      Add( args, opt.target );
    else
      Add( args, "-" );
    fi;
    Add( args, url );
    code:= Process( DirectoryCurrent(), exec, InputTextNone(), outstream, args );
    CloseStream( outstream );
    if code <> 0 then
      return rec( success:= false,
                  error:= Concatenation( "Process returned ", String( code ) ) );
    elif not ( IsBound( opt.target ) and IsString( opt.target ) ) then
      return rec( success:= true, result:= res );
    else
      return rec( success:= true );
    fi;
  end ) );


#############################################################################
##
#M  Download( <url>[, <opt>] )
##
##  Try to download the file described by the string <url>,
##  and return a record with the components 'success' ('true' or 'false'),
##  and 'result' (a string, only if 'success' is 'true'),
##  and 'error' (a string, only if 'success' is 'false').
##
InstallMethod( Download,
    [ "IsString" ],
    url -> Download( url, rec() ) );

InstallMethod( Download,
    [ "IsString", "IsRecord" ],
    function( url, opt )
    local errors, r, res;

    # Set the default for 'verifyCert' if necessary.
    if not IsBound( opt.verifyCert ) and
       UserPreference( "utils", "DownloadVerifyCertificate" ) = false then
      opt.verifyCert:= false;
    fi;

    # Run over the methods.
    errors:= [];
    for r in Download_Methods do
      if r.isAvailable() then
        Info( InfoUtils, 2, "try Download method ", r.name );
        res:= r.download( url, opt );
        if res.success = true then
          return res;
        fi;
        Info( InfoUtils, 2, "Download method ", r.name, " failed with\n",
              "#I    ", res.error );
        Add( errors, Concatenation( r.name, ": ", res.error ) );
      else
        Info( InfoUtils, 2, "Download method ", r.name, " is not available" );
      fi;
    od;

    # No method was successful.
    if Length( errors ) = 0 then
      # No method was available, inform the user
      # that it is recommended to load or install some download tool.
      Info( InfoWarning, 1,
            "No 'Download' method is available.\n",
            "#I  Please consider to install one of the tools, ",
            "see '?Download'" );
      return rec( success:= false, error:= "no method was available" );
    else
      # At least one method was tried but without success.
      return rec( success:= false,
                  error:= JoinStringsWithSeparator( errors, "; " ) );
    fi;
    end );

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
##  - The function 'DownloadURL' does not admit specifying that error codes
##    >= 400 are regarded as failures.
##    ('CURLOPT_FAILONERROR' cannot be set via the GAP interface.)
##    If one asks for a nonexisting file then the "via CurlInterface" method
##    returns a record in which 'success' is set to 'true',
##    and 'result' explains the problem.
##    The other methods set 'success' to 'false'.
##
##  - The function 'SingleHTTPRequest' does not regard the error code 301
##    as failure.
##    This happens for example if one asks for the file at
##    'http://www.gap-system.org/Packages/utils.html'.
##
BindGlobal( "Download_Methods", [] );

Add( Download_Methods, rec(
  name:= "via CurlInterface",
  isAvailable:= {} -> IsBoundGlobal( "DownloadURL" ),
  download:= function( url, target )
    local res;

    res:= ValueGlobal( "DownloadURL" )( url, rec( verifyCert:= false ) );
    if target <> fail then
      FileString( target, res.result );
      Unbind( res.result );
    fi;
    return res;
  end ) );

Add( Download_Methods, rec(
  name:= "via SingleHTTPRequest",
  isAvailable:= {} -> IsBoundGlobal( "SingleHTTPRequest" ),
  download:= function( url, target )
    local rurl, pos, domain, uri, res;

    if not StartsWith( url, "http://" ) then
      return rec( success:= false, error:= "protocol is not http" );
    fi;

    rurl:= ReplacedString( url, "http://", "" );
    pos:= Position( rurl, '/' );
    domain:= rurl{ [ 1 .. pos-1 ] };
    uri:= rurl{ [ pos .. Length( rurl ) ] };
    if target = fail then
      res:= ValueGlobal( "SingleHTTPRequest" )( domain, 80, "GET", uri, rec(), false, false );
    else
      res:= ValueGlobal( "SingleHTTPRequest" )( domain, 80, "GET", uri, rec(), false, target );
    fi;
    if res.statuscode >= 400 then
      return rec( success:= false,
                  error:= Concatenation( "HTTP error code ", res.statuscode ) );
    elif target <> fail then
      return rec( success:= true );
    else
      return rec( success:= true, result:= res.body );
    fi;
  end ) );

Add( Download_Methods, rec(
  name:= "via wget",
  isAvailable:= function()
    local exec;

    exec:= Filename( DirectoriesSystemPrograms(), "wget" );
    return exec <> fail and IsExecutableFile( exec );
  end,
  download:= function( url, target )
    local res, outstream, exec, args, code;

    res:= "";
    outstream:= OutputTextString( res, true );
    exec:= Filename( DirectoriesSystemPrograms(), "wget" );
    if target = fail then
      args:= [ "--quiet", "-O", "-", url ];
    else
      args:= [ "--quiet", "-O", target, url ];
    fi;
    code:= Process( DirectoryCurrent(), exec, InputTextNone(), outstream, args );
    CloseStream( outstream );
    if code <> 0 then
      return rec( success:= false,
                  error:= Concatenation( "Process returned ", String( code ) ) );
    elif target = fail then
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
  download:= function( url, target )
    local res, outstream, exec, args, code;

    res:= "";
    outstream:= OutputTextString( res, true );
    exec:= Filename( DirectoriesSystemPrograms(), "curl" );
    if target = fail then
      args:= [ "--silent", "-L", "--fail", "-k", "--output", "-", url ];
    else
      args:= [ "--silent", "-L", "--fail", "-k", "--output", target, url ];
    fi;
    code:= Process( DirectoryCurrent(), exec, InputTextNone(), outstream, args );
    CloseStream( outstream );
    if code <> 0 then
      return rec( success:= false,
                  error:= Concatenation( "Process returned ", String( code ) ) );
    elif target = fail then
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
    local target, r, res;

    if IsBound( opt.target ) and IsString( opt.target ) then
      target:= opt.target;
    else
      target:= fail;
    fi;

    # Run over the methods.
    for r in Download_Methods do
      if r.isAvailable() then
        Info( InfoUtils, 2, "try Download method ", r.name );
        res:= r.download( url, target );
        if res.success = true then
          return res;
        fi;
        Info( InfoUtils, 2, "Download method ", r.name, " failed with\n",
              "#I    ", res.error );
      else
        Info( InfoUtils, 2, "Download method ", r.name, " is not available" );
      fi;
    od;

    return rec( success:= false, error:= "no method was applicable" );
    end );

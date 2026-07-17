#@local meths, i, urls, pair, url, expected, res1, good1, n, file, res2, good2, contents, r, res3, good3, bad, server, baseurl, iometh
############################################################################
##
#W  download.tst               Utils Package                   Thomas Breuer
##
#Y  Copyright (C) 2022, The GAP Group
##
gap> START_TEST( "download.tst" );

##
gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true
gap> LoadPackage( "io", false );
true
gap> ReadPackage( "utils", "tst/http-server.g" );;
gap> server:= UTILS_StartHTTPTestServer();;
gap> baseurl:= Concatenation( "http://127.0.0.1:",
>                            String( server.port ) );;

##  Test the available Download methods
gap> meths:= List( Filtered( Download_Methods, r -> r.isAvailable() ),
>                  ShallowCopy );;
gap> iometh:= First( meths,
>                    r -> StartsWith( r.name, "via SingleHTTPRequest" ) );;
gap> for i in [ 1 .. Length( meths ) ] do
>      meths[i].position:= String( i );
>    od;

##  Test URL parsing in the SingleHTTPRequest based method.
gap> res1:= iometh.download( Concatenation( baseurl, "?a=b#fragment" ),
>                           rec() );;
gap> res1.success;
true
gap> res1:= iometh.download( "http://127.0.0.1:not-a-port/", rec() );;
gap> res1.success = false;
true
gap> res1:= iometh.download( "http://127.0.0.1:65536/", rec() );;
gap> res1.success = false;
true
gap> res1:= iometh.download(
>      Concatenation( "http://[::1]:", String( server.port ), "/" ),
>      rec() );;
gap> res1.success = false;
true
gap> res1.error;
"IPv6 addresses are not supported"
gap> urls:= [ # an http url that works as such
>             [ Concatenation( baseurl, "/success" ), true ],
>           ];;

##  The problem is that the methods do not behave consistently
##  in the case of failure.
##  (Well, they even do not agree what failure means.)
##  The test results depend on which methods are available at runtime,
##  which makes them useless as automatic tests.
##  Thus we test only a working http url.
gap> for pair in urls do
>      url:= pair[1];
>      expected:= pair[2];
>      res1:= List( meths, r -> [ r.download( url, rec() ), r.position ] );;
>      good1:= Filtered( res1, r -> r[1].success = true );;
>      if expected = true and Length( good1 ) <> Length( meths ) then
>        Print( "failure for url ", url, "\n" );
>      fi;
>      if expected = false and Length( good1 ) > 0 then
>        Print( "success for url ", url, "?\n" );
>      fi;
>      n:= Length( Set( good1, r -> r[1].result ) );
>      if n > 1 then
>        Print( "different results (", n, ") for url ", url, "\n" );
>      fi;
>      file:= Filename( DirectoryTemporary(), "test" );
>      res2:= List( meths,
>               r -> [ r.download( url,
>                        rec( target:= Concatenation( file, r.position ) ) ),
>                      r.position ] );;
>      good2:= Filtered( res2, r -> r[1].success = true );;
>      if expected = false and Length( good2 ) > 0 then
>        Print( "success for url ", url, "?\n" );
>      fi;
>      if List( good1, x -> x[2] ) <> List( good2, x -> x[2] ) then
>        Print( "different success cases for url ", url, ":\n",
>               List( good1, x -> x[2] ), " vs. ", List( good2, x -> x[2] ),
>               "\n" );
>      fi;
>      if Length( good1 ) > 0 then
>        contents:= good1[1][1].result;
>        for r in good2 do
>          if contents <> StringFile( Concatenation( file, r[2] ) ) then
>            Print( "different files and contents for url ", url, "\n" );
>          fi;
>        od;
>      fi;
>      res3:= List( meths,
>               r -> [ r.download( url,
>                        rec( maxTime:= 10 ) ),
>                      r.position ] );;
>      good3:= Filtered( res3, r -> r[1].success = true );;
>      if expected = false and Length( good3 ) > 0 then
>        Print( "success for url ", url, "?\n" );
>      fi;
>      # The IO and wget based methods are available.
>      # They cannot handle the 'maxTime' parameter.
>      bad:= Filtered( meths,
>                  x -> StartsWith( x.name, "via SingleHTTPRequest" ) or
>                       StartsWith( x.name, "via wget" ) );
>      bad:= List( bad, x -> x.position );
>      good1:= Filtered( good1, x -> not x[2] in bad );
>      if List( good1, x -> x[2] ) <> List( good3, x -> x[2] ) then
>        Print( "different success cases for url ", url, ":\n",
>               List( good1, x -> x[2] ), " vs. ", List( good3, x -> x[2] ),
>               "\n" );
>      fi;
>    od;

##  test timeout
gap> url:= Concatenation( baseurl, "/delay/3" );;
gap> res1:= Download( url, rec( maxTime:= 1 ) );;
gap> res1.success = false;
true
gap> res1:= Download( url, rec( maxTime:= 5 ) );;
gap> res1.success = true;
true

##  test errors and redirects
gap> res1:= Download( Concatenation( baseurl, "/missing" ) );;
gap> res1.success = false;
true
gap> res1:= Download( Concatenation( baseurl, "/redirect" ) );;
gap> res1.success = true;
true

gap> UTILS_StopHTTPTestServer( server );;

##
gap> STOP_TEST( "download.tst" );

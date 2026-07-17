#############################################################################
##
##  A small HTTP server for the download tests.
##

BindGlobal( "UTILS_HandleHTTPTestRequest", function( listener, socket )
  local connection, line, parts, uri, body, status, location;

  IO_close( listener );
  connection:= IO_WrapFD( socket, IO.DefaultBufSize, IO.DefaultBufSize );
  line:= IO_ReadLine( connection );
  parts:= SplitString( line, " \r\n" );
  if Length( parts ) < 2 then
    IO_Close( connection );
    IO_exit( 1 );
  fi;
  uri:= parts[2];

  repeat
    line:= IO_ReadLine( connection );
  until line = fail or line = "" or line = "\n" or line = "\r\n";

  body:= "download test response\n";
  status:= "200 OK";
  location:= "";
  if StartsWith( uri, "/delay/3" ) then
    Sleep( 3 );
  elif StartsWith( uri, "/missing" ) then
    body:= "not found\n";
    status:= "404 Not Found";
  elif StartsWith( uri, "/redirect" ) then
    body:= "";
    status:= "302 Found";
    location:= "Location: /success\r\n";
  fi;

  IO_Write( connection,
      "HTTP/1.1 ", status, "\r\n",
      location,
      "Content-Type: text/plain\r\n",
      "Content-Length: ", String( Length( body ) ), "\r\n",
      "Connection: close\r\n\r\n",
      body );
  IO_Flush( connection );
  IO_Close( connection );
  IO_exit( 0 );
end );

BindGlobal( "UTILS_StartHTTPTestServer", function()
  local listener, address, port, pid, socket, handler;

  listener:= IO_socket( IO.PF_INET, IO.SOCK_STREAM, "tcp" );
  if listener = fail or
     IO_bind( listener, IO_MakeIPAddressPort( "127.0.0.1", 0 ) ) = fail or
     IO_listen( listener, 8 ) <> true then
    Error( "cannot start the HTTP test server" );
  fi;
  address:= IO_getsockname( listener );
  port:= 256 * INT_CHAR( address[3] ) + INT_CHAR( address[4] );

  pid:= IO_fork();
  if pid = 0 then
    while true do
      socket:= IO_accept( listener,
                          IO_MakeIPAddressPort( "0.0.0.0", 0 ) );
      if socket = fail then
        IO_exit( 0 );
      fi;
      handler:= IO_fork();
      if handler = 0 then
        UTILS_HandleHTTPTestRequest( listener, socket );
      elif handler < 0 then
        IO_close( socket );
        IO_exit( 1 );
      else
        IO_close( socket );
        IO_IgnorePid( handler );
      fi;
    od;
  elif pid < 0 then
    IO_close( listener );
    Error( "cannot fork the HTTP test server" );
  fi;

  IO_close( listener );
  return rec( pid:= pid, port:= port );
end );

BindGlobal( "UTILS_StopHTTPTestServer", function( server )
  IO_kill( server.pid, IO.SIGTERM );
  IO_WaitPid( server.pid, true );
end );

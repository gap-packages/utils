##############################################################################
##
#W  email.gd                    GAP4 package `Utils'               Stefan Kohl
##                                                           Sebastian Gutsche
##                                                                    Max Horn
##  version 0.21, 01/02/2016 
##
#Y  Copyright (C) 2015-2016, The GAP Group, 

if OKtoReadFromUtils( "ResClasses" ) then

#############################################################################
##  this function transferred from ResClasses 
##
#F  SendEmail( <sendto>, <copyto>, <subject>, <text> ) . . . . send an e-mail
##
##  Sends an e-mail with subject <subject> and body <text> to the addresses
##  in the list <sendto>, and copies it to those in the list <copyto>.
##  The first two arguments must be lists of strings, and the latter two must
##  be strings.
##
DeclareGlobalFunction( "SendEmail" );

#############################################################################
##  this function transferred from ResClasses 
##
#F  EmailLogFile( <addresses> ) . . .  send log file by e-mail to <addresses>
##
##  Sends the current logfile by e-mail to <addresses>, if GAP is in logging
##  mode and one is working under UNIX, and does nothing otherwise.
##  The argument <addresses> must be either a list of email addresses or
##  a single e-mail address. Long log files are abbreviated, i.e. if the log
##  file is larger than 64KB, then any output is truncated at 1KB, and if the
##  log file is still longer than 64KB afterwards, it is truncated at 64KB.
##
DeclareGlobalFunction( "EmailLogFile" );

#############################################################################
##  this function transferred from ResClasses 
##
#F  DownloadFile( <url> )
##
##  Downloads the file <url> and returns its contents as a string.
##  If an error occurs, the function prints a warning and returns `fail'.
##  The IO package is needed for using this function.
##
DeclareGlobalFunction( "DownloadFile" );

fi;

#############################################################################
##
#E  email.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

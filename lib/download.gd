##############################################################################
##
#W  download.gd                 GAP4 package `Utils'             Thomas Breuer
##
#Y  Copyright (C) 2022, The GAP Group

#############################################################################
##  This function is intended to be used instead of similar ones from
##  various packages (AtlasRep, FactInt, GAPDoc, PackageManager,
##  StandardFF, ...)
##
#O  Download( <url>[, <opt>] )
##
DeclareOperation( "Download", [ IsString ] );
DeclareOperation( "Download", [ IsString, IsRecord ] );


#############################################################################
##
#U  DownloadVerifyCertificate
##
DeclareUserPreference( rec(
  name:= "DownloadVerifyCertificate",
  description:= [
    "The value 'true' (the default) means that the server's certificate \
is checked in calls of 'Download' such that nothing gets downloaded \
if the certificate is invalid. \
If the value is 'false' then those download methods that are based on \
curl or wget will omit the check of the server's certificate."
    ],
  default:= true,
  values:= [ true, false ],
  multi:= false,
  package:= "utils",
  ) );


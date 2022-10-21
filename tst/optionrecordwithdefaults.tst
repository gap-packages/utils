#@local defaults

##############################################################################
##
#W  record.tst                  Utils Package                    
##
#Y  Copyright (C) 2015-2019, The GAP Group 
##  

gap> ReadPackage( "utils", "tst/loadall.g" );;
gap> UtilsLoadingComplete;
true

#
gap> defaults := rec(a := 1, b := 2);;
gap> OptionRecordWithDefaults(defaults, rec(a := 7));
rec( a := 7, b := 2 )
gap> OptionRecordWithDefaults(defaults, rec(b := 7));
rec( a := 1, b := 7 )
gap> OptionRecordWithDefaults(defaults, []);
rec( a := 1, b := 2 )
gap> OptionRecordWithDefaults(defaults, [rec(b := 7)]);
rec( a := 1, b := 7 )
gap> OptionRecordWithDefaults(defaults, rec(c := 7));
Error, Unknown option: c
gap> OptionRecordWithDefaults(defaults, [rec(b := 7), rec(a := 1)]);
Error, Too many arguments for function
gap> OptionRecordWithDefaults(defaults, 2);
Error, Options should be a record
gap> OptionRecordWithDefaults(defaults, [2]);
Error, Options should be a record

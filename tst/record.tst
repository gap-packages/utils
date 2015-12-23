##############################################################################
##
#W  record.tst                  Utils Package                    
##
##  version 0.16, 21/12/2015   
##
#Y  Copyright (C) 2015, The GAP Group, 
##  

## SubSection 2.1.1 

gap> r := rec( a := 1, b := 2 );                                      
rec( a := 1, b := 2 )
gap> BindInRecordIfMissing( r, "c", 3 );
gap> RecNames( r );
[ "b", "c", "a" ]
gap> BindInRecordIfMissing( r, "c", 4 );
gap> r;
rec( a := 1, b := 2, c := 3 )


#############################################################################
##
#E  record.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

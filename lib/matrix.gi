#############################################################################
##
#W  matrix.gi              GAP4 package `Utils'       Pedro A. Garcia-Sanchez
##  
#Y  Copyright (C) 2023, The GAP Group 

InstallMethod( DirectSumBlock, "for a matrix", 
    [ IsMatrixOrMatrixObj, IsInt, IsList, IsList ], 0, 
function( M, level, blocks, answer ) 

    local  nrM, ncM, nM, nr0, nc0, found, nlzr, nlzc, ntzr, ntzc, nlz, ntz, 
           B, nrB, ncB, nB, nr, nc, i, j, k, i0, j0, nzr, nzc, rest, sub,  
           bls, nrbls, ncbls, pr1, diag0, up0, low0, imax, jmax, 
           len1, ok, ans;

    nrM := NumberRows( M ); 
    ncM := NumberColumns( M ); 
    nM := Minimum( [ nrM, ncM ] ); 
    ## deal with the diagonal case first 
    if IsDiagonalMatrix( M ) then 
        bls := List( [1..nM], i -> [ [ M[i,i] ] ] ); 
        if ( ncM > nM ) then 
            sub := ExtractSubMatrix( M, [nM], [nM..ncM] )[1]; 
            bls[nM] := [ sub ];
        fi; 
        if ( nrM > nM ) then 
            sub := ExtractSubMatrix( M, [nM..nrM], [nM] )[1]; 
            bls[ nM] := [ sub ]; 
        fi; 
        blocks[1] := Concatenation( blocks[1], bls ); 
        ans := Concatenation( blocks[1], blocks[2] ); 
        if not ( ans in answer ) then 
            Add( answer, ans ); 
        fi; 
        return 0;
    fi; 
    ## check for leading or trailing rows or columns of zeros 
    nlzr := 0; 
    found := false; 
    i := 0; 
    while not found do 
        i := i+1; 
        if ForAll( [1..ncM], j -> M[i,j] = 0 ) then 
            nlzr := nlzr + 1; 
        else 
            found := true; 
        fi; 
    od; 
    nlzc := 0; 
    found := false; 
    j := 0; 
    while not found do 
        j := j+1; 
        if ForAll( [1..nrM], i -> M[i,j] = 0 ) then 
            nlzc := nlzc + 1; 
        else 
            found := true; 
        fi; 
    od; 
    ntzr := 0; 
    found := false; 
    i := nrM + 1; 
    while not found do 
        i := i-1; 
        if ForAll( [1..ncM], j -> M[i,j] = 0 ) then 
            ntzr := ntzr + 1; 
        else 
            found := true; 
        fi; 
    od; 
    ntzc := 0; 
    found := false; 
    j := ncM + 1; 
    while not found do 
        j := j-1; 
        if ForAll( [1..nrM], i -> M[i,j] = 0 ) then 
            ntzc := ntzc + 1; 
        else 
            found := true; 
        fi; 
    od; 
    ## add any leading or trailing blocks [ [0] ] 
    nlz := Minimum( [ nlzr, nlzc ] ); 
    if ( nlz > 0 ) then 
        blocks[1] := Concatenation( blocks[1], 
                     ListWithIdenticalEntries( nlz, [ [0] ] ) ); 
    fi; 
    ntz := Minimum( [ ntzr, ntzc ] ); 
    if ( ntz > 0 ) then 
        blocks[2] := Concatenation(  
                     ListWithIdenticalEntries( ntz, [ [0] ] ), blocks[2] ); 
    fi; 
    B := ExtractSubMatrix( M, [nlz+1..nrM-ntz], [nlz+1..ncM-ntz] ); 

    nrB := NumberRows( B ); 
    ncB := NumberColumns( B ); 
    nB := Minimum( [nrB, ncB] ); 
    bls := [ ]; 
    if ( nrB = 1 ) or ( ncB = 1 ) then 
        Add( blocks[1], B ); 
        ans := Concatenation( blocks[1], blocks[2] ); 
        if not ( ans in answer ) then 
            Add( answer, ans ); 
        fi; 
        return 0;
    fi; 
    ## find first non-zero entry in column 1 
    found := false; 
    pr1 := 0; 
    while ( not found ) and ( pr1 < nrB-1 ) do 
        pr1 := pr1 + 1; 
        found := B[pr1,1] <> 0; 
    od; 
    ## determine ranges for i0 and j0 
    diag0 := nB+1; 
    i := nB+1; 
    while ( i > 1 ) do 
        i := i-1; 
        if ( B[i,i] <> 0 ) then 
            diag0 := i; 
        fi; 
    od; 
    up0 := [diag0,diag0]; 
    j := 1; 
    found := false; 
    while ( not found ) and ( j < ncB ) do 
        j := j+1; 
        k := Minimum( [ j-1, nrB ] ); 
        for i in [1..k] do 
            if ( B[i,j] <> 0 ) then 
                up0 := [i,j]; 
                found := true; 
            fi; 
        od;
    od; 
    low0 := [diag0,diag0]; 
    i := 1; 
    found := false; 
    while ( not found ) and ( i < nrB ) do 
        i := i+1; 
        k := Minimum( [ i-1, ncB ] ); 
        for j in [1..k] do 
            if ( B[i,j] <> 0 ) then 
                low0 := [i,j]; 
                found := true; 
            fi; 
        od; 
    od; 
    imax := diag0; 
    jmax := diag0; 
    if ( up0[2] < low0[2] ) then 
        jmax := low0[2] - 1; 
    fi; 
    if ( low0[1] < up0[1] ) then 
        imax := up0[1] - 1;  
    fi; 
    if ( up0[1] < low0[1] ) then 
        imax := Minimum( imax, low0[1] - 1 ); 
    fi; 
    if ( low0[2] < up0[2] ) then 
        jmax := Minimum( jmax, up0[2] - 1 ); 
    fi; 
    if ( low0[1] > nrB ) then
        imax := up0[1]; 
    fi; 
    if ( up0[1] > ncM ) then 
        jmax := low0[2]; 
    fi; 
    i0 := 0; 
    while ( i0 < imax ) do 
        i0 := i0 + 1; 
        i := i0; 
        j0 := 0; 
        while ( j0 < jmax ) do 
            found := false; 
            j0 := j0 + 1; 
            if ( j0 <= pr1 ) then 
                j := j0;
                rest := MutableCopyMatrix( B ); 
                nr := NumberRows( rest ); 
                nc := NumberColumns( rest );
                i := i0;  
                j := j0; 
                nzr := true;
                nzc := true;
                while nzr or nzc do
                    nzr := ForAny( [1..i], 
                           i1 -> ForAny( [j+1..nc], j1->rest[i1][j1]<>0 ) );
                    nzc := ForAny( [i+1..nr], 
                           i1 -> ForAny( [1..j], j1->rest[i1][j1]<>0 ) );
                    if nzr then
                        j := j+1;
                    fi;
                    if nzc then
                        i := i+1;
                    fi;
                od; 
                bls := List( [1..i], i1 -> rest[i1]{[1..j]} ); 
                ## check if we have filled all columns and rows 
                nzc := ntzc - ntz; 
                nrbls := NumberRows( bls );
                ncbls := NumberColumns( bls );
                if ( nzc > 0 ) and ( ncbls + nzc = ncB ) then 
                    ## add zero columns at the end of the block 
                    j := j + nzc; 
                    bls := List( [1..i], i1 -> rest[i1]{[1..j]} );
                fi; 
                nzr := ntzr - ntz; 
                if ( nzr > 0 ) and ( nrbls + nzr = nrB ) then 
                    ## add zero rows at the end of the block 
                    i := i + nzr; 
                    bls := List( [1..i], i1 -> rest[i1]{[1..j]} );
                fi;                 
                Add( blocks[1], bls ); 
                len1 := Length( blocks[1] ); 
                rest := List( [i+1..nr], i1 -> rest[i1]{[j+1..nc]} ); 
                if ( rest <> [ ] ) then 
                    ok := DirectSumBlock( rest,level+1,blocks,answer ); 
                else 
                    ans := Concatenation( blocks[1], blocks[2] ); 
                    if not ( ans in answer ) then 
                        Add( answer, ans ); 
                    fi; 
                fi; 
                blocks := [ blocks[1]{[1..len1-1]}, blocks[2] ]; 
            fi; 
        od;
    od; 
    return Length( answer );
end ); 


InstallMethod( DirectSumDecompositionMatrices, "for a matrix", 
    [ IsMatrixOrMatrixObj ], 0, 
function( M ) 

    local L, blocks, answer, a, ma; 

    blocks := [ [], [] ];
    answer := [ ]; 
    L := DirectSumBlock( M, 1, blocks, answer ); 
    ## check that the answers are correct 
    for a in answer do 
        ma := DirectSumMat( a ); 
        if not ( ma = M ) then 
            Display( ma ); 
            Error( "direct sum of decomposition <> original matrix" );     
        fi; 
    od;
    return answer; 
end ); 

    
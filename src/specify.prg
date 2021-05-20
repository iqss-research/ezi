/* specify.prg */

proc(0) = clearLowerScreen( bottomStr );
    scroll 2 | 1 | 25 | 80 | 24 | 7;
    locate 25,1;
    print bottomStr;;
endp;


proc(9) = specifyModel( varnames, t, x, n, zbCvec, zwCvec, tb, tw, kCvec, V );
    local varlist, cursorPosition, keyPressed, k,
          newT, newX, newN, newZbCvec, newZwCvec, newTB, newTW, newkCvec,
	  newV;

    if (varnames $== "");
        retp(t,x,n,varget(zbCvec),varget(zwCvec), tb, tw, varget(kCvec), V);
    endif;
    call csrtype(0);
    specifyScreen();

    /* make varlist a vector of varnames and tag status */
    varlist = getVarList(varnames);

    @save varlist, t, x, n, zbCvec, zwCvec, tb, tw, kCvec;@
    varlist = varlist ~
              getTagList(varlist, t, x, n, zbCvec, zwCvec, tb, tw, kCvec, V);
    cursorPosition = 1;

    entryloop:
    keyPressed = 0;
    do while (keyPressed /= 27);    /* the escape key */
        drawDataVars( varlist, cursorPosition );
        { cursorPosition, keyPressed } =
            wrappedMoveCurs( cursorPosition, rows(varlist), 3 );
        if (keyPressed <= 122);
            varlist = assignList( varlist, keyPressed, cursorPosition );
        endif;
    endo;

    { newT, newX, newN, newZbCvec, newZwCvec, newTB, newTW, newKCvec, newV } =
                                       ReturnVarElements(varlist);
    if (newT==0 or newX==0);
        locate 18,26;
        "You must assign "
        "\027[1;32mt\027[0m and ";;
        "\027[1;32mx\027[0m.";;
        locate 19,8;
        "Press ESC to exit model specification, any other key to continue.";;
        k=0; do until (k/=0); k = key; endo;
        if (k==27);
            retp(t, x, n, zbCvec, zwCvec, tb, tw, kCvec, V );
        else;
            scroll 18|1|20|80|3|7;
            goto entryloop;
        endif;
    elseif ((newTB==0 and newTW/=0) or (newTB/=0 and newTW==0));
        locate 18,5;
        "Error:  If you assign one of ";;
        "\027[1;32mtruthB\027[0m or ";;
        "\027[1;32mtruthW\027[0m then you must assign both.\027[0m";;
        locate 19,8;
        "Press ESC to exit model specification, any other key to continue.";;
        k=0; do until (k/=0); k = key; endo;
        if (k==27); 
            retp(t, x, n, zbCvec, zwCvec, tb, tw, kCvec, V );
	endif;
        scroll 18|1|20|80|3|7;
        goto entryloop;
    elseif (newN==0);
        scroll 14|1|20|80|7|7;
        locate 14,1;
"     \27[1;5;31mNote: if you do not assign "
        "\027[1;32mn\027[1;5;31m then EzI will make it a vector of ones.\27[0m     ";;
"\27[1;31m       This means that you are telling  EzI  that all your aggregate units
     (such as precincts) contain the same number of individuals (such as 
     people).  If that's really what you want, go ahead.\27[0m";
        locate 19,8;
        "\27[1mPress ESC to exit model specification, any other key to continue.\27[0m";;
        k=0; do until (k/=0); k = key; endo;
        if (k/=27);
	  scroll 14|1|20|80|7|7;
	  goto entryloop;
        else;
            newN = "ndefault";
	endif;
    endif;
    
    retp( newT, newX, newN, newZbCvec, newZwCvec, newTB, newTW, newkCvec,
          newV );
endp;



proc(0) = specifyScreen();
    local SpecifyBottom, SpecifyBottomTop;

    SpecifyBottomTop = "\27[44;1m\27[D"$+
        "      \027[32m\029\018\027[37m to move;    "$+
        "\027[32mx\027[37m, "$+
        "\027[32mt\027[37m, "$+
        "\027[32mn\027[37m, "$+
        "z\027[32mw\027[37m,  z\027[32mb\027[37m,  "$+
        "\027[32mv\027[37m,  "$+
	"t\027[32mr\027[37muthB,  tr\027[32mu\027[37mthW"$+
        ",  or  \027[32mk\027[37meep  "$+
        "       \27[0m";

    SpecifyBottom = "\27[44;1m\27[D"$+
        "      to assign variables.       \27[32mSPACE\27[37m to clear;    "$+
        "      \027[32mESC\027[37m when finished.   \27[0m";

    clearLowerScreen(SpecifyBottom);
    locate 21,1;
    SpecifyBottomTop;;

    locate 22,1;
    print "    ";;
    print cmon$+"t"$+cmoff$+", "$+cmon$+"x"$+cmoff$+", and "$+cmon$+"n"$+cmoff;;
    print " may only be assigned to one variable at a time.  If "$+cmon$+"n";;
    print cmoff$+" is not ";
    print "   assigned then it will be replaced by a vector of 1's.  ";;
    print "    You must assign "; "       ";;
    print cmon$+"t"$+cmoff$+" and "$+cmon$+"x"$+cmoff;;
    print cmon$+".    v"$+cmoff$+" is required for EI2 only.  The others are optional.";
/*    print ".  It is optional to assign ";;
    print cmon$+"zW"$+cmoff$+", "$+cmon;;
    print "zB"$+cmoff$+", "$+cmon$+"truthB"$+cmoff;;
    print ", or "$+cmon$+"truthW"$+cmoff$+"."; */

endp;


/* here listMat is k x 2 matrix where
 * col 1 = variable label (character matrix element)
 * col 2 = character matrix element of specification
 */
proc(9) =  ReturnVarElements( listMat );
    local tV, xV, nV, zbCharVec, zwCharVec, i, trB, trW, kCharVec, vV;
    tV = 0; xV = 0; nV = 0; trB = 0; trW = 0; vV=0;
    kCharVec = 0;
    zbCharVec = 0;
    zwCharVec = 0;

    i = 1;
    do while (i <= rows(listMat));

        if ( listMat[i,2] $== "truthB" );
            trB = listMat[i,1];
            i = i+1;
            continue;
        elseif ( listMat[i,2] $== "truthW" );
            trW = listMat[i,1];
            i = i+1;
            continue;
        elseif ( listMat[i,2] $== "k" );
            if (kCharVec /= 0);
                kCharVec = kCharVec | listMat[i,1];
            else;
                kCharVec = listMat[i,1];
            endif;
            i = i+1;
            continue;
        elseif ( listMat[i,2] $=="n" );
            nV = listMat[i,1];
            i = i+1;
            continue;
        elseif ( listMat[i,2] $=="v" );
            vV = listMat[i,1];
            i = i+1;
            continue;
        endif;

        if ( strindx(listMat[i,2],"t",1)
             and (not strindx(listMat[i,2], "truth", 1)) );
            tV = listMat[i,1];
        endif;
        if (strindx(listMat[i,2],"x",1)); xV = listMat[i,1]; endif;
        if (strindx(listMat[i,2],"zb",1));
            if (zbCharVec /= 0);
                zbCharVec = zbCharVec | listMat[i,1];
            else;
                zbCharVec = listMat[i,1];
            endif;
        endif;
        if (strindx(listMat[i,2],"zw",1));
            if (zwCharVec /= 0);
                zwCharVec = zwCharVec | listMat[i,1];
            else;
                zwCharVec = listMat[i,1];
            endif;
        endif;
        i = i+1;
    endo;
    retp( tV, xV, nV, zbCharVec, zwCharVec, trB, trW, kCharVec, vV );
endp;


proc(1) = assignList( listMat, keySca, cpos );
    local tempStr, i;

    tempStr = ones(1,1)*lower(chrs(keySca));

    if (keySca==88 or keySca==120           /* x or X */
       or keySca==84 or keySca==116         /* t or T */
       or keySca==78 or keySca==110        /* n or N */
       or keySca==86 or keySca==118);       /* v or V */
        i = 1;
	do while (i <= rows(listMat));
            if ( strindx(listMat[i,2], tempStr,1)
                 and i/= cpos
                 and listMat[i,2]$/="<none>"
                 and (not ((keySca==84 or keySca==116) and
                           strindx(listMat[i,2], "truth", 1)))
                );
                locate 18,20;
                "Error: only one variable can be "$+cmon$+"\27[1m";;
                format 1,0; $tempStr;; "\027[0m";;
                wait;
                scroll 18|1|19|80|1|7;
                retp(listMat);
            endif;
            i = i+1;
        endo;
        if ( (strindx(listMat[cpos,2], "t", 1) and
                not strindx(listMat[cpos,2], "truth", 1))
             or strindx(listMat[cpos,2], "x", 1)
             or strindx(listMat[cpos,2], "v", 1)	     
             or (strindx(listMat[cpos,2], "n", 1) and
                 listMat[cpos,2]$/="<none>") );
            locate 18,9;
            "Error: ";;
            cmon$+"\27[1mt\027[0m, ";;
            cmon$+"\27[1mx\027[0m, and ";;
            cmon$+"\27[1mn\027[0m may be assigned to only one variable each.";;
            wait;
            scroll 18|1|19|80|1|7;
            retp(listMat);
        endif;
        if ((keySca==78 or keySca==110) and listMat[cpos,2]$/="<none>");
            locate 18,9;
            "Error: ";;
            "You may not assign "$+cmon$+"\27[1mn";;
            "\027[0m to a previously assigned variable.";;
            wait;
            scroll 18|1|19|80|1|7;
            retp(listMat);
        endif;

        listMat[cpos,2] = additemToAssignList(listMat[cpos,2], tempStr);

    elseif (keySca==114 or keysca==82);       /* r or R */
        i = 1;
        do while (i <= rows(listMat));
            if (listMat[i,2]$=="truthB" and i/= cpos);
                locate 18,20;
                "Error: only one variable can be "$+cmon$+"\27[1m";;
                format 6,0; "truthB";;
                wait;
                scroll 18|1|19|80|1|7;
                retp(listMat);
            endif;
            i = i+1;
        endo;
        listMat[cpos,2] = "truthB";

    elseif (keySca==117 or keysca==85);       /* u or U */
        i = 1;
        do while (i <= rows(listMat));
            if (listMat[i,2]$=="truthW" and i/= cpos);
                locate 18,20;
                "Error: only one variable can be "$+cmon$+"\27[1m";;
                format 6,0; "truthW";;
                wait;
                scroll 18|1|19|80|1|7;
                retp(listMat);
            endif;
            i = i+1;
        endo;
        listMat[cpos,2] = "truthW";

    elseif (keySca==107 or keysca==75);       /* k or K */
        if (listMat[cpos,2] $== "<none>");
            listMat[cpos,2] = "k";
        endif;

    elseif (keySca==32);                        /* SPACE */
        listMat[cpos,2] = ones(1,1)*"<none>";
    elseif (keySca==87 or keySca==119 or        /* b or w */
            keySca==66 or keySca==98);
        tempStr = ones(1,1)*lower("z"$+chrs(keySca));
        listMat[cpos,2] = additemToAssignList(listMat[cpos,2], tempStr);
    endif;

@    save listMat;@
    retp(listMat);
endp;

proc(1) =  additemToAssignList(olditems, additem);
    local newitems;
    if (olditems $== "<none>" or olditems $== "k");
        newitems = additem;
    elseif (strindx(olditems, additem, 1));
        newitems = olditems;
    elseif (strindx(olditems,"truth",1));
        newitems = olditems;
    else;
        newitems = olditems $+ "," $+ additem;
    endif;
    retp(newitems);
endp;

/* take a space-delimited string and return a kx1 character matrix */
proc(1) = getVarList( varnameStr );
    local tok, s, varn;
    {varn, s} = token( varnameStr );
    do while (s $/= "");
        {tok, s} = token( s );
        varn = varn | tok;
    endo;
    retp( varn );
endp;

/* take a kx1 character matrix and return a space-delimited string */
proc(1) = makeVarList( varnameCharMat );
    local varnameStr, i;
    if (varnameCharMat==0); retp(0); endif;
    varnameStr = lower(cvtos(varnameCharMat[1]));
    i = 2;
    do while (i <= rows(varnameCharMat));
        varnameStr = varnameStr $+ " " $+ lower(varnameCharMat[i]);
        i = i+1;
    endo;
    retp(varnameStr);
endp;


/* take a vector of variable names, plus existing qty. labels
 * make a zw,zb t x n truthB etc. taglist and return this
 */
proc(1) = getTagList(varlistVec, t, x, n, zbCV, zwCV, tb, tw, kCV, V);
    local i, j, taglist;
    taglist = ones(rows(varlistVec),1)*"<none>";

    i = 1;
    do while (i <= rows(varlistVec));
        if (varlistVec[i] $== t); tagList[i] = "t"; endif;
        if (varlistVec[i] $== x); tagList[i] = "x"; endif;
        if (varlistVec[i] $== n); tagList[i] = "n"; endif;
        if (varlistVec[i] $== v); tagList[i] = "v"; endif;      
      
        if (varlistVec[i] $== tb); tagList[i] = "truthB"; endif;
        if (varlistVec[i] $== tw); tagList[i] = "truthW"; endif;

        j = 1;
        do while (j <= rows(zbCV));
            if (varlistVec[i] $== zbCV[j]);
                if tagList[i] $== "<none>"; tagList[i] = "zb";
                else; tagList[i] = tagList[i] $+ ",zb";
                endif;
            endif;
            j = j+1;
        endo;

        j = 1;
        do while (j <= rows(zwCV));
            if (varlistVec[i] $== zwCV[j]);
                if tagList[i] $== "<none>"; tagList[i] = "zw";
                else; tagList[i] = tagList[i] $+ ",zw";
                endif;
            endif;
            j = j+1;
        endo;

        j = 1;
        do while (j <= rows(kCV));
            if (varlistVec[i] $== kCV[j]); tagList[i] = "k"; endif;
            j = j+1;
        endo;

        i = i+1;
    endo;
    retp( tagList );
endp;

proc(0) = drawDataVars( varnameMat, cpos );

    local printrow, printcol, printincrm, i, r, c;
    printrow = 4;
    printcol = 7;
    printincrm = 20;

    i = 0;
    do while ( i < rows(varnameMat));
        r = printrow;
        c = printcol + printincrm*(i%3);
        locate r, c;
        if (i+1 == cpos); "\027[7m";; endif;
        format 8,0; "\027[1m";; $varnameMat[i+1,1];; "\027[0m";;
        format 1,0; "= ";;
        if (varnameMat[i+1,2] $/= "<none>"); "\027[1m"$+cmon;; endif;
        format 8,0; $varnameMat[i+1,2];; "\027[0m";;
        if (2 == i%3); printrow = printrow + 1; endif;
        i = i+1;
    endo;
endp;

/* general funtion to move a cursor around a wrapped list
 *    cpos = current cursor position in list
 *    listdim = size of list
 *    wrapcols = number of columns by which the list is wrapped
 * Returns: (1) scalar new cpos
 *          (2) scalar keypress
 */
proc (2) = wrappedMoveCurs(cpos, listdim, wrapcols);
    local keypress;

    keypress = 0;
    do while (keypress==0);
        keypress=key;
    endo;

    if keypress==1072;      /* Up Arrow */
        if (cpos > wrapcols);
            cpos = cpos - wrapcols;
        endif;
    elseif keypress==1080;  /* Down Arrow */
        if (cpos + wrapcols <= listdim);
            cpos = cpos + wrapcols;
        endif;
    elseif keypress==1075;  /* Left Arrow */
        if (cpos-1 % wrapcols /= 0);
            cpos = cpos - 1;
        endif;
    elseif keypress==1077;  /* Right Arrow */
        if (cpos % wrapcols /= 0 AND cpos+1 <= listdim);
            cpos = cpos + 1;
        endif;
    endif;
    retp(cpos, keypress);
endp;

/* check values of x, t, n to see if already assigned
 *   if yes, then return 0
 *   if no, return -1
 *  eventually add a warning/confirmation request here
 */
proc(1) = preEIwarning(tlabel, xlabel, nlabel, zWlabel, zBlabel);
    if (tlabel==0);
        retp(-1);
    else;
        retp(0);
    endif;
endp;


proc(0) = showGlobLabs();
    format 18,0;
    ?;
    "tlab   = " $tlab;
    "xlab   = " $xlab;
    "nlab   = " $nlab;
    "zb     = " makevarlist(zblabCV);
    "zw     = " makevarlist(zwlabCV);
    "truthB = " $trBlab;
    "truthW = " $trWlab;
    "keep   = ";; if (klabCV/=0); makevarlist(klabCV); endif;
endp;


/*
 * take a kx1 character vector of variable specifications
 * check for errors
       return: 1 if a non-zw/zb tag is assigned to multiple vars
               2 if a variable tag is multiply assigned to same var.
               3 if invalid tags found
               4 if try to assign another variable with n
               5 if try to assign t and x together
               6 if not both t and x assigned
 */
proc(1) = checkTagList( specCV );
    local i, j, r, tok, s, foundt, foundx, foundv;
    foundt = 0;
    foundx = 0;

    /* eliminate blank fields */
    specCV = packr(miss(specCV,""));
    r = rows(specCV);

    i = 1;
    do while (i <= r);
        { tok, s } = token( cvtos(specCV[i]) );
        j = 1;
        do while (j <= r);
            if ( strindx(specCV[j], tok, 1)
                 and (not (tok $== "t" and strindx(specCV[j],"truth",1)))
                 and (i /= j)
                 and (tok $/= "zw" and tok $/= "zb" and tok$/="k")  );
                retp(1);
            endif;
            j = j+1;
        endo;
        if (tok$=="t"); foundt = 1; endif;
        if (tok$=="v"); foundv = 1; endif;
        if (tok$=="x"); foundx = 1; endif;
        if (tok$/="t" and tok$/="x" and tok$/="n" and tok$/="zw" 
	    and tok$/="zb" and tok$/="truthB" and tok$/="truthW" 
	    and tok$/="k" and tok$/="v");
            retp(3); endif;
        if (strindx(s,tok,1)); retp(2); endif;

        if (tok$=="n" and s$/="" );
            retp(4);
        endif;
        if ( (tok$=="t" and strindx(s,"x",1)) or
             (tok$=="x" and strindx(s,"t",1)) );  retp(5); endif;

        do until ( s $== "" );
            { tok, s } = token( s );
            if (tok$/="t" and tok$/="x" and tok$/="n"
                and tok$/="zw" and tok$/="zb"
                and tok$/="truthB" and tok$/="truthW" and tok$/="k");
                retp(3); endif;
            j = 1;
            do while (j <= r);
                if ( strindx(specCV[j], tok, 1)
                     and (not (tok $== "t" and strindx(specCV[j],"truth",1)))
                     and (i /= j)
                     and (tok $/= "zw" and tok $/= "zb" and tok$/="k")  );
                    retp(1);
                endif;
                j = j+1;
            endo;
            if (tok$=="t"); foundt = 1; endif;
            if (tok$=="x"); foundx = 1; endif;
            if ( (tok$=="t" and strindx(s,"x",1)) or
                 (tok$=="x" and strindx(s,"t",1)) );  retp(5); endif;
        endo;
        i = i+1;
    endo;
    if (not (foundt and foundx)); retp(6); endif;
    retp(0);
endp;


loadFileBottom = "\27[44;1m\27[D                         "$+
"ENTER blank filename to exit                          \27[0m";

proc(0) = clearMidScreen();
    scroll 2 | 1 | 19 | 80 | 19-2+1 | 7;
endp;

proc(0) = clearLowerScreen( bottomStr );
    scroll 2 | 1 | 25 | 80 | 24 | 7;
    locate 25,1;
    print bottomStr;;
endp;

proc(0) = showStats( varnames );
    local tok, varn, s, temp;

    clearMidScreen();
    temp = mergevar( varnames );
    {varn, s} = token(varnames);
    varn = stocv(varn);
    do until (s $== "");
        {tok, s} = token(s);
        varn = varn | stocv(tok);
    endo;
    __altnam = upper(varn);
    locate 3,1;
    call dstat(0, temp);
    ?;
    "                \027[36m       *** Press any key to resume ***\027[0m";
    wait;
endp;


proc(1) = getDbufFilename( dbfilenStr );
    local tempfnStr;

    ask:
    scroll 20|1|25|80|6|7;
    locate 21,6;
    print "\27[1;31mEnter filename under which to save the data buffer you ";;
    print "just created:";
    print "               (no filename extension; default = \27[37m";; dbfilenStr;;
    print "\27[31m)\27[0m";
    tempfnStr = cons;
    print;

    if (tempfnStr $== "");
        retp(dbfilenStr);
    elseif (strindx(tempfnStr,".",1));
        "         Error: do not enter a filename extension (.FMT is automatic).";
        wait;
        goto ask;
    elseif (not verifyFilename(tempfnStr));
        "               Error: invalid filename.  Please re-enter."; wait;
        goto ask;
    endif;

    retp(upper(tempfnStr));
endp;


proc(1) = verifyFilename( filenStr );
    if (filenStr $=="");
        retp(0);
    elseif (strlen(filenStr)>12);
        retp(0);
    elseif ( (not strindx(filenStr,".",1)) and (strlen(filenStr)>8) );
      retp(0);
    elseif (strindx(filenStr, " ",1));
        retp(0);
    /* elseif (strindx(filenStr, "\"",1));
        retp(0); */
    elseif (strindx(filenStr, "/",1));
        retp(0);
    elseif (strindx(filenStr, "\\",1));
        retp(0);
    elseif (strindx(filenStr, "[",1));
        retp(0);
    elseif (strindx(filenStr, "]",1));
        retp(0);
    elseif (strindx(filenStr, "[",1));
        retp(0);
    /* elseif (strindx(filenStr, ":",1));
        retp(0); */
    elseif (strindx(filenStr, "<",1));
        retp(0);
    elseif (strindx(filenStr, ">",1));
        retp(0);
    elseif (strindx(filenStr, "+",1));
        retp(0);
    elseif (strindx(filenStr, "=",1));
        retp(0);
    elseif (strindx(filenStr, ";",1));
        retp(0);
    elseif (strindx(filenStr, ",",1));
        retp(0);
    elseif (strindx(filenStr, "*",1));
        retp(0);
    elseif (strindx(filenStr, "?",1));
        retp(0);
    else;
        retp(1);
    endif;
endp;


/* askFileName( filetype )
 *     filetype = 1  ask for an ascii file
 *                2  ask for a data buffer, automatically add .fmt if needed
 *                3  ask for export ascii filename, put on row 3, no cls
 */
proc(1) = askFileName( filetype );
    local f, filename, oldcsr;

    oldcsr = 2;
    ask:
    if filetype/=3;
      clearMidScreen();
      locate 10,20;
    else;
      scroll 3|1|3|80|1|7;
      locate 3,13;
    endif;
    print "\27[1mEnter the name of the ";;
    if (filetype==1);
        print "ascii file: ";;
    elseif (filetype==2);
        print "data buffer: ";;
    elseif (filetype==3);
    print "export ascii file: ";;
    else;
      print "Unknown file type in askFileName()!";
      end;
    endif;

    call csrtype(oldcsr);
    filename = cons;
    oldcsr = csrtype(0);
    if (filename $== ""); retp("NULL"); endif;
    if (not verifyFilename(filename));
      locate 16,20;
      "Error: invalid filename.  Please re-enter.";
      wait;
      goto ask;
    elseif (strindx(upper(filename),".VAR",1));
      "\27[1;31m";;
      center(16,"Error: You are trying to load a file of variable names.");
      center(17,"instead of a dataset.  Please re-enter.");
      "\27[0m";;
      wait;
      goto ask;
    endif;

    filename = upper(filename);
    if (filetype==2);
      if (strindx(upper(filename),".ASC",1));
	"\27[1;31m";;
	center(16,"Error: It appears that you are trying to load an ASCII file of");
	center(17,"variable names instead of a data buffer.  Please re-enter.");
	"\27[0m";;
	wait;
	goto ask;
      elseif ((0 == strindx(filename, ".", 1))
	AND (0 == strindx(filename,".FMT",1)) );
	filename = filename $+ ".FMT";
      endif;
    endif;

    if (filetype==1);
      if (strindx(upper(filename),".FMT",1));
	"\27[1;31m";;
	center(16,"Error: It appears that you are trying to load a data buffer");
	center(17,"instead of an ASCII data file.  Please re-enter.");
	"\27[0m";;
	wait;
	goto ask;
      else;
	if ( (0 == strindx(filename, ".", 1)) AND 
	  (0 == strindx(filename,".ASC",1)) );
	filename = filename $+ ".ASC";
	endif;
      endif;  
    endif;

    f = files(filename,0);

    if (f==0 and filetype/=3);
        locate 13,24;
        print "\027[1;31mError: File "$+filename$+" does not exist.";
        locate 16,23;
        print "*** Press Any Key to Continue ***\027[0m";
        wait;
        goto ask;
/*    elseif (strlen(filename) - strindx(filename,".",1) > 3);
        locate 13,26;
        print "\027[1;31mError: "$+filename$+" is invalid.";
        locate 16,23;
        print "*** Press Any Key to Continue ***\027[0m";
        wait;
        goto ask; */
    else;
        retp(filename);
    endif;
endp;


proc(1) = askVarNames( filename );
    local varNames, k;

    getvn:
    locate 12,20;
    print "Type the names of the variables, in order,";;
    locate 13,20;
    print "         separated by spaces.";;
    locate 17,10;
    varNames = cons;
    if (varNames $== "");
        scroll 12 | 1 | 19 | 80 | 8 | 7;
        locate 12,13;
        "\027[1;31mYou didn't supply any variable names.  Please try again.";
        locate 14,23;
        print "*** Press Any Key to Continue ***\027[0m";
        k = 0; do until (k/=0); k = key; endo;
        scroll 12 | 1 | 19 | 80 | 8 | 7;
        if (k==27); retp("RESTART"); endif;
        goto getvn;
    elseif (verifyNvars(varNames, filename));
        scroll 12 | 1 | 19 | 80 | 8 | 7;
        locate 12,13;
        "\027[1;31mSorry, but the file either contains a different number of";
        locate 13,13;
        "variables, or some rows are missing one or more columns.";
        locate 15,17;
        print "  *** Any Key to Re-enter, ESC to EXIT ***\027[0m";
        k = 0; do until (k/=0); k = key; endo;
        scroll 12 | 1 | 19 | 80 | 8 | 7;
        if (k==27); retp("NULL"); else; goto getvn; endif;
    elseif (checkInvalVarnames(varNames));
        locate 15,17;
        print "  *** Any Key to Re-enter, ESC to EXIT ***\027[0m";
        k = 0; do until (k/=0); k = key; endo;
        scroll 12 | 1 | 19 | 80 | 8 | 7;
        if (k==27); retp("NULL"); else; goto getvn; endif;
    endif;
    retp(varNames);
endp;


proc(1) = checkInvalVarnames( vnamesStr );
    local tok, s, varn, invcode;
    {varn, s} = token( vnamesStr );
    if (isVarnInvalid( varn ));
        locate 16,20;
        "\027[1;31mError: variable name \27[33m"$+varn;;
        "\27[31m is ";;
        if (invcode==2); "too long.";; else; "invalid.";; endif;
        retp(1);
    endif;
    do while (s $/= "");
        {varn, s} = token( s );
        invcode = isVarnInvalid( varn );
        if (invcode);
            scroll 12 | 1 | 19 | 80 | 8 | 7;
            locate 16,20;
            "\027[1;31mError: variable name \27[33m"$+varn;;
            "\27[31m is ";;
            if (invcode==2); "too long.";; else; "invalid.";; endif;
            retp(1);
        endif;
    endo;
    retp( 0 );
endp;

/* return 1 if invalid
   return 0 if ok
 */
proc(1) = isVarnInvalid( varnStr );
    if (strindx(varnStr, "_", 1)); retp(1);
    elseif (strlen(varnStr) > 8); retp(2);
    elseif (0==verifyFilename(varnStr)); retp(3);
    endif;
    retp(0);
endp;

/* check if varnames string contains same # of variables
 * as the columns in ascii file filename
 *   1 = something doesn't match
 *   0 = probably OK
 */
proc(1) = verifyNvars( varnames, filename );
    local t, nvarsSupplied, nrowsInFile, d;

    nvarsSupplied = 1;
    { t, varnames } = token(varnames);
    do until (varnames $=="");
        { t, varnames } = token(varnames);
        nvarsSupplied = nvarsSupplied + 1;
    endo;

    load d[] = ^filename;
    nrowsInFile = rows(d);

    retp( nrowsInFile % nvarsSupplied );
endp;



proc(2) = readAsciiFile();
    local oldCsrtype, dataFileN, varNames, loadvarsArg, f, varFileN, k;

    restart:
    oldCsrtype = csrtype(2); 
    clearLowerScreen( loadFileBottom );
    dataFileN = askFileName(1);
    if (dataFileN $== "NULL"); 
      retp("<none>",""); 
    endif;

    varFileN = getFilenameRoot(dataFileN)$+".var";
    if (0==files(varFileN,0));
        varNames = askVarNames( dataFileN );
        call csrtype(oldCsrtype);
        if (varNames $== "NULL"); retp("<none>",""); endif;
        if (varNames $== "RESTART"); goto restart; endif;
    else;
        call csrtype(oldCsrtype);
        varNames = useVarFile( varFileN );
        if (varNames $== "BADVARFI");
            locate 18,22;
            print "  *** Press Any Key to Continue ***";
            wait;
            scroll 12 | 1 | 19 | 80 | 8 | 7;
            goto restart;
        endif;
    endif;

    clearOldVars( varsinMem );
    loadvarsArg = dataFileN $+ " " $+ varNames;
    loadvars ^loadvarsArg;
    workingFileType = "ASCII source";
    statusMessage = "Loaded ASCII data";

    
    scroll 12 | 1 | 24 | 80 | 8 | 7;
    locate 14,1; "\27[1;31m";;
"    Now press <SPACE BAR> to see descriptive statistics (so you can verify 
    that the data have been read in correctly), or any other key to continue.";
    "\27[0m";
    k = 0;
    do until (k < 0);
        k = keyw;
        if (k==32);       /* Yes */
            call showStats( varNames );
	    scroll 2 | 1 | 24 | 80 | 23 | 7;
            k = -1;
        else;
            k = -1;
        endif;
    endo;
    
    locate 17,1; "\27[1m";;
"    If your data have been read in correctly, return to the main menu and
           select \27[33mMODEL:Specify\27[0;1m to define the model to be run.";  
    "\27[0m";
    locate 23,18;
    print "  *** Press Any Key to Return to Main Menu ***";
    wait;
    @scroll 12 | 1 | 24 | 80 | 8 | 7;@
    
    retp(dataFileN, varNames);
endp;


proc(2) = loadDataBuf();
    local oldCsrtype, databufFileN, dataBuf;

    clearLowerScreen( loadFileBottom );
    oldCsrtype = csrtype(2);
    databufFileN = askFileName(2);
    if (databufFileN $== "NULL"); retp("<none>",0); endif;

    workingFileType = "Data buff. (file)";
    statusMessage = "Loaded Data Buffer";

    load dataBuf = ^databufFileN;

    call csrtype(oldCsrtype);
    retp(databufFileN, dataBuf);
endp;

proc(1) = getFilenameRoot( filename_asc );
    local filename;
    if (0==strindx(filename_asc,".",1)); retp(filename_asc); endif;
    filename = strsect(filename_asc, 1, strindx(filename_asc, ".", 1) - 1);
    retp(filename);
endp;

proc(1) = useVarFile( varfilename );
    local varNameStr, rf, s, tok, ss, varnstrlen,
          specifystrstart, varSpec, varName, varSpecVec, varNameVec;

    locate 11,20; "\27[1m";;
    print "Reading variable names from:      ";; upper(varfilename);; "\27[0m";;
    rf = getf( varfilename, 0 );
    {tok, s} = tokenNS(rf);
    varnstrlen = maxc( strindx(tok,"=",1)-1 |
                       (not strindx(tok,"=",1))*strlen(tok) );
    specifystrstart = strindx(tok,"=",1) + (0/=strindx(tok,"=",1));
    varName = strsect(tok, 1, varnstrlen);
    if checkInvalVarnames( varName ); 
      retp("BADVARFI");                /* return if invalid .var file */
    endif;
    
    /* starting settings for t, x, n, zB, zW, truthB, truthW, keep */
    tlab = 0;     
    xlab = 0;
    vlab = 0;
    v = 0;
    ndefault = 1;
    nlab = "ndefault";
    TrBlab = 0;
    TrWlab = 0;
    ndefault = 1;
    zB = 1;  zW = 1;
    zBlabCV = "zB";
    zWlabCV = "zW";
    keepMat = 0;
    klabCV = 0;

    varSpec = strsect(tok, specifystrstart, strlen(tok));
    varSpecVec = varSpec;
    varNameStr = varName;

    do until (s $== "");
        {tok, s} = tokenNS(s);
        varnstrlen = maxc( strindx(tok,"=",1)-1 |
                           (not strindx(tok,"=",1))*strlen(tok) );
        specifystrstart = strindx(tok,"=",1) + (0/=strindx(tok,"=",1));
        varName = strsect(tok, 1, varnstrlen);
        if checkInvalVarnames( varName ); retp("BADVARFI"); endif;
        varSpec = strsect(tok, specifystrstart, strlen(tok));
        varSpecVec = varSpecVec | varSpec;
        varNameStr = varNameStr $+ " " $+ varName;
    endo;

    varNameVec = getVarList(varNameStr);
    if (not checkTagList(varSpecVec));
        { tlab, xlab, nlab, zBlabCV, zWlabCV, trBlab, trWlab, klabCV, vlab } =
                           returnVarElements( varNameVec~varSpecVec );
    else;
        "\27[31;1m";;
        center(14,
	"Error: could not use "$+varfilename$+" for variable assignment.");
        center(15,"Please correct and reload, or specify variables manually.");
        "\27[0m";;
    endif;

    retp(varNameStr);
endp;

/*
** tokenNS.src - String parser, based on token.src by Aptech
**
** Purpose:    To extract the first token from a string,
**             recognizing *only spaces* as delimiters
*/
proc (2) = tokenNS(str);
    local i,n,cmdvec,tok;
    if strlen(str) == 0; retp("",""); endif;
    cmdvec = vals(str);
    cmdvec = miss(cmdvec,13);
    cmdvec = miss(cmdvec,10);
    cmdvec = missrv(cmdvec,32);
    n = rows(cmdvec);
    i = 1;
    do while i <= rows(cmdvec);
        if cmdvec[i] /= 32;
            break;
        endif;
        i = i+1;
    endo;
    if i > rows(cmdvec);
        retp("","");
    endif;
    tok = cmdvec[i];
    i = i+1;
    do while i <= rows(cmdvec);
        if cmdvec[i] == 32;
            do while i <= rows(cmdvec);
                if cmdvec[i] /= 32;
                    break;
                endif;
                i = i+1;
            endo;
            if i > n;
                break;
            endif;
            do while i <= rows(cmdvec);
                if cmdvec[i] /= 32;
                    break;
                endif;
                i = i+1;
            endo;
            break;
        endif;
        tok = tok|cmdvec[i];
        i = i+1;
    endo;
    if i <= rows(cmdvec);
        cmdvec = chrs(cmdvec[i:rows(cmdvec)]);
    else;
        cmdvec = "";
    endif;
    retp(chrs(tok),cmdvec);
endp;


proc(0) = center( row, str );
    locate row, ((80 - strlen(str))/2);
    str;;
endp;

proc(0) = mainErrorMsg( messageStr );
    "\27[1;33m";; center( 2, messageStr );; "\27[0m";;
     wait;
     scroll 2|1|2|80|1|7;
endp;

proc(0) = viewOrSave( tempfilename );
    local viewBottom, doscmd, oldcsr, k;
    viewBottom = "\27[44;1m\27[D"$+
        "         re\027[32mV\027[37miew results     "$+
        "    \027[32mS\027[37mave to file     "$+
        "        \027[32mESC\027[37m when finished     \27[0m";

    call csrtype(0);
    /* locate 1,1;
    doscmd = "type " $+ tempfilename;
    dos ^doscmd; */
    locate 25,1; viewBottom;;

    k = 0;
    do until (k < 0);
        k = keyw;
        if (k==118 or k==86);           /* v or V to view file */
            doscmd = "l.com " $+ tempfilename;
            dos ^doscmd;
	    scroll 1|1|1|80|1|7;
	    k = 0;
        elseif (k==115 or k==83);       /* s or S to save file */
            oldcsr = csrtype(2);
            k = saveToFile( tempfilename );
            call csrtype(oldcsr);
            k = 0;
	    scroll 1|1|24|80|24|7;
	elseif (k==27);
            k = -1;                     /* cause outer loop exit condition */
            continue;
        endif;
        locate 25,1; viewBottom;;
    endo;

    doscmd = "del " $+ tempfilename $+ " > nul";
    @dos ^doscmd;@
endp;

/* take the temporary (internally assigned) filename
 * ask user for permanent save filename
 * copy the temp file to the save file
 *      later: can return 0 for continue calling loop
 *                        -1 to exit calling loop (and eiread routine)
 */
proc(1) = saveToFile( tempfilen );
    local exitFlag, savefilen, doscmd;

    askSTF:
    clearMidScreen();
    locate 10, 20;
    "\27[1m";
    center(10,
           "Enter the name of the file to which the output should be saved:");
    locate 13, 34; "\27[0m ";;
    savefilen = cons;
    if (savefilen $== "");
        retp(0);
    endif;
    if (not verifyFilename(savefilen));
        "\27[1;31m";;
        center(15, "Error: \27[33m"$+savefilen$+
                   "\27[31m is an invalid filename.  Please re-enter.");
        "\27[0m";;
        wait;
        goto askSTF;
    endif;
    doscmd = "copy "$+tempfilen$+" "$+savefilen$+"> nul";
    dos ^doscmd;
    retp( 0 );
endp;


proc(1) = exitConfirm();
    local confirmQuitStr, k;
    call csrtype(0);

    confirmQuitStr ="\27[1;5mDo you really wish to Exit?  (\27[32mY\27[37mes" $+
                     " or \27[32mN\27[37mo)\027[0m";
    locate 2, 20; confirmQuitStr;;
    k = 0;
    do until (k < 0);
        k = keyw;
        if (k==121 or k==89);       /* Yes */
            retp(1);
        elseif (k==110 or k==78 or k==27);   /* No (ESC also exits */
            k = -1;
        endif;
    endo;
    scroll 2|1|2|80|1|7;
    retp(0);
endp;

proc(0) = mn();
    run main.prg;
endp;

proc(0) = td();
    dos e to-do.txt;
endp;

proc(0) = loadednovarDbufmsg();
    local c;
    c = 13;
    "\27[31;1m";;
    center(16, " NOTE: This data buffer did not contain variable names.");
    "\27[0m";;
    locate 17,c; "Probably this data buffer was  created using the library";
    locate 18,c; "version of EI.  Since there are no variable names in the";
    locate 19,c; "data buffer, I will use "$+cmon$+" t"$+cmoff$+", ";;
                 cmon$+"x"$+cmoff$+", "$+cmon$+"n";;
                 cmoff$+",  and "$+cmon$+"zB";;
                 cmoff$+"\27[1mn\27[0m through "$+cmon$+"zW";;
                 cmoff$+"\27[1mn\27[0m,";
    locate 20,c; "plus "$+cmon$+"truthB";;
                  cmoff$+" and "$+cmon$+"truthW"$+cmoff$+".";;
    "\27[36m";; center(22, "*** Press any key to continue ***"); "\27[0m";;
    wait;
endp;


proc(0) = clearOldVars(variablesStr);
    local variablesCV, i;
    
    if (variablesStr $== ""); retp; endif;
    variablesCV = getVarList(variablesStr);
    i = 1;
    do while (i<=rows(variablesCV));
      call varput(0,variablesCV[i]);      /* equivalent to clear */
      i = i+1;
    endo;

    varsinMem   = "";
    genericDbuf = 0;
endp;
  

proc(0) = clearGlobals(variablesStr);
    local variablesCV, i;
    
    if (variablesStr $== ""); retp; endif;
    variablesCV = getVarList(variablesStr);
    i = 1;
    do while (i<=rows(variablesCV));
      call varput(0,variablesCV[i]);      /* equivalent to clear */
      i = i+1;
    endo;

    varsinMem   = "";
    genericDbuf = 0;
    /* starting settings for t, x, n, zB, zW, truthB, truthW, keep */
    tlab = 0;     
    xlab = 0;
    vlab = 0;
    v = 0;
    ndefault = 1;
    nlab = "ndefault";
    TrBlab = 0;
    TrWlab = 0;
    ndefault = 1;
    zB = 1;  zW = 1;
    zBlabCV = "zB";
    zWlabCV = "zW";
    keepMat = 0;
    klabCV = 0;
endp;

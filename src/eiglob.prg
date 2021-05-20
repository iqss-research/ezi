
#include eiglob.h           /* Menu Elements in separate file
			       defined globally.  Hey, it's not my fault
			       that Gauss has such limited data types! */
temp = _Ebeta;              /* this helps the vargets, I dunno why! */

proc(1) = doEditMenu( whichGlobalStr, varnamesStr );
    local currentsel, cursorpos, titleStr, globalMat;
    cls;
    if (whichGlobalStr $== "eiglobs");
	globalMat = eiglobs;
	titleStr = "Configure global parameters before running EI model";
    elseif (whichGlobalStr $== "egglobs");
	globalMat = egglobs;
	titleStr = "Configure graphics options before running graphs";
    else;
	"doEditMenu(): Someone passed me a wrong global flag!";
	wait;
	retp(-1);
    endif;

    currentsel = 1;
    drawgmen(titleStr, globalMat, currentsel);
    do until ( currentsel < 0 );                /* ESC to exit */
	cursorpos = currentsel;
	drawmel(globalMat, 4, 5, cursorpos);
	drawdescr(globalMat, cursorpos, 21);
	currentsel = globmenukey(globalMat, cursorpos);
	if (currentsel==0);                     /* ENTER to edit */
	if varget(globalMat[cursorpos,1]) $== "_Eselect";
	  _Eselect = assignESelect( varnamesStr );
	else;
	  EditValue( globalMat, cursorpos );
	endif;
	currentsel = cursorpos;
	drawgmen(titleStr, globalMat, currentsel);
	elseif (currentsel==99);                /* RESET was chosen */
	    if (confirmReset()); 
	       titl = "";
	       call eiset; 
	    endif;
	    currentsel = cursorpos;
	endif;
    endo;
    if (type(_Eselect)==13);  /* if default 1 is now a variable name */
       _Eselect = varget(_Eselect); 
    endif;
    retp(0);
endp;


proc (0) = drawgmen(globtitl, m_el, cursorpos);
    local m_top, m_bottom, halfline, i, j, pmask, pfmt, temp, halftherows,
	  label;

    m_top    = main_top;    /**** global ****/

    m_bottom = "\27[44m\27[D"$+chrs(29)$+chrs(18)$+
	       ": Move      ENTER: Edit    R: Reset to Defaults      "$+
	       "ESC: Return to Main Menu\27[40m";
    halfline="컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴";

    call csrtype(0);
    if m_top$/="";
	scroll w1;
	locate 1,2;
	print m_top;
	locate 2,1;"          ";
    endif;

    locate 3,30; 
    print "\27[1m";;
    center(3, globtitl);;
	"\27[0m";

    drawmel(m_el, 4, 5, cursorpos);

    locate 20,1;
    print $halfline;;$halfline;;
    if m_bottom$/="";
	scroll w4;
	locate 25,2;
	print "\27[1m";; m_bottom;; "\27[0m";;
    endif;
endp;


proc(0) = drawmel(menu_els, firstx, firsty, cpos);
    local i, j, halftherows, temp, label, l;

    if (rows(menu_els) % 2);
	menu_els = menu_els | miss(ones(1,3),1);
    endif;

    j = 1;
    do while (j <= 2);
	i=1;
	halftherows = ceil(rows(menu_els)/2);
	do while (i <= halftherows );
	    format 8,0;
	    temp = menu_els[ i+(j-1)*halftherows, 1 ];
	    if (ismiss(temp)); break; endif;
	    label = varget(temp);
	    locate firstx + (i-1), firsty + (j-1)*40;
	    print "\27[1m"$+cgon;;
	    print label;;
	    print "\27[0m";;
	    locate firstx + (i-1), firsty + 16 + (j-1)*40;
	    print "= ";;
	    format 8, menu_els[ i+(j-1)*halftherows, 3];
	    temp = varget(label);
	    if (type(temp)==13);
	      print strsect(temp,1,8);;
	      l = maxc(0 | (8-strlen(temp)));
	      do while (l>0);
		" ";;
		l=l-1;
	      endo;
	    else;
	      print temp[1,1];;
	    endif;
	  if (cols(temp)>1) or (rows(temp)>1) or 
	    (type(temp)==13 and strlen(temp)>8);
	    "+";; 
	  else; 
	    " ";; 
	  endif;
	i = i+1;
	endo;
    j = j+1;
    endo;

    locate (firstx  + (cpos - halftherows*(cpos>halftherows))-1),
	   (firsty + (cpos > halftherows)*40);
    print "\027[7m"$+varget(menu_els[cpos,1])$+"\027[0m";;


endp;

proc (0) = drawdescr(menu_el, cpos, lineno);
    locate lineno, 1;
    scroll  lineno | 1 | lineno+3 | 80 | 4 | 7;
    print "\027[1m";;
    print varget( menu_el[cpos,2] );
    print "\027[0m";;
endp;


proc (1) = globmenukey(list, cpos);
    local keypress, column, maxrows, halftherows;
    call csrtype(0);
    halftherows = ceil(rows(list)/2);
    column      = 1 + (cpos <= halftherows);
    maxrows     = rows(list);

    keypress = 0;
    do while (keypress==0);
	keypress=key;
	if keypress==1072;      /* Up Arrow */
	    cpos = cpos - 1 + maxrows*(cpos==1);
	elseif keypress==1080;  /* Down Arrow */
	    cpos = cpos*(cpos/=maxrows) + 1;
	elseif keypress==1075;  /* Left Arrow */
	    cpos = cpos - halftherows*(cpos > halftherows)
			+ halftherows*(cpos <= halftherows);
	    if (cpos>maxrows); cpos = maxrows; endif;
	elseif keypress==1077;  /* Right Arrow */
	    cpos = cpos - halftherows*(cpos > halftherows)
			+ halftherows*(cpos <= halftherows);
	    if (cpos>maxrows); cpos = maxrows; endif;
	elseif keypress==27;    /* Hit ESC to Quit */
	    cpos = -1;
	elseif keypress==13;    /* Press Return to Select */
	    cpos = 0;
	elseif keypress==1071;  /* HOME key */
	    cpos = 1;
	elseif keypress==1079;  /* END key */
	    cpos = maxrows;
	elseif (keypress==114 or keypress==82);     /* R/r for reset */
	    cpos = 99;
	else;
	    keypress = 0;
	endif;
    endo;

    retp(cpos);
endp;

proc(0) = EditValue(menu_els, cpos);
    local newvalue, OldCursorType, errorMsg, temp, oldvalue, tv, tfmt, ktmp, 
	  answ;
    scroll 16|7|18|73|3|7;
    locate 17,10;
    OldCursorType = csrtype(2);

    ktmp = 5 + cols(zb) + cols(zw) - 2;
    
    temp = varget(menu_els[cpos,1]);
    if (varget(menu_els[cpos,1]) $== "_Ebounds");
      print "Would you like enter a matrix? \27[5m(Y/N)\27[0m";;
      answ = 0;
      do until (answ==78 or answ==110 or answ==89 or answ==121);
	answ=keyw;
      endo;
      if answ==78 or answ==110; 
	goto scalar;
      else;             
	{ newvalue, tv, tfmt } = medit( miss(ones(ktmp,2),1), 1, 1 );
	newvalue = packr(newvalue);
      endif;
    elseif (varget(menu_els[cpos,1]) $== "_EalphaB"); 
      if scalmiss(_EalphaB);
        { newvalue, tv, tfmt } = medit( miss(ones(cols(zb),2),1), 1, 1 );
      else;
        { newvalue, tv, tfmt } = medit( _EalphaB, 1, 1 );
      endif;
      newvalue = packr(newvalue);
    elseif (varget(menu_els[cpos,1]) $== "_EalphaW"); 
      if scalmiss(_EalphaW);
        { newvalue, tv, tfmt } = medit( miss(ones(cols(zw),2),1), 1, 1 );
      else;
        { newvalue, tv, tfmt } = medit( _EalphaW, 1, 1 );
      endif;
      newvalue = packr(newvalue);
    elseif (varget(menu_els[cpos,1]) $== "_Eeta");
      if rows(_Eeta)==1;
        print "Would you like enter a matrix? \27[5m(Y/N)\27[0m";;
        answ = 0;
        do until (answ==78 or answ==110 or answ==89 or answ==121);
	  answ=keyw;
        endo;
        if answ==78 or answ==110; 
	  goto scalar;
        else;             
          temp = _Eeta;
          if _Eeta==0; temp = _Eeta | miss(ones(3,1),1); endif; 
          { newvalue, tv, tfmt } = medit( temp, 1, 1 );
        endif;
      else;
          { newvalue, tv, tfmt } = medit( _Eeta, 1, 1 );
      endif;
    elseif (varget(menu_els[cpos,1]) $== "_EI_vc");
      temp = _EI_vc | miss(ones(maxc(18-rows(_EI_vc) | rows(_EI_vc)), 2), 1);
      { newvalue, tv, tfmt } = medit( temp, 1, 1 );
      newvalue = packr(newvalue);
    elseif (varget(menu_els[cpos,1]) $== "_Estval");
      helpkmedit();
      temp = _Estval;
      if (_Estval==1); temp = miss(ones(ktmp,1),1); endif;
      { newvalue, tv, tfmt } = medit( temp, 1, 1 );
    else;
      scalar:
      locate 17,10;
      print "Please enter the new value for ";;
      cgon;; "\027[1m";;
      print varget(menu_els[cpos,1]);;
      cgoff;; "\027[0m";;
      print ":   ";;
      newvalue = cons;
      if (strlen(newvalue)==0); goto end; endif;
      if (typecv(varget(menu_els[cpos,1])) /= 13);
	newvalue = stof(newvalue);
      endif;

    endif;
    
    oldvalue = varget(varget(menu_els[cpos,1]));
    call varput( newvalue, varget(menu_els[cpos,1]));

    errorMsg = EzIcheckinputs();
    if (errorMsg $/="");
      mainErrorMsg(errorMsg);
      call varput( oldvalue, varget(menu_els[cpos,1]));
    endif;

    end:
	call csrtype(OldCursorType);
	scroll 17 | 1 | 19 | 80 | 3 | 7;
endp;


/* Call checkinputs() in ei.src but first vput relevant data into _Eres
 *      (then remove them when done)
 * Warning: this proc uses global labels for basic quantities
 */
proc(1) = EzIcheckinputs();
local errorMsgStr, precheckEsel;
/* must vput "t", "x", "n", "Zb", and "Zw" and "truth" into _Eres first */
/* default to zw/b = 1 if no covars specified  */
  if (zBlabCV$/="");
    zB = mergevar(zBlabCV);
  else;
    zB = 1;
  endif;
  if (zWlabCV$/="");
    zW = mergevar(zWlabCV);
  else;
    zW = 1;
  endif;
  /* now vput the labels into _Eres */
  _Eres = vput( _Eres, varget(tlab), "t" );
  _Eres = vput( _Eres, varget(xlab), "x" );
  _Eres = vput( _Eres, varget(nlab), "n" );
  _Eres = vput( _Eres, zB, "Zb" );
  _Eres = vput( _Eres, zW, "Zw" );
  if (trBlab /= 0 and trWlab /= 0);
    _Eres = vput(_Eres, varget(trBlab)~varget(trWlab), "truth");
  endif;
  precheckEsel = _Eselect;
  if (type(_Eselect)==13);  /* if default 1 is now a variable name */
    _Eselect = varget(_Eselect); 
  endif;

  errorMsgStr = checkinputs();

  
  _Eselect = precheckEsel;
  /* now must vget "t", "x", "n", "Zb", and "Zw" and "truth" from _Eres */
  { temp, _Eres } = vget( _Eres, "t" );
  { temp, _Eres } = vget( _Eres, "x" );
  { temp, _Eres } = vget( _Eres, "n" );
  { temp, _Eres } = vget( _Eres, "Zb" );
  { temp, _Eres } = vget( _Eres, "Zw" );
  if (trBlab /= 0 and trWlab /= 0);
    { temp, _Eres } = vget( _Eres, "truth" );
  endif;

  retp(errorMsgStr);
endp;


proc(1) = confirmReset();
    local oldcsr, k;
    oldcsr = csrtype(0);
    locate 16,19;
    print "\27[31;1mAre you sure you want to reset the globals?";
    locate 17,18;
    print "This resets \27[33mall\27[31m globals (both EI and EIgraph).";
    locate 18,24;
    print "\27[33;5mY to confirm, any other key to exit\27[0m";
    k = 0;
    do until (k /= 0); k = key; endo;
    call csrtype(oldcsr);
    scroll 16|1|18|80|3|7;
    if (k==121 or k==89); retp(1); else; retp(0); endif;
endp;


proc(0) = drawVarNamelist( varnameMat, cpos );

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
	if (2 == i%3); printrow = printrow + 1; endif;
	i = i+1;
    endo;
endp;


/* input screen for selecting a variable to be the indicator variable
 * for _Eselect.  Clears the screen and lets user cursor through vars
 * and select one of them.  Returns the variable name if one is selected
 * otherwise return scalar 0
 */
proc(1) = assignESelect( varnStr );
    local m_bottom, keyPressed,
	  varlistCV, cursorPosition, ESstartval;

    m_bottom = "\27[44;1m\27[D       "$+chrs(29)$+chrs(18)$+
	       ": Move             ENTER: Select         "$+
	       "ESC: Return to Globals Menu  \27[40m";

    call csrtype(0);

    scroll 2|1|18|80|17|7;
    locate 3,23;
    "\27[1mSelect a variable for "$+cgon$+"_Eselect\27[0m";;
    locate 25,1; m_bottom;;

    /* make varlist a vector of varnames and tag status */
    varlistCV = getVarList(varnStr);

    ESstartval = _Eselect;
    cursorPosition = 1;
    entryloop:
    keyPressed = 0;
    do while (keyPressed /= 27);    /* the escape key */
	drawEselectvarlist( varlistCV, cursorPosition );
    /* this fn is in specify.prg */
    { cursorPosition, keyPressed } =
	    wrappedMoveCurs( cursorPosition, rows(varlistCV), 3 );
	if (keyPressed == 13); /* enter */
	    _Eselect = cvtos(varlistCV[cursorPosition]);
	if ismiss( miss( (varget(_Eselect).==1
	  .or varget(_Eselect).==0), 0 ));
	  "\27[1;31m";;
	  center(18,"*** Error: _Eselect must be only 1's and 0's ***");
	  "\27[0m";;
	  _Eselect = ESstartval;
	  wait;
	    endif;
	break;
	endif;
    endo;

    scroll 2|1|18|80|17|7;
    retp(_Eselect);
endp;


proc(0) = drawEselectvarlist( varnameCV, cpos );
    local printrow, printcol, printincrm, i, r, c;
    printrow = 8;
    printcol = 14;
    printincrm = 17;

    i = 0;
    do while ( i < rows(varnameCV));
	r = printrow;
	c = printcol + printincrm*(i%3);
	locate r, c;
	if (i+1 == cpos); "\027[7m";; endif;
	format 8,0; "\027[1m";; $varnameCV[i+1];; "\027[0m";;
	if (2 == i%3); printrow = printrow + 1; endif;
	i = i+1;
    endo;
endp;


proc(0) = helpkmedit();
    cls;
endp;


proc(3) = medit(x, dummy1, dummy2);
    local mrows, mcols, newval, varn, currxpos, currypos;
    local tmpv, titleStr, globalMat, origx, tempxpos;
    cls;
    origx = x;
    mrows = rows(x);
    mcols = cols(x);
    format 1,0;
    tmpv = 0;

    currxpos = 1;
    currypos = 1;
    meditdrawmat(x, currxpos, currypos);

    do until ( currxpos < 0 );                  /* ESC to exit */
        tempxpos = currxpos;	
	if tmpv;
            x[currxpos,currypos] = tmpv;
            tmpv = 0;
        endif;
        meditdrawmat(x, currxpos, currypos);
	{currxpos, currypos} = meditmenukey(x, currxpos, currypos);
	if (currxpos==0);                     /* ENTER to edit */
	  currxpos = tempxpos;
	  tmpv = mEditValue( x, currxpos, currypos );
	elseif (currxpos==99);                /* RESET was chosen */
	    if (confirmReset()); 
	        x = origx;
	    endif;
	endif;
    endo;

    cls;
    retp(x, dummy1, dummy2);
endp;



proc (0) = meditdrawmat(m_el, currxpos, currypos);
    local m_top, m_bottom, halfline, i, j, pmask, pfmt, temp, halftherows,
	  label;

    m_top    = main_top;    /**** global ****/

    m_bottom = "\27[44m\27[D"$+chrs(29)$+chrs(18)$+
	       ": Move                    ENTER: Edit Cell           "$+
	       "ESC: Return to Main Menu\27[40m";
    halfline="컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴";

    cls;

    call csrtype(0);
    if m_top$/="";
	scroll w1;
	locate 1,2;
	print m_top;
	locate 2,1;"          ";
    endif;

    locate 3,30; 
    print "\27[1m";;
    center(3, "Matrix Editor");;
@    center(4,"Please enter a " mrows " x " mcols " matrix:");; ?;
	"\27[0m";@

    meditdrawmel(m_el, currxpos, currypos);

    locate 20,1;
    /*print $halfline;;$halfline;;*/
    if m_bottom$/="";
	scroll w4;
	locate 25,2;
	print "\27[1m"$+m_bottom$+"\27[0m";;
    endif;

    /*
    locate 18,70; currxpos;
    locate 19,70; currypos;
    */
endp;


proc(0) = meditdrawmel(menu_els, xpos, ypos);
    local i, j, halftherows, temp, label, l, cellwidth;

    locate 4+(rows(menu_els)==1),1;
    cellwidth = 8;
    format cellwidth, 4;
    menu_els;
    locate 4+xpos, (cellwidth * ypos)-cellwidth+(ypos);
    print "\027[7m";;
    menu_els[xpos,ypos];;
    print "\027[0m";;
endp;

proc(1) = mEditValue( x, xpos, ypos );

    local newval, cellwidth, OldCursorType;
    OldCursorType = csrtype(2);

    cellwidth = 8;
    locate 4+xpos, (cellwidth * ypos)-cellwidth+(ypos);
    print "\027[7m";;
    "        ";
    print "\027[0m";;

    locate 4+xpos, (cellwidth * ypos)-cellwidth+(ypos);
    newval = con(1,1);
        
    call csrtype(OldCursorType);
    retp(newval);
endp;

proc (2) = meditmenukey(matr, currrow, currcol);
    local keypress;
    call csrtype(0);

    keypress = 0;
    do while (keypress==0);
	keypress=key;
	if keypress==1072;      /* Up Arrow */
	    if currrow /= 1;
	        currrow = currrow - 1;
	    endif;
	elseif keypress==1080;  /* Down Arcol */
	    if currrow /= rows(matr);
	        currrow = currrow + 1;
	    endif;
	elseif keypress==1075;  /* Left Arcol */
	    if currcol /= 1;
	        currcol = currcol - 1;
	    endif;
	elseif keypress==1077;  /* Right Arcol */
	    if currcol /= cols(matr);
	        currcol = currcol + 1;
	    endif;
	elseif keypress==27;    /* Hit ESC to Quit */
	    currrow = -1;
	elseif keypress==13;    /* Press Return to Select */
	    currrow = 0;
	elseif keypress==1071;  /* HOME key */
	    currrow = 1;	    
	    currcol = 1;
	elseif keypress==1079;  /* END key */
	    currrow = rows(matr);	    
	    currcol = cols(matr);
/*	elseif (keypress==114 or keypress==82);     /* R/r for reset */
	    currrow = 99; */
	else;
	    keypress = 0;
	endif;
    endo;

    /*
    locate 18,50; "currrow";
    locate 19,50; "currcol";
    locate 18,60; currrow;
    locate 19,60; currcol;
    */

    retp(currrow, currcol);
endp;



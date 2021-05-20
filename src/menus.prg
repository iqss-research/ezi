
#include menus.h;

/* **********************************************************************
*   drawmenu() draws the given menu and supporting screen attributes.
*
*   USAGE:
*   drawmenu(m_name,m_el,m_top,m_bottom,m_r,m_c,m_step,m_fmt); or
*   call drawmenu(m_name,m_el,m_top,m_bottom,m_r,m_c,m_step,m_fmt);
*
*   DEFN:
*   m_name  = string containing menu column names to be printed at 4,1
*   m_el    = matrix of element names or titles to be printed
*   m_top   = string to be printed across window w1
*   m_bottom = string to be printed across window w4
*   m_r     = top (or starting) screen row
*   m_c     = left-most screen column
*   m_step  = # of columns from start of element to start of next element
*   m_fmt   = format used to print out elements in call to movecurs()
*
************************************************************************/
proc (0) = drawmenu(m_name,m_el,m_top,m_bottom,m_r,m_c,m_step,m_fmt, sd);
    local m_mask, i, j, line1, line2;
    call csrtype(0);
    if m_top$/="";
        scroll w1;
        locate 1,1;
        print m_top;
    endif;
    scroll w2;
    locate 2,1;
    print m_name;
    m_mask={ 0 };
    i=1;
    do while (i <= minc(11|rows(M_el)));
        j = 1;
        do while j<=cols(m_el);
            locate m_r+i-1,m_c+(j-1)*m_step;
            call printfm(m_el[i-1+sd[j],j],m_mask,m_fmt);
            j = j+1;
        endo;
        i = i+1;
    endo;

    locate m_r+12-1, m_c+(3-1)*m_step; darrow;;
    locate m_r+12-1, m_c+(4-1)*m_step; darrow;;

    scroll w3;
    locate 20,1;
    line1 = "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴";
    line2 = "컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴";
    print $line1;;$line2;;
    locate 21,49; "�";
    locate 22,49; "�";
    locate 23,49; "�";
    locate 24,49; "�";
    if m_bottom$/="";
        locate 25,1;
        print m_bottom;;
    endif;
endp;

/* **********************************************************************
*   menukey() takes the max number of rows and columns in a menu, waits
*   for a keypress, and then returns a code for the category of key
*   pressed and, if appropriate, the new row and column of the menu cursor.
*
*   USAGE:
*   { code, newrow, newcol } = menukey(maxrows, maxcols, oldrow, oldcol);
*
*   DEFN:
*   code    = -1 if ESC, 0 if ENTER, 1 if ARROW, or KEY if anything else
*   newrow  = row of menu selection
*   newcol  = column of menu selection
*   maxrows = vector containing max # of rows in each column
*   maxcols = scalar value of max # of columns
*   oldrow  = old menu row
*   oldcol  = old group or menu column
*
************************************************************************/
proc (5) = menukey(maxrows, maxcols, row, col, cursorrow, start_display_el);
    local keypress, firstkeyindex;

    format 2,0;

    call csrtype(0);
    keypress=0;
    do until keypress;
        keypress=key;
    endo;
    if keypress==1072;      /* Up Arrow */
        if maxrows[col] > 11;
            if (row /= 1);
                if (start_display_el[col] /= 1 and cursorrow == 1);

                    start_display_el[col] = start_display_el[col] - 1;
                else;
                    cursorrow = cursorrow - 1;
                endif;
                row = row - 1;
            endif;
        else;
            row=round((row-1)%maxrows[col]);
            row=(row==0).*maxrows[col] + row;
            cursorrow = row;
        endif;
        retp(1, row, col, cursorrow, start_display_el);


    elseif keypress==1080;  /* Down Arrow */
        if maxrows[col] > 11;
            if (row /= maxrows[col]);
                if (start_display_el[col] /= maxrows[col]-(11-1) and
                                                    cursorrow == 11);
                    start_display_el[col] = start_display_el[col] + 1;
                else;
                    cursorrow = cursorrow + 1;
                endif;
                row = row + 1;
            endif;
        else;
            row=round((row+1)%maxrows[col]);
            row=(row==0).*maxrows[col] + row;
            cursorrow = row;
        endif;
        retp(1, row, col, cursorrow, start_display_el);

    elseif keypress==1075;  /* Left Arrow */
        col=round((col-1)%maxcols);
        col=(col==0).*maxcols + col;
        row = start_display_el[col] + cursorrow - 1;
        if (row > maxrows[col]);
            row       = maxrows[col];
            cursorrow = maxrows[col];
        endif;
        retp(1, row, col, cursorrow, start_display_el);

    elseif keypress==1077;  /* Right Arrow */
        col=round((col+1)%maxcols);
        col=(col==0).*maxcols + col;
        row = start_display_el[col] + cursorrow - 1;
        if (row > maxrows[col]);
            cursorrow = maxrows[col];
            row       = maxrows[col];
        endif;
        retp(1, row, col, cursorrow, start_display_el);

    elseif keypress==1079;  /* END key */
        row = maxrows[col];
        cursorrow = minc(maxrows[col] | 11);
        start_display_el[col] = maxc( 1 | maxrows[col]-(11-1));
        retp(1, row, col, cursorrow, start_display_el);
    elseif keypress==1071;  /* HOME key */
        row = 1;
        cursorrow = 1;
        start_display_el[col] = 1;
        retp(1, row, col, cursorrow, start_display_el);

    elseif keypress==1081;  /* PgDn key */
        if (cursorrow /= 11);   /* if cursor not at displayed list bottom */
            row = minc( maxrows[col] | row + 11 - cursorrow );
            cursorrow = minc( maxrows[col] | 11 );
        else;
            row = minc(row + 11 | maxrows[col]);
            start_display_el[col] = minc( start_display_el[col] + 11 |
                                          maxrows[col] - 11 + 1 );
            if (start_display_el[col] > maxrows[col]);
                start_display_el[col] = 1;
            endif;

        endif;
        retp(1, row, col, cursorrow, start_display_el);

    elseif keypress==1073;  /* PgUp key */
        if (cursorrow /= 1);    /* if cursor not at displayed list top */
            row = maxc( 1 | row - cursorrow + 1 );
            cursorrow = 1;
        else;
            row = maxc( 1 | row - 11 );
            start_display_el[col] = maxc( start_display_el[col] - 11 | 1 );
        endif;
        retp(1, row, col, cursorrow, start_display_el);

    elseif keypress==27;    /* Hit ESC to Quit */
        retp(-1,row,col, cursorrow, start_display_el);

    elseif keypress==13;    /* Press Return to Select */
        retp(0,row,col, cursorrow, start_display_el);
      
    elseif (keypress==95 or (keypress>=65 and keypress<=90) or 
	(keypress>=97 and keypress<=122));   /* first-letter key shortcut */

	firstkeyindex = getAlphaRow( chrs(keypress), main_elm[.,col]);
	if firstkeyindex == -1 or (col/=3 and col/=4);
	  retp(keypress,row,col, cursorrow, start_display_el);
	else;
	  cursorrow = 1;
	  row = firstkeyindex;
	  start_display_el[col] = minc( firstkeyindex |
	                                maxrows[col] - 11 + 1 );
	  if (firstkeyindex > (maxrows[col] - 11 + 1));
	     cursorrow = maxrows[col] - firstkeyindex + 1; 
	  endif;

          retp(1, row, col, cursorrow, start_display_el);
        endif;
	  
    else;
        retp(keypress,row,col, cursorrow, start_display_el);
    endif;
    "Error in menukey branching!"; stop;  
endp;


/* **********************************************************************
*   m1Vget() takes a vector of vectors (each of which contain strings
*   representing variables with values) and returns the value (using varget)
*   of the string/variable j in vector i.
*
*   USAGE:
*   element = m1Vget(p_array,i,j);
*
*   DEFN:
*   element = value of string/variable j in array i of p_array
*   p_array = 1xm array of 1xn arrays
*   i       = pointer to array in p_array
*   j       = pointer to string/variable in array i
*
************************************************************************/
proc (1) = m1Vget(p_array,i,j);
    local tmp1;
    tmp1=varget(p_array[i]);
    retp(varget(tmp1[j]));
endp;


/*
 *   m_el    = matrix of element names or titles to be printed
 *   m_r     = top (or starting) screen row
 *   m_c     = left-most screen column
 *   m_step  = # of columns from start of element to start of next element
 *   fmt     = format used to print out elements
 *   m_str   = matrix of pointers to strings printed in window w3
 *   orow    = old menu row
 *   ocol    = old group or menu column
 *   nrow    = new menu row
 *   ncol    = new group or menu column
 */
proc (0) = movecurs(m_el,m_r,m_c,m_step,fmt,m_str,orow,ocol,nrow,ncol,
                    cursrow, stdispl, maxrows);
    local mask, s, i;
    mask  = { 0 };

    /* print old column in normal text */
    i = 1;
    do while (i <= minc(maxrows[ocol] | 11));
        locate m_r+(i-1), m_c+(ocol-1)*m_step;
        call printfm( m_el[stdispl[ocol]+i-1, ocol], mask, fmt);
        i = i+1;
    endo;

    /* now reverse video the cursor position */
    locate m_r+(cursrow-1), m_c+(ncol-1)*m_step;
    print "\27[7m";;
    call printfm( m_el[nrow,ncol], mask, fmt);
    print "\27[0m";;

    /* display up-more and down-more as needed */
    locate m_r-1, m_c+(ncol-1)*m_step;
    if (stdispl[ncol] > 1);                     /* draw up arrow */
        print uarrow;;
    else;
        print "        ";;
        @print "\27[1m컴컴�\27[0m";;@
    endif;
    locate m_r+11, m_c+(ncol-1)*m_step;
    if (stdispl[ncol] <= maxrows[ncol] - 11);    /* draw down arrow */
        print darrow;;
    else;
        print "        ";;
    endif;

    /* show message associated with each menu choice */
    let s = 21 1 24 48 4 7;
    scroll s;
    if m_str[1,1]/=0;
        locate 21,1;
        print "\27[1m";;
        print m1Vget(m_str,ncol,nrow);;
        print "\27[0m";;
    endif;
endp;

proc(0) = scrollmenus(m_r, m_c, ncol, ocol, nrow, orow,
                        mask, fmt, m_el, m_step);
    locate m_r+(orow-1), m_c+(ocol-1)*m_step;  /* print old in normal */
    call printfm( m_el[orow,ocol], mask, fmt );
    locate m_r+(nrow-1), m_c+(ncol-1)*m_step;  /* print new in inverse */
    printdos "\27[7m";
    call printfm( m_el[nrow,ncol], mask, fmt );
    printdos "\27[0m";
endp;

    ss1 = "New Session       ";
    ss2 = "Read ASCII file   ";
    ss3 = "Loaded data buffer";
    ss4 = "Chose a new model ";
    ss5 = "Ran a new model   ";
    ssVec = { ss1 ss2 ss3 ss4 ss5 };

proc(0) = drawstatus( statusVec );
    local s, statusMsgStr;
    let s = 21 51 24 80 4 7;
    call csrtype(0);
    scroll s;
    locate 21,50;
    print "\27[33;1mWorking File:\27[37m "$+workingFile;;
    print padMessages(workingFile,17);;
    locate 22,50;
    print "\27[33;1mSource Type: \27[37m "$+workingFileType;;
    print padMessages(workingFileType,17);;
    locate 23,50;
    print "                               ";;
    locate 24,50;
    print "\27[33;1mStatus:  \27[32m";;
    statusMsgStr = varget( ssVec[maxindc(statusVec)] );
    print "\27[37m";;
    statusMsgStr;;
    print "\27[40;0m";;
endp;

proc(1) = padMessages( str, totalLength );
    local padAmount, padString;
    padAmount = totalLength - strlen(str);
    padString = "";
    do while (padAmount > 0);
        padString = padString $+ " ";
        padAmount = padAmount - 1;
    endo;
    retp(padString);
endp;

proc(1) = getEIitem( menuMat, mrow, mcol );
    local itemStr;
    itemStr = menuMat[ mrow, mcol ];
    itemStr = strsect( itemStr, 1,
                       maxc( strindx(itemStr, " ", 1)-1 |
                             (not strindx(itemStr," ", 1))*strlen(itemStr)));
    /* check for truncated items */
    if     (itemStr $== "tomoCI95"); itemStr = "tomogCI95";
    elseif (itemStr $== "expvrcis"); itemStr = "expvarcis";
    elseif (itemStr $== "_EmaxItr"); itemStr = "_EmaxIter";
    elseif (itemStr $== "Palmquis"); itemStr = "Palmquist"; endif;
    retp(itemStr);
endp;

/* take a single character and a character vector and return the index
 * for the char vector of the first item whose first letter matches
 * the single character.
 * 
 * letterKey is a one-chracter string
 * CharVector is an arbitrarily long character vector
 */
proc (1) = getAlphaRow( letterKey, CharVector );
  local location, vecrows, i, firstletter;
  vecrows = rows(CharVector);
  i = 1;
  /* "letterKey = " letterKey; ?; */
  do while (i <= vecrows);
    firstletter  = stocv(lower(strsect(CharVector[i],1,1)));
    /* print "firstletter[";; i;; "] = ";; $firstletter; */
    if letterKey $== firstletter;
      retp(i);
    endif;
    i = i+1;
  endo;
  retp(-1);
endp;

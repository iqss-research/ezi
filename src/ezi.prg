/**********  EzI  --  main program code
 **********
 **********  MS-DOS stand-alone version of Gary King's EI gauss library
 **********
 **********  written by Kenneth Benoit
 **********  EI library by Gary King
 **********
 **********  (c) 1996-1998
 **********
 **************************************************************************/


#include startrun.prg

doswin;
cls;
format /rd 8,2;
library ei, cml, pgraph;


#lineson

/* included code.  note that the order matters since specify.prg, 
   ioutils.prg, and eiglob.prg call some fns in each other. */
   
#include globals.h;     /* some globally defined variables */
#include menus.prg;     /* menu procs */
#include specify.prg    /* specify model routines */
#include helpinfo.prg   /* help screens, manual, info, about, etc. */
#include ioutils.prg;   /* I/O routines for reading/writing files */
#include eiglob.prg;    /* global value editing/display subroutines */
#include export.prg


/*
medit( miss(ones(1,3),1), 1, 1 );


    print "\027[0m";;
stop;

saveall ezi;


use ezi;
*/

clear tempf, tempv, truthtemp;

screen on;

menu_row=zeros(10,1);
menu_col=zeros(10,1);
menu_cod=zeros(10,1);
menu_don=zeros(10,1);
orow=1;
ocol=1;
menu_idx=1;
menu_row[menu_idx]=1;
menu_col[menu_idx]=1;
menu_don[menu_idx]=0;

status =  { 1,      /* toggle for Just Started */
            0,      /* toggle for AsciiFileRead */
            0,      /* toggle for databuffer read */
            0,      /* toggle for ModelSpecified */
            0 };    /* toggle for New Model run */


/* for handling of long menu scrolls */
start_display_el = ones(main_mxc,1);
cursrow = 1;

call AboutEIScreen();          /* show the "welcome" screen */

menuloop:

drawmenu(main_nam,main_elm,main_top,main_bot,main_row,main_col,main_stp,
         main_fmt, start_display_el);

movecurs(main_elm,main_row,main_col,main_stp,main_fmt,main_str,orow,ocol,
         menu_row[menu_idx],menu_col[menu_idx], cursrow, start_display_el,
         main_mxr );
drawstatus(status);

if truthtemp/=0;
    truthtemp = "     Sorry, you must first provide \27[34mtruth\27[33m for this graph.";
	mainErrorMsg(truthtemp);
    truthtemp=0;   
endif;

do while (menu_don[menu_idx]==0);   /* main menu loop */
    orow=menu_row[menu_idx];
    ocol=menu_col[menu_idx];
    var_code=0;
    _cntrnc0=1;
    { menu_cod[menu_idx], menu_row[menu_idx], menu_col[menu_idx],
                                     cursrow, start_display_el } =
       menukey(main_mxr, main_mxc, menu_row[menu_idx], menu_col[menu_idx],
            cursrow, start_display_el );

    if (menu_cod[menu_idx] == 1);
        movecurs(main_elm,main_row,main_col,main_stp,main_fmt,main_str,
                 orow, ocol, menu_row[menu_idx], menu_col[menu_idx],
                 cursrow, start_display_el,
                 main_mxr );
    elseif (menu_cod[menu_idx] == -1);  /* ESC was pressed to exit */
        if (exitConfirm()); ndpclex; cls; end; endif;

    elseif (menu_cod[menu_idx] == 0);   /* ENTER was pressed */

        colChosen = menu_col[menu_idx];
        rowChosen = menu_row[menu_idx];

        /* ***************************************
         *  These are the branches for selected  *
         *             menu choices              *
         *************************************** */

        if (colChosen == 1);       /*-------- FILE MENU */

            if (rowChosen == 1);       /* read ascii data */
                
		clear tempf, tempv;
		{ tempf, tempv } = readAsciiFile();
		if (tempf $/= "<none>");
		  call eiset();
	          workingFile = tempf;
                  varsinMem = tempv;	  
		  status = { 0, 1, 0, 0, 0 };
		endif;  
                drawstatus(status);

	      elseif (rowChosen == 2 );   /* load a data buffer */
                
		{ tempf, tempd } = loadDataBuf();
                if (tempf $== "<none>");
		  clear tempf, tempd;
		else;
		  clearGlobals(varsinMem);
		  workingFile = tempf;
		  genericDbuf = tempd;
		  clear tempf, tempd;
 		  status = { 0, 0, 1, 0, 0 };
		    
		    /* if the dbuf from file contains variable labels
                   (it would not if the dbuf comes from the library EI
                    version, although every dbuf created by EzI has them */
		    if strindx( cvtos(vnamecv(genericDbuf)), "nlab", 1);

		   /* now vget the labels from the dbuf */
		   { tlab, genericDbuf }   = vget( genericDbuf, "tlab" );
		   { xlab, genericDbuf }   = vget( genericDbuf, "xlab" );
		   { nlab, genericDbuf }   = vget( genericDbuf, "nlab" );
		   { vlab, genericDbuf }   = vget( genericDbuf, "vlab" );
		   { zBlabCV, genericDbuf }  = vget( genericDbuf, "zBlabCV" );
		   { zWlabCV, genericDbuf }  = vget( genericDbuf, "zWlabCV" );
		   { trBlab, genericDbuf } = vget( genericDbuf, "trBlab" );
		   { trWlab, genericDbuf } = vget( genericDbuf, "trWlab" );
		   { klabCV, genericDbuf } = vget( genericDbuf, "klabCV" );
		   { keepMat, genericDbuf } = vget( genericDbuf, "keepMat" );

                    /* now varput data into the vars in specifier labels */
		    if (vlab/=0);
		      { v, genericDbuf }      = vget( genericDbuf, "v" );
		      call varput( v, vlab );
		    endif;
		    call varput( eiread(genericDbuf, "t"), tlab );
                    call varput( eiread(genericDbuf, "x"), xlab );
                    call varput( eiread(genericDbuf, "n"), nlab );
		    if (zBlabCV /= 0);
                        zb = eiread(genericDbuf, "Zb");
                        i = 1;
                        do while (i <= cols(zb));
                            call varput( zb[.,i], zBlabCV[i] );
                            i = i+1;
                        endo;
                    endif;
                    if (zWlabCV /= 0);
                        zw = eiread(genericDbuf, "Zw");
                        i = 1;
                        do while (i <= cols(zw));
                            call varput( zw[.,i], zWlabCV[i] );
                            i = i+1;
                        endo;
                    endif;
                    if (keepMat /= 0);
                        i = 1;
                        do while (i <= cols(keepMat));
                            call varput( keepMat[.,i], klabCV[i] );
                            i = i+1;
                        endo;
                    endif;
                    if (trBlab /= 0 and trWlab /= 0);
                        call varput( eiread(genericDbuf,"truthB"), trBlab );
                        call varput( eiread(genericDbuf,"truthW"), trWlab );
                    endif;

                    /* now make a string VarsInMem of all var names */
                    varsinMem = tlab | xlab | nlab | vlab | zBlabCV |
                                zWlabCV | trBlab | trWlab | klabCV;
                    varsinMem = packr(miss( varsinMem, 0 ));
                    varsinMem = unique( varsinMem, 0 );
                    varsinMem = makeVarList( varsinMem );

                    status[2:4] = status[2:4] + 1;
                else;
                    loadednovarDbufmsg();
                endif;
                endif;
                drawstatus(status);
	      
	    elseif (rowChosen == 3);   /* stats on data */
                if (varsinMem $/= "");
                    call showStats( varsinMem );
                else;
                    mainErrorMsg(
                    "You must first load some variables into memory." );
                endif;

            elseif (rowChosen == 4);   /* call l.com to view text files */
                call csrtype(1); cls; dos l.com; call csrtype(0);

            elseif (rowChosen == 5);   /* build the export database */

	      if (status[3] or status[5]);
		cls;
		ExportMain( varsinMem, genericDbuf );
	      else;
		mainErrorMsg(
		"You must first have a data buffer in memory.");
	      endif;
	    
            elseif (rowChosen == 6);   /* exit to DOS */
                call csrtype(1); cls; dos; call csrtype(0);
	      
	    endif;
            goto menuloop;

        elseif (colChosen == 2);   /*-------- RUN MODEL menu  */


	  if (rowChosen == 2);       /* edit EI globals */

                if (status[4]);
 		    call doEditMenu("eiglobs", varsinMem);
		else;
		    mainErrorMsg("You must first specify a model"$+
		                 " (Config needs t, x, and n).");
		endif;



	      elseif (rowChosen == 5);   /* replicate a data buffer */
					    
		cls;
		"\27[1;31m";;
		center(8,"This will re-estimate a model from a"$+
		" data buffer which you will load.");
		center(10,"*** ESC to exit, any other key to"$+
		" continue. ***");
		"\27[0m";;
		if (27==keyw); goto menuloop; endif;

		{ tempf, tempd } = loadDataBuf();
                if (tempf $== "<none>");
		  clear tempf, tempd;
		else;
		  clearGlobals(varsinMem);
		  workingFile = tempf;
		  genericDbuf = tempd;
		  clear tempf, tempd;
 		  status = { 0, 0, 1, 0, 0 };

		    _Eprt = 2;
		    tempOutputFile = "00000000.tmp";
		    output file = ^tempOutputFile reset;
		    genericDbuf = eirepl(genericDbuf);
		    output off;
		    viewOrSave( tempOutputFile );

		    /* if the dbuf from file contains variable labels
                   (it would not if the dbuf comes from the library EI
                    version, although every dbuf created by EzI has them */
		    if strindx( cvtos(vnamecv(genericDbuf)), "tlab", 1);

		   /* now vget the labels from the dbuf */
		   { tlab, genericDbuf }   = vget( genericDbuf, "tlab" );
		   { xlab, genericDbuf }   = vget( genericDbuf, "xlab" );
		   { nlab, genericDbuf }   = vget( genericDbuf, "nlab" );
		   { zBlabCV, genericDbuf }  = vget( genericDbuf, "zBlabCV" );
		   { vlab, genericDbuf }   = vget( genericDbuf, "vlab" );
		   { zWlabCV, genericDbuf }  = vget( genericDbuf, "zWlabCV" );
		   { trBlab, genericDbuf } = vget( genericDbuf, "trBlab" );
		   { trWlab, genericDbuf } = vget( genericDbuf, "trWlab" );
		   { klabCV, genericDbuf } = vget( genericDbuf, "klabCV" );
		   { keepMat, genericDbuf } = vget( genericDbuf, "keepMat" );


                    /* now varput data into the vars in specifier labels */

		    if (vlab/=0);
		      { v, genericDbuf }      = vget( genericDbuf, "v" );
		      call varput( v, vlab );
		    endif;
                    call varput( eiread(genericDbuf, "t"), tlab );
                    call varput( eiread(genericDbuf, "x"), xlab );
                    call varput( eiread(genericDbuf, "n"), nlab );
                    if (zBlabCV /= 0);
                        zb = eiread(genericDbuf, "Zb");
                        i = 1;
                        do while (i <= cols(zb));
                            call varput( zb[.,i], zBlabCV[i] );
                            i = i+1;
                        endo;
                    endif;
                    if (zWlabCV /= 0);
                        zw = eiread(genericDbuf, "Zw");
                        i = 1;
                        do while (i <= cols(zw));
                            call varput( zw[.,i], zWlabCV[i] );
                            i = i+1;
                        endo;
                    endif;
                    if (keepMat /= 0);
                        i = 1;
                        do while (i <= cols(keepMat));
                            call varput( keepMat[.,i], klabCV[i] );
                            i = i+1;
                        endo;
                    endif;
                    if (trBlab /= 0 and trWlab /= 0);
                        call varput( eiread(genericDbuf,"truthB"), trBlab );
                        call varput( eiread(genericDbuf,"truthW"), trWlab );
                    endif;

                    /* now make a string VarsInMem of all var names */
                    varsinMem = tlab | xlab | nlab | zBlabCV |
                                zWlabCV | trBlab | trWlab | klabCV;
                    varsinMem = packr(miss( varsinMem, 0 ));
                    varsinMem = unique( varsinMem, 0 );
                    varsinMem = makeVarList( varsinMem );

		    DbufFilename = getFilenameRoot(workingFile);
		    call csrtype(2);
                    DbufFilename = getDbufFilename( DbufFilename );
                    call csrtype(0);
                    save ^DbufFilename = genericDbuf;
                    workingFile = DbufFilename$+".FMT";
                    status[5] = maxc(status) + 1;
                    drawstatus(status);
                else;
                    loadednovarDbufmsg();
                endif;

                endif;
                drawstatus(status);

	      
	    elseif (rowChosen == 4);   /* Run EI2 */

		if ( preEIwarning(tlab, xlab, nlab, zBlabCV, zWlabCV) or
                     (not status[4]) );
                    mainErrorMsg("You must first specify a model.");
                    continue;
		elseif (vlab==0);  
		  mainErrorMsg("    You must first assign "$+cgon$+"V"$+
		               "\27[33;1m before running EI2.");
		  continue;
		else;

		  cls;
		  "\27[1;31m";;
		center(8,"This will estimate a second stage model for the dbuf in memory.");
   	          center(10,"*** ESC to exit, any other key to"$+
		  " continue. ***");
		  "\27[0m";;
		  if (27==keyw); goto menuloop; endif;
		  		  
		    cls;
                    /* _Esims = 10; */

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

                    if (klabCV/=0); keepMat = mergevar(klabCV);
                    else; keepMat = 0;
                    endif;

                    /* now vput the labels into _Eres */
                    _Eres = vput( _Eres, tlab, "tlab" );
                    _Eres = vput( _Eres, xlab, "xlab" );
                    _Eres = vput( _Eres, nlab, "nlab" );
                    _Eres = vput( _Eres, vlab, "vlab" );
		    _Eres = vput( _Eres, varget(vlab), "v" );
                    _Eres = vput( _Eres, zBlabCV, "zBlabCV" );
                    _Eres = vput( _Eres, zWlabCV, "zWlabCV" );
                    _Eres = vput( _Eres, trBlab, "trBlab" );
                    _Eres = vput( _Eres, trWlab, "trWlab" );
                    _Eres = vput( _Eres, keepMat, "keepMat" );
                    _Eres = vput( _Eres, klabCV, "klabCV" );
		    _Eres = vput( _Eres, titl, "titl");

		    if (vlab/=0 and v==0); 
			 { v, genericDbuf }      = vget( genericDbuf, "v" );
			 call varput( v, vlab );
		    endif;

		    _Eprt = 2;
		    tempOutputFile = "00000000.tmp";
		    output file = ^tempOutputFile reset;
		    genericDbuf = ei2( v, genericDbuf,
                                       zB, zW );
		    output off;
		    viewOrSave( tempOutputFile );
		    cls;
		    locate 16,10;
		    "Now please enter a name under which to save this ";;
		    "data buffer.";?;?;
		    DbufFilename = getFilenameRoot(workingFile);
		    call csrtype(2);
                    DbufFilename = getDbufFilename( DbufFilename );
                    call csrtype(0);
                    save ^DbufFilename = genericDbuf;
                    workingFile = DbufFilename$+".FMT";

                    scroll 14|1|25|80|10|7;
		    locate 16,1;
                    " You may also wish to save the meta data-buffer ";;
		    "which contains the four imputed";
		    " data buffers from this run.  Please enter a name under ";;
		    "which to save this data";
 		    " buffer, or just press <ENTER> to skip."; ?;?;
		    call csrtype(2);
		    tmpFilename = "";
                    tmpFilename = getDbufFilename( tmpFilename );
                    call csrtype(0);
		    if (tmpFilename$/="");
		      save ^tmpFilename = _EI2_MTA;
		    endif;
		    
		    statusMessage = "Ran EI2 estimation";
                    workingFileType = "Data buffer (EI2)";
                    status[5] = maxc(status) + 1;
                    drawstatus(status);
                endif;

	      elseif (rowChosen == 1);   /* specify a new model */
                if (status[2] or status[3]);
                    { tlab, xlab, nlab, zBlabCV, zWlabCV, trBlab,
                          trWlab, klabCV, vlab } =
                      specifyModel( varsinMem, tlab, xlab, nlab, zBlabCV,
                                    zWlabCV, trBlab, trWlab, klabCV, vlab );

                    if (tlab /= 0);
		      ndefault = ones( rows(varget(tlab)), 1);
		    endif;
		    errorMsg = EzIcheckinputs();
                    if (errorMsg $/="");
		      mainErrorMsg(errorMsg);
                    elseif (tlab /= 0);
		      status[4] = status[4] + 1;
		      if (trBlab /= 0 and trWlab /= 0);
			_Eres = vput(_Eres, varget(trBlab)~varget(trWlab),
			"truth");
		      endif;
		      ndefault = ones( rows(varget(tlab)), 1);
                    endif;
                else;
                    mainErrorMsg("You must first load some variables with GetASCII or Get DBUF.");
                    continue;
                endif;

            elseif (rowChosen == 3);   /* run the ei model */
		
		if ( preEIwarning(tlab, xlab, nlab, zBlabCV, zWlabCV) or
                     (not status[4]) );
                    mainErrorMsg("You must first specify a model using MODEL:Specify.");
                    continue;
                else;

		  cls;
		  "\27[1;31m";;
		center(8,"This will estimate the model you have specified.");
   	          center(10,"*** ESC to exit, any other key to"$+
		  " continue. ***");
		  "\27[0m";;
		  if (27==keyw); goto menuloop; endif;
		  		  
		    cls;
                    /* _Esims = 10; */

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

                    if (klabCV/=0); keepMat = mergevar(klabCV);
                    else; keepMat = 0;
                    endif;

                    /* now vput the labels into _Eres */
                    _Eres = vput( _Eres, tlab, "tlab" );
                    _Eres = vput( _Eres, xlab, "xlab" );
                    _Eres = vput( _Eres, nlab, "nlab" );
                    _Eres = vput( _Eres, zBlabCV, "zBlabCV" );
                    _Eres = vput( _Eres, vlab, "vlab" );
                    _Eres = vput( _Eres, zWlabCV, "zWlabCV" );
		    _Eres = vput( _Eres, trBlab, "trBlab" );
                    _Eres = vput( _Eres, trWlab, "trWlab" );
                    _Eres = vput( _Eres, keepMat, "keepMat" );
                    _Eres = vput( _Eres, klabCV, "klabCV" );
		    _Eres = vput( _Eres, titl, "titl");
		    
		    if (vlab/=0); 
		      _Eres = vput( _Eres, varget(vlab), "v" );
		    endif;
		    
		    _Eprt = 2;
		    tempOutputFile = "00000000.tmp";
		    output file = ^tempOutputFile reset;
		    genericDbuf = ei( varget(tlab), varget(xlab),
                                      varget(nlab), zB, zW );
		    output off;
		    viewOrSave( tempOutputFile );

		    ?;?; "Now please enter a name under which to save this ";;
		    "data buffer.";?;?;
		    DbufFilename = getFilenameRoot(workingFile);
		    call csrtype(2);
                    DbufFilename = getDbufFilename( DbufFilename );
                    call csrtype(0);
                    save ^DbufFilename = genericDbuf;
	 	    ranEImessage(DbufFilename);
                    workingFile = DbufFilename$+".FMT";

		    statusMessage = "Ran EI estimation";
                    workingFileType = "Data buffer (EI)";
                    status[5] = maxc(status) + 1;
                    drawstatus(status);
                endif;
            endif;
            goto menuloop;

	    
        elseif (colChosen == 3);   /*--------- EI GRAPH MENU */

            if (rowChosen == 1);
                if (status[4]);
		   call doEditMenu("egglobs", varsinMem);
		else;
		    mainErrorMsg("You must first specify a model"$+
		                 " (Config needs t, x, and n).");
		endif;

            elseif (status[3] or status[5]);
                graphclr;
                cls;
                truthtemp = 
                eigraph(genericDbuf, getEIitem(main_elm,rowChosen, colChosen));

                @ dos del graphic.tkf > nul; @
            else;
                mainErrorMsg(
                    "You must first run a model or load a data buffer.");
                continue;
            endif;
            goto menuloop;

                                    /*--------- EI READ MENU */
        elseif (colChosen == 4);
            if (status[3] or status[5]);
	        _Eprt = 2;
	        tempOutputFile = "00000000.tmp";
                cls;
                format 8,4;
                output file = ^tempOutputFile reset;
		if (getEIitem(main_elm, rowChosen, colChosen)$=="parnames");
		  $eiread(genericDbuf, getEIitem(main_elm, rowChosen, colChosen));
		elseif (getEIitem(main_elm, rowChosen, colChosen)$=="abounds"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="Eaggbias"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="expvrcis"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="Goodman"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="mpPsiu"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="nobs"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="Paggs"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="Palmquist"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="Pphi"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="psi"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="psitruth"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="psiu"
		  or getEIitem(main_elm, rowChosen, colChosen)$=="Thomsen");
		  call eiread(genericDbuf, 
		  getEIitem(main_elm, rowChosen, colChosen));
		else;
		  eiread(genericDbuf, getEIitem(main_elm, rowChosen, colChosen));
		endif;
                output off;
                viewOrSave( tempOutputFile );
                goto menuloop;
            else;
                mainErrorMsg(
                    "You must first run a model or load a data buffer.");
                continue;
            endif;

        elseif (colChosen == 5);   /*--------- MISC MENU */
            clearMidScreen();
            if (rowChosen == 1);   
	      AboutHelpScreen;
            elseif (rowChosen == 2);
	      cls; dos l tutorial.txt;
            elseif (rowChosen == 3);
	      cls; dos l ezi.txt;
            elseif (rowChosen == 4);
	      cls; dos l eiintro.txt;
            elseif (rowChosen == 5);
	      cls; dos l eiei2.txt;
            elseif (rowChosen == 6);
	      cls; dos l eigraph.txt;
            elseif (rowChosen == 7);
	      cls; dos l eiread.txt;
            elseif (rowChosen == 8);
	      cls; dos l eimisc.txt;
            elseif (rowChosen == 9);
	      cls; dos l readme.1st;
            elseif (rowChosen == 10);
	      showCredits;
            elseif (rowChosen == 11);
	      AboutEIscreen;
            endif;

            break;
        endif;

    endif;
endo;

goto menuloop;
end;



/*
use ezi;
loadvars sample.asc larry moe curly;
varnStr = "larry moe curly";
load sample;
ExportMain(varnStr, sample);
dos l test.exp;
dos l test.var;
*/

/* input screen for selecting a quantities to be exported to a p x selected
 * ascii file.
 * expVarsMat = col1 character quantity names
 *              col2 order of selection (initially zero)
 */
proc(0) = ExportMain( varnStr, dbufinMem );
    local m_bottom, keyPressed, oldcpos, exportFileName, truthVarsMat,
          cursorPosition, expVarsMat, counter, isTruth, isavar;

    m_bottom = "\27[44;1m\27[D "$+chrs(29)$+chrs(18)$+
               ": Move   +: Add  -: Remove   "$+
               "ESC: Return to Main Menu   ENTER: Begin Export \27[40m";
    let expVarsMat =
                "bounds"   @ px4       boundblo boundbhi boundwlo boundwhi @
                "betaB"    @ px_Esims  betaB @
                "betaBs"   @ px_Esims  Bbs1 -- Bbs<_Esims> ; _Esims<=9999@
                "betaW"    @ px_Esims  betaW @
                "betaWs"   @ px_Esims  Bws1 -- Bws<_Esims> ; _Esims<=9999@
                "CI50b"    @ px2       CI50blo CI50bhi @
                "CI50w"    @ px2       CI50wlo CI50whi @
                "CI80b"    @ px2       CI80blo CI80bhi @
                "CI80w"    @ px2       CI80wlo CI80whi @
                "CI95bw"   @ px4       CI95blo CI95bhi CI95wlo CI95whi @
                "CI95b"    @ px2       CI95blo CI95bhi @
                "CI95w"    @ px2       CI95wlo CI95whi @
                "CsbetaB"  @ px1       CsbetaB @
                "CsbetaW"  @ px1       CsbetaW @
                "N"    @ px1       N @
                "Nb"       @ px1       Nb @
                "Nw"       @ px1       Nw @
                "sbetaB"   @ px1       sbetaB @
                "sbetaW"   @ px1       sbetaW @
                "STbetaBs" @ px_Esims  SBbs1 -- SBbs<_Esims>; _Esims<9999 @
                "STbetaWs" @ px_Esims  SBws1 -- SBws<_Esims>; _Esims<9999 @
                "t"    @ px1       t @
                "x"    @ px1       x @
                "Zb"       @ pxVAR     Zb1 ... Zb<cols(Zb)> @
                "Zw";      @ pxVAR     Zw1 ... Zw<cols(Zw)> @

     let truthVarsMat =
                "NbN"      @ px1       NbN @
                "NbV"      @ px1       NbV @
                "NwN"      @ px1       NwN @
                "NwV"      @ px1       NwV @
                "truPtile" @ px2       truPtib truPtiw @
                "truth"    @ px2       truthB truthW @
                "truthB"   @ px1       truthB @
                "truthW";   @ px1       truthW @
     screen off;
     if not ismiss(eiread(dbufinMem,"truth"));
       expVarsMat = expVarsMat | truthVarsMat;
     endif;
     screen on;

    @ pxk <original var names>@
    isavar = zeros(rows(expVarsMat),1);
    isavar = isavar | ones(rows(getVarList( varnStr )),1);
    expVarsMat = expVarsMat | getVarList( varnStr );
    expVarsMat = expVarsMat ~ zeros(rows(expVarsMat),1);
    expVarsMat = expVarsMat ~ isavar;
    
    
    exploop:
    counter = 1;
    cursorPosition = 1;
    oldcpos = 0;


    call csrtype(0);
    cls;
    locate 25,1; m_bottom;;
    "\27[1;32m";;
    center(3,"Select the quantities for export to an ASCII file.")
    center(4,"Pick them in the order you wish the columns to be constructed.");
    "\27[0m";;
    locate 1,1; main_top;;
    locate 2,1; "              ";

    keyPressed = 0;
    do while (keyPressed /= 13);    /* ENTER */
        drawExportSelList( expVarsMat, cursorPosition, oldcpos );
	/* this fn is in specify.prg */
	oldcpos = cursorPosition;
	{ cursorPosition, keyPressed } =
	   wrappedMoveCurs( cursorPosition, rows(expVarsMat), 3 );
	/* '+' key */
	if (keyPressed==43 and expVarsMat[cursorPosition,2]==0);
	  if (expVarsMat[cursorPosition,1]$=="Zb" and
	    eiread(dbufinMem,"zb")==1);
	    center(22,
	    "You cannot select Zb since no such covariates were specified.");
	    wait;
	    scroll 22|1|22|80|1|7;
	  elseif ( expVarsMat[cursorPosition,1]$=="Zw" and
	    eiread(dbufinMem,"zw")==1 );
	    center(22,
	    "You cannot select Zw since no such covariates were specified.");
	    wait;
	    scroll 22|1|22|80|1|7;
	  else;
	    expVarsMat[cursorPosition,2] = counter;
	    counter = counter + 1;
	  endif;
      

	  /* '-' key */
	elseif (keyPressed==45 and expVarsMat[cursorPosition,2]/=0);
	  expVarsMat[.,2] = expVarsMat[.,2] -
	  (expVarsMat[.,2] .> expVarsMat[cursorPosition,2]);
	  expVarsMat[cursorPosition,2] = 0;
	  counter = counter - 1;
	elseif (keyPressed==27);
      retp;
    endif;
  endo;
  
  if (sumc(expVarsMat[.,2])==0);    /* were no items selected? */
    retp;
  endif;

  scroll 3|1|4|80|2|7;
  exportFileName = askFileName(3);
  if exportFileName $== "NULL"; 
    goto exploop; 
  else;
    writeExportFile( exportFileName, expVarsMat, dbufinMem );
  endif;
endp;


proc(0) = writeExportFile( filenStr, varsMat, dbuf );
    local i, expMat, expVarCV, unknown_ctr, varFilen, currentvnCV,
          expMatFirst, expVarCVFirst;
    unknown_ctr = 1;
    expMatFirst = 1;
    expVarCVFirst = 1;
    screen off;
    expMat = 0;
    expVarCV = 0;

    varsMat = delif(varsMat, (varsMat[.,2].==0)); /* eliminate non-tagged */
    varsMat = sortc(varsMat, 2);                  /* sort on tagorder */
    
    save varsmat;
    
    cls;
    i = 1;
    do while (i <= rows(varsMat));
      format 6,4;
      "------------------------------------";
      "Iteration number " i;

      /* build the data matrix */
      if (expMatFirst);
	?;"about to call first eiread for ";; $varsMat[i,1];
	if varsMat[i,3];
	  expMat = varget(varsMat[i,1]);
	else;
	  expMat = eiread(dbuf, varsMat[i,1]);
	  "called first eiread for ";; $varsMat[i,1];?;
	endif;
	expMatFirst = 0;
      else;
	?;"about to call append eiread for ";; $varsMat[i,1];
	if varsMat[i,3];
	  expMat = expMat ~ varget(varsMat[i,1]);
	else;
	  expMat = expMat ~ eiread(dbuf, varsMat[i,1]);
	  "called append eiread for ";; $varsMat[i,1];?;
	endif;
      endif;

      /* build the .var list */
      "about to assign currentvnCV";
      currentvnCV = varsMat[i,1];       /* use quantity name as default */
      "assigned currentvnCV default value of ";; $varsMat[i,1];
      if (varsMat[i,1] $== "bounds");
	currentvnCV = { "boundblo", "boundbhi", "boundwlo", "boundwhi" };
      elseif (varsMat[i,1] $== "CI50b");
	currentvnCV = { "CI50blo", "CI50bhi" };
      elseif (varsMat[i,1] $== "CI50w");
	currentvnCV = { "CI50wlo", "CI50whi" };
      elseif (varsMat[i,1] $== "CI80b");
	currentvnCV = { "CI80blo", "CI80bhi" };
      elseif (varsMat[i,1] $== "CI80w");
	currentvnCV = { "CI80wlo", "CI80whi" };
      elseif (varsMat[i,1] $== "CI50bw");
	currentvnCV = { "CI80blo", "CI80bhi", "CI80wlo", "CI80whi" };
      elseif (varsMat[i,1] $== "CI95bw");
	currentvnCV = { "CI95blo", "CI95bhi", "CI95wlo", "CI95whi" };
      elseif (varsMat[i,1] $== "CI95b");
	currentvnCV = { "CI95blo", "CI95bhi" };
      elseif (varsMat[i,1] $== "CI95w");
	currentvnCV = { "CI95wlo", "CI95whi" };
      elseif (varsMat[i,1] $== "truPtile");
	currentvnCV = { "truPtib", "truPtiw" };
      elseif (varsMat[i,1] $== "truth");
	currentvnCV = { "truthB", "truthW" };
      elseif (varsMat[i,1] $== "Zb");
	currentvnCV = 0$+"Zb" $+ ftocv(seqa(1,1,cols(eiread(dbuf,"Zb"))),1,0);
      elseif (varsMat[i,1] $== "Zw");
	currentvnCV = 0$+"Zw" $+ ftocv(seqa(1,1,cols(eiread(dbuf,"Zw"))),1,0);
      elseif (varsMat[i,1] $== "betaBs");
	currentvnCV = 0$+"Bbs" $+ ftocv(seqa(1,1,eiread(dbuf,"_Esims")),1,0);
      elseif (varsMat[i,1] $== "betaWs");
	currentvnCV = 0$+"Bws" $+ ftocv(seqa(1,1,eiread(dbuf,"_Esims")),1,0);
      elseif (varsMat[i,1] $== "STbetaBs");
	currentvnCV = 0$+"SBbs" $+ ftocv(seqa(1,1,eiread(dbuf,"_Esims")),1,0);
      elseif (varsMat[i,1] $== "STbetaWs");
	currentvnCV = 0$+"SBws" $+ ftocv(seqa(1,1,eiread(dbuf,"_Esims")),1,0);
      endif;

      format 8,0;
      if (expVarCVFirst);
	expVarCV = currentvnCV;
	"initialized expVarCV as ";; $currentvnCV';
	expVarCVFirst = 0;
      else;
	expVarCV = expVarCV | currentvnCV;
	"added to expVarCV: added ";; $currentvnCV';
      endif;
      
      i = i+1;
    endo;
    
    ?;?;"NOW WRITING TO FILES";
    
    screen off;
    format /rd 8,4;     /* <-------- change precision here! *********** */
    outwidth 256;
    "about to print output data";;
    output file = ^filenStr reset; print expMat; output off;
    ",,,,printed output data.";
    format /ld 8,0;
    varFilen = getfilenameroot(filenStr) $+ ".var";
    output file = ^varFilen reset; print $expVarCV; output off;
    ",,,,printed .var file.";
    screen on;
endp;




proc(0) = drawExportSelList( varnMat, cpos, oldcpos );
    local printrow, printcol, printincrm, i, r, c;
    printrow = 6;
    printcol = 18;
    printincrm = 17;
    i = 0;

    do while ( i < rows(varnMat));
        r = printrow;
        c = printcol + printincrm*(i%3);
        locate r,c-3;
    format /rd 2,0;
    "\027[1;35m";;
    if varnMat[i+1,2]/=0; varnMat[i+1,2]; else; "  "; endif;
        format /ld 8,0;
    "\027[0m";;
        locate r,c;
    if (i+1 == cpos);
      "\027[7m";;
      format 8,0;
      "\027[1m";;
      $varnMat[i+1,1];;
      "\027[0m";;
    elseif (i+1==oldcpos or oldcpos==0);
      format 8,0;
      "\027[1m";;
      $varnMat[i+1,1];;
      "\027[0m";;
    endif;
    if (2 == i%3); printrow = printrow + 1; endif;
        i = i+1;
    endo;
endp;

proc(0) = e;
run export.prg;
endp;

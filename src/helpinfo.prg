/*
new;
library ei;
#include globals.h
showCredits;
@abouteiscreen;
cls;
AboutHelpScreen;@
ranEImessage("sample");
*/


proc(0) = AboutHelpScreen();
    local s;

    scroll 2|1|25|80|24|7;
    s = 
"\27[1;33m    These help screens are designed to provide convenient  and useful infor-
    mation on-screen without your  having to refer to a paper version of the 
    manuals. The disadvantage is that text files cannot display mathematical 
    notation appropriately.    

    You may print paper versions of the  manuals by sending the files  \27[37mei.ps\27[33m 
    and \27[37mezi.ps\27[33m to any Postscript printer (e.g., \27[36mcopy ei.ps lpt1:\27[33m). If you do
    not have a Postscript-compatible printer,  you can  take  the Postscript
    files to your local Kinko's or other xerox shop, as many can print these 
    files for you.  Alternatively, you can use  Ghostscript to  print  Post-
    script on any printer, or  Ghostview  to see it on the screen. These are 
    freely distributed  software  available for most  computer platforms at:
    \27[37mhttp://www.cs.wisc.edu/~ghost/\27[33m.
    
    Another possibility is to view  the  html version of the  manual on-line 
    at  \27[37mhttp://GKing.Harvard.Edu/ei/ei.html\27[33m,  using  a web  browser  such as
    Netscape Navigator.   You may also use  this method to print the manual.
    If you are using a windowed operating system  (e.g. OS/2 Warp) then  you
    can have the online manual and EzI open at the same time.";
	
/*    The help screens organize the EI manual into sections for easier access.
    The EzI Help menu item is a  text version of the \27[37mezi.ps\27[33m Postscript file."; */

    locate 3,1;
    s;;
    call csrtype(0);
    locate 24,26;
    print "\27[7;44;37m Press any key to continue \27[0m";;
    wait;
    cls;

endp;

proc(0) = AboutEIScreen();
    local s;
    cls;
    "\27[2J";;
    "\27[0m";
    s = "
\27[1;35m                                              ﬂ
                             €ﬂﬂﬂﬂﬂ€          ‹
                             €‹‹‹‹‹€ \27[37m⁄ƒƒƒƒƒø\27[35m  €    (for Windows 95)
                             €       \27[37m    ⁄Ÿ \27[35m  €
                             €‹‹‹‹‹€ \27[37m  ⁄Ÿ   \27[35m  €    \27[0;1mEzI v"$+eivers$+"   
                                     \27[37m ¿ƒƒƒƒƒŸ\27[0m      \27[1m"$+_Eversion$+"\l
               \27[1m   A(n Easy) Program for Ecological Inference

        \27[1;33m                 Kenneth Benoit and Gary King 
        Department of Political Science     Department of Government
          Trinity College, U. of Dublin     Harvard University 
                  (c) Copyright 1996-98, All rights reserved

   EI is a stand-alone front end to \27[37m\"EI: A Program for Ecological Inference,\"\27[33m 
   by Gary King.   \27[37mEI\27[33m is distributed as  part of the  Gauss CML module  (from 
   Aptech Systems) and via the WWW at \27[37mhttp://GKing.Harvard.Edu/\27[33m.   "$+
	   "\27[37mEI\27[33m and \27[37mEzI\27[33m 
   implement  methods described in  \27[36mA Solution  to  the Ecological  Inference
   Problem: Reconstructing Individual Behavior from  Aggregate Data\27[33m,  by Gary 
   King (Princeton University Press, 1997).\27[33m";

    s;;
    call csrtype(0);
    locate 24,26;
    print "\27[7;44;37m Press any key to continue \27[0m";;
    wait;
    cls;
endp;


proc(0) = showCredits();
    local s;

    scroll 2|1|25|80|24|7;
    s = 
"
\27[1;37m    EzI\27[33m is a front end for \"EI: A Program for Ecological Inference\"
    (c)Copyright, 1995-97, Gary King.  \27[37mEI\27[33m is available via WWW at
    \27[37mhttp://GKing.Harvard.Edu\27[33m and as part of Gauss' CML module.      
                                                                
    EI\27[33m and \27[37mEzI\27[33m are based on \27[36mA Solution to the Ecological Inference Problem:
    Reconstructing Individual Behavior from Aggregate Data\27[33m (Princeton: 
    Princeton University Press, 1997), by Gary King.  (To order a copy: Call 
    (609) 258-4897 or Princeton University Press, c/o California/Princeton 
    Fulfillement Services 1445 Lower Ferry Road, Ewing, New Jersey 08618.)
    
    \27[37mEI\27[33m and \27[37mEzI\27[33m are written in the Gauss Programming Language, (c)Copyright  
    Aptech Systems, Inc., 1984-1997, and uses Gauss' Constrained Maximum    
    Likelihood Module written by Ronald J.\ Schoenberg (To purchase Gauss,  
    contact Aptech at Sales@Aptech.Com or 206-432-7855).                    
                                                                         
    \27[37mEI\27[33m and \27[37mEzI\27[33m make use of public domain Gauss code written by David Baird 
    (an inverse cumulative normal procedure), Martin van der Ende (an 
    accurate cumulative bivariate normal procedure), and Simon Jackman
    (a loess procedure).";                                                             
                                                                         
    locate 3,1;
    s;;
    call csrtype(0);
    locate 24,26;
    print "\27[7;44;37m Press any key to continue \27[0m";;
    wait;
    cls;
endp;


proc(0) = ranEImessage(dbfilenameStr);
    cls;
    locate 10,6;
    print "\27[1;31mYou have now run the model and saved the results in the data buffer";
    print "     \27[37m";; dbfilenameStr;; "\27[31m.";;
    "  All the information necessary to produce any graph or
     numerical calculation is stored in this data buffer. To see these 
     graphs or calculations, choose the items of your choice from the 
     GRAPH and READ menus.";
    
    call csrtype(0);
    locate 24,26;
    print "\27[7;44;37m Press any key to continue \27[0m";;
    wait;
    cls;
endp;


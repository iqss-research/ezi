# ezi

<strong>This software is no longer being actively updated. Previous versions and information about the software are archived here.</strong>

Authors: Kenneth Benoit, Gary King
Website: https://gking.harvard.edu/EzI

This is a stand-alone, menu-oriented version of EI that runs under Windows. It does not require Gauss or any other software to run.

EzI does everything EI does and with fewer startup costs but, due to the lack of the Gauss command line, is somewhat less flexible. Winner of the APSA Research Software Award. 


EzI Source File Guide
Ken Benoit
Aug 15, 1998

Files are following.  Not exactly a paragon of organized or efficient
code...

ezi.prg         main program
menus.h         gauss global vars for main menu routines
menus.prg       main menu code
ioutils.prg     inputting and outputting routines used by various
eiglob.h        header file (global variables) for the EI Globals screen  
eiglob.prg      code for EI globals screen (includes screen menus)
export.prg      export output variables, incl. screen menus
globals.h       some globals for whole ezi program
helpinfo.prg    help screens
specify.prg     for assigning variables to EI quantities
box.prg         some pop-up boxes, not actually used

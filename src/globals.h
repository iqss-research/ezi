#IFNDEF globals_h
#DEFINE globals_h 1


eivers    =  "2.02 9/6/1998";       /* EzI version number */
eidir     =   envget("EI_DIR");     /* EI_DIR environment variable */
if eidir $== "";
    eidir = cdir(0);
endif;

/* menu masks for graphics and stuff */

DECLARE w1 = 1  1  1 80 0 0;        /* scroll window: row 1, inverse */
DECLARE w2 = 2  1 21 80 0 0;        /* scroll window: rows 2-21 */
DECLARE w3 = 23 1 24 80 0 0;        /* scroll window: rows 23-24 */
DECLARE w4 = 25 1 25 80 0 0;        /* scroll window: row 25, inverse */
DECLARE bhalf = 16 1 21 80 0 0;     /* scroll window: for OUTPUT menu item */

cmon  = "\027[35m";         /* math highlights on */
cmoff = "\027[37m";         /* math highlights off */
cgon  = "\027[34m";         /* globals hl on */
cgoff = "\027[37m";         /* globals hl off */
B     = "á";                /* symbol for beta */

/* main_top = "\27[41;37m\27[D                                 EzI  v" $+
           eivers $+ "                               \27[0;40m"; */

workingFile     = "<none>";
workingFileType = "<none>";
statusMessage = "New session.";
varsinMem   = "";
genericDbuf = 0;

tlab = 0;     /* starting settings for t, x, n, zB, zW, truthB, truthW, keep */
xlab = 0;
vlab = 0;
v    = 0;
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

#ENDIF

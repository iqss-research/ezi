#IFNDEF menus_h
#DEFINE menus_h 1

darrow = "\27[33m\025more\27[0m";
uarrow = "\27[33m\024more\27[0m";
start_display_row = 1;
end_diplay_row    = 11;

/* **************************** MAIN MENU ***************************** */

main_top = "\27[41;1m\27[D                                 EzI  v" $+
           eivers $+ "                                     \27[0m";
main_bot = "\27[44;1m           "$+chrs(29)$+chrs(18)$+
 ": Move             ENTER: Select             ESC: Quit            " $+
  "\27[0m";

main_mxr = { 6 5 49 106 11 };     /* maximum #choices for each menu item */
main_mxc = cols(main_mxr);       /* number of menu items */
main_row = 8;                    /* top line of menu items */
main_col = 8;                    /* starting position of left-most column */
main_stp = 12;
main_fmt = { "- *.*lf" 10 8 };
main_nam="\27[1m

   旼컴컴 Getting Started 컴컴컴 Examine Results 컴컴컴 Misc 컴컴컴컴컴컴컴커
   쳐컴컴컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴캑
   �   DATA        MODEL    �  GRAPH       READ    �   INFORMATION          �
   읕컴컴컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴켸
\27[0m";
 
main_elm = { 
 "GetASCII"  "Specify "  "Config  "  "abounds "  "Re: Help", 
 "Get DBUF"  "Config  "  "beta    "  "aggbias "  "Example ", 
 "Stats   "  "Run     "  "betaB   "  "aggs    "  "EzI Help", 
 "ViewText"  "Run EI2 "  "betaW   "  "aggtruth"  " EIIntro", 
 "Export  "  "Replicat"  "betabw  "  "beta    "  " EI/EI2 ", 
 "To OS   "  0           "bias    "  "betaB   "  " EIGRAPH", 
 0           0           "biasB   "  "betaBs  "  " EIREAD", 
 0           0           "biasW   "  "betaW   "  " EI-Misc", 
 0           0           "bivar   "  "betaWs  "  "README  ", 
 0           0           "boundX  "  "bounds  "  "Credits ", 
 0           0           "boundXB "  "CI50b   "  "AboutEzI", 
 0           0           "boundXW "  "CI50w   "  0         , 
 0           0           "estsims "  "CI80b   "  0         , 
 0           0           "fit     "  "CI80bw  "  0         , 
 0           0           "fitT    "  "CI80w   "  0         , 
 0           0           "goodman "  "CI95b   "  0         , 
 0           0           "lines   "  "CI95bw  "  0         , 
 0           0           "movie   "  "CI95w   "  0         , 
 0           0           "nonpar  "  "coverage"  0         , 
 0           0           "post    "  "CsbetaB "  0         , 
 0           0           "postB   "  "CsbetaW "  0         , 
 0           0           "postW   "  "dataset "  0         , 
 0           0           "prectB  "  "date    "  0         , 
 0           0           "prectW  "  "Eaggbias"  0         , 
 0           0           "ptile   "  "etaC    "  0         , 
 0           0           "ptileB  "  "etaS    "  0         , 
 0           0           "ptileW  "  "expvarci"  0         , 
 0           0           "results "  "expvrcis"  0         , 
 0           0           "sims    "  "GEbw    "  0         , 
 0           0           "simsB   "  "GEbwa   "  0         , 
 0           0           "simsW   "  "GEwb    "  0         , 
 0           0           "TbiasB  "  "GEwba   "  0         , 
 0           0           "TbiasW  "  "GhActual"  0         , 
 0           0           "Tbivar  "  "Goodman "  0         , 
 0           0           "Tlines  "  "lnir    "  0         , 
 0           0           "tomoCI95"  "loglik  "  0         , 
 0           0           "tomog   "  "Maggs   "  0         , 
 0           0           "tomogCI "  "meanIR  "  0         , 
 0           0           "tomogD  "  "mpPsiu  "  0         , 
 0           0           "tomogE  "  "N       "  0         , 
 0           0           "tomogP  "  "Nb      "  0         , 
 0           0           "tomogS  "  "Nb2     "  0         , 
 0           0           "tomogT  "  "NbN     "  0         , 
 0           0           "truth   "  "NbT     "  0         , 
 0           0           "xgraph  "  "nobs    "  0         , 
 0           0           "XgraphC "  "Nt      "  0         , 
 0           0           "xt      "  "Nw      "  0         , 
 0           0           "xtC     "  "Nw2     "  0         , 
 0           0           "xtfit   "  "NwN     "  0         , 
 0           0           "xtfitg  "  "NwT     "  0         , 
 0           0           0           "Paggs   "  0         , 
 0           0           0           "Palmquis"  0         , 
 0           0           0           "parnames"  0         , 
 0           0           0           "phi     "  0         , 
 0           0           0           "PhiSims "  0         , 
 0           0           0           "Pphi    "  0         , 
 0           0           0           "psi     "  0         , 
 0           0           0           "psitruth"  0         , 
 0           0           0           "psiu    "  0         , 
 0           0           0           "Resamp  "  0         , 
 0           0           0           "retcode "  0         , 
 0           0           0           "RNbetaBs"  0         , 
 0           0           0           "RNbetaWs"  0         , 
 0           0           0           "sbetaB  "  0         , 
 0           0           0           "sbetaW  "  0         , 
 0           0           0           "STbetaBs"  0         , 
 0           0           0           "STbetaWs"  0         , 
 0           0           0           "sum     "  0         , 
 0           0           0           "t       "  0         , 
 /* 0           0           0           "Thomsen "  0         , */
 0           0           0           "titl    "  0         , 
 0           0           0           "truPtile"  0         , 
 0           0           0           "truth   "  0         , 
 0           0           0           "truthB  "  0         , 
 0           0           0           "truthW  "  0         , 
 0           0           0           "tsims   "  0         , 
 0           0           0           "V       "  0         ,
 0           0           0           "VCaggs  "  0         , 
 0           0           0           "vcphi   "  0         , 
 0           0           0           "x       "  0         , 
 0           0           0           "x2      "  0         , 
 0           0           0           "x2rn    "  0         , 
 0           0           0           "Zb      "  0         , 
 0           0           0           "Zw      "  0         , 
 0           0           0           "_EalphaB"  0         , 
 0           0           0           "_EalphaW"  0         , 
 0           0           0           "_Ebeta  "  0         , 
 0           0           0           "_Ebounds"  0         , 
 0           0           0           "bvsmth  "  0         , 
 0           0           0           "_Ecdfbvn"  0         , 
 0           0           0           "_EdirTol"  0         , 
 0           0           0           "_EdoML  "  0         , 
 0           0           0           "doML_phi"  0         , 
 0           0           0           "doML_vc "  0         , 
 0           0           0           "_EdoSim "  0         , 
 0           0           0           "_Eeta   "  0         , 
 0           0           0           "_EisChk "  0         ,
 0           0           0           "_EisFac "  0         , 
 0           0           0           "_Eisn   "  0         , 
 0           0           0           "_EisT   "  0         , 
 0           0           0           "_Ei_vc  "  0         , 
 0           0           0           "_EmaxItr"  0         , 
 0           0           0           "_EnonEva"  0         , 
 0           0           0           "_EnonNum"  0         , 
 0           0           0           "_EnonPar"  0         , 
 0           0           0           "_EnumTol"  0         , 
 0           0           0           "_Erho   "  0         , 
 0           0           0           "_Eselect"  0         , 
 0           0           0           "_Esigma "  0 ,
 0           0           0           "_Esims  "  0 ,
 0           0           0           "_Estval "  0 ,
 0           0           0           "_Ez     "  0 
};
 /*
 0           0           0           "_GhDelta"  0         , 
 0           0           0           "_GhFall "  0         , 
 0           0           0           "_GhQuad "  0         , 
 0           0           0           "_GhStart"  0          
 */



/* ...... DATA menu descriptions ....... */

m_1_1  = "Import a delimited ASCII dataset.";
m_1_2  =
"Load the results from a previously run model.
This will not require running the estimations
again.";
m_1_3  = "Check some descriptive statistics for the
dataset.  This is helpful for making sure that
you read in the data correctly.";
m_1_4  = "View text files using a text file browser.";
m_1_5  = "Select variables and "$+cgon$+"EIREAD()"$+cgoff$+" quantities to
be exported to an ASCII file with "$+cgon$+"p"$+cgoff$+" rows.
\27[31mThis may only be done after loading a data
buffer file or running "$+cgon$+"EI"$+cgoff$+".\27[0m";
m_1_6 = "Temporarily exit to operating system.";

/* ...... RUN MODEL menu descriptions ....... */

m_2_2  =
"Configure global parameters affecting the
EI model.";
m_2_4  =
"Replicate results from an existing data
buffer.  (Loads previously specified model,
global settings, and re-runs the model
estimation).";
m_2_1  =
"Choose a new model.  Specify which variables
from the dataset are "$+cgon$+"t, x, n, zb, zw,
truthB"$+cgoff$+", and "$+cgon$+"truthW"$+cgoff$+", and which are to 
be passed to the data buffer.";
m_2_3  =
"Run the EI model, saving results in a data
buffer.  Run time depends on your dataset size 
and computer speed.  To examine results in the
data buffer, choose items under GRAPH and READ.";
m_2_5 =
"Gives observation-level estimates of parameters
from "$+cmon$+"2 x C"$+cmoff$+" tables with "$+cmon$+"C > 2"$+cmoff$+".  "$+cgon$+"EI2"$+cmoff$+" is the 
second-stage "$+cgon$+"EI"$+cgoff$+" model through which larger
tables are computed.";


/* ...... EI GRAPH menu descriptions ....... */


m_3_1  = "Configure options for graphics.";
m_3_2  =
"Combination of "$+cgon$+"lines, Tlines, bivar, Tbivar"$+cgoff$+".
See Figure 10.8, page 197.";
m_3_3  =
"Combination of "$+cgon$+"biasB, biasW, TbiasB, TbiasW"$+cgoff$+".
See the points in Figure 13.2, page 238.";
m_3_4  = cmon$+"X_i"$+cmoff$+" by *estimated* " $+ cmon $+ "\225_i^b" $+ cmoff;
m_3_5  =
cmon$+"X_i"$+cmoff$+" by *estimated* " $+ cmon $+ "\225_i^w" $+ cmoff;
m_3_6 =
"*estimated* "$+cmon$+"\225_i^b"$+cmoff$+" by "$+cmon$+"\225_i^w"$+cmoff$+".
See the right graph in Figure 13.6, page 243.";
m_3_7  =
cmon $+
"X_i"$+cmoff$+" by the bounds on "$+cmon$+"\225_i^b"$+cmoff$+" (each precinct
appears as one vertical line).  See the lines
in the left graph in Figure 13.2, page 238.";
m_3_8  =
cmon $+
"X_i"$+cmoff$+" by the bounds on "$+cmon$+"\225_i^w"$+cmoff$+" (each precinct
appears as one vertical line).  See the lines
in the left graph in Figure 13.2, page 238.";
m_3_9  =
cgon$+"boundXB, boundXW, boundXB"$+cgoff$+" overlaid on "$+cgon$+" TbiasB,
boundXW"$+cgoff$+" overlaid on "$+cgon$+"TbiasW"$+cgoff$+".  See Figure 13.2,
page 238.";
m_3_10 = "Combination of "$+cgon$+"xtfit"$+cgoff$+" and "$+cgon$+"tomogP"$+cgoff$+".";
m_3_11 = "Combination of "$+cgon$+"xtfit"$+cgoff$+" and "$+cgon$+"tomogT"$+cgoff$+".";
m_3_12 =
cmon$+"X_i"$+cmoff$+" by "$+cmon$+"T_i"$+cmoff$+" plot with Goodman's regression line
plotted.  See Figure 4.1, page 60.";
m_3_13 =
cmon$+"X_i"$+cmoff$+" by "$+cmon$+"T_i"$+cmoff$+" plot with one *estimated* line per
precinct.  See Figure 10.8, page 214.";
m_3_14 =
"*"$+cgon$+"postB"$+cgoff$+" and "$+cgon$+"postW"$+cgoff$+".  See Figure 10.4, page 208.";
m_3_15 =
"Density estimate of district-level
quantity of interest, the posterior
distribution for "$+cmon$+"B^b"$+cmoff$+".  See Figure 10.4,
page 208.";
m_3_16 =
"Density estimate of district-level
quantity of interest, the posterior
distribution for "$+cmon$+"B^w"$+cmoff$+".  See Figure 10.5,
page 208.";
m_3_17 =
"Plot of estimated "$+cmon$+"\225_i^b"$+cmoff$+" by true "$+cmon$+"\225_i^b"$+cmoff$+".
See Figure 10.5, page 210.";
m_3_18 =
"Plot of estimated "$+cmon$+"\225_i^w"$+cmoff$+" by true "$+cmon$+"\225_i^w"$+cmoff$+".
See Figure 10.5, page 210.";


m_3_19 =
cgon$+"*ptileB"$+cgoff$+" and "$+cgon$+"ptileW"$+cgoff$+".  See Figure 10.5,
page 210.";


m_3_20 =
"true percentile at which"$+cmon$+" \255_i^b"$+cmoff$+" falls by
estimated "$+cmon$+"\225_i^b"$+cmoff$+".  See Figure 10.7, page
213.";
m_3_21 =
"true percentile at which"$+cmon$+" \255_i^w"$+cmoff$+" falls by
estimated "$+cmon$+"\225_i^w"$+cmoff$+".  See Figure 10.7, page
213.";
m_3_22 =
cgon$+"simsB"$+cgoff$+" and "$+cgon$+"simsW"$+cgoff$+".  See Figure 10.6, page 212.";


m_3_23 =
"simulations of "$+cmon$+"\225_i^b"$+cmoff$+" by true "$+cmon$+"\225_i^b"$+cmoff$+".
See Figure 10.6, page 212.";
m_3_24 =
"simulations of "$+cmon$+"\225_i^w"$+cmoff$+" by true "$+cmon$+"\225_i^w"$+cmoff$+".
See Figure 10.6, page 212.";
m_3_25  =
cmon$+"X_i"$+cmoff$+" by *true* "$+cmon$+"\225_i^b"$+cmoff$+".  See the points in the
left graph in Figure 13.2, page 238.";
m_3_26  =
cmon$+"X_i"$+cmoff$+" by *true* "$+cmon$+"\225_i^w"$+cmoff$+".  See the points in the
left graph in Figure 13.2, page 238.";
m_3_27  =
"*true* "$+cmon$+"\225_i^b"$+cmoff$+" by "$+cmon$+"\225_i^w"$+cmoff$+".  See Figure 13.2,
page 238.";
m_3_28  =
cmon$+"X_i"$+cmoff$+" by "$+cmon$+"T_i"$+cmoff$+" plot with one *true* line per
precinct.  See Figure 3.1, page 41.";
m_3_29  = "tomography plot with ML contours. See Figure
10.2, page 186.  Dashed lines represent obs.
"$+cgon$+"_Eselect"$+cgoff$+"ed out. Notes appear at 0,0 and 1,1 
if observations exist for which "$+cmon$+"T=0"$+cmoff$+" or "$+cmon$+"T=1"$+cmoff$+".";
m_3_30  =
"tomography plot with 95% confidence intervals.
See Figure 9.5, page 179.";
m_3_31  =
"tomography plot with 80% confidence intervals.
See Figure 9.5, page 179.";
m_3_32  = "tomography plot with data only.  See Figure
5.1, page 81.  Dashed lines represent obs.
"$+cgon$+"_Eselect"$+cgoff$+"ed out. Notes appear at 0,0 and 1,1 
if observations exist for which "$+cmon$+"T=0"$+cmoff$+" or "$+cmon$+"T=1"$+cmoff$+".";
m_3_33  = "tomography plot with estimated mean
posterior "$+cmon$+"\225_i^b"$+cmoff$+" and "$+cmon$+"\225_i^w"$+cmoff$+" points.  Dashed lines 
represent obs. "$+cgon$+"_Eselect"$+cgoff$+"ed out. Notes appear at
0,0 and 1,1 if obs. exist for which "$+cmon$+"T=0"$+cmoff$+" or "$+cmon$+"T=1"$+cmoff$+".";
m_3_34  = "tomography plot with mean posterior
contours.  Dashed lines represent obs.
"$+cgon$+"_Eselect"$+cgoff$+"ed out. Notes appear at 0,0 and 1,1 
if observations exist for which "$+cmon$+"T=0"$+cmoff$+" or "$+cmon$+"T=1"$+cmoff$+".";
m_3_35  = cgon$+"tomog, tomogp, tomogCI,"$+cgoff$+" and "$+cgon$+" Tbivar"$+cgoff$+" (or "$+cgon$+"estsims
"$+cgoff$+"if "$+cgon$+"truth"$+cgoff$+" is not available).  See Figures 10.2,
9.5, and 7.1, on pages 204, 179, and 126
respectively.";
m_3_36  = "tomography plot with true "$+cmon$+"\225_i^b"$+cmoff$+" and
"$+cmon$+"\225_i^w"$+cmoff$+" points.  See Fig. 7.1, p126.  Dashed 
lines represent observations "$+cgon$+"_Eselect"$+cgoff$+"ed out. 
Notes appear if obs. exist for which "$+cmon$+"T=0"$+cmoff$+" or "$+cmon$+"T=1"$+cmoff$+".";
m_3_37  = cgon$+"post, precB, precW"$+cgoff$+" (compare "$+cgon$+"truth"$+cgoff$+" to
estimates at district and precinct-level).  See
Figures 10.4 and 10.5 on pages 208 and 210
respectively.";
m_3_38  = "a scattercross with data plotted.  See
Figure 12.1, page 227.";


m_3_39  = "a scattercross with data plotted using 
circle sizes proportional to "$+cmon$+"N_i"$+cmoff$+".";
m_3_40  = "basic "$+cmon$+"X_i"$+cmoff$+" by "$+cmon$+"T_i"$+cmoff$+" scatter plot";
m_3_41  = "basic "$+cmon$+"X_i"$+cmoff$+" by "$+cmon$+"T_i"$+cmoff$+" scatter plot with circles
sized proportional to "$+cmon$+"N_i"$+cmoff$+" or some other
variable defined by the global "$+cgon$+"_eigraph_circ"$+cgoff$+".";
m_3_42  = cmon$+"X_i"$+cmoff$+" by "$+cmon$+"T_i"$+cmoff$+" plot with estimated "$+cmon$+"E(T_i|X_i)"$+cmoff$+" and
conditional 80% confidence intervals.  See
Figure 10.3, page 206.";
m_3_43  = cgon$+"xtfit"$+cgoff$+" with Goodman's regression line
superimposed.";
m_3_44  = cgon$+"tomogd"$+cgoff$+" and a nonparametric density
estimation with contour plot and surface plot
representations.";
m_3_45  = "Density estimate of estimated "$+cgon$+"betaB"$+cgoff$+"'s
with whiskers at point estimates.";
m_3_46  = "Density estimate of estimated "$+cgon$+"betaW"$+cgoff$+"'s
with whiskers at point estimates.";
m_3_47  = "Combination of "$+cgon$+"betaB"$+cgoff$+" and "$+cgon$+"betaW"$+cgoff$+".";
m_3_48  = "For each observation one page of graphics 
appears with posterior distributions and
simulated and other values.  The user can
cycle through multiple observations.";
m_3_49  = "Simulations of "$+cmon$+"\225_i^b"$+cmoff$+"'s by simulations
of "$+cmon$+"\225_i^w"$+cmoff$+"'s.";
m_3rslt = "Combination of "$+cgon$+"postB"$+cgoff$+", "$+cgon$+"postW"$+cgoff$+", "$+cgon$+"betaB"$+cgoff$+" and "$+cgon$+"betaW"$+cgoff$+".";


/* ...... EI READ menu descriptions ....... */


m_4_1  =
cmon$+"2 x 2"$+cmoff$+": aggregate (district-level) bounds 
on "$+cmon$+"B^b"$+cmoff$+" and "$+cmon$+"B^w"$+cmoff$+".";
m_4_2  =
cmon$+"4x2"$+cmoff$+": regressions of true "$+cmon$+"\225_i^b"$+cmoff$+" and "$+cmon$+"\225_i^w"$+cmoff$+" 
on a constant and "$+cmon$+"X_i"$+cmoff$+".  Requires 
"$+cgon$+"truthB"$+cgoff$+" and "$+cgon$+"truthW"$+cgoff$+".";
m_4_3  =
cgon$+"_Esims"$+cmon$+" x 2"$+cmoff$+": simulations of district-level
quantities of interest, "$+cmon$+"\225-hat^b ~ \225-hat^w"$+cmoff$+".";
m_4_4  =
cmon$+"2x1"$+cmoff$+": true aggregate (district-level) quantities
of interest "$+cmon$+"\225^b"$+cmoff$+" and "$+cmon$+"\225^w"$+cmoff$+".  Requires 
"$+cgon$+"truthB"$+cgoff$+" and "$+cgon$+"truthW"$+cgoff$+".";
m_4_5  =
cmon$+"px1"$+cmoff$+" point estimate of "$+cmon$+"\225_i^b"$+cmoff$+" based on its
mean posterior.  See section 8.2";
m_4_6  = cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": simulations of "$+cmon$+"\225_i^b"$+cmoff$+".  See
Chapter 8.";
m_4_7  =
cmon$+"px1"$+cmoff$+" point estimate of "$+cmon$+"\225_i^w"$+cmoff$+" based on its
mean posterior.  See section 8.2";
m_4_8  =
cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": simulations of "$+cmon$+"\225_i^w"$+cmoff$+".  See
Section 8.2.";
m_4_9  = cmon$+"px4"$+cmoff$+": bounds on "$+cmon$+"\225_i^b"$+cmoff$+" and "$+cmon$+"\225_i^w"$+cmoff$+",
"$+cgon$+"lowerB~upperB~lowerW~upperW"$+cgoff$+".  See Chapter 5.";
m_4_10  = cmon$+"px2"$+cmoff$+": "$+cgon$+"lower~upper"$+cgoff$+" 50% confidence intervals
for "$+cmon$+"\225_i^b"$+cmoff$+".  See Section 8.2.";
m_4_11  = cmon$+"px2: "$+cgon$+"lower~upper"$+cgoff$+" 50% confidence intervals
for "$+cmon$+"\225_i^w"$+cmoff$+".  See Section 8.2.";
m_4_12  = cmon$+"px2: "$+cgon$+"lower~upper"$+cgoff$+" 80% confidence intervals
for "$+cmon$+"\225_i^b"$+cmoff$+".  See Section 8.2.";
m_4_13  = cmon$+"px4: "$+cgon$+"lowerB~upperB~lowerB~upperW"$+cgoff$+" 80%
confidence intervals for "$+cmon$+"\225_i^b"$+cmoff$+" and "$+cmon$+"\225_i^w"$+cmoff$+".
See Section 8.2.";
m_4_14  = cmon$+"px2: "$+cgon$+"lower~upper"$+cgoff$+" 80% confidence intervals
for "$+cmon$+"\225_i^w"$+cmoff$+".  See Section 8.2.";
m_4_15  = cmon$+"px2: "$+cgon$+"lower~upper"$+cgoff$+" 95% confidence intervals
for "$+cmon$+"\225_i^b"$+cmoff$+".  See Section 8.2.";
m_4_16  = cmon$+"px4: "$+cgon$+"lowerB~upperB~lowerW~upperW"$+cgoff$+" 95%
confidence intervals for "$+cmon$+"\225_i^b"$+cmoff$+" and "$+cmon$+"\225_i^w"$+cmoff$+".
See Section 8.2.";


m_4_17  = cmon$+"px2: "$+cgon$+"lower~upper"$+cgoff$+" 95% confidence intervals
for "$+cmon$+"\225_i^w.  See Section 8.2.";
m_4_18  = cmon$+"2x4"$+cmoff$+" confidence interval coverage; percent of
true values within the 50% and 80% confidence
intervals: "$+cgon$+"50b~80b~50w~80w"$+cgoff$+".  Requires "$+cgon$+"truthW"$+cgoff$+" 
and "$+cgon$+"truthB"$+cgoff$+".";
m_4_19  = cmon$+"px1"$+cmoff$+" confidence interval-based standard
error of "$+cmon$+"\225_i^b"$+cmoff$+".";
m_4_20  = cmon$+"px1"$+cmoff$+" confidence interval-based standard
error of "$+cmon$+"\225_i^w"$+cmoff$+".";
m_4_21  = cgon$+"Zb~Zw~x~t"$+cgoff$+", used for input to log likelihood
estimation.";
m_4_22  = "The date and time at which the data buffer 
was originally created and the version (and 
date) of "$+cgon$+"EI"$+cgoff$+" which created it.";
m_4_23  = cmon$+"4x2"$+cmoff$+" regressions of estimated "$+cmon$+"\225_i^b"$+cgoff$+" and
"$+cmon$+"\225_i^w"$+cgoff$+" on a constant term and "$+cmon$+"X_i"$+cmoff$+".";
m_4_24  = cmon$+"2x1"$+cmoff$+" alpha coefficients implied by global "$+cgon$+"_Eeta"$+cgoff$+".";
m_4_25  = cmon$+"2x1"$+cmoff$+" standard errors implied by global "$+cgon$+"_Eeta"$+cgoff$+".";
m_4_26  = cmon$+"100x4"$+cmoff$+" 80% confidence intervals for "$+cgon$+"T_i"$+cgoff$+" given
"$+cmon$+"X_i"$+cmoff$+".  "$+cmon$+"X~20%CI~mean~80%CI"$+cmoff$+" of sims from
"$+cmon$+"P(T_i|X_i)"$+cmoff$+".  See Section 8.5";
m_4_27  = cmon$+"100x4"$+cmoff$+" same as "$+cgon$+"expvarci"$+cgoff$+", but smoothed with
LOESS.  See Section 8.5.";
m_4_28  = "value of global "$+cgon$+"_GhActual"$+cgoff$+" from gvc().
Indicates method of computing the variance-
covariance matrix.";
m_4_29  = cmon$+"2x2"$+cmoff$+" Goodman Regression Coefficents
and standard errors.  See Section 3.1.";
m_4_30  = "Value of the log-likelihood (or log-posterior
if priors are used) at the maximum.";
m_4_31  = cmon$+"2x1"$+cmoff$+" point estimate of 2 district-level
parameters, "$+cgon$+"B-hat^b"$+cgoff$+" and "$+cgon$+"B-hat^w"$+cgoff$+".
See Section 8.3.";
m_4_32  = "Mean posterior of the untrucated Psi's  
(psi with a \"u\" on top).";
m_4_33  = cmon$+"px1"$+cmoff$+" number of individual elements in
precincts i, "$+cgon$+"N_i"$+cgoff$+", and input to "$+cgon$+"ei"$+cgoff$+".";
m_4_34  = cmon$+"px1"$+cmoff$+" denominator of "$+cgon$+"x"$+cgon$+" and "$+cgon$+"t"$+cgoff$+", equal to "$+cgon$+"x.*n"$+cgoff$+",
"$+cgon$+"N_i^b"$+cgoff$+" (e.g., number of blacks in the voting
age population).";
m_4_35  = cmon$+"px1: N_i^(bN)"$+cmoff$+" (e.g., number of blacks who
don't vote).  Requires "$+cgon$+"truthW"$+cgoff$+" and "$+cgon$+"truthB"$+cgoff$+".
See Chapter 2.";
m_4_36  = cmon$+"px1: N_i^(bT)"$+cmoff$+" Black turnout (e.g., number 
of blacks who vote).  Requires "$+cgon$+"truthW"$+cgoff$+" and
"$+cgon$+"truthB"$+cgoff$+".  See Chapter 2.";
m_4_37  = "scalar"$+cmoff$+" number of observations, "$+cmon$+"p"$+cmoff$+".";
m_4Nt   = cmon$+"px1"$+cmoff$+" number of people who vote (total turnout).";
m_4_38  = cmon$+"px1"$+cmoff$+" equal to "$+cmon$+"(1-x).*n, N_i^w"$+cmoff$+" (e.g., number
of whites in the voting age population).";
m_4_39  = cmon$+"px1: N_i^(wN)"$+cmoff$+" (e.g., number of whites who
do not vote).  Requires "$+cgon$+"truthB"$+cgoff$+" and "$+cgon$+"truthW"$+cgoff$+".
See Chapter 2.";
m_4_40  = cmon$+"px1: N_i^(wT)"$+cmoff$+" White turnout (e.g., number 
of whites who vote).  Requires "$+cgon$+"truthB"$+cgoff$+" 
and "$+cgon$+"truthW"$+cgoff$+".  See Chapter 2.";
m_4_41  = cmon$+"2x2: B-hat^b"$+cmoff$+" and "$+cmon$+"B-hat^w"$+cmoff$+" and
standard errors.  See Section 8.3.";
m_4_42  = "scalar: Palmquist's Inflation Factor.
See Equation 3.14, page 52.";
m_4_43  = "character vector of names for "$+cmon$+"\237"$+cmoff$+"
("$+cgon$+"_cml_parnames"$+cgoff$+").";
m_4_44  = "Estimates of phi based on the mode of the 
posterior.  The last two are fixed coefficients
as implied by "$+cgon$+"_Eeta"$+cgoff$+".";
m_4_45  = "If "$+cgon$+"_EisChk"$+cgoff$+"=1, a "$+cgon$+"_Esims"$+cgoff$+" x rows(psi) matrix of 
random simulations of "$+cmon$+"\237"$+cmoff$+"; otherwise, a 
"$+cmon$+"1 x rows(psi)"$+cmoff$+" vector of the mean of the simul-
ations (mean posterior "$+cmon$+"\237"$+cmoff$+"'s).  See Section 8.2.";
m_4_46  = cmon$+"2x5"$+cmoff$+" maximum posterior estimates.  
See Chapter 7.";
m_4_47  = cmon$+"psi"$+cmoff$+", which is computed from reparameterizing 
"$+cmon$+"phi"$+cmoff$+" into "$+cmon$+"psi-u"$+cmoff$+" and then computing "$+cmon$+"psi"$+cmoff$+".  
See Section 6.2.2.";
m_4_48  = cmon$+"5x1"$+cmoff$+": True values of "$+cmon$+"psi"$+cmoff$+".  Requires "$+cgon$+"truthB
"$+cgoff$+"and "$+cgon$+"truthW"$+cgoff$+".  See Table 10.3, page 207.";
m_4_49  = cmon$+"psi-u"$+cmoff$+", which was reparameterized from "$+cmon$+"\237"$+cmoff$+" into 
untruncated scale.  See Equation 7.4,
page 136.";
m_4_50  = "Return code from the maximization procedure.
0 indicates normal convergence.";
m_4_51  = cmon$+"px1"$+cmoff$+" standard error for the estimate of "$+cmon$+"\225_i^b"$+cmoff$+",
based on the standard deviation of its
posterior.  See Section 8.2.";
m_4_52  = cmon$+"px1"$+cmoff$+" standard error for the estimate of "$+cmon$+"\225_i^w"$+cmoff$+",
based on the standard deviation of its
posterior.  See Section 8.2.";
m_4_53  = cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": SORTED simulations of "$+cmon$+"\225_i^b"$+cmoff$+" 
(e.g., 80% confidence interval lower bound 
is in column "$+cmon$+"0.1*"$+cgon$+"_Esims"$+cgoff$+").  See Section 8.2.";
m_4_54  = cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": SORTED simulations of "$+cmon$+"\225_i^w"$+cmoff$+" 
(e.g., 80% confidence interval lower bound 
is in column "$+cmon$+"0.1*"$+cgon$+"_Esims"$+cgoff$+").  See Section 8.2.";
m_4_55  = "A summary of some district-level
information.";
m_4_56  = cmon$+"px1"$+cmoff$+": outcome variable proportion, "$+cmon$+"T_i"$+cmoff$+" 
(e.g. turnout); input to "$+cgon$+"ei"$+cgoff$+".";
m_4_57  = cmon$+"2 x 1"$+cmoff$+": Estimates of "$+cmon$+"B^b|B^w"$+cmoff$+" from Thomsen's
Ecological Logit Model.  See section 6.2.5.";
m_4_58  = "A title that you may have entered in Config
prior to running the model.";
m_4_59  = cmon$+"p x 2"$+cmoff$+": percentile of sorted simulates at which
the true value falls for "$+cmon$+"\225_i^b"$+cmoff$+" and "$+cmon$+"\225_i^w"$+cmoff$+".
Requires "$+cgon$+"truthB"$+cgoff$+" and "$+cgon$+"truthW"$+cgoff$+".  See Figure 10.7,
page 214.";
m_4_60  = cmon$+"p x 2"$+cmoff$+": true values of the precinct-level
quantities of interest "$+cmon$+"\225_i^b ~ \225_i^w"$+cmoff$+".
Must have been specified before running
ei.";
m_4_61  = "The true "$+cmon$+"\225_i^b"$+cmoff$+".  Requires "$+cgon$+"truthB"$+cgoff$+" to have
been entered.";
m_4_62  = "The true "$+cmon$+"\225_i^w"$+cmoff$+".  Requires "$+cgon$+"truthW"$+cgoff$+" to have
been entered.";
m_4_63  = cmon$+"100 x "$+cgon$+"_Esims"$+cmon$+"+1"$+cmoff$+": simulations of "$+cgon$+"T_i"$+cgoff$+" given "$+cgon$+"X_i"$+cgoff$+".
Rows correspond to 100 values of "$+cgon$+"X_i"$+cgoff$+" equally
spaced between 0 and 1; columns are "$+cgon$+"X_i"$+cgoff$+" and
sorted simulations from "$+cgon$+"T_i|X_i"$+cgoff$+". See Sec. 8.5.";
m_4_64  = cmon$+"2 x 2"$+cmoff$+": variance matrix of 2 district-level
parameters, "$+cmon$+"B-hat^b"$+cmoff$+" and "$+cmon$+"B-hat^w"$+cmoff$+".
See Section 8.3.";
m_4_65  = "Variance matrix of phi coefficients, as
affected by "$+cgon$+"_Gh*"$+cgoff$+" global parameters.";
m_4_66  = cmon$+"p x 1"$+cmoff$+": explanatory variable proportion, "$+cgon$+"X_i"$+cgoff$+" 
(e.g., black voting age population);
input to "$+cgon$+"ei"$+cgoff$+".";
m_4_67  = "matrix of covariates for "$+cgon$+"betaB"$+cgoff$+" or 1 for none; 
as affected by "$+cgon$+"_Eeta"$+cgoff$+"; input to "$+cgon$+"ei"$+cgoff$+".
See Section 9.2.1.";
m_4_68  = "matrix of covariates for "$+cgon$+"betaW"$+cgoff$+" or 1 for none; 
as affected by "$+cgon$+"_Eeta"$+cgoff$+"; input to "$+cgon$+"ei"$+cgoff$+".
See Section 9.2.1.";
/* note: rather than renumber all of above labels I'll just insert this
   between m_4_9 and m_4_10 */
m_4_69i = "value of global parameter "$+cgon$+"_eigraph_bvsmth"$+cgoff$+"
(smoothing parameter for nonparametric
density estimation).";

m_4_70  = "value of this global (priors on "$+cmon$+"B-cup"$+cmoff$+").";
m_4_71  = "value of this global (bounds for CML, not
quantities of interest).";
m_4_72  = "value of this global (CML convergence
tolerance).";
m_4_73  = "value of this global (factor to multiply
by estimated variance matrix in the normal 
approximation for use in importance sampling).";
m_4_73a = "value of this global (fixed alpha constraints).";
m_4_73b = "value of this global (Checking importance 
sampling).";
m_4_74  = "value of this global (first stage importance
sampling factor).";
m_4_75  = "Log of mean importance ratio.";
m_4_76  = "value of output global "$+cgon$+"_EnonEval"$+cgoff$+" (number of 
nonparametric density evaluations for each 
tomography line).";
m_4_77  = "value of output global "$+cgon$+"_EnonNumInt"$+cgoff$+" (number of
points to evaluate for numerical integration 
in computing the denominator for bivariate
kernel density).";
m_4_78  = "value of this output global (0, parametric;
or 1, nonparametric estimation).";
m_4_79  = "Actual number of resampling tries.  
Smaller numbers are better; 100 is the 
maximum.";
m_4_80  = "value of this global (prior on "$+cmon$+"rho"$+cmoff$+").
See Section 7.4";
m_4_81  = "value of this global (priors on "$+cmon$+"\229-cup_b"$+cmoff$+" and
"$+cmon$+"\229-cup_b"$+cmoff$+").  See Section 7.4.";
m_4_82  = "value of this global (number of simulations).
See Appendix F.";
m_4_83  = "value of this global when ei was run
(starting values).";

m_4_84  = cmon$+"2 x 1"$+cmoff$+": number of covariates (see Chapter 9),
including implied constant term for "$+cmon$+"Zb|Zw"$+cmoff$+";
also sets this global.";


m_4_85  = "If "$+cgon$+"_EisChk"$+cmon$+"=1"$+cmoff$+", a "$+cgon$+"_Esims"$+cmon$+"*"$+cgon$+"_Eisn"$+cmon$+" x rows(\237)+1"$+cmoff$+" matrix 
w/log of importance ratio as 1st col. and
normal simulations of "$+cmon$+"~\237"$+cmoff$+" as remaining cols.  
Scalar mean importance ratio if "$+cgon$+"_EisChk"$+cmon$+"=0"$+cmoff$+".";      
m_4_88  = "value of this global (Hessian).";
m_4_89  = "value of this global (likelihood falloff 
fraction in computing the Hessian).";
m_4_90  = "value of this global (1=used quadratic 
approach or 2=used direct approach to 
compute the Hessian).";
m_4_91  = "value of this global (1=search for positive
definite Hessian or 0=skip this step [default]).";

m_4rnbbs = cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": random horizontally permuted 
simulations of "$+cmon$+"\225_i^b"$+cmoff$+".  This is essentially 
equivalent to "$+cgon$+"betaB"$+cgoff$+"s except that it randomly 
permutes estimation variation also.";
m_4rnbws = "p x "$+cgon$+"_Esims"$+cgoff$+": random horizontally permuted 
simulations of "$+cmon$+"\225_i^w"$+cmoff$+".  This is essentially 
equivalent to "$+cgon$+"betaW"$+cgoff$+"s except that it randomly 
permutes estimation variation also.";
m_4EalpB = "value of this global (priors on "$+cmon$+"\224^b"$+cmoff$+").";
m_4EalpW = "value of this global (priors on "$+cmon$+"\224^w"$+cmoff$+").";
m_4Ecdf  = "value of this global (method of calculating CDF
of the bivariate normal).";
m_4EdoML = "value of this global (do maxlik).";
m_4EdoMp = "value of this global (input "$+cmon$+"\237"$+cmoff$+"'s).  Only
relevant if "$+cgon$+"_EdoML"$+cmon$+"=0"$+cmoff$+".";
m_4EdoMv = "value of this global (input variance-
covariance of "$+cmon$+"\237"$+cmoff$+"'s).  Only relevant if "$+cgon$+"_EdoML"$+cmon$+"=0"$+cgoff$+".";

m_4EdoSi = "Value of this global (controls whether
simulations are run).";
m_4Emxit = "value of this global (maximum iterations for
CML).";
m_4_Esel = "value of this global (vector of 0/1 to 
delete/select observations during the like-
lihood stage).";
m_4EnumT = "value of this global (numerical tolerance for
homogeneous precincts).";
m_4bvsm  = "value of the global "$+cgon$+"_EIgraph_bvsmth"$+cgoff$+" (smoothing
parameter for nonparametric density evaluation).";
m_4x2    = "for "$+cgon$+"ei2"$+cgoff$+" data buffers only, "$+cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": 
simulations of the explanatory variable 
proportion, "$+cgon$+"x_i"$+cgoff$+" (e.g., black fraction of 
voters).";
m_Nb2 = "for "$+cgon$+"ei2"$+cgoff$+" data buffers only, "$+cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": 
denominator of "$+cgon$+"x2"$+cgoff$+" and "$+cgon$+"V"$+cgoff$+", equal to "$+cmon$+"x2.*n,
N^b_i"$+cgoff$+" (e.g., number of people who turnout).";
m_Nw2 = "for "$+cgon$+"ei2"$+cgoff$+" data buffers only, "$+cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": equal 
to "$+cgon$+"(1-x2).*n, N^w_i"$+cmoff$+" (e.g., number of whites
in the voting age population).";
m_4_v = cmon$+"p x 1"$+cmoff$+": outcome variable proportion, "$+cgon$+"V_i"$+cgoff$+" for "$+cmon$+"2xC"$+cmoff$+"
tables (e.g., Democratic fraction of the 
major party vote); input to "$+cgon$+"ei2"$+cgoff$+".";
m_4_x2rn = "For "$+cgon$+"ei2"$+cgoff$+" data buffers only, "$+cmon$+"p x "$+cgon$+"_Esims"$+cgoff$+": horizont-
ally randomly permuted simulations of the 
explanatory variable proportion, "$+cgon$+"x_i"$+cgoff$+" (e.g.,
black fraction of voters.";
m_4_eivc = "Value of this global ("$+cmon$+"N x 2"$+cmoff$+" matrix 
configuring the search for an estimated
positive definite variance matrix of "$+cmon$+"\237"$+cmoff$+").";
m_4_EisT = "0 (default) to use multivariate normal 
density for initial importance sampling; or
if >2, use the multivariate Student t density, 
with degrees of freedom "$+cgon$+"_Eist"$+cgon$+".";

m_4beta =
cmon$+"px2"$+cmoff$+": point estimate of "$+cmon$+"\225_i^b"$+cmoff$+" (col 1) and "$+cmon$+"\225_i^w"$+cmoff$+" 
(col 2) based on their mean posteriors.  
See section 8.2";

m_4GEbw  = 
cmon$+"px3"$+cmoff$+": "$+cmon$+"\225_i^b"$+cmoff$+" ~ "$+cmon$+"\225_i^w"$+cmoff$+" ~ "$+cgon$+"Nsims"$+cgoff$+".  Point estimates 
of "$+cmon$+"\225_i^b"$+cmoff$+" (col 1) and "$+cmon$+"\225_i^w"$+cmoff$+" (col 2) based on 
their mean posterior, with the assumption that 
"$+cmon$+"\225_i^b"$+cmoff$+" \242 "$+cmon$+"\225_i^w"$+cmoff$+".";

m_4GEbwa = 
cmon$+"px2"$+cmoff$+": "$+cmon$+"B^b"$+cmoff$+" ~ "$+cmon$+"B^w"$+cmoff$+".  Aggregate level mean posterior 
estimates, based on simulations where
"$+cmon$+"\225_i^b"$+cmoff$+" \242 "$+cmon$+"\225_i^w"$+cmoff$+".";

m_4GEwb  = 
cmon$+"px3"$+cmoff$+": "$+cmon$+"\225_i^b"$+cmoff$+" ~ "$+cmon$+"\225_i^w"$+cmoff$+" ~ "$+cgon$+"Nsims"$+cgoff$+".  Point estimates 
of "$+cmon$+"\225_i^b"$+cmoff$+" (col 1) and "$+cmon$+"\225_i^w"$+cmoff$+" (col 2) based on 
their mean posterior, with the assumption that 
"$+cmon$+"\225_i^b"$+cmoff$+" \243 "$+cmon$+"\225_i^w"$+cmoff$+".";

m_4GEwba = 
cmon$+"px2"$+cmoff$+": "$+cmon$+"B^b"$+cmoff$+" ~ "$+cmon$+"B^w"$+cmoff$+".  Aggregate level mean posterior 
estimates, based on simulations where
"$+cmon$+"\225_i^b"$+cmoff$+" \243 "$+cmon$+"\225_i^w"$+cmoff$+".";


/* ...... UTILITIES menu descriptions ....... */

m_5_1 = "General Information about using the Help menu.";
m_5_2 = "People and companies behind "$+cgon$+"EzI"$+cgoff$+" and "$+cgon$+"EI"$+cgoff$+".";

m_5_3 = "General help with "$+cgon$+"EzI"$+cgoff$+" (text version of the
"$+cgon$+"EzI"$+cgoff$+" manual included with the "$+cgon$+"EzI"$+cgoff$+" 
distribution).";
m_5_4 = "Introductory sections of the "$+cgon$+"EI"$+cgoff$+" manual
(text version) including installation
and an overview.";
m_5_5 = "Covers the "$+cgon$+"EI"$+cgoff$+" functions "$+cgon$+"ei()"$+cgoff$+" and "$+cgon$+"ei2()"$+cgoff$+",
from the text version of the "$+cgon$+"EI"$+cgoff$+" manual.";
m_5_6 = "Covers the "$+cgon$+"EI"$+cgoff$+" function "$+cgon$+"eigraph()"$+cgoff$+", 
from the text version of the "$+cgon$+"EI"$+cgoff$+" manual.";
m_5_7 = "Covers the "$+cgon$+"EI"$+cgoff$+" function "$+cgon$+"eiread()"$+cgoff$+",
from the text version of the "$+cgon$+"EI"$+cgoff$+" manual.";
m_5_8 = "Covers the "$+cgon$+"EI"$+cgoff$+" library functions "$+cgon$+"eirepl()"$+cgoff$+",
"$+cgon$+"graphon, loadvars, subdatv"$+cgoff$+", and includes 
Occasionally Asked Questions.  From the
text version of the "$+cgon$+"EI"$+cgoff$+" manual.";

m_5_9 = "README.1ST file included with the "$+cgon$+"EzI"$+cgoff$+" 
distribution.";
m_5_10 = "WHATSNEW.TXT file included with the "$+cgon$+"EI"$+cgoff$+"
distribution; documents the latest changes
to the Gauss library "$+cgon$+"EI"$+cgoff$+".";
m_5_11 = "About "$+cgon$+"EzI"$+cgoff$+" v" $+ eivers $+ ".";
m_5_tut = "A simple "$+cgon$+"EzI"$+cgoff$+" tutorial.";


m_0_0=" ";

m_1_str={ m_1_1 m_1_2 m_1_3 m_1_4 m_1_5 m_1_6 };
m_2_str={ m_2_1 m_2_2 m_2_3 m_2_5 m_2_4 };

m_3_str={ @ config    @  m_3_1  
          @ beta      @  m_3_47 
          @ betaB     @  m_3_45 
          @ betaW     @  m_3_46 
          @ betabw    @  m_3_2  
          @ bias      @  m_3_3  
          @ biasB     @  m_3_4  
          @ biasW     @  m_3_5  
          @ bivar     @  m_3_6  
          @ boundX    @  m_3_9  
          @ boundXB   @  m_3_7  
          @ boundXW   @  m_3_8  
          @ estsims   @  m_3_49
          @ fit       @  m_3_10 
          @ fitT      @  m_3_11 
          @ goodman   @  m_3_12 
          @ lines     @  m_3_13 
          @ movie     @  m_3_48 
          @ nonpar    @  m_3_44 
          @ post      @  m_3_14 
          @ postB     @  m_3_15 
          @ postW     @  m_3_16 
          @ prectB    @  m_3_17 
          @ prectW    @  m_3_18 
          @ ptile     @  m_3_19 
          @ ptileB    @  m_3_20 
          @ ptileW    @  m_3_21 
          @ results   @  m_3rslt
          @ sims      @  m_3_22 
          @ simsB     @  m_3_23 
          @ simsW     @  m_3_24 
          @ TbiasB    @  m_3_25 
          @ TbiasW    @  m_3_26 
          @ Tbivar    @  m_3_27 
          @ Tlines    @  m_3_28 
          @ tomoCI95  @  m_3_30 
          @ tomog     @  m_3_29 
          @ tomogCI   @  m_3_31 
          @ tomogD    @  m_3_32 
          @ tomogE    @  m_3_33 
          @ tomogP    @  m_3_34 
          @ tomogS    @  m_3_35 
          @ tomogT    @  m_3_36 
          @ truth     @  m_3_37 
          @ xgraph    @  m_3_38 
          @ XgraphC   @  m_3_39 
          @ xt        @  m_3_40 
          @ xtC       @  m_3_41 
          @ xtfit     @  m_3_42 
          @ xtfitg    @  m_3_43 
 };

m_4_str={ @ abounds   @  m_4_1   
          @ aggbias   @  m_4_2   
          @ aggs      @  m_4_3   
          @ aggtruth  @  m_4_4   
          @ beta      @  m_4beta   
          @ betaB     @  m_4_5   
          @ betaBs    @  m_4_6   
          @ betaW     @  m_4_7   
          @ betaWs    @  m_4_8   
          @ bounds    @  m_4_9   
          @ CI50b     @  m_4_10  
          @ CI50w     @  m_4_11  
          @ CI80b     @  m_4_12  
          @ CI80bw    @  m_4_13  
          @ CI80w     @  m_4_14  
          @ CI95b     @  m_4_15  
          @ CI95bw    @  m_4_16  
          @ CI95w     @  m_4_17  
          @ coverage  @  m_4_18  
          @ CsbetaB   @  m_4_19  
          @ CsbetaW   @  m_4_20  
          @ dataset   @  m_4_21  
          @ date      @  m_4_22  
          @ Eaggbias  @  m_4_23  
          @ etaC      @  m_4_24  
          @ etaS      @  m_4_25  
          @ expvarci  @  m_4_26  
          @ expvrcis  @  m_4_27  
          @ GEbw      @  m_4GEbw 
          @ GEbwa     @  m_4GEbwa
          @ GEwb      @  m_4GEwb 
          @ GEwba     @  m_4GEwba
          @ GhActual  @  m_4_28  
          @ Goodman   @  m_4_29  
          @ lnir      @  m_4_85  
          @ loglik    @  m_4_30  
          @ Maggs     @  m_4_31  
          @ meanIR    @  m_4_75  
          @ mpPsiu    @  m_4_32  
          @ N         @  m_4_33  
          @ Nb        @  m_4_34  
          @ Nb2       @  m_Nb2
          @ NbN       @  m_4_35  
          @ NbV       @  m_4_36  
          @ nobs      @  m_4_37  
          @ Nt        @  m_4Nt
          @ Nw        @  m_4_38  
          @ Nw2       @  m_Nw2  
          @ NwN       @  m_4_39  
          @ NwV       @  m_4_40  
          @ Paggs     @  m_4_41  
          @ Palmquis  @  m_4_42  
          @ parnames  @  m_4_43  
          @ phi       @  m_4_44  
          @ PhiSims   @  m_4_45  
          @ Pphi      @  m_4_46  
          @ psi       @  m_4_47  
          @ psitruth  @  m_4_48  
          @ psiu      @  m_4_49  
          @ Resamp    @  m_4_79  
          @ retcode   @  m_4_50  
          @ RNbetaBs  @  m_4rnbbs
          @ RNbetaWs  @  m_4rnbws
          @ sbetaB    @  m_4_51  
          @ sbetaW    @  m_4_52  
          @ STbetaBs  @  m_4_53  
          @ STbetaWs  @  m_4_54  
          @ sum       @  m_4_55  
          @ t         @  m_4_56  
          @ titl      @  m_4_58  
          @ truPtile  @  m_4_59  
          @ truth     @  m_4_60  
          @ truthB    @  m_4_61  
          @ truthW    @  m_4_62  
          @ tsims     @  m_4_63  
	  @ V         @  m_4_v
          @ VCaggs    @  m_4_64  
          @ vcphi     @  m_4_65  
          @ x         @  m_4_66
          @ x2        @  m_4x2  
          @ x2rn      @  m_4_x2rn  
          @ Zb        @  m_4_67  
          @ Zw        @  m_4_68  
          @ _EalphaB  @  m_4EalpB
          @ _EalphaW  @  m_4EalpW
          @ _Ebeta    @  m_4_70  
          @ _Ebounds  @  m_4_71
          @ bvsmth    @  m_4bvsm  
          @ _Ecdfbvn  @  m_4Ecdf 
          @ _EdirTol  @  m_4_72  
          @ _EdoML    @  m_4EdoML 
          @ doML_phi  @  m_4EdoMp
          @ doML_vc   @  m_4EdoMv
          @ _EdoSim   @  m_4EdoSi
          @ _Eeta     @  m_4_73a 
          @ _EisChk   @  m_4_73b 
          @ _EisFac   @  m_4_73  
          @ _Eisn     @  m_4_74  
          @ _EisT     @  m_4_EisT  
          @ _EI_vc    @  m_4_eivc
          @ _EmaxItr  @  m_4Emxit
          @ _EnonEva  @  m_4_76  
          @ _EnonNum  @  m_4_77  
          @ _EnonPar  @  m_4_78  
          @ _EnumTol  @  m_4EnumT
          @ _Erho     @  m_4_80  
          @ _Eselect  @  m_4_Esel  
          @ _Esigma   @  m_4_81  
          @ _Esims    @  m_4_82  
          @ _Estval   @  m_4_83  
          @ _Ez       @  m_4_84  
};
/*        @ _GhDelta  @  m_4_88  
          @ _GhFall   @  m_4_89  
          @ _GhQuad   @  m_4_90  
          @ _GhStart  @  m_4_91   */


m_5_str  = { m_5_1 m_5_tut  m_5_3 m_5_4 m_5_5
             m_5_6 m_5_7 m_5_8 m_5_9 m_5_2 m_5_11 };
main_str = { m_1_str m_2_str m_3_str m_4_str m_5_str };



#ENDIF

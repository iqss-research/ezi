
/* EI globals: variable names */
eigl_v0a = "_EalphaB";
eigl_v0b = "_EalphaW";
eigl_v01 = "_Ebeta";
eigl_v02 = "_Ebounds";
eigl_v03 = "_Ecdfbvn";
/* eigl_vEC = "_Echeck"; */
eigl_v04 = "_EdirTol";
eigl_v05 = "_EdoML";
eigl_vdp = "_EdoML_phi";
eigl_vdv = "_EdoML_vcphi";
eigl_v06 = "_EdoSim";
eigl_v07 = "_Eeta";
eigl_v08 = "_EIgraph_bvsmth";
eigl_v09 = "_Eisn";
eigl_v10 = "_EmaxIter";
eigl_v11 = "_EnonEval";
eigl_v12 = "_EnonNumInt";
eigl_v13 = "_EnonPar";
eigl_v14 = "_EnumTol";
eigl_v15 = "_Eprt";
eigl_v16 = "titl";
eigl_v17 = "_Erho";
eigl_v18 = "_Eselect";
eigl_v19 = "_Esigma";
eigl_v20 = "_Esims";
eigl_v21 = "_Estval";
eigl_v22 = "_EisFac";  /* _EisFac in eiread */
eigl_v23 = "_EisChk";  /* eiread as _EisChk, lnir */
eigl_v24 = "_EisT";

eigl_v25 = "_EselRnd";


/* eigl_v24 = "_GhDelta";  
eigl_v25 = "_GhFall";  
eigl_v26 = "_GhQuad";  
eigl_v27 = "_GhStart";  */

eigl_v28 = "_EI2_M";
eigl_v29 = "_EI_vc";
eigl_v30 = "_EcdfTol";


/* EI globals: descriptions */
eigl_d0a = cmon$+"cols(Zb) x 2"$+cmoff$+": matrix of means (in col. 1) and "$+
"standard deviations (in col. 2) 
of an independent normal prior distribution on elements of "$+cmon$+"\224^b"$+
cmoff$+".  If you specify "$+cgon$+"
Zb"$+cgoff$+", you should probably specify a prior, at least "$+
"with mean zero and some 
variance (default = {.}, indicating no prior).";

eigl_d0b = cmon$+"cols(Zw) x 2"$+cmoff$+": matrix of means (in col. 1) and "$+
"standard deviations (in col. 2) 
of an independent normal prior distribution on elements of "$+cmon$+"\224^w"$+
cmoff$+".  If you specify "$+cgon$+"
Zb"$+cgoff$+", you should probably specify a prior, at least "$+
"with mean zero and some 
variance (default = {.}, indicating no prior).";

eigl_d01 = "Standard deviation of the flat normal prior on "
 $+ cmon $+"~B^b" $+
cmoff $+ " and " $+ cmon $+ "~B^w" $+ cmoff $+ ".  The flat normal  "
$+ "prior is uniform within the unit square and dropping outside the square
according to the normal distribution.  Set to zero for no prior.  This keeps
the estimated mode within the unit square.  0.25 is a reasonable beginning.";

eigl_d02 =
"1 if set CML bounds on parameters automatically unless z's are included;
0 if don't use bounds; " $+ cmon $+ "k x 2" $+cmoff$+ " or "$+cmon$+"1 x 2"
$+cmoff$+ " matrix to indicate upper~lower bounds.
(Do not confuse bounds referred to here with the bounds on the quantites of
interest.)  Default = 1.";

eigl_d03 =
"Determines which procedure to use for bivariate normal integral; 1 use the
Gauss function CDFBVN, with some fixes for small values, a fast method, but
still inaccurate for small values (default); 3 use integration of log of the
unit square; often, but not always the most accurate.  See Appendix E.";

eigl_d04 =
"Direction tolerance for CML convergance.  Default = 0.0001.";

eigl_d05 =
"1 do maxlik (default); 0 don't do maxlik, and use " $+ cmon $+ "\237" $+cmoff$+
" in "$+cgon$+"_EdoML_phi"$+cgoff$+" and "$+cmon$+"
vcphi"$+cmoff$+" in 
" $+ cgon $+ "_EdoML_vcphi" $+ cgoff $+ ".";

eigl_ddp = 
"If "$+cgon$+"_EdoML"$+cmon$+"=0"$+cmoff$+", then "$+cgon$+"_EdoML_phi"$+cgoff$+" should include a vector of values of phi to
be used in place of the maximum likelihood stage.";

eigl_ddv = 
"If "$+cgon$+"_EdoML"$+cmon$+"=0"$+cmoff$+", then "$+cgon$+"_EdoML_vc"$+cmoff$+" should include a matrix of values of "$+cgon$+"V(phi)"$+cgoff$+" to
be used in place of the maximum likelihood stage.";

eigl_d06 =
"1 do simulations (default); 0 don't do simulations; -1 don't do simulations
or compute the maxlik variance (use this option for computing conditional
loglik of "$+cgon$+"eta"$+cgoff$+"'s).";

eigl_d07 =
"Set to a 4 x 1 vector of "$+cgon$+"etaB|etaW|se(etaB)|se(etaW)"$+cgoff$+" to fix "$+cmon$+"\224^b"$+cmoff$+" and "$+cmon$+"\224^w"$+cmoff$+",
and their std. errors, during estimation.  Set to a scalar to include "$+cmon$+"X_i
"$+cgoff$+"automatically in inputs zb and zw as follows: "$+cgon$+"_Eeta"$+cmon$+"=0"$+cmoff$+" do not fix "$+cmon$+"\224"$+cmoff$+" (default);
1 set "$+cmon$+"zb=x"$+cmoff$+", "$+cmon$+"zw=1"$+cmoff$+", and estimate "$+cmon$+"\224^w"$+cmoff$+"; 3 set "$+cmon$+"zb=zw=z"$+cmoff$+" and estimate "$+cmon$+"\224"$+cmoff$+".  See Ch 9.";

eigl_d08 =
"A smoothing parameter for nonparametric density estimatation.  Default = 0.08.";

eigl_d09 =
"A factor to multiply "$+cgon$+"_Esims"$+cgoff$+" to compute the number of normals to draw before
resampling.  This is used to try to get "$+cgon$+"_Esims"$+cgoff$+" samples from exact posterior.
Default=10.  See Section 7.5.";

eigl_d10 =
"Maximum number of iterations for CML.  Default = 500.";

eigl_d11 =
"Number of nonparametric density evaluations for each tomography line.
Default = 11.";

eigl_d12 =
"The number of points to evaluate for numerical integration in computing the
denominator for the bivariate kernel density.  Default = 50.";

eigl_d13 =
"0 do not run the nonparametric model (default); 1 run the nonparametric
model.  (When choosing nonparametric estimation, only relevant options will
be available under eigraph and eiread.).  See Section 9.3.2.";

eigl_d14 =
"Numerical tolerance.  A homogeneous precinct is one for which " $+ cmon $+
"X_i > "$+cgon$+"_EnumTol
"$+cgoff$+ "or " $+ cmon $+ "X_i < (1 - "$+cgon$+"_EnumTol)." $+ cmoff
$+"  Default is 0.0001.";

eigl_d15 =
"0 print nothing; 1 print only final output from each stage; 2 also prints
friendly iteration numbers etc. (default); 3 also prints all sorts of checks
along the way.  Use "$+cgon$+"eiread"$+cgoff$+" and "$+cgon$+"eigraph"$+cgoff$+" instead of this global to see output.";

eigl_d16 =
"Add a customized title.  (This is a string label which will be vput as "$+
cgon$+"titl"$+cgoff$+" 
into the EI global "$+cgon$+"_Eres"$+cgoff$+".)";

eigl_d17 =
cgon$+"_Erho[1]"$+cgoff$+": Standard deviation of normal prior on "$+cmon$+"\232_5"$+cmoff$+" for the correlation;
set to 0 to fix "$+cmon$+"\232_5"$+cmoff$+" to a second element, "$+cgon$+"_Erho[2]"$+cmoff$+"; set to <0 to estimate
without a prior.  Default = 0.5.  See Section 7.4";

eigl_d18 =
"Set to 1 for observations to include and 0 to exclude, during likelihood
stage.  "$+cgon$+"EzI"$+cgoff$+" will compute the contours from only the included observations, 
but will still produce estimates of all observations during the simulation 
stage.  Set to scalar 1 to include all observations (default).";

eigl_d19 =
"Standard deviation of an underlying normal distribution, from which a half
normal is constructed as a prior for both "$+cmon$+"~\229^b"$+cmoff$+" and "$+cmon$+"~\229^w"$+cmoff$+".  Note: the
expected value under this prior is "$+cgon$+"_Esigma"$+cmon$+"*\2512/\227 \247"$+cgon$+" _Esigma"$+cmon$+"*0.8"$+cmoff$+".
Set to zero or negative for no prior.  Default = 0.5.  See Section 7.4.";

eigl_d20 = "Number of simulations.  Default = 100.";

eigl_d21 =
"Use best guess starting values (default); or set to vector of starting values.";

eigl_d22 =
"Factor to multiply by estimated variance matrix in the normal approximation 
for use in importance sampling.  Adjust this or "$+cgon$+"_Eisn"$+cgoff$+" if the output global
"$+cgon$+"_Eresamp"$+cgoff$+" is too large.  (Default=4). See Section 7.5.";                    
                                                                     
eigl_d23 =
"0 to do nothing (default); 1 change lnir from the the scalar mean importance
ratio to a "$+cgon$+"_Esims"$+cmon$+"*"$+cgon$+"_Eisn"$+cmon$+" x rows(\237)+1"$+cmoff$+" matrix containing the log of the import-
ance ratio as the first column and "$+cmon$+"~\237"$+cmoff$+" as remaining cols.  Also change "$+cgon$+"PhiSims"$+cgoff$+" 
from mean posterior "$+cmon$+"\237"$+cmoff$+"'s to a "$+cgon$+"_Esims"$+cmon$+" x rows(\237)"$+cmoff$+" matr. of normal simulations of \237."; 



eigl_d24 =
"0 (default) to use multivariate normal density to draw random numbers for 
initial approximation for importance sampling; or if greater than 2, use the 
multivariate Student t density, with degrees of freedom "$+cgon$+"_Eist"$+cgoff$+".  
Use this, "$+cgon$+"_EisFac"$+cgoff$+", or "$+cgon$+"_Eisn"$+cgoff$+" if "$+cgon$+"resamp"$+cgoff$+" is larger than 15 or 20.";

eigl_d25 = 
"Set to scalar 1 to include all observations not already deleted by "$+cgon$+"_Eselect"$+cgoff$+".
(default), or a scalar greater than 0 and less than 1 to randomly select this 
fraction of observations in the estimation stage.  This global is especially 
useful for speeding up estimation in very large datasets.";

/*
eigl_d24 =
"If 0, do nothing (default); if nonzero (try 0.1), force Hessian to be 
positive definite by setting _GhDelta to be the floor for the eigenvalues of 
the Hessian.  If this option is set to greater than zero, the matrix will be 
positive definite on the first try.";
 
eigl_d25 =
"Fraction fall off in the likelihood function for computing step lengths in 
computing Hessian on the first try (default=0.1).";
eigl_d26 =
"1 if use quadradic approximation for computing Hessian; 0 if use the direct 
approach.";
eigl_d27 =
"EI will search for a positive definite Hessian by changing values of _GhDelta,
_GhFall, and _GhQuad.  This global indicates whether to begin the search with
the usual method (if 1) or to skip this step (if 0).  Default=0.";
*/

eigl_d28 =
"Number of data sets to multiply impute (must be less than or equal to "$+cgon$+"_Esims"$+cgoff$+"),
default=4.";

eigl_d29 = 
cmon$+"Mx2"$+cmoff$+" matrix, each row of which represents globals for 1 attempt to compute an 
estimated positive definite variance matrix of "$+cmon$+"\237"$+cmoff$+".  The procedure exits after
the first positive definite hessian is found.  See EI manual for complete 
options.  DEFAULT = 1 0, 2 0.1, 2 0.05, 3 0.1, 1 0.1, 1 0.2.";  

eigl_d30 = 
"Tolerance for the "$+cmon$+"lncdfbvn"$+cmoff$+" function, with smaller calculated values truncated
at the value of this global.  May be any positive number, but only set to 
smaller values if you think you need the precision, such as if most of your 
values of "$+cgon$+"t"$+cgoff$+", "$+cgon$+"x"$+cgoff$+", and "$+cgon$+"n"$+cgoff$+" are small."; 

cmon$+"Mx2"$+cmoff$+" matrix, each row of which represents globals for 1 attempt to compute an 
estimated positive definite variance matrix of "$+cmon$+"\237"$+cmoff$+".  The procedure exits after
the first positive definite hessian is found.  See EI manual for complete 
options.  DEFAULT = 1 0, 2 0.1, 2 0.05, 3 0.1, 1 0.1, 1 0.2.";  

eiglobs = {     eigl_v0a  eigl_d0a  2,
                eigl_v0b  eigl_d0b  2,
                eigl_v01  eigl_d01  2,
                eigl_v02  eigl_d02  0,
                eigl_v03  eigl_d03  0,
                eigl_v04  eigl_d04  6,
                eigl_v05  eigl_d05  0,
                eigl_vdp  eigl_ddp  0,
                eigl_vdv  eigl_ddv  0,
                eigl_v06  eigl_d06  0,
                eigl_v07  eigl_d07  0,
                eigl_v08  eigl_d08  3,
                eigl_v09  eigl_d09  0,
                eigl_v10  eigl_d10  0,
                eigl_v11  eigl_d11  0,
                eigl_v12  eigl_d12  0,
                eigl_v13  eigl_d13  0,
                eigl_v14  eigl_d14  6,
                eigl_v15  eigl_d15  0,
                eigl_v16  eigl_d16  0,
                eigl_v17  eigl_d17  3,
                eigl_v18  eigl_d18  0,
                eigl_v19  eigl_d19  3,
                eigl_v20  eigl_d20  0,
                eigl_v21  eigl_d21  0,
                eigl_v22  eigl_d22  0,  
                eigl_v23  eigl_d23  0,
                eigl_v24  eigl_d24  0,
                eigl_v25  eigl_d25  2,
                eigl_v29  eigl_d29  0,
		eigl_v28  eigl_d28  0,		
		eigl_v30  eigl_d30  6
           };

egglobs = {     eggl_v01  eggl_d01  0,
                eggl_v02  eggl_d02  0,
                eggl_v03  eggl_d03  0,
                eggl_v04  eggl_d04  0,
                eggl_v05  eggl_d05  0,
                eggl_v06  eggl_d06  0,
                eggl_v07  eggl_d07  0,
                eggl_v08  eggl_d08  0,
                eggl_v09  eggl_d09  0,
                eggl_v10  eggl_d10  0,
                eggl_v11  eggl_d11  0,
                eggl_v12  eggl_d12  0,
                eggl_v13  eggl_d13  0,
                eggl_v14  eggl_d14  0,
                eggl_v15  eggl_d15  0,
                eggl_v18  eggl_d18  0,
                eggl_v16  eggl_d16  2,
                eggl_v17  eggl_d17  2,
                eggl_v19  eggl_d19  2,
                eggl_v20  eggl_d20  2
   };

eggl_d01 =
"string: xlabel for "$+cmon$+B$+"_i^b" $+ cmoff $+
" by "$+cmon$+B$+"_i^w"$+cmoff$+
" plots.
Default = \"" $+ cmon $+ "betaB" $+ cmoff $+ "\" ";

eggl_d02 =
"High end for "$+ cgon $+"betaB"$+ cgoff $+" plots.  Default = 1.";

eggl_d03 =
"Low end for "$+ cgon $+"betaB"$+ cgoff $+" plots.  Default = 0.";

eggl_d04 =
"Smoothing parameter for nonparametric density estimation.  Default = 0.08.";

eggl_d05 =
"string: ylabel for "$+cmon$+B$+"_i^b" $+ cmoff $+
" by " $+ cmon $+ B$+"_i^w"$+cmoff$+
" plots.
Default = \"" $+ cmon $+ "betaW" $+ cmoff $+ "\" ";

eggl_d06 =
"High end for "$+ cgon $+"betaW"$+ cgoff $+" plots.  Default = 1.";
eggl_d07 =
"Low end for "$+ cgon $+"betaW"$+ cgoff $+" plots.  Default = 0.";

eggl_d08 =
"If 1, create data buffer called "$+ cgon $+"betaW"$+ cgoff $+" with px, py, pz
inputs to the contour plot when option nonpar is chosen.";

eggl_d09 =
"Number of equally spaced evaluations on each axis of the nonparametric
density evaluation.  Default = 31.";

eggl_d10 =
"1 if show simulated and fitted loess for xtfit;
0 if show fit only (default).";

eggl_d11 =
"Set this to (0,1] to randomly select this fraction of observations to use in
tomography plots.  This is useful if "$+cmon$+"p"$+cmoff$+" is so large that
it is difficult to see patterns.  Default = 1.";

eggl_d12 =
"string: ylabel for xt plots.  "$+
"Default = \"" $+ cmon $+ "T" $+ cmoff $+ "\" ";

eggl_d13 =
"Value to add to line thickness parameter (default = 1).";

eggl_d14 = "string: xlabel for xt plots.  "$+
"Default = \"" $+ cmon $+ "X" $+ cmoff $+ "\" ";

eggl_d15 =
"Multiply by circle size to change sizes.  Default = 1, which means do not
change.  Must ge greater than zero.";

eggl_d18 = 
"If the dbuf is a meta-data buffer (i.e., saved from an EI2 run),  this 
global denotes which of the imputed data buffers stored in dbuf should be 
accessed when running running GRAPHs or READs.  Default = 1.";

eggl_d16 =
"High end of X graphs.  Default = 1.";
eggl_d17 =
"Low end of X graphs.  Default = 0.";

eggl_d19 =
"High end of T graphs.  Default = 1.";
eggl_d20 =
"Low end of T graphs.  Default = 0.";

eggl_v01  =  "_eigraph_bb";
eggl_v02  =  "_eigraph_bbhi";
eggl_v03  =  "_eigraph_bblo";
eggl_v04  =  "_eigraph_bvsmth";
eggl_v05  =  "_eigraph_bw";
eggl_v06  =  "_eigraph_bwhi";
eggl_v07  =  "_eigraph_bwlo";
eggl_v08  =  "_eigraph_dbuf";
eggl_v09  =  "_eigraph_eval";
eggl_v10  =  "_eigraph_loess";
eggl_v11  =  "_eigraph_smpl";
eggl_v12  =  "_eigraph_t";
eggl_v13  =  "_eigraph_thick";
eggl_v14  =  "_eigraph_x";
eggl_v15  =  "_eigraphC";
eggl_v18  =  "_EI2_R";
eggl_v16  =  "_eigraph_Xhi";
eggl_v17  =  "_eigraph_Xlo";
eggl_v19  =  "_eigraph_Thi";
eggl_v20  =  "_eigraph_Tlo";


titl = "";

meditglobs = miss(1,1);

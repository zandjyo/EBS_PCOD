#V3.30.18.00;_safe;_compile_date:_Sep 30 2021;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: BSPcod22_MAY.dat // Model_19_12a.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
 1 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1976 1976
 1977 2007
 1977 1980
#
# controls for all timevary parameters 
3 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity
  #_no additional input for selected M option; read 1P per morph
#
2 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
1.5 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
2 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.1 1 0.434175 0 0 0 6 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 10 20 17.2763 0 0 0 5 0 1 1977 2021 5 0 0 # L_at_Amin_Fem_GP_1
 60 150 100.535 0 0 0 5 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.202815 0 0 0 5 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 10 0.822025 0 0 0 5 0 0 0 0 0 0 0 # Richards_Fem_GP_1
 0 10 3.26164 0 0 0 5 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 10.4365 0 0 0 5 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -10 10 5.30606e-06 0 0 0 -1 202 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -10 10 3.19723 0 0 0 -1 203 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 -10 100 58 0 0 0 -1 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -10 10 -0.132 0 0 0 -1 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -10 10 1 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
 -10 10 1 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm1
 -10 10 0 0 0 0 -1 0 0 0 0 0 2 3 # AgeKeyParm2
 -10 10 0 0 0 0 -1 0 0 0 0 0 2 3 # AgeKeyParm3
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm4
 -10 10 0.085 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm5
 -10 10 1.692 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm6
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm7
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 1e-06 10 0.1804 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_se
 -0.99 0.99 0 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_autocorr
 -10 10 1 0 0 -1 -1 # Wtlen_1_Fem_GP_1_ENV_add
 -10 10 1 0 0 -1 -1 # Wtlen_2_Fem_GP_1_ENV_add
 -10 10 0.324754 0 0 0 1 # AgeKeyParm2_BLK2delta_1977
 -10 10 0.63274 0 0 0 1 # AgeKeyParm3_BLK2delta_1977
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
            12            16       13.8005             0             0             0          3          0          0          0          0          0          0          0 # SR_LN(R0)
           -10            10             1             0             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
           -10            10       0.62595             0             0             0          3          0          0          0          0          0          0          0 # SR_sigmaR
           -10            10             0             0             0             0         -1          0          0          0          0          0          1          1 # SR_regime
         -0.99          0.99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
# timevary SR parameters
 -10 10 -0.875122 0 -1 0 1 # SR_regime_BLK1add_1976
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1977 # first year of main recr_devs; early devs can preceed this era
2020 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 -20 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 1 #_recdev_early_phase
 -1 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1900 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1901 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2020 #_last_yr_fullbias_adj_in_MPD
 2021 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 1 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975E 1976E 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F
#  0.00434864 0.00119417 0.00295764 0.00506936 0.00532016 0.00425682 -0.00253805 -0.0222839 -0.0658396 -0.147041 -0.274396 -0.435209 -0.60302 -0.733743 -0.755692 -0.531919 0.273786 0.745822 -0.148914 1.2306 1.21732 0.576738 0.817278 -0.963334 -0.501729 1.21491 -0.648295 0.685872 0.126546 -0.486809 -0.790481 -0.284616 0.41635 0.197892 -0.16524 0.664694 -0.569993 -0.57186 -0.32653 0.752675 0.119628 -0.0426136 0.302674 0.0086408 -0.78113 -0.398723 -0.616703 -0.979214 -0.903293 0.550516 0.0393348 0.968201 -0.611547 0.26352 0.993724 0.250489 1.12851 -0.408404 -0.257083 -0.948795 -1.08528 0.682637 0.381874 -0.0183624 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.2 # F ballpark value in units of annual_F
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
3 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 1
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 0 1 0.124954 0 0 0 1 # InitF_seas_1_flt_1Fishery
#
# F rates by fleet x season
# Yr:  1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Fishery 0.167617 0.206037 0.125747 0.0692101 0.0698537 0.0585916 0.0776746 0.0974217 0.117282 0.10599 0.121057 0.161932 0.158899 0.189257 0.285093 0.293257 0.210774 0.282898 0.364467 0.361879 0.466676 0.373567 0.379522 0.338558 0.275573 0.267954 0.284658 0.309595 0.351549 0.38081 0.373298 0.473446 0.587254 0.50456 0.56761 0.56651 0.464351 0.510428 0.482997 0.431301 0.347792 0.237373 0.226297 0.211524 0.212594 0.428944 0.428944 0.428944 0.427823 0.428944 0.428345 0.426131 0.42511 0.424826 0.424814 0.424854 0.424882
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         2         1         0         1         0         0  #  Survey
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
          -1           1         -0.2             0             0             0          4          0          0          0          0          0          0          0  #  LnQ_base_Survey(2)
             0            10      0.127914             0             0             0          7          0          0          0          0          0          0          0  #  Q_extraSD_Survey(2)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_2;  parm=6; modification of pattern 24 with improved sex-specific offset
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 Fishery
 0 0 0 0 # 2 Survey
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 0 0 0 0 # 1 Fishery
 20 0 0 0 # 2 Survey
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   Fishery LenSelex
            10            80        72.937          -999          -999             0          1          0          2       1977       2021          1          0          0  #  Size_DblN_peak_Fishery(1)
           -10            10      -2.46411          -999          -999             0          1          0          2       1977       2021          1          0          0  #  Size_DblN_top_logit_Fishery(1)
           -10            10       5.93143          -999          -999             0          1          0          2       1977       2021          1          0          0  #  Size_DblN_ascend_se_Fishery(1)
           -10            10      -9.79532          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fishery(1)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fishery(1)
           -10            10       1.67367          -999          -999             0          1          0          2       1977       2021          1          0          0  #  Size_DblN_end_logit_Fishery(1)
# 2   Survey LenSelex
# 1   Fishery AgeSelex
# 2   Survey AgeSelex
           0.1            10        3.1778          -999          -999             0          1          0          2       1982       2021          1          0          0  #  Age_DblN_peak_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_top_logit_Survey(2)
           -10             5       1.59026          -999          -999             0          1          0          2       1982       2021          1          0          0  #  Age_DblN_ascend_se_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_descend_se_Survey(2)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_start_logit_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_end_logit_Survey(2)
#_Dirichlet parameters
#_multiple_fleets_can_refer_to_same_parm;_but_list_cannot_have_gaps
           -10            10       1.13218             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_1
           -10            10      0.138626             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_2
           -10            10       1.06419             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_3
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
         1e-06            10           0.8             0             0             0      -9  # Size_DblN_peak_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_peak_Fishery(1)_dev_autocorr
         1e-06            10           0.8             0             0             0      -9  # Size_DblN_top_logit_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_top_logit_Fishery(1)_dev_autocorr
         1e-06            10           0.8             0             0             0      -9  # Size_DblN_ascend_se_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_ascend_se_Fishery(1)_dev_autocorr
         1e-06            10           0.8             0             0             0      -9  # Size_DblN_end_logit_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_end_logit_Fishery(1)_dev_autocorr
         1e-06            10           0.8             0             0             0      -9  # Age_DblN_peak_Survey(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_peak_Survey(2)_dev_autocorr
         1e-06            10           0.8             0             0             0      -9  # Age_DblN_ascend_se_Survey(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_ascend_se_Survey(2)_dev_autocorr
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      1     2     1     0     0     0     0     1     1  1977  2021     5 -1.03302 -0.268352 -0.764244 -0.291545 -0.72344 -0.673662 0.565191 0.240424 -0.976388 0.329392 0.169839 -0.117827 -0.611448 -0.122864 0.0566032 -0.00400663 0.737213 -0.349732 -0.835249 -0.0695835 0.166507 -0.411849 -0.352956 -0.087864 -0.308633 0.36537 0.445069 0.561267 0.826351 0.960501 1.50076 1.00719 -0.521117 -0.149269 -0.995414 0.842778 -0.0113284 -0.33565 0.264622 0.270068 -1.47101 3.24473 1.94248 0.753624 -3.76074
#      1     8     3     0     0     2     2     0     0     0     0     0
#      1     9     4     0     0     2     3     0     0     0     0     0
#      1    16     5     2     3     0     0     0     0     0     0     0
#      1    17     6     2     3     0     0     0     0     0     0     0
#      2     4     7     1     1     0     0     0     0     0     0     0
#      5     1     8     0     0     0     0     2     2  1977  2021     1 -0.224025 -0.795986 -0.701695 -0.24541 -0.152979 0.577561 0.439862 0.175479 -1.81574 -0.891629 2.29854 1.75588 1.43088 3.28657 -1.17566 0.947276 -0.850035 -0.568316 -1.27954 1.63434 1.8596 -1.90439 0.204105 -0.0614323 1.05598 -1.78037 -2.26077 -2.94006 -2.09369 -1.16197 -0.720607 -0.658211 -1.38421 2.98881 -1.40485 2.27771 -0.569241 1.45013 0.92624 0.556088 1.45181 0.384372 -0.590004 1.10474 -0.576947
#      5     2    10     0     0     0     0     3     2  1977  2021     1 -0.195766 -0.365891 -0.493905 0.0176221 -0.189206 0.108522 0.142021 0.149933 -0.138671 -0.417671 0.370801 0.756273 1.02161 0.450186 0.459058 -0.0648045 0.178675 0.332537 -0.227977 0.182467 0.17993 -0.0236234 0.171013 0.790157 -0.129631 -1.12313 0.0913847 -1.25274 0.0379528 -0.28041 -0.502624 -0.497479 -0.163503 0.149708 -0.699814 -0.561503 -0.00783567 -0.771678 -0.53984 0.899145 0.545551 0.74144 0.855078 0.562903 -0.54434
#      5     3    12     0     0     0     0     4     2  1977  2021     1 0.269833 -0.205057 -0.179668 0.380235 0.462588 0.0586623 0.179239 0.685586 0.458953 0.768214 0.490369 0.612918 0.380266 -0.144819 -0.204062 0.0890293 0.0856955 -0.0149578 0.0743602 -0.0501828 0.0476266 -0.382238 -0.226543 -0.184757 -0.176902 0.0517062 -0.125317 -0.0789375 -0.164487 -0.152747 -0.0101468 -0.00804546 -0.233879 0.0631652 -0.248368 0.000736611 -0.0251256 -0.0882018 -0.36411 -0.490176 -0.432313 -0.261613 -0.421493 0.181639 -0.467775
#      5     6    14     0     0     0     0     5     2  1977  2021     1 -0.933003 -1.26593 -1.66269 0.197256 -0.282241 0.715356 0.432412 0.417966 -0.611232 -0.665085 1.28222 1.05648 1.2598 1.59459 1.14015 -0.155828 0.0612477 -0.249279 -0.351358 2.02328 0.303303 0.197691 -0.0428599 0.467771 0.82871 -0.361581 -0.064405 -0.554043 -0.3054 1.84646 1.62492 -0.0990421 -1.28243 -1.41591 -0.0750101 -0.926317 -1.09007 -1.36263 -0.955859 -1.17282 -0.741854 0.175535 -0.802452 1.07916 0.725512
#      5     7    16     0     0     0     0     6     2  1982  2021     1 2.36514 0.75051 1.25584 -0.978437 -1.37149 -0.0905327 -0.448212 2.67805 0.624872 -1.01502 -1.27839 -0.863397 -0.425588 -1.29973 -0.732814 0.0937421 -0.252642 1.27231 1.75479 -1.70524 0.0847673 -0.579203 -0.0211898 -0.758812 -2.3196 -1.70537 1.03116 0.162648 0.66736 -0.50974 -0.225803 1.32466 1.45668 0.322056 1.80491 -0.142113 0.159404 -1.41576      0 0.342654
#      5     9    18     0     0     0     0     7     2  1982  2021     1 0.944107 0.268388 0.692029 -0.377248 -2.30503 0.190018 -1.43683 0.606415 1.15964 -1.20297 -0.251898 -0.191253 0.32478 -2.12794 -1.61767 -0.464878 -1.18645 0.366098 1.02009 0.22049 -0.0885889 -0.0524676 0.0465139 0.175843 0.0703474 0.225962 0.504047 1.11736 0.0354176 0.94991 0.229083 0.198988 1.02404 -0.0210415 0.862636 0.923397 0.112483 0.294946      0 -1.23801
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      4      1         1
      4      2         8
      5      2         1
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  1 #_CPUE/survey:_2
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  0 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999


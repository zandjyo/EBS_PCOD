#V3.30.20.00;_safe;_compile_date:_Sep 30 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.0
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: BSPcod23C.dat // Model_19_12a.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
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
 1964 2006
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
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
2 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
1.5 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0 1 0.41 0 0 0 1 0 5 1977 2022 4 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 10 25 17.1597 0 0 0 2 0 5 1977 2022 4 0 0 # L_at_Amin_Fem_GP_1
 80 150 107.309 0 0 0 2 0 5 1977 2022 4 0 0 # L_at_Amax_Fem_GP_1
 0 0.3 0.174992 0 0 0 2 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 1 0.970971 0 0 0 2 0 0 0 0 0 0 0 # Richards_Fem_GP_1
 0 0.2 0.15555 0 0 0 2 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0 0.1 0.0488003 0 0 0 2 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -10 10 5.40706e-06 0 0 0 -1 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -10 10 3.19601 0 0 0 -1 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
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
 1e-06 10 0.1 0 0 0 -1 # NatM_uniform_Fem_GP_1_dev_se
 -0.99 0.99 0 0 0 0 -1 # NatM_uniform_Fem_GP_1_dev_autocorr
 1e-06 10 0.1804 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_se
 -0.99 0.99 0 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_autocorr
  1e-06 10 0.2 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_se
 -0.99 0.99 0 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_autocorr
 -1 1 0.3 0 0 0 -2 # AgeKeyParm2_BLK2delta_1964
 -1 2 1.3 0 0 0 -2 # AgeKeyParm3_BLK2delta_1964
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
            10            16       13.5            0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           -10            10             1             0             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
           -10            10        0.6651             0             0             0         -1          0          0          0          0          0          0          0 # SR_sigmaR
           -10            10             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_regime
         -0.99          0.99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
3 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1977 # first year of main recr_devs; early devs can preceed this era
2020 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 -20 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 1 #_recdev_early_phase
 -1 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1945.3 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1980.5 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2016.9 #_last_yr_fullbias_adj_in_MPD
 2083 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.9824 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
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
#  1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975E 1976E 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F 2035F 2036F 2037F
#  -0.415072 -0.505273 -0.597657 -0.695684 -0.794655 -0.88985 -0.97984 -1.12872 -1.22498 -1.33048 -1.42407 -1.49175 -1.54427 -1.55087 -1.48078 -1.32646 -0.660297 -0.305236 -0.721562 0.0252172 0.923242 0.742451 0.826605 -0.406842 -0.380057 1.18056 -0.461251 1.04378 0.235098 -0.329724 -0.450847 -0.209567 0.608584 0.303303 0.162062 0.934968 0.049996 -0.00204713 -0.0106774 0.924281 0.12272 -0.279672 0.588787 0.387882 -0.419491 0.125617 -0.0557589 -0.536706 0.253183 0.638985 0.101025 1.05908 -0.318202 0.6923 1.01342 0.318426 1.11428 -0.260517 0.0176324 -0.58575 -0.32976 1.00244 -0.404996 -0.306222 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
 0 0.2 0.00986708 0 0 0 1 # InitF_seas_1_flt_1trawl
#
# F rates by fleet x season
# Yr:  1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036 2037
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# trawl 0.0164284 0.0198339 0.0270696 0.0535275 0.113403 0.11942 0.208092 0.157951 0.18953 0.303986 0.496238 0.567453 0.700954 0.457594 0.368192 0.185173 0.0752976 0.0935348 0.128495 0.12036 0.098193 0.0962929 0.0982303 0.116548 0.246663 0.266527 0.294413 0.23094 0.147768 0.157688 0.125864 0.168159 0.212261 0.225395 0.158296 0.146252 0.130914 0.111101 0.0940651 0.111896 0.115966 0.119394 0.140488 0.11794 0.0928058 0.101802 0.109469 0.14137 0.208038 0.14651 0.147873 0.165942 0.176857 0.128561 0.0962449 0.0788839 0.0933964 0.079582 0.100638 0.112261 0.112261 0.112261 0.112261 0.112261 0.112261 0.112261 0.112261 0.111904 0.111332 0.111131 0.111095 0.111111 0.111133 0.111148
# longline 8.94029e-05 0 6.08242e-06 9.05915e-05 0 7.53932e-05 2.74637e-05 0.00305623 0.00622271 0.00404636 0.000753669 0.0143201 0.0192231 0.0194814 0.0432985 0.0159597 0.0202086 0.0160001 0.00857839 0.00924418 0.0291648 0.0424629 0.0349017 0.0540588 0.00251416 0.0186132 0.0714483 0.146114 0.180033 0.104948 0.157111 0.182024 0.20333 0.243918 0.204682 0.211011 0.219522 0.175262 0.183275 0.198226 0.203414 0.226406 0.247622 0.238071 0.303883 0.387147 0.323252 0.312102 0.383238 0.247912 0.300084 0.291419 0.206565 0.217505 0.132153 0.127551 0.114167 0.100951 0.121766 0.116298 0.116298 0.116298 0.116298 0.116298 0.116298 0.116298 0.116298 0.115928 0.115336 0.115127 0.11509 0.115106 0.115129 0.115145
# pot 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000961896 0 0 0 0 0 3.34883e-05 0 0 0.000122601 1.54621e-06 0.000530514 0.000258826 0.0025364 0.00842666 0.0253472 0.00758071 0.021548 0.0503574 0.0905759 0.0589597 0.0420037 0.0496278 0.068337 0.0455696 0.0390002 0.0654389 0.049512 0.0466104 0.0701721 0.0732144 0.0806074 0.084003 0.111471 0.109669 0.12343 0.0825076 0.128615 0.121924 0.104965 0.107952 0.0690715 0.07669 0.0776702 0.0705149 0.11386 0.036415 0.036415 0.036415 0.036415 0.036415 0.036415 0.036415 0.036415 0.0362991 0.0361136 0.0360481 0.0360366 0.0360417 0.0360488 0.0360539
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         4         1         0         0         0         0  #  survey
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -3             3             0             0             0             0         8          0          0          0          0          0          0          0  #  LnQ_base_survey(4)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
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
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 0 0 0 0 # 1 trawl
 0 0 0 0 # 2 longline
 0 0 0 0 # 3 pot
 0 0 0 0 # 4 survey
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
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
 20 0 0 0 # 1 trawl
 20 0 0 0 # 2 longline
 20 0 0 0 # 3 pot
 20 0 0 0 # 4 survey
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   trawl LenSelex
# 2   longline LenSelex
# 3   pot LenSelex
# 4   survey LenSelex
# 1   trawl AgeSelex
             0            12       5.37396          -999          -999             0          4          0          1       1977       2022          5          0          0  #  Age_DblN_peak_trawl(1)
           -10            10       1.64703          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_trawl(1)
           -10            10       1.12107          -999          -999             0          4          0          2       1977       2022          5          0          0  #  Age_DblN_ascend_se_trawl(1)
           -10            10     -0.100046          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_trawl(1)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_start_logit_trawl(1)
           -10            10       8.69139          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_trawl(1)
# 2   longline AgeSelex
             0            12       4.04176          -999          -999             0          4          0          1       1978       2022          5          0          0  #  Age_DblN_peak_longline(2)
           -10            10            10          -999          -999             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_longline(2)
           -10            10      -9.99956          -999          -999             0          4          0          2       1978       2022          5          0          0  #  Age_DblN_ascend_se_longline(2)
           -10            10             0          -999          -999             0         -4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_longline(2)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_start_logit_longline(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_end_logit_longline(2)
# 3   pot AgeSelex
             0            12       5.34317          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_peak_pot(3)
           -10            10           -10          -999          -999             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_pot(3)
           -10            10      -0.48754          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_pot(3)
           -10            10           -10          -999          -999             0         -4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_pot(3)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_start_logit_pot(3)
           -10            10      0.638498          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_pot(3)
# 4   survey AgeSelex
             0            12      0.970173          -999          -999             0          4          0          1       1982       2022          5          0          0  #  Age_DblN_peak_survey(4)
           -10            10      0.452268          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_survey(4)
           -10            10           -10          -999          -999             0          4          0          2       1982       2022          5          0          0  #  Age_DblN_ascend_se_survey(4)
           -10            10      -7.91076          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_survey(4)
           -10            10           -10          -999          -999             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_survey(4)
           -10            10      0.659868          -999          -999             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_survey(4)
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
         1e-06            10           0.2             0             0             0      -9  # Age_DblN_peak_trawl(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_peak_trawl(1)_dev_autocorr
         1e-06            10           0.2             0             0             0      -9  # Age_DblN_ascend_se_trawl(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_ascend_se_trawl(1)_dev_autocorr
         1e-06            10           0.2             0             0             0      -9  # Age_DblN_peak_longline(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_peak_longline(2)_dev_autocorr
         1e-06            10           0.2             0             0             0      -9  # Age_DblN_ascend_se_longline(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_ascend_se_longline(2)_dev_autocorr
         1e-06            10           0.2             0             0             0      -9  # Age_DblN_peak_survey(4)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_peak_survey(4)_dev_autocorr
         1e-06            10           0.2             0             0             0      -9  # Age_DblN_ascend_se_survey(4)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Age_DblN_ascend_se_survey(4)_dev_autocorr
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
#      1     1     1     0     0     0     0     1     5  1977  2022     1 0.0815841 -0.00605802 -0.0819019 -0.083451 -0.0787269 0.195596 0.674475 0.18636 -0.0517577 0.504493 1.35599 1.97963 0.958561 -0.640022 -1.92124 -2.6388 -2.35065 -0.208491 2.17432 2.75651 1.68094 0.0397529 -0.851493 -1.77629 -1.44674 -0.391008 0.129937 0.436432 0.493173 0.674493 0.255965 -0.854593 -1.46507 -1.4193 -0.998545 -0.543839 -1.02207 -1.07466 -0.177203 0.368043 -0.230233 -0.776665 -0.642152 -0.698976 -0.554801 -0.21472
#      1     2     3     0     0     0     0     2     5  1977  2022     2 -1.13599 0.28616 0.134283 -0.0910853 -0.886742 -2.48434 1.20791 1.99773 -2.52984 1.07097 0.0997496 -0.103421 -2.45917 -1.13673 0.316581 -0.491611 1.45649 1.07615 0.493615 0.217858 -1.8681 -0.70388 -2.50055 0.654678 0.6362 1.26448 -0.529499 1.63832 -2.89154 -3.34962 -3.73318 -3.05995 -2.80875 0.624323 -4.43494 -0.454937 -0.579515 -0.794245 4.19148 2.25478 3.50417 5.8396 1.3168 3.89224 1.39769 3.73451
#      1    16     5     2     3     0     0     0     0     0     0     0
#      1    17     6     2     3     0     0     0     0     0     0     0
#      5     1     7     0     0     0     0     3     1  1977  2022     5 0.0403192 -0.0695054 -0.186629 -0.676977 -0.258435 0.36016 0.222685 -0.387945 -0.961651 -0.966179 0.340955 0.265615 0.599001 0.857356 -0.0577616 -0.336727 -0.101417 -0.475831 -0.392072 0.275297 0.329686 0.136975 0.187349 0.00764362 0.542487 -0.00340212 0.407436 0.210577 0.249545 0.163082 -0.22327 -0.437001 -0.511813 -0.0730298 -0.261943 0.257128 -0.188181 0.0703944 0.368147 0.467659 0.216114 0.355345 0.386063 0.762733 0.20215 0.597193
#      5     3     9     0     0     0     0     4     2  1977  2022     5 -0.311791 -1.29438 -1.30003 -2.32297 -0.704613 0.255359 0.122674 -0.0454135 -3.45594 -2.61254 1.84956 1.14649 1.72888 1.61814 -0.757409 -1.06269 -0.446037 -1.70206 -1.24437 0.476587 0.968624 -0.170835 0.393214 -0.331212 1.15091 0.455549 1.06453 0.950121 0.681415 0.31637 -0.573396 -0.966911 -2.08899 0.185269 -0.937056 0.66212 -0.25577 0.350719 0.787288 0.895043 -0.197632 1.04611 1.16155 3.18359 -0.337927 1.37004
#      5     7    11     0     0     0     0     5     1  1978  2022     5 -0.00584885 -0.0178642 -0.105325 -0.00583449 0.0254431 0.0264305 -0.0274959 -0.0207705 0.0131347 -0.0335544 -0.0207686 0.0596237 0.131766 0.0355663 -0.0148055 -0.0154595 0.0102842 -0.0168318 0.0110715 0.001466 -0.0156548 -0.0234444 -0.00459094 -0.0274717 -0.493666 -0.0181805 -0.0160797 -0.0185305 -0.014791 0.0114737 -0.0154599 -0.0124346 0.0151805 -0.0172387 0.010338 -0.0181451 -0.0105232 0.018445 -0.0274359 0.0132292 -0.0150763 -0.0274903 -0.0640324 -0.0207741 -0.00406463
#      5     9    13     0     0     0     0     6     2  1978  2022     5 5.8993e-09 -5.9212e-05 -6.58032e-08 -1.52281e-08 1.56954e-08 2.07137e-09 -0.0529603 3.60355e-08 -1.00653e-08 1.82153e-08 -7.04519e-09 6.45467e-09 4.05177e-08 1.17395e-08 -2.203e-05 -1.56245e-05 6.91129e-09 -4.11948e-05 -4.4874e-09 9.57384e-10 -3.32186e-05 5.15268e-05 -1.06241e-08 -0.0959008 -6.48635e-09 -5.12576e-06 1.63905e-06 -1.6601e-05 1.7162e-05 -1.1889e-08 -0.00068596 -0.000107889 2.25223e-09 -0.000335938 -5.97051e-10 -7.62673e-05 -6.09081e-06 2.0872e-08 -0.160287 7.92863e-09 -0.000156087 -0.062471 -1.67231e-08 1.3936e-07 1.41681e-08
#      5    19    15     0     0     0     0     7     1  1982  2022     5 0.0851001 0.0865173 0.0846485 0.083511 0.0853637 0.0834132 0.0852699 0.0866158 0.0853259 0.085425 0.083687 0.0799561 0.0833863 0.0854082 0.0857672 0.0875305 0.0859149 0.0856291 0.086279 -0.722059 0.0842638 0.0837392 0.0846038 -0.481787 0.10166 -1.29365 0.0845326 0.0980005 0.0848847 -0.0573951 -0.127028 0.0855798 0.0835646 0.084284 0.0842288 0.0843513 0.0850575 0.170997      0 -0.343699 0.11094
#      5    21    17     0     0     0     0     8     2  1982  2022     5 -0.276531 -0.528563 -0.200091 -0.0332138 -0.324831 -0.0232769 -0.307734 -0.54482 -0.31693 -0.335448 -0.0600596 -0.00137815 -0.0186152 -0.331715 -0.394653 -0.711797 -0.421408 -0.370918 -0.486851 -2.48859e-09 -0.137322 -0.060204 -0.195112 -3.12747e-09 0.000298272 -1.65777e-08 -0.177246 0.000616388 -0.239619 5.15215e-09 -6.75769e-09 -0.361637 -0.0313808 -0.139453 -0.129256 -0.149838 -0.269777 -0.000535958      0 -1.58957e-08 0.000283325
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
      4      1   1.24
      4      2   5.18
      4      3   2.05
      4      4   0.95
      5      1   3.54
      5      2   1.43
      5      3   3.12
      5      4   1.49
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
#  0 #_CPUE/survey:_2
#  0 #_CPUE/survey:_3
#  1 #_CPUE/survey:_4
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  1 #_lencomp:_3
#  1 #_lencomp:_4
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  1 #_agecomp:_4
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_init_equ_catch3
#  1 #_init_equ_catch4
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


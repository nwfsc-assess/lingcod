#V3.30
#C control file for 2021 Lingcod North assessment
#C modified using models/model_bridging_change_ctl.R
#C see https://github.com/iantaylor-NOAA/Lingcod_2021/ for info
#C file written to models/2021.n.022.001_new_INIT
#C at 2021-06-27 13:17:07
#
0 # 0 means do not read wtatage.ss; 1 means read and usewtatage.ss and also read and use growth parameters
1 #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern
4 # recr_dist_method for parameters
1 # not yet implemented; Future usage:Spawner-Recruitment; 1=global; 2=by area
1 # number of recruitment settlement assignments 
0 # unused option
# for each settlement assignment:
#_GPattern	month	area	age
1	1	1	0	#_recr_dist_pattern1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
8 #_Nblock_Patterns
3 4 2 2 2 6 3 2 #_blocks_per_pattern
#_begin and end years of blocks
1993 1997 1998 2010 2011 2020 #_Comm_Trawl_sel
1998 2006 2007 2009 2010 2010 2011 2020 #_Comm_Trawl_ret_infl
1998 2010 2011 2020 #_Comm_Trawl_ret_width
1998 2010 2011 2020 #_Comm_Fix_ret_infl
1998 2010 2011 2020 #_Comm_Fix_ret_width
1987 1994 1995 1997 1998 2006 2007 2010 2011 2016 2017 2020 #_Rec_WA_sel
1995 1997 1998 2006 2007 2020 #_Rec_OR_sel
1999 2010 2011 2020 #_Rec_CA_sel
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#
# AUTOGEN
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
#_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr;5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
14 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0 #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
2 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn
 5.0e-02	  0.800000	 4.12604e-01	-1.20397	0.438	3	 7	0	0	0	0	0.5	0	0	#_NatM_p_1_Fem_GP_1        
 4.0e+00	 60.000000	 1.26866e+01	 0.00000	0.000	0	 1	0	0	0	0	0.5	0	0	#_L_at_Amin_Fem_GP_1       
 4.0e+01	130.000000	 1.05089e+02	 0.00000	0.000	0	 7	0	0	0	0	0.5	0	0	#_L_at_Amax_Fem_GP_1       
 1.0e-02	  0.500000	 1.51966e-01	 0.00000	0.000	0	 3	0	0	0	0	0.5	0	0	#_VonBert_K_Fem_GP_1       
 1.0e-02	  0.500000	 1.90884e-01	 0.00000	0.000	0	 4	0	0	0	0	0.5	0	0	#_CV_young_Fem_GP_1        
 1.0e-02	  0.500000	 3.97440e-02	 0.00000	0.000	0	 4	0	0	0	0	0.0	0	0	#_CV_old_Fem_GP_1          
-3.0e+00	  3.000000	 2.80223e-06	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Wtlen_1_Fem_GP_1         
-3.0e+00	  5.000000	 3.27656e+00	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Wtlen_2_Fem_GP_1         
-3.0e+00	100.000000	 3.23000e+00	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Mat50%_Fem_GP_1          
-5.0e+00	  5.000000	-2.94200e+00	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Mat_slope_Fem_GP_1       
-3.0e+00	  3.000000	 1.00000e+00	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Eggs/kg_inter_Fem_GP_1   
-3.0e+00	  3.000000	 0.00000e+00	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Eggs/kg_slope_wt_Fem_GP_1
 1.5e-01	  0.800000	 4.09054e-01	-0.87855	0.438	3	 7	0	0	0	0	0.5	0	0	#_NatM_p_1_Mal_GP_1        
 1.0e+01	 60.000000	 1.80180e+01	 0.00000	0.000	0	 2	0	0	0	0	0.5	0	0	#_L_at_Amin_Mal_GP_1       
 4.0e+01	110.000000	 7.61938e+01	 0.00000	0.000	0	 2	0	0	0	0	0.5	0	0	#_L_at_Amax_Mal_GP_1       
 1.0e-02	  1.000000	 2.81452e-01	 0.00000	0.000	0	 3	0	0	0	0	0.5	0	0	#_VonBert_K_Mal_GP_1       
 1.0e-02	  0.500000	 1.08354e-01	 0.00000	0.000	0	 4	0	0	0	0	0.5	0	0	#_CV_young_Mal_GP_1        
 1.0e-02	  0.500000	 7.47147e-02	 0.00000	0.000	0	 4	0	0	0	0	0.0	0	0	#_CV_old_Mal_GP_1          
-3.0e+00	  3.000000	 1.49298e-06	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Wtlen_1_Mal_GP_1         
-5.0e+00	  5.000000	 3.44489e+00	 0.00000	0.000	0	-3	0	0	0	0	0.5	0	0	#_Wtlen_2_Mal_GP_1         
 1.0e-01	 10.000000	 1.00000e+00	 1.00000	1.000	0	-1	0	0	0	0	0.0	0	0	#_CohortGrowDev            
 1.0e-06	  0.999999	 5.00000e-01	 0.00000	0.000	0	-3	0	0	0	0	0.0	0	0	#_FracFemale_GP_1          
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; 2=Ricker; 3=std_B-H; 4=SCAA;5=Hockey; 6=B-H_flattop; 7=survival_3Parm;8=Shepard_3Parm
0 # 0/1 to use steepness in initial equ recruitment calculation
0 # future feature: 0/1 to make realized sigmaR a function of SR curvature
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn # parm_name
 5.0	15.00	9.671560	0.000	0.000	0	  1	0	0	0	0	0	0	0	#_SR_LN(R0)  
 0.2	 0.99	0.801331	0.777	0.113	2	  4	0	0	0	0	0	0	0	#_SR_BH_steep
 0.0	 2.00	0.600000	0.000	0.000	0	 -3	0	0	0	0	0	0	0	#_SR_sigmaR  
-5.0	 5.00	0.000000	0.000	0.000	0	 -5	0	0	0	0	0	0	0	#_SR_regime  
 0.0	 2.00	0.000000	0.000	0.000	0	-50	0	0	0	0	0	0	0	#_SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1960 # first year of main recr_devs; early devs can preceed this era
2018 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase
1 # (0/1) to read 13 advanced options
1889 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
6 #_recdev_early_phase
0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1 #_lambda for Fcast_recr_like occurring before endyr+1
1960.4999 #_last_yr_nobias_adj_in_MPD; begin of ramp
1981.5064 #_first_yr_fullbias_adj_in_MPD; begin of plateau
2018.2864 #_last_yr_fullbias_adj_in_MPD
2019.8742 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
0.9566 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
0 #_period of cycles in recruitment (N parms read below)
-4 #min rec_dev
4 #max rec_dev
0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
#Fishing Mortality info
0.1 # F ballpark
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4 # max F or harvest rate, depends on F_Method
5 # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 0
#
#_Q_setup for fleets with cpue or survey data
#_fleet	link	link_info	extra_se	biasadj	float  #  fleetname
    1	1	0	1	0	1	#_1_Comm_Trawl 
    2	1	0	1	0	1	#_2_Comm_Fix   
    3	1	0	1	0	1	#_3_Rec_WA     
    4	1	0	1	0	1	#_4_Rec_OR     
    5	1	0	1	0	1	#_5_Rec_CA     
    6	1	0	1	0	1	#_6_Surv_TRI   
    7	1	0	0	0	1	#_7_Surv_WCGBTS
-9999	0	0	0	0	0	#_terminator   
#_Q_parms(if_any);Qunits_are_ln(q)
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
-15	15	 -1.1038600	0	0	0	-1	0	0	0	0	0	0	0	#_LnQ_base_1_Comm_Trawl(1) 
  0	 2	  0.0880309	0	0	0	 2	0	0	0	0	0	0	0	#_Q_extraSD_1_Comm_Trawl(1)
-15	15	 -7.6489700	0	0	0	-1	0	0	0	0	0	0	0	#_LnQ_base_2_Comm_Fix(2)   
  0	 2	  0.0000000	0	0	0	-2	0	0	0	0	0	0	0	#_Q_extraSD_2_Comm_Fix(2)  
-15	15	 -9.0971400	0	0	0	-1	0	0	0	0	0	0	0	#_LnQ_base_3_Rec_WA(3)     
  0	 2	  0.1390890	0	0	0	 2	0	0	0	0	0	0	0	#_Q_extraSD_3_Rec_WA(3)    
-15	15	-11.5844000	0	0	0	-1	0	0	0	0	0	0	0	#_LnQ_base_4_Rec_OR(4)     
  0	 2	  0.0000000	0	0	0	-2	0	0	0	0	0	0	0	#_Q_extraSD_4_Rec_OR(4)    
-15	15	-11.5844000	0	0	0	-1	0	0	0	0	0	0	0	#_LnQ_base_5_Rec_CA(5)     
  0	 2	  0.1879200	0	0	0	 2	0	0	0	0	0	0	0	#_Q_extraSD_5_Rec_CA(5)    
-15	15	 -1.2331900	0	0	0	-1	0	0	0	0	0	0	0	#_LnQ_base_6_Surv_TRI(6)   
  0	 2	  0.2323570	0	0	0	 2	0	0	0	0	0	0	0	#_Q_extraSD_6_Surv_TRI     
-15	15	 -0.8532360	0	0	0	-1	0	0	0	0	0	0	0	#_LnQ_base_7_Surv_WCGBTS(7)
#_no timevary Q parameters
#
#_size_selex_patterns
#_Pattern	Discard	Male	Special
24	2	0	0	#_1 1_Comm_Trawl   
24	2	0	0	#_2 2_Comm_Fix     
24	0	0	0	#_3 3_Rec_WA       
24	0	0	0	#_4 4_Rec_OR       
24	0	0	0	#_5 5_Rec_CA       
24	0	0	0	#_6 6_Surv_TRI     
24	0	0	0	#_7 7_Surv_WCGBTS  
 0	0	0	0	#_8 8_Surv_HookLine
24	0	0	0	#_9 9_Research_Lam 
 0	0	0	0	#_10 10_CPFV_DebWV 
#
#_age_selex_patterns
#_Pattern	Discard	Male	Special
0	0	0	0	#_1 1_Comm_Trawl   
0	0	0	0	#_2 2_Comm_Fix     
0	0	0	0	#_3 3_Rec_WA       
0	0	0	0	#_4 4_Rec_OR       
0	0	0	0	#_5 5_Rec_CA       
0	0	0	0	#_6 6_Surv_TRI     
0	0	0	0	#_7 7_Surv_WCGBTS  
0	0	0	0	#_8 8_Surv_HookLine
0	0	0	0	#_9 9_Research_Lam 
0	0	0	0	#_10 10_CPFV_DebWV 
#
#_SizeSelex
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
 20.00	120	  93.28260	0	0	0	  2	0	0	0	0	0.0	1	2	#_SizeSel_P_1_1_Comm_Trawl(1)   
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_1_Comm_Trawl(1)   
 -1.00	  9	   6.49859	0	0	0	  3	0	0	0	0	0.0	1	2	#_SizeSel_P_3_1_Comm_Trawl(1)   
 -1.00	 15	  15.00000	0	0	0	-99	0	0	0	0	0.0	1	2	#_SizeSel_P_4_1_Comm_Trawl(1)   
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_1_Comm_Trawl(1)   
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_1_Comm_Trawl(1)   
 10.00	100	  10.00000	0	0	0	 -4	0	0	0	0	0.0	2	2	#_SizeSel_PRet_1_1_Comm_Trawl(1)
  1.00	 15	  15.00000	0	0	0	 -4	0	0	0	0	0.0	3	2	#_SizeSel_PRet_2_1_Comm_Trawl(1)
-10.00	 10	  10.00000	0	0	0	 -5	0	0	0	0	0.0	0	0	#_SizeSel_PRet_3_1_Comm_Trawl(1)
 -2.00	  2	   0.00000	0	0	0	 -5	0	0	0	0	0.0	0	0	#_SizeSel_PRet_4_1_Comm_Trawl(1)
 -1.00	  1	   0.00000	0	0	0	 -4	0	0	0	0	0.0	0	0	#_SizeSel_PDis_1_1_Comm_Trawl(1)
 -1.00	  1	   0.00010	0	0	0	 -5	0	0	0	0	0.0	0	0	#_SizeSel_PDis_2_1_Comm_Trawl(1)
  0.01	  1	   0.50000	0	0	0	 -6	0	0	0	0	0.0	0	0	#_SizeSel_PDis_3_1_Comm_Trawl(1)
 -2.00	  2	   0.00000	0	0	0	 -4	0	0	0	0	0.0	0	0	#_SizeSel_PDis_4_1_Comm_Trawl(1)
 20.00	120	  69.36770	0	0	0	  2	0	0	0	0	0.0	0	0	#_SizeSel_P_1_2_Comm_Fix(2)     
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_2_Comm_Fix(2)     
 -1.00	  9	   5.69773	0	0	0	  3	0	0	0	0	0.0	0	0	#_SizeSel_P_3_2_Comm_Fix(2)     
 -1.00	 15	  15.00000	0	0	0	-99	0	0	0	0	0.0	0	0	#_SizeSel_P_4_2_Comm_Fix(2)     
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_2_Comm_Fix(2)     
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_2_Comm_Fix(2)     
 10.00	100	  10.00000	0	0	0	 -4	0	0	0	0	0.0	4	2	#_SizeSel_PRet_1_2_Comm_Fix(2)  
  1.00	 15	  15.00000	0	0	0	 -4	0	0	0	0	0.0	5	2	#_SizeSel_PRet_2_2_Comm_Fix(2)  
-10.00	 10	  10.00000	0	0	0	 -5	0	0	0	0	0.0	0	0	#_SizeSel_PRet_3_2_Comm_Fix(2)  
 -2.00	  2	   0.00000	0	0	0	 -5	0	0	0	0	0.0	0	0	#_SizeSel_PRet_4_2_Comm_Fix(2)  
 -1.00	  1	   0.00000	0	0	0	 -4	0	0	0	0	0.0	0	0	#_SizeSel_PDis_1_2_Comm_Fix(2)  
 -1.00	  1	   0.00010	0	0	0	 -5	0	0	0	0	0.0	0	0	#_SizeSel_PDis_2_2_Comm_Fix(2)  
  0.01	  1	   0.07000	0	0	0	 -6	0	0	0	0	0.0	0	0	#_SizeSel_PDis_3_2_Comm_Fix(2)  
 -2.00	  2	   0.00000	0	0	0	 -4	0	0	0	0	0.0	0	0	#_SizeSel_PDis_4_2_Comm_Fix(2)  
 20.00	120	  82.94280	0	0	0	  2	0	0	0	0	0.0	6	2	#_SizeSel_P_1_3_Rec_WA(3)       
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_3_Rec_WA(3)       
 -1.00	  9	   6.34222	0	0	0	  3	0	0	0	0	0.0	6	2	#_SizeSel_P_3_3_Rec_WA(3)       
 -1.00	 15	  15.00000	0	0	0	-99	0	0	0	0	0.0	6	2	#_SizeSel_P_4_3_Rec_WA(3)       
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_3_Rec_WA(3)       
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_3_Rec_WA(3)       
 20.00	120	  63.29760	0	0	0	  2	0	0	0	0	0.0	7	2	#_SizeSel_P_1_4_Rec_OR(4)       
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_4_Rec_OR(4)       
 -1.00	  9	   5.48888	0	0	0	  3	0	0	0	0	0.0	7	2	#_SizeSel_P_3_4_Rec_OR(4)       
 -1.00	 15	  15.00000	0	0	0	-99	0	0	0	0	0.0	7	2	#_SizeSel_P_4_4_Rec_OR(4)       
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_4_Rec_OR(4)       
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_4_Rec_OR(4)       
 20.00	120	  77.70150	0	0	0	  2	0	0	0	0	0.0	8	2	#_SizeSel_P_1_5_Rec_CA(4)       
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_5_Rec_CA(4)       
 -1.00	  9	   5.50265	0	0	0	  3	0	0	0	0	0.0	8	2	#_SizeSel_P_3_5_Rec_CA(4)       
 -1.00	 15	  15.00000	0	0	0	-99	0	0	0	0	0.0	8	2	#_SizeSel_P_4_5_Rec_CA(4)       
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_5_Rec_CA(4)       
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_5_Rec_CA(4)       
 20.00	120	 104.14200	0	0	0	  2	0	0	0	0	0.5	0	0	#_SizeSel_P_1_6_Surv_TRI(6)     
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_6_Surv_TRI(6)     
 -1.00	  9	   7.51224	0	0	0	  3	0	0	0	0	0.0	0	0	#_SizeSel_P_3_6_Surv_TRI(6)     
 -1.00	 15	  10.05580	0	0	0	  3	0	0	0	0	0.0	0	0	#_SizeSel_P_4_6_Surv_TRI(6)     
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_6_Surv_TRI(6)     
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_6_Surv_TRI(6)     
 20.00	120	  83.13650	0	0	0	  2	0	0	0	0	0.0	0	0	#_SizeSel_P_1_7_Surv_WCGBTS(7)  
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_7_Surv_WCGBTS(7)  
 -1.00	  9	   7.12094	0	0	0	  3	0	0	0	0	0.0	0	0	#_SizeSel_P_3_7_Surv_WCGBTS(7)  
 -1.00	 15	   5.38386	0	0	0	  3	0	0	0	0	0.0	0	0	#_SizeSel_P_4_7_Surv_WCGBTS(7)  
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_7_Surv_WCGBTS(7)  
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_7_Surv_WCGBTS(7)  
 20.00	120	  88.36840	0	0	0	  2	0	0	0	0	0.0	0	0	#_SizeSel_P_1_9_Research_Lam(9) 
-20.00	  4	 -15.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_2_9_Research_Lam(9) 
 -1.00	  9	   6.41625	0	0	0	  3	0	0	0	0	0.0	0	0	#_SizeSel_P_3_9_Research_Lam(9) 
 -1.00	 15	   4.75083	0	0	0	  3	0	0	0	0	0.0	0	0	#_SizeSel_P_4_9_Research_Lam(9) 
 -5.00	  9	-999.00000	0	0	0	 -2	0	0	0	0	0.0	0	0	#_SizeSel_P_5_9_Research_Lam(9) 
 -5.00	  9	-999.00000	0	0	0	 -3	0	0	0	0	0.0	0	0	#_SizeSel_P_6_9_Research_Lam(9) 
#_AgeSelex
#_No age_selex_parm
# timevary selex parameters 
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE
20	120	102.33300	0	0	0	  2	#_SizeSel_P_1_1_Comm_Trawl_1993   
20	120	 77.55680	0	0	0	  2	#_SizeSel_P_1_1_Comm_Trawl_1998   
20	120	 91.80360	0	0	0	  2	#_SizeSel_P_1_1_Comm_Trawl_2011   
-1	  9	  6.93195	0	0	0	  3	#_SizeSel_P_3_1_Comm_Trawl_1993   
-1	  9	  6.69330	0	0	0	  3	#_SizeSel_P_3_1_Comm_Trawl_1998   
-1	  9	  6.96899	0	0	0	  3	#_SizeSel_P_3_1_Comm_Trawl_2011   
-1	 15	  1.00000	0	0	0	-99	#_SizeSel_P_4_1_Comm_Trawl_1993   
-1	 15	  5.44526	0	0	0	  3	#_SizeSel_P_4_1_Comm_Trawl_1998   
-1	 15	  4.82090	0	0	0	  3	#_SizeSel_P_4_1_Comm_Trawl_2011   
40	100	100.00000	0	0	0	-99	#_SizeSel_PRet_1_1_Comm_Trawl_1998
40	100	 90.40630	0	0	0	  4	#_SizeSel_PRet_1_1_Comm_Trawl_2007
40	100	 64.39130	0	0	0	  4	#_SizeSel_PRet_1_1_Comm_Trawl_2010
40	100	 55.73440	0	0	0	  4	#_SizeSel_PRet_1_1_Comm_Trawl_2011
 1	 15	 10.03340	0	0	0	  4	#_SizeSel_PRet_2_1_Comm_Trawl_1998
 1	 15	  2.32857	0	0	0	  4	#_SizeSel_PRet_2_1_Comm_Trawl_2011
40	100	 72.86540	0	0	0	  4	#_SizeSel_PRet_1_2_Comm_Fix_1998  
40	100	 59.91400	0	0	0	  4	#_SizeSel_PRet_1_2_Comm_Fix_2011  
 1	 15	 13.63750	0	0	0	  4	#_SizeSel_PRet_2_2_Comm_Fix_1998  
 1	 15	  8.86156	0	0	0	  4	#_SizeSel_PRet_2_2_Comm_Fix_2011  
20	120	 60.60650	0	0	0	  2	#_SizeSel_P_1_3_Rec_WA_1987       
20	120	 60.19990	0	0	0	  2	#_SizeSel_P_1_3_Rec_WA_1995       
20	120	 63.98640	0	0	0	  2	#_SizeSel_P_1_3_Rec_WA_1998       
20	120	 62.99880	0	0	0	  2	#_SizeSel_P_1_3_Rec_WA_2007       
20	120	 63.20150	0	0	0	  2	#_SizeSel_P_1_3_Rec_WA_2011       
20	120	 67.19850	0	0	0	  2	#_SizeSel_P_1_3_Rec_WA_2017       
-1	  9	  4.62059	0	0	0	  3	#_SizeSel_P_3_3_Rec_WA_1987       
-1	  9	  3.33801	0	0	0	  3	#_SizeSel_P_3_3_Rec_WA_1995       
-1	  9	  2.90498	0	0	0	  3	#_SizeSel_P_3_3_Rec_WA_1998       
-1	  9	  3.55535	0	0	0	  3	#_SizeSel_P_3_3_Rec_WA_2007       
-1	  9	  3.66218	0	0	0	  3	#_SizeSel_P_3_3_Rec_WA_2011       
-1	  9	  5.20046	0	0	0	  3	#_SizeSel_P_3_3_Rec_WA_2017       
-1	 15	 15.00000	0	0	0	-99	#_SizeSel_P_4_3_Rec_WA_1987       
-1	 15	 15.00000	0	0	0	-99	#_SizeSel_P_4_3_Rec_WA_1995       
-1	 15	  8.34583	0	0	0	  3	#_SizeSel_P_4_3_Rec_WA_1998       
-1	 15	  7.23815	0	0	0	  3	#_SizeSel_P_4_3_Rec_WA_2007       
-1	 15	 15.00000	0	0	0	-99	#_SizeSel_P_4_3_Rec_WA_2011       
-1	 15	 15.00000	0	0	0	-99	#_SizeSel_P_4_3_Rec_WA_2017       
20	120	 59.62280	0	0	0	  2	#_SizeSel_P_1_4_Rec_OR_1995       
20	120	 62.42460	0	0	0	  2	#_SizeSel_P_1_4_Rec_OR_1998       
20	120	 58.19150	0	0	0	  2	#_SizeSel_P_1_4_Rec_OR_2007       
-1	  9	  3.32792	0	0	0	  3	#_SizeSel_P_3_4_Rec_OR_1995       
-1	  9	  1.66305	0	0	0	  3	#_SizeSel_P_3_4_Rec_OR_1998       
-1	  9	  1.86432	0	0	0	  3	#_SizeSel_P_3_4_Rec_OR_2007       
-1	 15	 15.00000	0	0	0	-99	#_SizeSel_P_4_4_Rec_OR_1995       
-1	 15	 15.00000	0	0	0	-99	#_SizeSel_P_4_4_Rec_OR_1998       
-1	 15	  7.48861	0	0	0	  3	#_SizeSel_P_4_4_Rec_OR_2007       
20	120	 66.72800	0	0	0	  2	#_SizeSel_P_1_5_Rec_CA_1999       
20	120	 62.32220	0	0	0	  2	#_SizeSel_P_1_5_Rec_CA_2011       
-1	  9	  3.50449	0	0	0	  3	#_SizeSel_P_3_5_Rec_CA_1999       
-1	  9	  3.42888	0	0	0	  3	#_SizeSel_P_3_5_Rec_CA_2011       
-1	 15	 15.00000	0	0	0	-99	#_SizeSel_P_4_5_Rec_CA_1999       
-1	 15	  7.55546	0	0	0	  3	#_SizeSel_P_4_5_Rec_CA_2011       
# info on dev vectors created for selex parms are reported with other devs after tag parameter section
#
0 #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
# Tag loss and Tag reporting parameters go next
0 # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# Input variance adjustments factors: 
#_Factor	Fleet	Value
    2	1	0.050000	#_Variance_adjustment_list1 
    2	2	0.050000	#_Variance_adjustment_list2 
    4	1	0.342575	#_Variance_adjustment_list3 
    4	2	0.279187	#_Variance_adjustment_list4 
    4	3	0.130498	#_Variance_adjustment_list5 
    4	4	0.111012	#_Variance_adjustment_list6 
    4	6	0.096246	#_Variance_adjustment_list7 
    4	7	0.082053	#_Variance_adjustment_list8 
    4	9	0.172464	#_Variance_adjustment_list9 
    5	6	0.175583	#_Variance_adjustment_list10
    5	7	0.173010	#_Variance_adjustment_list11
    5	9	0.144351	#_Variance_adjustment_list12
    4	5	0.149377	#_Variance_adjustment_list13
    5	1	0.077372	#_Variance_adjustment_list14
    5	2	0.269288	#_Variance_adjustment_list15
    5	3	0.146080	#_Variance_adjustment_list16
    5	4	0.101224	#_Variance_adjustment_list17
-9999	0	0.000000	#_terminator                
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
-9999 0 0 0 0 # terminator
#
0 # 0/1 read specs for more stddev reporting
#
999

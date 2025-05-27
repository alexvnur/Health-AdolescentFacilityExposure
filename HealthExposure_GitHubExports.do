********************************************************
********************************************************
*Author:			Alex Nur
*Topic:				Health and Waiver - IPTW Modeling
*					with Three-Level Treatment
*					in teffects
*Date created:		05/13/2025
*Date modified:		05/21/2025
********************************************************
********************************************************

clear
clear matrix
cls

********************************************************************************
***DATA MERGING AND CLEANING
********************************************************************************
/*
log using "E:\Papers\Health and Waiver\Log Output\Cleaning_Merging", ///
	text replace

**BASELINE

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "00 Baseline.dta", clear
	
	keep CASEID S0INTYR S0INTLOC S0INTLOC_FACTYPE S0SITE S0AGE S0ETHN_R S0SGEND ///
	S0FAMSTR S0REL149 S0BSISOM S0BSIOC S0BSIIS S0BSIDEP S0BSIANX S0BSIHOS S0BSIPHB ///
	S0BSIPAR S0BSIPSY S0BSIGSI S0GSI_T S0BSIPST S0BSIPSD S0BSIDX1 S0BSIDX S0CADPRE ///
	S0REL197 S0REL198 S0CRIMEATH S0FCATH S0REL95 S0REL102 S0COMIN S0MDD S0MDD12 ///
	S0MDD30 S0DYS S0DYS12 S0DYS30 S0MANIA S0MANIA12 S0MANIA30 S0PTSD S0PTSD12 S0PTSD30 ///
	S0ALCHABU S0ALCABU12 S0ALCABU30 S0ALCHDEP S0ALCDEP12 S0ALCDEP30 S0DRUGABU ///
	S0DRUABU12 S0DRUABU30 S0DRUGDEP S0DRUDEP12 S0DRUDEP30 S0MDSYMCNT S0PTSDSYMCNT ///
	S0NEARPRO S0DEM26B S0DEM27 S0DEM28 S0DEM26 S0DEM30 S0DEM29 S0DEM31 S0DEM33 ///
	S0DEM35 S0SCH2A S0NDAY6 S0SCH_COMMTYPE S0TOTEXA S0SCHTCH S0SCHATC ///
	S0SCH_HSENGAGEMENT S0DETTCH S0DETATC S0SCH_DETENGAGEMENT S0DEM49 S0REL75 ///
	S0OFFHX0 S0OFFHX1 S0OFFHX2 S0OFFHX4 S0PRBEHV S0SER40 S0SER44 S0SER48 S0ANYCOM ///
	S0MEDSEV S0IMPULS S0PAEDUC S0SROFRQ S0AGGFRQ S0INCFRQ S0ICFQND S0OFFCU4 ///
	S0AGE1STOFFENSE S0PRINFL S0DEP_T S0ANX_T S0SUPAGG S0SROPRV S0SRON56 S0SRON57 ///
	S0HOOD S0PARMNT S0EXPVIC S0FUTURE S0HEADIN S0MORDIS S0MOTSUC S0ANYIN S0SER24 ///
	S0BYPCLS S0GNGINV S0NEISOC S0CONSID S0TEMPER S0ROUT S0DEM42 S0SOCAP2 AGE_1_PRI_B4_BL ///
	S0SRO6 S0WALDEN S0EASI S0DEM53 S0PUNYOU S0SOCCST S0PERRWD S0DEM60 S0BSIPSY ///
	S0REL117 S0ADULTS S0MOM_SUBSTANCE S0REL253 S0DEM64A S0DEM69 S0EXPWIT S0FRDQLT ///
	S0SCH40 S0SCH41 S0SCH42 S0SCH43 S0SCH44 S0SCH45 S0SCH46 S0SCH47 S0NEIPHY ///
	PRI_B4_BL_EVER S0OPP01A S0OPP01B S0OPP02A S0OPP02B S0OPP03A S0OPP03B S0OPP04A ///
	S0OPP04B S0OPP05A S0OPP05B S0OPP06A S0OPP06B S0OPP07A S0OPP07B S0OPP131 ///
	S0OPPORT S0EXPECT S0PESSIM S0SER10 S0SER11

	*RENAMING BASELINE MEASURES TO MATCH FOLLOW-UP WAVES
*	rename (S0INTLOC_FACTYPE S0DEM29 S0SCH46 S0SCH47) ///
*		(PLCTYPE SCHOOL_PERFORMANCE SCH_SCH46 SCH_SCH47)
		
	*REMOVING PREFIX FOR LATER APPENDING
	rename S0* S*
	gen wave=0

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "00 Baseline.dta", replace
	
	
	
**WAVE 1, 6 MONTH RECALL

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "01 Wave 1.dta", clear
	
	keep CASEID S1INTCOMPSTAT S1INTYR S1INTLOC S1PLCTYPE S1NMONTHS S1DAYSINRP ///
	S1SITE S1SGEND S1AGE S1ETHN_R S1BSISOM S1BSIOC S1BSIIS S1BSIDEP S1BSIANX ///
	S1BSIHOS S1BSIPHB S1BSIPAR S1BSIPSY S1BSIGSI S1BSIPST S1BSIPSD S1CADPRE ///
	S1DEMO_FMCRIM S1WALDEN S1COM6MO S1SCHCAL_MAINSCHOOLTYPE S1SCHCAL_MAINSCHOOLCOUNT ///
	S1SCHCAL_MAINDETTYPE S1HEADIN S1HEADINJ_HEADN S1DEMO_PRGNOW S1DEMO_PREGRP ///
	S1CHLD_COUNT S1HOOD S1PRBEHV S1PROPTIMEALLSETTINGS S1PROPTIMESTREETS ///
	S1PROPTIMESECURESETTINGS S1PROPTIMESTREETS_SECURE S1SUBUSE1 S16MOUSE S1QFSMK6 ///
	S1IMPULS S1A6DP2 S1D6DP2 S1SOCAP2 S1SROPRV S1SRSEND ///
	S1JOBCAL_NWEEKSCU S1TRTM S1SUBUSE1 S16MOUSE S1PROJUS_PJPNUM S1NEIPHY S1NEISOC S1NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S1* S*
	gen wave=1
	
	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "01 Wave1.dta", replace



**WAVE 2, 12 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "02 Wave 2.dta", clear
	
	keep CASEID S2INTCOMPSTAT S2INTYR S2INTLOC S2PLCTYPE S2NMONTHS S2DAYSINRP ///
	S2SITE S2SGEND S2AGE S2ETHN_R S2BSISOM S2BSIOC S2BSIIS S2BSIDEP S2BSIANX ///
	S2BSIHOS S2BSIPHB S2BSIPAR S2BSIPSY S2BSIGSI S2BSIPST S2BSIPSD S2CADPRE ///
	S2DEMO_FMCRIM S2WALDEN S2COM6MO S2SCHCAL_MAINSCHOOLTYPE S2SCHCAL_MAINSCHOOLCOUNT ///
	S2SCHCAL_MAINDETTYPE S2HEADIN S2HEADINJ_HEADN S2DEMO_PRGNOW S2DEMO_PREGRP ///
	S2CHLD_COUNT S2HOOD S2PRBEHV S2PROPTIMEALLSETTINGS S2PROPTIMESTREETS ///
	S2PROPTIMESECURESETTINGS S2PROPTIMESTREETS_SECURE S2SUBUSE1 S26MOUSE S2QFSMK6 ///
	S2IMPULS S2A6DP2 S2D6DP2 S2SOCAP2 S2SROPRV S2SRSEND ///
	S2JOBCAL_NWEEKSCU S2TRTM S2SUBUSE1 S26MOUSE S2PROJUS_PJPNUM S2NEIPHY S2NEISOC S2NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S2* S*
	gen wave=2

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "02 Wave2.dta", replace
	
	
	
**WAVE 3, 18 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "03 Wave 3.dta", clear
	
	keep CASEID S3INTCOMPSTAT S3INTYR S3INTLOC S3PLCTYPE S3NMONTHS S3DAYSINRP ///
	S3SITE S3SGEND S3AGE S3ETHN_R S3BSISOM S3BSIOC S3BSIIS S3BSIDEP S3BSIANX ///
	S3BSIHOS S3BSIPHB S3BSIPAR S3BSIPSY S3BSIGSI S3BSIPST S3BSIPSD S3CADPRE ///
	S3DEMO_FMCRIM S3WALDEN S3COM6MO S3SCHCAL_MAINSCHOOLTYPE S3SCHCAL_MAINSCHOOLCOUNT ///
	S3SCHCAL_MAINDETTYPE S3HEADIN S3HEADINJ_HEADN S3DEMO_PRGNOW S3DEMO_PREGRP ///
	S3CHLD_COUNT S3HOOD S3PRBEHV S3PROPTIMEALLSETTINGS S3PROPTIMESTREETS ///
	S3PROPTIMESECURESETTINGS S3PROPTIMESTREETS_SECURE S3SUBUSE1 S36MOUSE S3QFSMK6 ///
	S3IMPULS S3A6DP2 S3D6DP2 S3SOCAP2 S3SROPRV S3SRSEND ///
	S3JOBCAL_NWEEKSCU S3TRTM S3SUBUSE1 S36MOUSE S3PROJUS_PJPNUM S3NEIPHY S3NEISOC S3NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S3* S*
	gen wave=3

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "03 Wave3.dta", replace



**WAVE 4, 24 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "04 Wave 4.dta", clear
	
	keep CASEID S4INTCOMPSTAT S4INTYR S4INTLOC S4PLCTYPE S4NMONTHS S4DAYSINRP ///
	S4SITE S4SGEND S4AGE S4ETHN_R S4BSISOM S4BSIOC S4BSIIS S4BSIDEP S4BSIANX ///
	S4BSIHOS S4BSIPHB S4BSIPAR S4BSIPSY S4BSIGSI S4BSIPST S4BSIPSD S4CADPRE ///
	S4DEMO_FMCRIM S4WALDEN S4COM6MO S4SCHCAL_MAINSCHOOLTYPE S4SCHCAL_MAINSCHOOLCOUNT ///
	S4SCHCAL_MAINDETTYPE S4HEADIN S4HEADINJ_HEADN S4DEMO_PRGNOW S4DEMO_PREGRP ///
	S4CHLD_COUNT S4HOOD S4PRBEHV S4PROPTIMEALLSETTINGS S4PROPTIMESTREETS ///
	S4PROPTIMESECURESETTINGS S4PROPTIMESTREETS_SECURE S4SUBUSE1 S46MOUSE S4QFSMK6 ///
	S4IMPULS S4A6DP2 S4D6DP2 S4HC1 S4HC2 S4HC3 S4SOCAP2 S4SROPRV S4SRSEND ///
	S4JOBCAL_NWEEKSCU S4TRTM S4SUBUSE1 S46MOUSE S4PROJUS_PJPNUM S4NEIPHY S4NEISOC S4NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S4* S*
	gen wave=4

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "04 Wave4.dta", replace



**WAVE 5, 30 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "05 Wave 5.dta", clear
	
	keep CASEID S5INTCOMPSTAT S5INTYR S5INTLOC S5PLCTYPE S5NMONTHS S5DAYSINRP ///
	S5SITE S5SGEND S5AGE S5ETHN_R S5BSISOM S5BSIOC S5BSIIS S5BSIDEP S5BSIANX ///
	S5BSIHOS S5BSIPHB S5BSIPAR S5BSIPSY S5BSIGSI S5BSIPST S5BSIPSD S5CADPRE ///
	S5DEMO_FMCRIM S5WALDEN S5COM6MO S5SCHCAL_MAINSCHOOLTYPE S5SCHCAL_MAINSCHOOLCOUNT ///
	S5SCHCAL_MAINDETTYPE S5HEADIN S5HEADINJ_HEADN S5DEMO_PRGNOW S5DEMO_PREGRP ///
	S5CHLD_COUNT S5HOOD S5PRBEHV S5PROPTIMEALLSETTINGS S5PROPTIMESTREETS ///
	S5PROPTIMESECURESETTINGS S5PROPTIMESTREETS_SECURE S5SUBUSE1 S56MOUSE S5QFSMK6 ///
	S5IMPULS S5A6DP2 S5D6DP2 S5HC1 S5HC2 S5HC3 S5SOCAP2 S5SROPRV S5SRSEND ///
	S5JOBCAL_NWEEKSCU S5TRTM S5SUBUSE1 S56MOUSE S5PROJUS_PJPNUM S5NEIPHY S5NEISOC S5NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S5* S*
	gen wave=5

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "05 Wave5.dta", replace



**WAVE 6, 36 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "06 Wave 6.dta", clear
	
	keep CASEID S6INTCOMPSTAT S6INTYR S6INTLOC S6PLCTYPE S6NMONTHS S6DAYSINRP ///
	S6SITE S6SGEND S6AGE S6ETHN_R S6BSISOM S6BSIOC S6BSIIS S6BSIDEP S6BSIANX ///
	S6BSIHOS S6BSIPHB S6BSIPAR S6BSIPSY S6BSIGSI S6BSIPST S6BSIPSD S6CADPRE ///
	S6DEMO_FMCRIM S6WALDEN S6COM6MO S6SCHCAL_MAINSCHOOLTYPE S6SCHCAL_MAINSCHOOLCOUNT ///
	S6SCHCAL_MAINDETTYPE S6HEADIN S6HEADINJ_HEADN S6DEMO_PRGNOW S6DEMO_PREGRP ///
	S6CHLD_COUNT S6HOOD S6PRBEHV S6PROPTIMEALLSETTINGS S6PROPTIMESTREETS ///
	S6PROPTIMESECURESETTINGS S6PROPTIMESTREETS_SECURE S6SUBUSE1 S66MOUSE S6QFSMK6 ///
	S6IMPULS S6A6DP2 S6D6DP2 S6HC1 S6HC2 S6HC3 S6SOCAP2 S6SROPRV S6SRSEND ///
	S6JOBCAL_NWEEKSCU S6TRTM S6SUBUSE1 S66MOUSE S6PROJUS_PJPNUM S6NEIPHY S6NEISOC S6NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S6* S*
	gen wave=6

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "06 Wave6.dta", replace


	
**WAVE 7, 48 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "07 Wave 7.dta", clear
	
	keep CASEID S7INTCOMPSTAT S7INTYR S7INTLOC S7PLCTYPE S7NMONTHS S7DAYSINRP ///
	S7SITE S7SGEND S7AGE S7ETHN_R S7BSISOM S7BSIOC S7BSIIS S7BSIDEP S7BSIANX ///
	S7BSIHOS S7BSIPHB S7BSIPAR S7BSIPSY S7BSIGSI S7BSIPST S7BSIPSD S7CADPRE ///
	S7DEMO_FMCRIM S7WALDEN S7COM6MO S7SCHCAL_MAINSCHOOLTYPE S7SCHCAL_MAINSCHOOLCOUNT ///
	S7SCHCAL_MAINDETTYPE S7HEADIN S7HEADINJ_HEADN S7DEMO_PRGNOW S7DEMO_PREGRP ///
	S7CHLD_COUNT S7HOOD S7PRBEHV S7PROPTIMEALLSETTINGS S7PROPTIMESTREETS ///
	S7PROPTIMESECURESETTINGS S7PROPTIMESTREETS_SECURE S7SUBUSE1 S76MOUSE S7QFSMK6 ///
	S7IMPULS S7A6DP2 S7D6DP2 S7HC1 S7HC2 S7HC3 S7SOCAP2 S7SROPRV S7SRSEND ///
	S7JOBCAL_NWEEKSCU S7TRTM S7SUBUSE1 S76MOUSE S7PROJUS_PJPNUM S7NEIPHY S7NEISOC S7NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S7* S*
	gen wave=7

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "07 Wave7.dta", replace	
	
	
	
**WAVE 8, 60 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "08 Wave 8.dta", clear
	
	keep CASEID S8INTCOMPSTAT S8INTYR S8INTLOC S8PLCTYPE S8NMONTHS S8DAYSINRP ///
	S8SITE S8SGEND S8AGE S8ETHN_R S8BSISOM S8BSIOC S8BSIIS S8BSIDEP S8BSIANX ///
	S8BSIHOS S8BSIPHB S8BSIPAR S8BSIPSY S8BSIGSI S8BSIPST S8BSIPSD S8CADPRE ///
	S8DEMO_FMCRIM S8WALDEN S8COM6MO S8SCHCAL_MAINSCHOOLTYPE S8SCHCAL_MAINSCHOOLCOUNT ///
	S8SCHCAL_MAINDETTYPE S8HEADIN S8HEADINJ_HEADN S8DEMO_PRGNOW S8DEMO_PREGRP ///
	S8CHLD_COUNT S8HOOD S8PRBEHV S8PROPTIMEALLSETTINGS S8PROPTIMESTREETS ///
	S8PROPTIMESECURESETTINGS S8PROPTIMESTREETS_SECURE S8SUBUSE1 S86MOUSE S8QFSMK6 ///
	S8IMPULS S8A6DP2 S8D6DP2 S8HC1 S8HC2 S8HC3 S8SOCAP2 S8SROPRV S8SRSEND ///
	S8JOBCAL_NWEEKSCU S8TRTM S8SUBUSE1 S86MOUSE S8PROJUS_PJPNUM S8NEIPHY S8NEISOC S8NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S8* S*
	gen wave=8

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "08 Wave8.dta", replace
	
	
	
**WAVE 9, 72 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "09 Wave 9.dta", clear
	
	keep CASEID S9INTCOMPSTAT S9INTYR S9INTLOC S9PLCTYPE S9NMONTHS S9DAYSINRP ///
	S9SITE S9SGEND S9AGE S9ETHN_R S9BSISOM S9BSIOC S9BSIIS S9BSIDEP S9BSIANX ///
	S9BSIHOS S9BSIPHB S9BSIPAR S9BSIPSY S9BSIGSI S9BSIPST S9BSIPSD S9CADPRE ///
	S9DEMO_FMCRIM S9WALDEN S9COM6MO S9SCHCAL_MAINSCHOOLTYPE S9SCHCAL_MAINSCHOOLCOUNT ///
	S9SCHCAL_MAINDETTYPE S9HEADIN S9HEADINJ_HEADN S9DEMO_PRGNOW S9DEMO_PREGRP ///
	S9CHLD_COUNT S9HOOD S9PRBEHV S9PROPTIMEALLSETTINGS S9PROPTIMESTREETS ///
	S9PROPTIMESECURESETTINGS S9PROPTIMESTREETS_SECURE S9SUBUSE1 S96MOUSE S9QFSMK6 ///
	S9IMPULS S9A6DP2 S9D6DP2 S9HC1 S9HC2 S9HC3 S9SOCAP2 S9SROPRV S9SRSEND ///
	S9JOBCAL_NWEEKSCU S9TRTM S9SUBUSE1 S96MOUSE S9PROJUS_PJPNUM S9NEIPHY S9NEISOC S9NSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename S9* S*
	gen wave=9

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "09 Wave9.dta", replace
	
	
	
**WAVE 10, 84 MONTHS

cd "E:\Papers\Health and Waiver\Data"

	*KEEPING RELEVANT VARIABLES NEEDED FOR ANALYSES
	use "10 Wave 10.dta", clear
	
	keep CASEID SAINTCOMPSTAT SAINTYR SAINTLOC SAPLCTYPE SANMONTHS SADAYSINRP ///
	SASITE SASGEND SAAGE SAETHN_R SABSISOM SABSIOC SABSIIS SABSIDEP SABSIANX ///
	SABSIHOS SABSIPHB SABSIPAR SABSIPSY SABSIGSI SABSIPST SABSIPSD SACADPRE ///
	SADEMO_FMCRIM SAWALDEN SACOM6MO SASCHCAL_MAINSCHOOLTYPE SASCHCAL_MAINSCHOOLCOUNT ///
	SASCHCAL_MAINDETTYPE SAHEADIN SAHEADINJ_HEADN SADEMO_PRGNOW SADEMO_PREGRP ///
	SACHLD_COUNT SAHOOD SAPRBEHV SAPROPTIMEALLSETTINGS SAPROPTIMESTREETS ///
	SAPROPTIMESECURESETTINGS SAPROPTIMESTREETS_SECURE SASUBUSE1 SA6MOUSE SAQFSMK6 ///
	SAIMPULS SAA6DP2 SAD6DP2 SAHC1 SAHC2 SAHC3 SASOCAP2 SASROPRV SASRSEND ///
	SAJOBCAL_NWEEKSCU SATRTM SASUBUSE1 SA6MOUSE SAPROJUS_PJPNUM SANEIPHY SANEISOC SANSAFE

	*REMOVING PREFIX FOR LATER APPENDING
	rename SA* S*
	gen wave=10

	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "10 Wave10.dta", replace

	
	
**FACILITY STAY 
cd "E:\Thesis and Dissertation\Thesis\Data\03 Facility Stay Data"
use "Recall Days at Facilities (Original).dta", clear	

*CODES FOR MONTH AND WAVE INDICATORS
	* L# : linear months since study inception
	* S# : recall period for participant
	* M# : months in the recall period	
	
*FACILITY TYPES
*	see https://www.pathwaysstudy.pitt.edu/codebook/cal-out_of_community_placements_codebook.html
*	code represents a prior analysis of restricted data; transformed variables 
*	are appended to public data; use of transformed datapoints aligns with the IRB
*	specified at the time of data use. the following code under section "FACILITY
*	TYPES" is pasted here for transparent coding practices.

	* DA_NDAYS		: drug/alcohol treatment
	* PSYCH_NDAYS	: psychiatric facility
	* FOSTER_NDAYS	: foster care
	* SHELTER_NDAYS	: homeless or other shelter
	* JP_NDAYS		: adult jail or prison facility
	* DET_NDAYS 	: detention facility (juvenile or adult; awaiting adjudication)
	* YDC_NDAYS		: youth correctional facility
	* CR_NDAYS		: contract residential facility (non-criminal)
	* CRMH_NDAYS	: contract residential mental health facility (non-criminal)
	* OTHER_NDAYS	: other facility
	
	*MAPPING LINEAR MONTHS TO RECALL PERIOD
		*CODE 11: MISSING
		*CODE 12: MISSED
		*CODE 13: NOT IN RECALL PERIOD
	foreach x of numlist 1/87 {
		gen wave`x' = `x'
	} // empty wave indicator to be filled with linear month map
	
	rename (L01TPMO L02TPMO L03TPMO L04TPMO L05TPMO L06TPMO L07TPMO L08TPMO ///
	L09TPMO) (L1TPMO L2TPMO L3TPMO L4TPMO L5TPMO L6TPMO L7TPMO L8TPMO ///
	L9TPMO)
	
	foreach x of numlist 1/87 {
		replace wave`x'=1 if L`x'TPMO=="S1M01"|L`x'TPMO=="S1M02"|L`x'TPMO=="S1M03"|L`x'TPMO=="S1M04"|L`x'TPMO=="S1M05"|L`x'TPMO=="S1M06"|L`x'TPMO=="S1M07"|L`x'TPMO=="S1M08"|L`x'TPMO=="S1M09"|L`x'TPMO=="S1M10"|L`x'TPMO=="S1M11"|L`x'TPMO=="S1M12"|L`x'TPMO=="S1M13"|L`x'TPMO=="S1M14"
		replace wave`x'=2 if L`x'TPMO=="S2M01"|L`x'TPMO=="S2M02"|L`x'TPMO=="S2M03"|L`x'TPMO=="S2M04"|L`x'TPMO=="S2M05"|L`x'TPMO=="S2M06"|L`x'TPMO=="S2M07"|L`x'TPMO=="S2M08"|L`x'TPMO=="S2M09"|L`x'TPMO=="S2M10"|L`x'TPMO=="S2M11"|L`x'TPMO=="S2M12"|L`x'TPMO=="S2M13"|L`x'TPMO=="S2M14"
		replace wave`x'=3 if L`x'TPMO=="S3M01"|L`x'TPMO=="S3M02"|L`x'TPMO=="S3M03"|L`x'TPMO=="S3M04"|L`x'TPMO=="S3M05"|L`x'TPMO=="S3M06"|L`x'TPMO=="S3M07"|L`x'TPMO=="S3M08"|L`x'TPMO=="S3M09"|L`x'TPMO=="S3M10"|L`x'TPMO=="S3M11"|L`x'TPMO=="S3M12"|L`x'TPMO=="S3M13"|L`x'TPMO=="S3M14"
		replace wave`x'=4 if L`x'TPMO=="S4M01"|L`x'TPMO=="S4M02"|L`x'TPMO=="S4M03"|L`x'TPMO=="S4M04"|L`x'TPMO=="S4M05"|L`x'TPMO=="S4M06"|L`x'TPMO=="S4M07"|L`x'TPMO=="S4M08"|L`x'TPMO=="S4M09"|L`x'TPMO=="S4M10"|L`x'TPMO=="S4M11"|L`x'TPMO=="S4M12"|L`x'TPMO=="S4M13"|L`x'TPMO=="S4M14"
		replace wave`x'=5 if L`x'TPMO=="S5M01"|L`x'TPMO=="S5M02"|L`x'TPMO=="S5M03"|L`x'TPMO=="S5M04"|L`x'TPMO=="S5M05"|L`x'TPMO=="S5M06"|L`x'TPMO=="S5M07"|L`x'TPMO=="S5M08"|L`x'TPMO=="S5M09"|L`x'TPMO=="S5M10"|L`x'TPMO=="S5M11"|L`x'TPMO=="S5M12"|L`x'TPMO=="S5M13"|L`x'TPMO=="S5M14"
		replace wave`x'=6 if L`x'TPMO=="S6M01"|L`x'TPMO=="S6M02"|L`x'TPMO=="S6M03"|L`x'TPMO=="S6M04"|L`x'TPMO=="S6M05"|L`x'TPMO=="S6M06"|L`x'TPMO=="S6M07"|L`x'TPMO=="S6M08"|L`x'TPMO=="S6M09"|L`x'TPMO=="S6M10"|L`x'TPMO=="S6M11"|L`x'TPMO=="S6M12"|L`x'TPMO=="S6M13"|L`x'TPMO=="S6M14"
		replace wave`x'=7 if L`x'TPMO=="S7M01"|L`x'TPMO=="S7M02"|L`x'TPMO=="S7M03"|L`x'TPMO=="S7M04"|L`x'TPMO=="S7M05"|L`x'TPMO=="S7M06"|L`x'TPMO=="S7M07"|L`x'TPMO=="S7M08"|L`x'TPMO=="S7M09"|L`x'TPMO=="S7M10"|L`x'TPMO=="S7M11"|L`x'TPMO=="S7M12"|L`x'TPMO=="S7M13"|L`x'TPMO=="S7M14"
		replace wave`x'=8 if L`x'TPMO=="S8M01"|L`x'TPMO=="S8M02"|L`x'TPMO=="S8M03"|L`x'TPMO=="S8M04"|L`x'TPMO=="S8M05"|L`x'TPMO=="S8M06"|L`x'TPMO=="S8M07"|L`x'TPMO=="S8M08"|L`x'TPMO=="S8M09"|L`x'TPMO=="S8M10"|L`x'TPMO=="S8M11"|L`x'TPMO=="S8M12"|L`x'TPMO=="S8M13"|L`x'TPMO=="S8M14"
		replace wave`x'=9 if L`x'TPMO=="S9M01"|L`x'TPMO=="S9M02"|L`x'TPMO=="S9M03"|L`x'TPMO=="S9M04"|L`x'TPMO=="S9M05"|L`x'TPMO=="S9M06"|L`x'TPMO=="S9M07"|L`x'TPMO=="S9M08"|L`x'TPMO=="S9M09"|L`x'TPMO=="S9M10"|L`x'TPMO=="S9M11"|L`x'TPMO=="S9M12"|L`x'TPMO=="S9M13"|L`x'TPMO=="S9M14"
		replace wave`x'=10 if L`x'TPMO=="SAM01"|L`x'TPMO=="SAM02"|L`x'TPMO=="SAM03"|L`x'TPMO=="SAM04"|L`x'TPMO=="SAM05"|L`x'TPMO=="SAM06"|L`x'TPMO=="SAM07"|L`x'TPMO=="SAM08"|L`x'TPMO=="SAM09"|L`x'TPMO=="SAM10"|L`x'TPMO=="SAM11"|L`x'TPMO=="SAM12"|L`x'TPMO=="SAM13"|L`x'TPMO=="SAM14"
		replace wave`x'=11 if L`x'TPMO=="-----"
		replace wave`x'=12 if L`x'TPMO=="-GAP-"
		replace wave`x'=13 if L`x'TPMO=="nirp"
		}
		
	*RENAMING VARIABLES TO SIMILAR SUFFIXES FOR RESHAPE
	foreach x in DA_NDAYS PSYCH_NDAYS JP_NDAYS DET_NDAYS YDC_NDAYS CR_NDAYS CRMH_NDAYS OTHER_NDAYS NDAYSSECURESETTINGS NDAYS MAINFAC_TYPE {
		rename L(##)`x' `x'(##)
		rename `x'0(#) `x'(#)
		}
		
	*KEEPING ONLY VARIABLES RELEVANT TO LENGTH OF STAY IN FACILITIES
	keep CASEID DA_NDAYS* PSYCH_NDAYS* JP_NDAYS* DET_NDAYS* YDC_NDAYS* CR_NDAYS* ///
		CRMH_NDAYS* OTHER_NDAYS* NDAYSSECURESETTINGS* NDAYS* MAINFAC_TYPE* wave*
	
	*RESHAPING LONG
	reshape long DA_NDAYS PSYCH_NDAYS JP_NDAYS DET_NDAYS YDC_NDAYS CR_NDAYS ///
		CRMH_NDAYS OTHER_NDAYS NDAYSSECURESETTINGS NDAYS MAINFAC_TYPE wave, ///
		i(CASEID) j(lmonth)	
		
	*RECODING MISSING DATA
	foreach x in DA_NDAYS PSYCH_NDAYS JP_NDAYS DET_NDAYS YDC_NDAYS CR_NDAYS ///
		CRMH_NDAYS OTHER_NDAYS NDAYSSECURESETTINGS NDAYS MAINFAC_TYPE {
			replace `x' = . if `x' < 0
			}
			
	*GENERATING TOTAL TIME SPENT IN FACILITIES BY WAVES
	bysort CASEID wave: egen DA_total = total(DA_NDAYS)
	bysort CASEID wave: egen PSYCH_total = total(PSYCH_NDAYS)
	bysort CASEID wave: egen JP_total = total(JP_NDAYS)
	bysort CASEID wave: egen DET_total = total(DET_NDAYS)
	bysort CASEID wave: egen YDC_total = total(YDC_NDAYS)
	bysort CASEID wave: egen CR_total = total(CR_NDAYS)
	bysort CASEID wave: egen CRMH_total = total(CRMH_NDAYS)
	bysort CASEID wave: egen OTHER_total = total(OTHER_NDAYS)
	bysort CASEID wave: egen ALLFAC_total = total(NDAYSSECURESETTINGS)
	bysort CASEID wave: egen WAVEDAYS_total = total(NDAYS)
	
	*REPLACING GENERATED ZEROS WITH MISSING VALUES
	foreach x in DA PSYCH JP DET YDC CR CRMH OTHER {
		replace `x'_total = . if `x'_NDAYS == .
		}
	replace ALLFAC_total = . if NDAYSSECURESETTINGS == .
	
	*DROPPING WAVES OUTSIDE OF STUDY PERIOD
	drop if wave > 10
	
	*COLLAPSING TO PERSON LEVEL
	sort CASEID lmonth 
	
	collapse (first) WAVEDAYS_total DA_total PSYCH_total JP_total DET_total ///
		YDC_total CR_total CRMH_total OTHER_total ALLFAC_total MAINFAC_TYPE, ///
		by(CASEID wave)
		
	*SAVING DATA
	cd "E:\Papers\Health and Waiver\Data\Cleaned"
	save "FacilityTotals.dta", replace


**APPENDING FILES 
cd "E:\Papers\Health and Waiver\Data\Cleaned"
	use "00 Baseline.dta", clear 
	append using "01 Wave1.dta"
	append using "02 Wave2.dta"
	append using "03 Wave3.dta"
	append using "04 Wave4.dta"
	append using "05 Wave5.dta"
	append using "06 Wave6.dta"
	append using "07 Wave7.dta"
	append using "08 Wave8.dta"
	append using "09 Wave9.dta"
	append using "10 Wave10.dta"
	merge 1:1 CASEID wave using "FacilityTotals.dta"
	
sort CASEID wave

cd "E:\Papers\Health and Waiver\Data\Cleaned"
save "HealthWaiver_Merged.dta", replace

*/



**************************************************
***********Additional Variable Cleaning************
***************************************************
/*
cd "E:\Papers\Health and Waiver\Data\Cleaned"
use "HealthWaiver_Merged.dta", clear

**OUTCOME VARIABLES
	* Physical health	: SHC3 (Rate overall health)
	* Mental health		: SBSIDEP (Depression scale)
	*					  SBSIANX (Anxiety scale)
	*					  SBSIGSI (Global severity index)
	*					  SD6DP2 (Drug dependence symptoms)
	*					  SA6DP2 (Alcohol dependence symptoms)
	* Service use		: SHC2 (Where do you go)
	
	*OVERALL HEALTH
		*Reverse coding health for interpretation
		numlabel, add
		tab SHC3
		recode SHC3 1=4 2=3 3=2 4=1
			label define hlth 1"Poor" 2"Fair" 3"Good" 4"Excellent", replace
			label value SHC3 healthr		
	
	gen HEALTH = SHC3 // overall health score
	gen HEALTH_adult = SHC3 if SAGE >= 18 & SAGE != . // health score, adult report only
		gen healthflag = 1 if HEALTH_adult != . // 1 if health score reported
			bysort CASEID (wave): gen healthsum = sum(healthflag)
			bysort CASEID (wave): egen healthmax = sum(healthflag)
				// last reported health score
	gen HEALTH_final = HEALTH if healthsum == healthmax
		gen WAVE_final = wave if healthsum == healthmax // wave of final health measure
	bysort CASEID: egen HEALTH_avg = mean(HEALTH_adult)
				
	label var HEALTH "Rate overall health"
	label var HEALTH_adult "Overall health ratings; adult report"
	label var HEALTH_final "Overal health ratings; last reported wave"
	
	label value HEALTH hlth
	label value HEALTH_adult hlth
	label value HEALTH_final hlth
	
	*INSURANCE STATUS
	label define ins 0"Not insured" 1"Insured"
		clonevar INS = SHC1
			recode INS 7 = 0 2/6 = 1
			label value INS ins
	
	gen INS_final = INS if HEALTH_final != .
		// insured at final wave of final health measure
		
	clonevar INS_wave = INS // insured at wave 
	clonevar INS_int = INS_wave // insured between adolescence and health measure 
		replace INS_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen INS_ttl = mean(INS_int) // avg insurance status between adolescence and health measure
		
	*SUBSTANCE ABUSE
	egen SUBDEP = rowmax(SD6DP2 SA6DP2)
		recode SUBDEP 2/10 = 1	
		// reported drug or alcohol dependence symptoms (any)
		
	gen SUBDEP_final = SUBDEP if HEALTH_final != .
		// substance dependence symptoms at wave of final health measure 
		
	label define subdep 0"No substance dependence symptoms" 1"One or more substance dependence symptoms"
		label value SUBDEP subdep 
		label value SUBDEP_final subdep
		
	*MENTAL HEALTH
	gen DEP = SBSIDEP // BSI depression scale
	gen DEP_adult = DEP if SAGE >= 18 & SAGE != . // adult depression
	gen DEP_final = DEP if HEALTH_final != . // depression at final wave
	bysort CASEID: egen DEP_avg = mean(DEP_adult) // avg adult depression
	
	gen ANX = SBSIANX // BSI anxiety scale
	gen ANX_adult = ANX if SAGE >= 18 & SAGE != . // adult anxiety
	gen ANX_final = ANX if HEALTH_final != . // anxiety at final wave
	bysort CASEID: egen ANX_avg = mean(ANX_adult) // avg adult anxiety
	
	gen GLOB = SBSIGSI // global severity index
	gen GLOB_adult = GLOB if SAGE >= 18 & SAGE != .  // GSI adult
	gen GLOB_final = GLOB if HEALTH_final != . // GSI at final wave
	bysort CASEID: egen GLOB_avg = mean(GLOB_adult)
	
	*HEALTHCARE USE
	clonevar CARE = SHC2 // type of healthcare used
		recode CARE 1=0 2/5=1 6=2 97=.n
	gen CARE_adult = CARE if SAGE >= 18 & SAGE != . // adult healthcare used 
	gen CARE_final = CARE if HEALTH_final != . // healthcare used at final wave
	bysort CASEID: egen CARE_mode = mode(CARE_adult)
		replace CARE_mode = CARE_final if CARE_mode == .
		bysort CASEID: egen CARE_avg = max(CARE_mode)
	
	label define care 0"Emergency" 1"Office/Clinic" 2"Nowhere"
		label value CARE care
		label value CARE_adult care
		label value CARE_final care
		label value CARE_avg care
		label value CARE_mode care
		

	*COLLAPSING TO SINGLE ROW
	foreach x in HEALTH_final INS_final SUBDEP_final DEP_final ANX_final GLOB_final CARE_final {
		bysort CASEID: egen x`x' = max(`x')
		}

	
**INDEPENDENT VARIABLES & TREATMENT
	* Adult facility	: JP_total | DET if MAINFAC_TYPE == 25
	* Youth facility 	: YDC_total | DET if MAINFAC_TYPE == 21
	
	*DIFFERENTIATING ADULT AND JUVENILE DETENTION
	gen DETA_total = DET_total if MAINFAC_TYPE == 25 // detention in adult facility (days)
	gen DETJ_total = DET_total if MAINFAC_TYPE == 21 // detention in juvenile facility (days)
	
	*TOTAL DAYS IN ADULT AND JUVENILE DETENTION IN WAVE
	egen YOUTH_total = rowtotal(YDC_total DETJ_total) // incarceration in youth facility (days)
	egen ADULT_total = rowtotal(JP_total DETA_total) // incarceration in adult facility (days)
	
	gen YOUTH_any = 1 if YOUTH_total >= 1 & YOUTH_total != . // incarceration in youth facility (any)
		replace YOUTH_any = 0 if YOUTH_total == 0
	gen ADULT_any = 1 if ADULT_total >= 1 & ADULT_total != . // incarceration in adult facility (any)
		replace ADULT_any = 0 if ADULT_total == 0
		
	*SENSITIVITY - 5+ DAYS IN ADULT AND JUVENILE DETENTION IN WAVE
	gen YOUTH_five = 1 if YOUTH_total >= 5 & YOUTH_total != . // incarceration in youth facility (5+ days)
		replace YOUTH_five = 0 if YOUTH_total == 0
	gen ADULT_five = 1 if ADULT_total >= 5 & ADULT_total != . // incarceration in adult facility (5+ days)
		replace ADULT_five = 0 if ADULT_total == 0
		
	*ANY DETENTION DURING WAVE 
	egen DETENTION_any = rowmax (YOUTH_any ADULT_any) // any detention during wave
	
	*ANY DETENTION OF 5+ DAYS DURING WAVE 
	egen DETENTION_five = rowmax (YOUTH_five ADULT_five) // 5+ days detention during wave
	
	**TREATMENT INDICATOR
	gen TRANSFER_wave = 1 if ADULT_any == 1 // wave level adult/youth detention experience
		replace TRANSFER_wave = 0 if YOUTH_any == 1 & TRANSFER_wave == .
		replace TRANSFER_wave = -1 if ADULT_any == 0 & YOUTH_any == 0
		replace TRANSFER_wave = .a if SAGE >= 18
		
	bysort CASEID: egen TRANSFER = max(TRANSFER_wave) // ever waived before 18
	
	replace TRANSFER = .n if TRANSFER == -1
	
	**TREATMENT INDICATOR OF 5+ FACILITY DAYS
	gen TRANSFER_wave_five = 1 if ADULT_five == 1 // wave level adult/youth detention experience
		replace TRANSFER_wave_five = 0 if YOUTH_five == 1 & TRANSFER_wave_five == .
		replace TRANSFER_wave_five = -1 if ADULT_five == 0 & YOUTH_five == 0
		replace TRANSFER_wave_five = .a if SAGE >= 18
		
	bysort CASEID: egen TRANSFER_five = max(TRANSFER_wave_five) // ever waived before 18 and 5+ days exposure
	
	replace TRANSFER_five = .n if TRANSFER_five == -1
	
	**EXPOSURE DURING ADOLESCENCE
	gen youth_expy = YOUTH_total if SAGE < 18
		bysort CASEID (wave): egen YOUTH_ttlexpy = sum(youth_expy)
		
	gen adult_expy = ADULT_total if SAGE < 18
		bysort CASEID (wave): egen ADULT_ttlexpy = sum(adult_expy)
		
	**EXPOSURE DURING ADULTHOOD
	clonevar ADULT_wave = ADULT_total // time in adult facilities at wave
	clonevar ADULT_int = ADULT_wave // time in adult facilities between adolescence and health measure
		replace ADULT_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen ADULT_ttl = sum(ADULT_int) // total time in adult facilities between adolescence and health measure
	
	clonevar DETAIN_wave = ADULT_total // 0/1 detained in adult facility during wave
		recode DETAIN_wave 2/427 = 1
	
	gen TREATSA_wave = DA_total if SAGE >= 18 // substance abuse treatment (facility)
		gen TREATSA_waveany = 1 if TREATSA_wave >= 1 & TREATSA_wave != .
		replace TREATSA_waveany = 0 if TREATSA_wave == 0
		replace TREATSA_waveany = .a if SAGE < 18
	
	gen TREATPSY_wave = PSYCH_total if SAGE >= 18
		gen TREATPSY_waveany = 1 if TREATPSY_wave >= 1 & TREATPSY_wave != . // inpatient psych service (facility)
		replace TREATPSY_waveany = 0 if TREATPSY_wave == 0
		replace TREATPSY_waveany = .a if SAGE < 18
		
	egen TREAT_waveany = rowmax(TREATSA_waveany TREATPSY_waveany) // any inpatient treatment
		replace TREAT_waveany = .a if SAGE < 18
		
	**AGE AT FIRST EXPOSURE IN DATA
	sort CASEID wave
	
	gen detflag = 1 if DETENTION_any >= 1 & DETENTION_any != .
	bysort CASEID (wave): gen detsum = sum(detflag)
		replace detsum = . if detflag == .
	
	gen FIRSTAGE = SAGE if detsum == 1
	bysort CASEID: egen FIRSTAGE_ttl = max(FIRSTAGE)
	
	*FIXED BASELINE COVARIATES
	replace SREL198 = 0 if SREL197 == 0
	
	foreach x in SHEADIN SANYIN SSUPAGG SSROPRV SPAEDUC SREL198 SNEARPRO SFUTURE ///
		SAGE1STOFFENSE SMEDSEV SIMPULS {
	    gen `x'_base = `x' if wave == 0
		bysort CASEID (wave): replace `x'_base = `x'_base[_n-1] if mi(`x'_base)
	}
		
	
**PRE-TREATMENT COVARIATE CLEANING
	label define site2 0"Philadelphia" 1"Phoenix"
		recode SSITE 1=0 2=1
		label value SSITE site2 
	
	label define mf 0"Female" 1"Male"
		recode SSGEND 2=0
		label value SSGEND mf
		
	label define bio 0"Other" 1"Two biological parents in home"
		clonevar SBIO = SFAMSTR 
		recode SBIO 2/13 = 0
		label value SBIO bio
	
	label define kid 0"None" 1"1 or more"
		recode SREL75 2=1
		label value SREL75 kid 
		
	replace SREL198 = 0 if SREL197 == 0 & SREL198 == .
	
	clonevar HSENGAGEMENT = SSCH_HSENGAGEMENT
		replace HSENGAGEMENT = SSCH_DETENGAGEMENT if HSENGAGEMENT == .
	
	*label define peer 0"None of them" 1"Very few of them" 2"Some or all of them"
		*recode SPRINFL 1/1.99 = 0 2/2.99 = 1 3/5 = 2
		*label value SPRINFL peer
		
	*label define hood 1"Never" 2"Rarely" 3"Sometimes or often"
		*recode SHOOD 1/1.99 = 1 2/2.99 = 2 3/4 = 3
		*label value SHOOD hood
		
	label define asex 0"12 or younger" 1"13 or older", replace
		recode SREL95 9/12 = 0 13/17 = 1
		label value SREL95 asex
		
	egen SCLINICAL = rowmax(SDEP_T SANX_T)
	
	label define off 0"None" 1"Any"
		clonevar SAGGOFF = SAGGFRQ
			recode SAGGOFF 1/876 = 1
			label value SAGGOFF off
		clonevar SINCOFF = SICFQND
			recode SINCOFF 1/3095 = 1
			label value SINCOFF off
		clonevar SDRUGOFF = SSRON56
			recode SDRUGOFF 1/995 = 1
			replace SDRUGOFF = 1 if SSRON57 >= 1 & SSRON57 != .
			label value SDRUGOFF off

	*label define en 0"Never" 1"Ever"
		*recode SCOMIN 2/4 = 1
		*label value SCOMIN en
		
	egen SUBABU = rowmax(SALCHABU SDRUGABU)
	
	label define mosub 0"No past or current substance problems" ///
		1"Past or current substance problems"
		recode SMOM_SUBSTANCE 2=1
		label value SMOM_SUBSTANCE mosub
		
	label define household 0"One or fewer guardians" 1"Two guardians"
			
*INTERMEDIATE OUTCOMES
	*Work
	clonevar WKSWORK_wave = SJOBCAL_NWEEKSCU // weeks worked in wave
	clonevar WORK_wave = SJOBCAL_NWEEKSCU // any work during wave
		recode WORK_wave 2/65 = 1
		label define work 0"No weeks worked in wave" 1"Some work during wave"
		label value WORK_wave work
	clonevar WKSWORK_int = WKSWORK_wave // weeks worked between adolescence and health measure
		replace WKSWORK_int = .w if SAGE < 18 | wave > WAVE_final 
	clonevar WORK_int = WORK_wave // worked between adolescence and health measure
		replace WORK_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen WKSWORK_ttl = sum(WKSWORK_int) // total weeks worked between adolescence and health measure
	bysort CASEID (wave): egen WORK_ttl = max(WORK_int) // any work between adolescence and health measure
	
	*Neighborhood conditions
	clonevar NEIGH_wave = SHOOD // neighborhood conditions during wave 
	clonevar NEIGH_int = NEIGH_wave // neighborhood conditions between adolescence and health measure
		replace NEIGH_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen NEIGH_ttl = mean(NEIGH_int) // average neighborhood conditions between adolescence and health measure
	
	*Child rearing
	clonevar CHILD_wave = SCHLD_COUNT // any children at wave
		recode CHILD_wave 2/6 = 1
		label value CHILD_wave kid
	clonevar CHILD_int = CHILD_wave // any children between adolescence and health measure
		replace CHILD_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen CHILD_ttl = max(CHILD_int) // any children between adolescence and health measure
	
	*Gang involvement
	clonevar GANG_wave = SGNGINV // gang involved at wave
	clonevar GANG_int = GANG_wave // gang involvement between adolescence and health measure
		replace GANG_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen GANG_ttl = max(GANG_int) // any gang involvement between adolescence and health measure
	
	*Substance dependence
	foreach x in SA6DP2 SD6DP2 {
		recode `x' 2/10 = 1
		}
	
	egen SUBDEP_wave = rowmax(SA6DP2 SD6DP2) // substance dependence symptoms at wave
	clonevar SUBDEP_int = SUBDEP_wave // substance dependence between adolescence and health measure
		replace SUBDEP_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen SUBDEP_ttl = max(SUBDEP_int) // any substance dependence between adolescence and health measure
	
	*Street time
	clonevar STREET_wave = SPROPTIMESTREETS // street time at wave
	clonevar STREET_int = STREET_wave // street time between adolescence and health measure
		replace STREET_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen STREET_ttl = mean(STREET_int) // avg street time between adolescence and health measure
	
	*Treatment
	egen TREAT_wave = rowmax(STRTM TREAT_waveany) // treatment at wave
	clonevar TREAT_int = TREAT_wave // treatment between adolescence and health measure
		replace TREAT_int = .w if SAGE < 18 | wave > WAVE_final 
	bysort CASEID (wave): egen TREAT_ttl = max(TREAT_int) // any treatment between adolescence and health measure
	
	*Offense variety
	clonevar VARIETY = SSRSEND
		replace VARIETY = SSRO6 if wave == 0
	

cd "E:\Papers\Health and Waiver\Data\Cleaned"
*save "HealthWaiver_Cleaned.dta", replace
			
log close
cls
*/

********************************************************************************
***DATA READING, TRANSFORMATIONS, AND VARIABLE LIST
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 1 - Data Reading and Transformations", ///
	text replace

*READING DATA
use "E:\Papers\Health and Waiver\Data\Cleaned\HealthWaiver_Cleaned.dta", clear
	// cleaned PtD health-waiver data
	
*CONDENSING TO PERSON-LEVEL
keep if wave == 0

*RECODING EXPOSURE VARIABLE
recode TRANSFER 0=1 1=2
	replace TRANSFER = 0 if TRANSFER == .n
	// .n indicates no exposure to juvenile or adult facility during adolescence
	// variable code:
	//		0 = No exposure to carceral facilities during adolecence
	//		1 = Exposure to only juvenile facilities during adolescence
	//		2 = Exposure to adult facilities during adolescence
	
*TRANSFORMING SKEWED OUTCOMES
sum HEALTH_avg DEP_avg ANX_avg, d

*gladder DEP_avg 
*gladder ANX_avg

gen log_DEP_avg = ln(DEP_avg + 0.0001)
gen log_ANX_avg = ln(ANX_avg + 0.0001)
	// natural log with small constant

*gladder log_DEP_avg 
*gladder log_ANX_avg

gen sqrt_DEP_avg = sqrt(DEP_avg)
gen sqrt_ANX_avg = sqrt(ANX_avg)
	// square root; preferred transformation in gladder

*gladder sqrt_DEP_avg 
*gladder sqrt_ANX_avg

*DISCRETE VARIABLES FOR RACE/ETHNICITY
tab SETHN_R, gen(race)
	rename (race1 race2 race3 race4) (White Black Hispanic Other)
	label var White "White race/ethnicity"
	label var Black "Black race/ethnicity"
	label var Hispanic "Hispanic race/ethnicity"
	label var Other "Other race/ethnicity"
	
*PARING DOWN TO NECESSARY VARIABLES
keep TRANSFER HEALTH_avg DEP_avg ANX_avg SSITE SAGE SSGEND SETHN_R SPAEDUC ///
	SREL198 AGE_1_PRI_B4_BL SSROPRV SEXPVIC SHEADIN SREL149 SDEM33 SDEM42 ///
	SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS SMOTSUC SSUPAGG ///
	SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV SCONSID ///
	log_DEP_avg log_ANX_avg sqrt_DEP_avg sqrt_ANX_avg White Black Hispanic Other ///
	SWALDEN SCOMIN SDEM26B SEXPWIT SFRDQLT SSOCCST SPERRWD

/*******************************************************************************
*****************************VARIABLES FOR ANALYSIS*****************************
********************************************************************************

Var Type			|	 Var			  |		Var Explained
--------------------+---------------------+---------------------------------------
Treatment			| TRANSFER	  	  	  | Facility exposure
Treatment  			| TRANSFER_five	  	  | Facility exposure of 5+ days (sensitivity)
--------------------+---------------------+---------------------------------------
DV					| HEALTH_avg	  	  | Average self-rated health in adulthood
DV					| DEP_avg			  | Average depression symptoms in adulthood
DV					| ANX_avg		  	  | Average anxious symptoms in adulthood
--------------------+---------------------+---------------------------------------
DV (transformed)	| log_DEP_avg		  | Average depression symptoms in adulthood (ln)
DV (transformed)	| log_ANX_avg		  | Average anxious symptoms in adulthood (ln)
DV (transformed)	| sqrt_DEP_avg		  | Average depression symptoms in adulthood (sqrt)
DV (transformed)	| sqrt_ANX_avg		  | Average anxious symptoms in adulthood (sqrt)
--------------------+---------------------+---------------------------------------
PRE-TREATMENT COVARIATES
--------------------+---------------------+---------------------------------------
Covariate			| SSITE				  | 1 = Phoenix, 0 = Philadelphia
Covariate			| SAGE				  | Age, continous 
Covariate			| SETHN_R			  | Race/ethnicity
Covariate			| SSGEND			  | 1 = Male
Covariate			| SBIO				  | Two biological parents in home
Covariate			| SPAEDUC			  | Average parents' education
Covariate			| SREL198			  | Anyone in family been in jail or prison 
Covariate			| AGE_1_PRI_B4_BL	  | Official record: Age at 1st prior
Covariate			| SSROPRV			  | Total Offending Variety Proportion - Ever
Covariate			| SEXPVIC			  | Prior victimization score [0-6]
Covariate			| SUBABU			  | Any prior substance abuse symptoms
Covariate			| SHEADIN			  | Prior head injury
Covariate			| SANYIN			  | Any Overnight Stays in a Facility
Covariate			| SBSIPSY			  | Psychotocism scale [0-4]
Covariate			| SREL149			  | Ever run away from where you were living
Covariate			| SDEM33			  | Ever been expelled
Covariate			| SDEM42			  | Have you ever failed a class
Covariate			| SREL75			  | Any children
Covariate			| SCADPRE			  | Domains of Social Support
Covariate			| SDEM49			  | Employed currently or before coming to facility
Covariate			| SROUT		  		  | Unsupervised Routine Activities
Covariate			| SPTSDSYMCNT		  | PTSD count of symptoms
Covariate			| SPRINFL			  | Antisocial peer influence
Covariate			| SSOCAP2 			  | Social integration scale
Covariate			| SNEISOC			  | Neighborhood social disorganization
Covariate			| SMORDIS			  | Moral Disengagement Overall
Covariate			| SMOTSUC 			  | Motivation to Succeed
Covariate			| SSUPAGG			  | Suppression of Aggression
Covariate			| SAGGOFF			  | Aggressive Offending Frequency in Past Year
Covariate			| SNEARPRO			  | Count of early onset problems
Covariate			| SINCOFF			  | Income Offending Frequency in Past Year - No Drug
Covariate			| SDRUGOFF			  | Sold marijuana - Num times in past yr
Covariate			| SCOMIN			  | Involvement in community activities
Covariate			| SSOCCST			  | Social cost of punishment
--------------------+---------------------+-------------------------------------
*******************************************************************************/

save "E:\Papers\Health and Waiver\Data\Cleaned\pre-imputation.dta", replace

log close
cls

********************************************************************************
***MISSINGNESS AND IMPUTATION
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 2 - Missingness and Imputation", ///
	text replace
	
use "E:\Papers\Health and Waiver\Data\Cleaned\pre-imputation.dta", clear

*MISSINGNESS
misstable sum SSITE SAGE SSGEND SETHN_R SPAEDUC ///
	SREL198 AGE_1_PRI_B4_BL SSROPRV SEXPVIC SHEADIN ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT ///
	SPRINFL SSOCAP2 SNEISOC SMORDIS SMOTSUC SSUPAGG SAGGOFF SNEARPRO ///
	SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV SCONSID SCOMIN SSOCCST
	
codebook SSITE SAGE SSGEND SETHN_R SPAEDUC ///
	SREL198 AGE_1_PRI_B4_BL SSROPRV SEXPVIC SHEADIN ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT ///
	SPRINFL SSOCAP2 SNEISOC SMORDIS SMOTSUC SSUPAGG SAGGOFF SNEARPRO ///
	SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV SCONSID SCOMIN SSOCCST
	
egen outcomemiss = rownonmiss(HEALTH_avg DEP_avg ANX_avg)
	// 32 with no outcome information
	// 42 with 1 outcome
	// 47 with 2 outcomes
	
misstable pattern HEALTH_avg DEP_avg ANX_avg
	
	
**DEPENDENT VARIABLE FLAG
gen dvflag = 1 if HEALTH_avg !=. & DEP_avg !=. & ANX_avg !=.
	replace dvflag = 0 if dvflag != 1

foreach x in SSITE SSGEND SETHN_R SREL198 SHEADIN SREL149 SDEM33 SDEM42 SDEM49 ///
	SAGGOFF SINCOFF SDRUGOFF SMEDSEV {
		tab dvflag `x', row chi
	}

foreach x in SAGE SPAEDUC AGE_1_PRI_B4_BL SSROPRV SEXPVIC SCADPRE SROUT SPRINFL ///
	SSOCAP2 SNEISOC SMORDIS SMOTSUC SSUPAGG SNEARPRO SIMPULS SFUTURE SCONSID ///
	SCOMIN SSOCCST {
		ttest `x', by(dvflag)
	}
	
	
*MULTIPLE IMPUTATION
mi set wide

mi register imputed SPAEDUC SREL198 SSROPRV SEXPVIC SDEM42 SROUT SPRINFL SNEISOC ///
	SMORDIS SSUPAGG SAGGOFF SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV SCONSID ///
	SMOTSUC SCOMIN SSOCCST // 18
		// registering variables with missingness
mi register regular SSITE SAGE SSGEND SETHN_R AGE_1_PRI_B4_BL SHEADIN SREL149 ///
	SDEM33 SCADPRE SDEM49 SSOCAP2 SNEARPRO // 13
		// registering variables with no missingness
		
mi impute chained ///
	(logit) SREL198 SDEM42 SMEDSEV SDRUGOFF SAGGOFF SINCOFF /// discrete variables
	(truncreg, ll(1) ul(6)) SPAEDUC ///
	(truncreg, ll(0) ul(1)) SSROPRV ///
	(truncreg, ll(0) ul(6)) SEXPVIC /// 
	(truncreg, ll(1) ul(5)) SPRINFL SSUPAGG SIMPULS SCONSID SMOTSUC SSOCCST SROUT ///
	(truncreg, ll(1) ul(4)) SNEISOC SFUTURE /// 
	(truncreg, ll(1) ul(3))	SMORDIS /// 
	(truncreg, ll(0) ul(4)) SCOMIN  /// truncated variables
	= SSITE SAGE SSGEND SETHN_R AGE_1_PRI_B4_BL SHEADIN SREL149 SDEM33 SCADPRE ///
		SDEM49 SSOCAP2 SNEARPRO, /// non-missing variables
	add(25) rseed(1234) // 25 imputations, seed set for repetition
		// 25 imputations from recommended metrics in Johnson & Young (2011)

		
*IMPUTATION MEAN ASSESSMENT
mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag == 1 & TRANSFER != . // values without imputation

mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag == 1 & TRANSFER != . //values with imputation and available
			// dependent variable values
			
mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag != 1 & TRANSFER != . // values with imputation and unavailable
			// dependent variable values	
				
save "E:\Papers\Health and Waiver\Data\PtDImputed.dta", replace

	*Extracting standard deviations (not estimated by Stata mi impute)
	do sdExtraction.do

log close
cls


********************************************************************************
***GROUP MEAN ASSESSMENTS AND UNADJUSTED MODELS
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 3 - Unadjusted Models", ///
	text replace 

use "E:\Papers\Health and Waiver\Data\PtDImputed.dta", clear
	// cleaned and imputed data
	
**Dependent variables over treatment
sum HEALTH_avg DEP_avg ANX_avg if HEALTH_avg != . | DEP_avg != . & ANX_avg != .

mean HEALTH_avg DEP_avg ANX_avg if HEALTH_avg != . | DEP_avg != . & ANX_avg != ., ///
	over(TRANSFER)

foreach x in HEALTH_avg DEP_avg ANX_avg {
	oneway `x' TRANSFER if HEALTH_avg != . | DEP_avg != . & ANX_avg != .
}

**Pre-treatment covariate group assessments - Unweighted
sum SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV SEXPVIC SHEADIN ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST ///
	if dvflag == 1

bysort TRANSFER: sum SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV SEXPVIC SHEADIN ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST ///
	if dvflag == 1
		
**Correlations - Unweighted
corr HEALTH_avg DEP_avg ANX_avg ///
	SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV SEXPVIC SHEADIN ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST ///
	if dvflag == 1
		// disregard correlations between health, depression, and anxiety
		// values are not introduced into the same models
		
**Imputed descriptives
mi misstable summarize SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN 
	
mi misstable patterns SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN 

mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag == 1 & TRANSFER != .
	
*By exposure to facility
mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag == 1 & TRANSFER == 0
		
mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag == 1 & TRANSFER == 1
		
mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag == 1 & TRANSFER == 2
		
*By missing dependent variable values
mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag == 1
		
mi estimate: mean SSITE SAGE SSGEND SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 SNEISOC SMORDIS ///
	SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV ///
	SCONSID White Black Hispanic Other SCOMIN SSOCCST SEXPVIC SHEADIN ///
		if dvflag != 1

**Global macro for covariates
global cov SSITE SAGE SSGEND i.SETHN_R SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SEXPVIC SHEADIN SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 ///
	SNEISOC SMORDIS SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS ///
	SFUTURE SMEDSEV SCONSID SCOMIN SSOCCST
	
	
**Unadjusted models
	**Original form dependent variables, linear and poission
	foreach x in HEALTH_avg DEP_avg ANX_avg {
		reg `x' ib1.TRANSFER if dvflag == 1
		reg `x' ib1.TRANSFER $cov if dvflag == 1
		poisson `x' ib1.TRANSFER if dvflag == 1
		poisson `x' ib1.TRANSFER $cov if dvflag == 1
	}
	
	**Transformed depression and anxiety measures
	foreach x in log_DEP_avg log_ANX_avg sqrt_DEP_avg sqrt_ANX_avg {
		reg `x' ib1.TRANSFER if dvflag == 1
		reg `x' ib1.TRANSFER $cov if dvflag == 1		
	}
	
	
**Unadjusted models with imputed values
	**Original form dependent variables, linear and poission
	foreach x in HEALTH_avg DEP_avg ANX_avg {
		mi estimate: reg `x' ib1.TRANSFER if dvflag == 1
		mi estimate: reg `x' ib1.TRANSFER $cov if dvflag == 1
		mi estimate: poisson `x' ib1.TRANSFER if dvflag == 1
		mi estimate: poisson `x' ib1.TRANSFER $cov if dvflag == 1
	}
	
	**Transformed depression and anxiety measures
	foreach x in log_DEP_avg log_ANX_avg sqrt_DEP_avg sqrt_ANX_avg {
		mi estimate: reg `x' ib1.TRANSFER if dvflag == 1
		mi estimate: reg `x' ib1.TRANSFER $cov if dvflag == 1	
	}

log close
cls
	
********************************************************************************
***INVERSE PROBABILITY OF TREATMENT WEIGHTING - AVG TREATMENT EFFECT (ATE)
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 4 - IPW and ATE Estimates", ///
	text replace

use "E:\Papers\Health and Waiver\Data\PtDImputed.dta", clear
	// cleaned and imputed data
	
**TREATMENT - Type of facility exposure (three-level)
	// 0 = No exposure to carceral confinement during adolescence
	// 1 = Exposure to juvenile carceral facilities only during adolescence
	// 2 = Exposure to adult facilities during adolescence

**GLOBAL MACRO FOR COVARIATES
global cov SSITE SAGE SSGEND i.SETHN_R SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SEXPVIC SHEADIN SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 ///
	SNEISOC SMORDIS SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS ///
	SFUTURE SMEDSEV SCONSID SSOCCST

**BALANCE ASSESSMENTS - Without imputed values to assess natural propensity overlap
	// Assessed with health outcome
quietly: teffects ipwra (HEALTH_avg) (TRANSFER $cov), ate control(1)
		// ipwra allows double robust estimation (Wooldredge)
		// estimated without doubly-robust covariate re-introduction
		// average treatment effect (ate) estimand
		// estimated quietly, estimate is not final, match assessment needed
		// match reference category: exposure to juvenile facilities only (==1)
	teffects overlap, legend(order(1 "No Confinement" 2 "Juvenile Facility" 3 "Adult Facility"))  ///
		xtitle("Propensity Score, ATE") // propensity score overlap assessment
			// overlap detected across all three treatment values
	tebalance summarize
		// balance summary (standardized values > |0.20|)
		//		no confinement (==0) to juvenile facility exposure (==1)
		//			pre-match imbalance: 24 covariates
		//			post-match imbalance: 0 covariates
		//		adult facility exposure (==2) to juvenile facility exposure (==1)
		//			pre-match imbalance: 6 covariates
		//			post-match imbalance: 1 covariates at |0.20|
		
quietly: teffects ipwra (ANX_avg) (TRANSFER $cov), ate control(1)
		// sensitivity with anxiety outcome; results similar to above
		// ipwra allows double robust estimation (Wooldredge)
		// estimated without doubly-robust covariate re-introduction
		// average treatment effect (ate) estimand
		// estimated quietly, estimate is not final, match assessment needed
		// match reference category: exposure to juvenile facilities only (==1)
	teffects overlap, legend(order(1 "No Confinement" 2 "Juvenile Facility" 3 "Adult Facility"))  ///
		xtitle("Propensity Score, ATE") // propensity score overlap assessment
			// overlap detected across all three treatment values
	tebalance summarize
		// balance summary (standardized values > |0.20|)
		//		no confinement (==0) to juvenile facility exposure (==1)
		//			pre-match imbalance: 24 covariates
		//			post-match imbalance: 0 covariates
		//		adult facility exposure (==2) to juvenile facility exposure (==1)
		//			pre-match imbalance: 6 covariates
		//			post-match imbalance: 1 covariates at |0.20|
		
**ATE - IMPUTED AND WEIGHTED RESULTS THROUGH TEFFECTS
mi estimate, cmdok: teffects ipwra (HEALTH_avg) (TRANSFER $cov), ate control(1)
mi estimate, cmdok: teffects ipwra (DEP_avg) (TRANSFER $cov), ate control(1)
mi estimate, cmdok: teffects ipwra (ANX_avg) (TRANSFER $cov), ate control(1)

	*Transformed depression and anxiety measures
		// health not transformed
	mi estimate, cmdok: teffects ipwra (sqrt_DEP_avg) (TRANSFER $cov), ate control(1)
	mi estimate, cmdok: teffects ipwra (sqrt_ANX_avg) (TRANSFER $cov), ate control(1)

*ATE - IMPUTED AND WEIGHTED RESULTS WITH DOUBLY ROBUST ESTIMATORS THROUGH TEFFECTS
mi estimate, cmdok: teffects ipwra (HEALTH_avg $cov) (TRANSFER $cov), ate control(1)
mi estimate, cmdok: teffects ipwra (DEP_avg $cov) (TRANSFER $cov), ate control(1)
mi estimate, cmdok: teffects ipwra (ANX_avg $cov) (TRANSFER $cov), ate control(1)  

	*Transformed depression and anxiety measures
		// health not transformed
	mi estimate, cmdok: teffects ipwra (sqrt_DEP_avg $cov) (TRANSFER $cov), ate control(1)
	mi estimate, cmdok: teffects ipwra (sqrt_ANX_avg $cov) (TRANSFER $cov), ate control(1)
	
log close
cls


********************************************************************************
***SENSITIVITY 1 - WEIGHTED ESTIMATES WITHOUT IMPUTATION
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 5 - Estimates wo Imputation", ///
	text replace

use "E:\Papers\Health and Waiver\Data\PtDImputed.dta", clear
	// cleaned and imputed data
	
**GLOBAL MACRO FOR COVARIATES
global cov SSITE SAGE SSGEND i.SETHN_R SPAEDUC SREL198 AGE_1_PRI_B4_BL SSROPRV ///
	SEXPVIC SHEADIN SREL149 SDEM33 SDEM42 SCADPRE SDEM49 SROUT SPRINFL SSOCAP2 ///
	SNEISOC SMORDIS SMOTSUC SSUPAGG SAGGOFF SNEARPRO SINCOFF SDRUGOFF SIMPULS ///
	SFUTURE SMEDSEV SCONSID SSOCCST
		
**ATE - WEIGHTED RESULTS, WITHOUT IMPUTATION
	// balance estimates same as above
teffects ipwra (HEALTH_avg) (TRANSFER $cov), ate control(1)
teffects ipwra (DEP_avg) (TRANSFER $cov), ate control(1)
teffects ipwra (ANX_avg) (TRANSFER $cov), ate control(1)

	*Transformed depression and anxiety measures
		// health not transformed
	teffects ipwra (sqrt_DEP_avg) (TRANSFER $cov), ate control(1)
	teffects ipwra (sqrt_ANX_avg) (TRANSFER $cov), ate control(1)

*ATE - WEIGHTED RESULTS WITH DOUBLY ROBUST ESTIMATORS, WITHOUT IMPUTATION
teffects ipwra (HEALTH_avg $cov) (TRANSFER $cov), ate control(1)
teffects ipwra (DEP_avg $cov) (TRANSFER $cov), ate control(1)
teffects ipwra (ANX_avg $cov) (TRANSFER $cov), ate control(1)  

	*Transformed depression and anxiety measures
		// health not transformed
	teffects ipwra (sqrt_DEP_avg $cov) (TRANSFER $cov), ate control(1)
	teffects ipwra (sqrt_ANX_avg $cov) (TRANSFER $cov), ate control(1)
	
log close
cls

********************************************************************************
***SENSITIVITY 2 - WEIGHTED AND IMPUTED POISSON DISTRIBUTION RESULTS
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 6 - Poission Distributions_Weighted", ///
	text replace

	// teffects does not support estimation of an outcome using an alternative
	// distribution. weights are estimated and then applied manually.

use "E:\Papers\Health and Waiver\Data\PtDImputed.dta", clear
	// cleaned and imputed data

**WEIGHT ESTIMATION
quietly: teffects ipwra (HEALTH_avg) (TRANSFER $cov), ate control(1)
		// ipwra allows double robust estimation (Wooldredge)
		// estimated without doubly-robust covariate re-introduction
		// average treatment effect (ate) estimand
		// estimated quietly, estimate is not final, match assessment needed
		// match reference category: exposure to juvenile facilities only (==1)
		predict ps // values for propensity scores
		gen iptweight = . // empty variable
			replace iptweight = (1 / (ps)) if TRANSFER == 1
				// comparison group weights
			replace iptweight = (1 / (1-ps)) if TRANSFER == 0 | TRANSFER == 2
				// treatment groups

**POISSION DISTRIBUTION ESTIMATES - WEIGHTED, IMPUTED VALUES
mi svyset [pweight=iptweight]

mi estimate: svy: poisson HEALTH_avg ib1.TRANSFER
mi estimate: svy: poisson HEALTH_avg ib1.TRANSFER $cov

mi estimate: svy: poisson DEP_avg ib1.TRANSFER
mi estimate: svy: poisson DEP_avg ib1.TRANSFER $cov

mi estimate: svy: poisson ANX_avg ib1.TRANSFER
mi estimate: svy: poisson ANX_avg ib1.TRANSFER $cov

	*Transformed values
	mi estimate: svy: poisson sqrt_DEP_avg ib1.TRANSFER
	mi estimate: svy: poisson sqrt_DEP_avg ib1.TRANSFER $cov

	mi estimate: svy: poisson sqrt_ANX_avg ib1.TRANSFER
	mi estimate: svy: poisson sqrt_ANX_avg ib1.TRANSFER $cov

log close 
cls


********************************************************************************
***SENSITIVITY 3 - WEIGHTED POISSON DISTRIBUTION RESULTS, WITHOUT IMPUTATION
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 7 - Poission Distributions_Unweighted", ///
	text replace

	// teffects does not support estimation of an outcome using an alternative
	// distribution. weights are estimated and then applied manually.

use "E:\Papers\Health and Waiver\Data\Cleaned\pre-imputation.dta", clear
	// cleaned data without imputation

**WEIGHT ESTIMATION
quietly: teffects ipwra (HEALTH_avg) (TRANSFER $cov), ate control(1)
		// ipwra allows double robust estimation (Wooldredge)
		// estimated without doubly-robust covariate re-introduction
		// average treatment effect (ate) estimand
		// estimated quietly, estimate is not final, match assessment needed
		// match reference category: exposure to juvenile facilities only (==1)
		predict ps // values for propensity scores
		gen iptweight = . // empty variable
			replace iptweight = (1 / (ps)) if TRANSFER == 1
				// comparison group weights
			replace iptweight = (1 / (1-ps)) if TRANSFER == 0 | TRANSFER == 2
				// treatment groups
				
**POISSION DISTRIBUTION ESTIMATES - WEIGHTED, NO IMPUTATION
svyset [pweight=iptweight]

svy: poisson HEALTH_avg ib1.TRANSFER
svy: poisson HEALTH_avg ib1.TRANSFER $cov

svy: poisson DEP_avg ib1.TRANSFER
svy: poisson DEP_avg ib1.TRANSFER $cov

svy: poisson ANX_avg ib1.TRANSFER
svy: poisson ANX_avg ib1.TRANSFER $cov

	*Transformed values
	svy: poisson sqrt_DEP_avg ib1.TRANSFER
	svy: poisson sqrt_DEP_avg ib1.TRANSFER $cov

	svy: poisson sqrt_ANX_avg ib1.TRANSFER
	svy: poisson sqrt_ANX_avg ib1.TRANSFER $cov

log close 
cls


********************************************************************************
***SENSITIVITY 4 - MODELS WITH IMPUTED OUTCOME VARIABLES
********************************************************************************

log using "E:\Papers\Health and Waiver\Log Output\SECTION 8 - Imputed Outcomes", ///
	text replace

use "E:\Papers\Health and Waiver\Data\Cleaned\pre-imputation.dta", clear

*MISSINGNESS
egen outcomemiss = rownonmiss(HEALTH_avg DEP_avg ANX_avg)
	// 32 with no outcome information
	// 42 with 1 outcome
	// 47 with 2 outcomes
	
**DEPENDENT VARIABLE FLAG
gen dvflag = 1 if HEALTH_avg !=. & DEP_avg !=. & ANX_avg !=.
	replace dvflag = 0 if dvflag != 1

	
*MULTIPLE IMPUTATION
mi set wide

mi register imputed SPAEDUC SREL198 SSROPRV SEXPVIC SDEM42 SROUT SPRINFL SNEISOC ///
	SMORDIS SSUPAGG SAGGOFF SINCOFF SDRUGOFF SIMPULS SFUTURE SMEDSEV SCONSID ///
	SMOTSUC SCOMIN SSOCCST HEALTH_avg DEP_avg ANX_avg // 
		// registering variables with missingness
mi register regular SSITE SAGE SSGEND SETHN_R AGE_1_PRI_B4_BL SHEADIN SREL149 ///
	SDEM33 SCADPRE SDEM49 SSOCAP2 SNEARPRO // 
		// registering variables with no missingness
		
mi impute chained ///
	(logit) SREL198 SDEM42 SMEDSEV SDRUGOFF SAGGOFF SINCOFF /// discrete variables
	(truncreg, ll(1) ul(6)) SPAEDUC ///
	(truncreg, ll(0) ul(1)) SSROPRV ///
	(truncreg, ll(0) ul(6)) SEXPVIC /// 
	(truncreg, ll(1) ul(5)) SPRINFL SSUPAGG SIMPULS SCONSID SMOTSUC SSOCCST SROUT ///
	(truncreg, ll(1) ul(4)) SNEISOC SFUTURE HEALTH_avg /// 
	(truncreg, ll(1) ul(3))	SMORDIS /// 
	(truncreg, ll(0) ul(4)) SCOMIN DEP_avg ANX_avg  /// truncated variables
	= SSITE SAGE SSGEND SETHN_R AGE_1_PRI_B4_BL SHEADIN SREL149 SDEM33 SCADPRE ///
		SDEM49 SSOCAP2 SNEARPRO, /// non-missing variables
	add(25) rseed(1234) // 25 imputations, seed set for repetition
		// 25 imputations from recommended metrics in Johnson & Young (2011)
		
**GLOBAL MACRO FOR COVARIATES
global cov SMEDSEV SHEADIN /// key covariates
	i.SETHN_R SAGE SSGEND SSITE /// demographics
	SPAEDUC SREL198 SCADPRE SPRINFL /// parent and peer indicators
	SSROPRV SAGGOFF SDRUGOFF SINCOFF AGE_1_PRI_B4_BL /// delinquency
	SREL149 SDEM33 SDEM42 SDEM49 SNEISOC SROUT /// school and home indicators
	SSUPAGG SEXPVIC SSOCAP2 SMORDIS SMOTSUC SNEARPRO SIMPULS SFUTURE SCONSID SSOCCST
		
*IPW ESTIMATION
quietly: teffects ipwra (HEALTH_avg) (TRANSFER $cov), ate control(1)
	predict ps
		gen iptweight = . 
			replace iptweight = (1 / (ps)) if TRANSFER == 1
				// comparison group weights
			replace iptweight = (1 / (1-ps)) if TRANSFER == 0 | TRANSFER == 2
				// treatment groups
		
*POISSON DISTRIBUTION MODELS
mi svyset [pweight=iptweight]

mi estimate: svy: poisson HEALTH_avg ib1.TRANSFER $cov
mi estimate: svy: poisson DEP_avg ib1.TRANSFER $cov
mi estimate: svy: poisson ANX_avg ib1.TRANSFER $cov		

log close 
cls

********************************************************************************
***FINAL AVERAGE TREATMENT EFFECT MODELS
********************************************************************************
			
use "E:\Papers\Health and Waiver\Data\PtDImputed.dta", clear
	// cleaned and imputed data
	
**TREATMENT - Type of facility exposure (three-level)
	// 0 = No exposure to carceral confinement during adolescence
	// 1 = Exposure to juvenile carceral facilities only during adolescence
	// 2 = Exposure to adult facilities during adolescence

**GLOBAL MACRO FOR COVARIATES
global cov SMEDSEV SHEADIN /// key covariates
	i.SETHN_R SAGE SSGEND SSITE /// demographics
	SPAEDUC SREL198 SCADPRE SPRINFL /// parent and peer indicators
	SSROPRV SAGGOFF SDRUGOFF SINCOFF AGE_1_PRI_B4_BL /// delinquency
	SREL149 SDEM33 SDEM42 SDEM49 SNEISOC SROUT /// school and home indicators
	SSUPAGG SEXPVIC SSOCAP2 SMORDIS SMOTSUC SNEARPRO SIMPULS SFUTURE SCONSID SSOCCST

**BALANCE ASSESSMENTS - Without imputed values to assess natural propensity overlap
	// Assessed with health outcome
quietly: teffects ipwra (HEALTH_avg) (TRANSFER $cov), ate control(1)
	predict ps
		gen iptweight = . 
			replace iptweight = (1 / (ps)) if TRANSFER == 1
				// comparison group weights
			replace iptweight = (1 / (1-ps)) if TRANSFER == 0 | TRANSFER == 2
				// treatment groups
		
*ATE - IMPUTED AND WEIGHTED POISSON RESULTS WITH DOUBLY ROBUST ESTIMATORS 
mi svyset [pweight=iptweight]

mi estimate: svy: poisson HEALTH_avg ib1.TRANSFER $cov if dvflag == 1
mi estimate: svy: poisson DEP_avg ib1.TRANSFER $cov if dvflag == 1
mi estimate: svy: poisson ANX_avg ib1.TRANSFER $cov if dvflag == 1


































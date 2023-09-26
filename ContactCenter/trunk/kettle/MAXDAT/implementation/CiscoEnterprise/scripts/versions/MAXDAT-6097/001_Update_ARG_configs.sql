alter session set current_schema = cisco_enterprise_cc;

update cc_c_agent_rtg_grp
set project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where agent_routing_group_name in ('VAHM_MAMH_1095_ENG',
'VAHM_MAMH_IPAPP_ENG',
'VAHM_MAMH_IPAPP_SPA',
'VAHM_MAMH_MBRENROLL_ENG',
'VAHM_MAMH_MBRMAP_ENG',
'VAHM_MAMH_MBRSVC_ENG',
'VAHM_MAMH_MECCSR_ENG',
'VAHM_MAMH_MECNOTICE_ENG',
'VAHM_MAMH_OBD_ENG',
'VAHM_MAMH_OBD_SPA',
'VAHM_MAMH_PHONE_APP_ENG',
'VAHM_MAMH_SPANADV_SPA',
'VAHM_MAMH_PAYRFM_ENG',
'VAHM_MAMH_SSELGB_ENG')
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where agent_routing_group_name in ('WADC_PDMS_SECSRESC',
'WADC_PDMS_SECSRL1',
'WADC_PDMS_SESPECESC',
'WADC_PDMS_SESPECL1',
'WADC_PDMS_SESPECL2'
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'Florida Healthy Kids', program_name = 'Florida Healthy Kids', region_name = 'Eastern', state_name = 'Florida'
where agent_routing_group_name in ('FLFP_FLHK_Creole',
'FLFP_FLHK_Creole_ESC',
'FLFP_FLHK_English',
'FLFP_FLHK_English_ESC',
'FLFP_FLHK_Spanish',
'FLFP_FLHK_Spanish_ESC',
'FLFP_FLHK_English_XFR'
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'Georgia Families', program_name = 'Medicaid Enrollment Broker', region_name = 'Eastern', state_name = 'Georgia'
where agent_routing_group_name in ('VAHM_SHSE_GAFM_CEQ1',
'VAHM_SHSE_GAFM_CSQ1'
)
and agent_routing_group_type = 'Precision Queue';

/* IDHW ET */

update cc_c_agent_rtg_grp
set project_name = 'IDHW ET', program_name = 'Idaho Employment - Training Services', region_name = 'Eastern', state_name = 'Idaho'
where agent_routing_group_name in ('IDBO_IBES_0040_SECSR',
'IDBO_IBES_0040_SSCSR'
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'IDHW ET', program_name = 'Idaho Employment - Training Services', region_name = 'Eastern', state_name = 'Idaho'
where agent_routing_group_number in (5141,
5142
)
and agent_routing_group_type = 'Precision Queue';


/* CA DIR*/

update cc_c_agent_rtg_grp
set project_name = 'CA DIR', program_name = 'IBR', region_name = 'West', state_name = 'California'
where agent_routing_group_name in ('CAFS_CIMR_BILL_EN'
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'CA DIR', program_name = 'IMR', region_name = 'West', state_name = 'California'
where agent_routing_group_name in ('CAFS_CIMR_ESC',
'CAFS_CIMR_MED_EN',
'CAFS_CIMR_MED_SP'
)
and agent_routing_group_type = 'Precision Queue';

/* Health Colorado */

update cc_c_agent_rtg_grp
set project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where agent_routing_group_name in ('COGD_HCCP_0041_SEGENL1',
'COGD_HCCP_0041_SSGENL1',
'COGD_HLCO_0041_SEGENL1',
'COGD_HLCO_0041_SSGENL1',
'COGD_HLCO_0041_SEESC1'
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'Health Colorado', program_name = 'Ombudsman', region_name = 'West', state_name = 'Colorado'
where agent_routing_group_name in ('COGD_OMBU_0041_SEGENL1',
'COGD_OMBU_0041_SSGENL1'
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'Health Colorado', program_name = 'Healthline', region_name = 'West', state_name = 'Colorado'
where agent_routing_group_name in ('COGD_HLIN_0041_SEGENL1',
'COGD_HLIN_0041_SSGENL1'
)
and agent_routing_group_type = 'Precision Queue';

/* MD HBE */

update cc_c_agent_rtg_grp
set project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland'
where agent_routing_group_name in (
'MDLB_MCSC_Consr_ESCA_ENG',
'MDLB_MCSC_Consr_ESCA_SPA',
'MDLB_MCSC_MCO_ENG',
'MDLB_MCSC_MCO_SPA')
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland'
where agent_routing_group_number in (
5030, 5013
)
and agent_routing_group_type = 'Precision Queue';

/* Wyoming Dept of Health */

update cc_c_agent_rtg_grp
set project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming'
where agent_routing_group_name in ('WYCH_DHCS_0039_SEASL1',
'WYCH_DHCS_0039_SEGENL1',
'WYCH_DHCS_0039_SEOFL1',
'WYCH_DHCS_0039_SSASL1',
'WYCH_DHCS_0039_SSGENL1',
'WYCH_DHCS_0039_SSOFL1',
'WYCH_DHCS_0039_SEESC',
'WYCH_DHCS_0039_SSESC'
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming'
where agent_routing_group_number in (5289,
5290
)
and agent_routing_group_type = 'Precision Queue';

/* SSA TTWP */

update cc_c_agent_rtg_grp
set project_name = 'SSA TTWP', program_name = 'TTWP-Beneficiary Service', region_name = 'Central', state_name = 'Texas'
where agent_routing_group_name in ('TXPH_TXTW_0009_SEBEN',
'TXPH_TXTW_0009_SEGEN',
'TXPH_TXTW_0009_SENBN',
'TXPH_TXTW_0009_SESCC',
'TXPH_TXTW_0009_SEWRK',
'TXPH_TXTW_0009_SEWSE',
'TXPH_TXTW_0009_SSBEN',
'TXPH_TXTW_0009_SSGEN',
'TXPH_TXTW_0009_SSNBN',
'TXPH_TXTW_0009_SSSCC',
'TXPH_TXTW_0009_SSWRK',
'TXPH_TXTW_0009_SSWSE')
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'SSA TTWP', program_name = 'TTWP-Provider Service', region_name = 'Eastern', state_name = 'Virginia'
where agent_routing_group_name in ('VAMC_VATW_0045_SECSR1',
'VAMC_VATW_0045_SECSR2')
and agent_routing_group_type = 'Precision Queue';


/* PA CHC */

update cc_c_agent_rtg_grp
set project_name = 'PA CHC', program_name = 'Community HealthChoices', region_name = 'Eastern', state_name = 'Pennsylvania'
where agent_routing_group_name in (
'VAHM_PACC_0026_ENG3',
'VAHM_PACC_0026_SPA3'
)
and agent_routing_group_type = 'Precision Queue';

/* MD HIX */
update cc_c_agent_rtg_grp
set project_name = 'MD HIX', program_name = 'MD HIX', region_name = 'Eastern', state_name = 'Maryland'
where agent_routing_group_number in (
5008,
5009,
5010,
5011,
5012,
5018,
5019,
5020,
5021,
5022,
5116,
5056,
5057
)
and agent_routing_group_type = 'Precision Queue';

/* KSLW */

update cc_c_agent_rtg_grp
set project_name = 'KSLW', program_name = 'KSLW', region_name = 'Central', state_name = 'Kansas'
where agent_routing_group_number in (
5027,
5028,
5029,
5031,
5032,
5079
)
and agent_routing_group_type = 'Precision Queue';

/* KS CH */

update cc_c_agent_rtg_grp
set project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas'
where agent_routing_group_number in (
5047,
5048,
5049,
5050,
5051,
5052,
5053,
5096,
5097,
5098,
5099,
5100,
5101,
5102,
5103,
5104,
5105,
5106,
5107,
5108,
5109,
5196,
5197,
5198,
5199
)
and agent_routing_group_type = 'Precision Queue';

/* MAXIMUS IT */

update cc_c_agent_rtg_grp
set project_name = 'MAXIMUS IT', program_name = 'Help Desk', region_name = 'Eastern', state_name = 'Minnesota'
where agent_routing_group_number in (
5054,
5055,
5284
)
and agent_routing_group_type = 'Precision Queue';

/* ME EB */

update cc_c_agent_rtg_grp
set project_name = 'MD EB', program_name = 'MD EB', region_name = 'Eastern', state_name = 'Maryland'
where agent_routing_group_number in (
5060,
5061,
5062,
5063,
5064,
5065,
5066,
5067
)
and agent_routing_group_type = 'Precision Queue';

/* MI CSCC */

update cc_c_agent_rtg_grp
set project_name = 'MI CSCC', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Michigan'
where agent_routing_group_number in (
5073,
5074,
5075,
5076
)
and agent_routing_group_type = 'Precision Queue';

/* TNCS */

update cc_c_agent_rtg_grp
set project_name = 'TNCS', program_name = 'TNCS', region_name = 'Eastern', state_name = 'Tennessee'
where agent_routing_group_number in (
5078
)
and agent_routing_group_type = 'Precision Queue';

/* WCHS */

update cc_c_agent_rtg_grp
set project_name = 'WC HS', program_name = 'WC HS', region_name = 'Eastern', state_name = 'Michigan'
where agent_routing_group_number in (
5068
)
and agent_routing_group_type = 'Precision Queue';

/* KSLW */

update cc_c_agent_rtg_grp
set project_name = 'KSLW', program_name = 'KSLW', region_name = 'Central', state_name = 'Kansas'
where agent_routing_group_number in (
5079
)
and agent_routing_group_type = 'Precision Queue';

/* NE PSE */

update cc_c_agent_rtg_grp
set project_name = 'NE PSE', program_name = 'Medicaid', region_name = 'Central', state_name = 'Nebraska'
where agent_routing_group_number in (
5080
)
and agent_routing_group_type = 'Precision Queue';

/* TN NEW HIRE */

update cc_c_agent_rtg_grp
set project_name = 'TN New Hire', program_name = 'New Hire Reporting', region_name = 'Eastern', state_name = 'Tennessee'
where agent_routing_group_number in (
5081,
5082,
5083
)
and agent_routing_group_type = 'Precision Queue';

/* CLCS */

update cc_c_agent_rtg_grp
set project_name = 'CLCS', program_name = 'CLCS', region_name = 'Eastern', state_name = 'Tennessee'
where agent_routing_group_number in (
5084,
5085,
5086
)
and agent_routing_group_type = 'Precision Queue';

/* WV EB */

update cc_c_agent_rtg_grp
set project_name = 'WV EB', program_name = 'WV EB', region_name = 'Eastern', state_name = 'West Virginia'
where agent_routing_group_number in (
5087,
5088,
5089,
5090
)
and agent_routing_group_type = 'Precision Queue';

/* VA EB */

update cc_c_agent_rtg_grp
set project_name = 'VA EB', program_name = 'CCC', region_name = 'Eastern', state_name = 'Virginia'
where agent_routing_group_number in (
5091,
5094
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'VA EB', program_name = 'CCC PLUS', region_name = 'Eastern', state_name = 'Virginia'
where agent_routing_group_number in (
5210,
5211
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'VA EB', program_name = 'Medallion', region_name = 'Eastern', state_name = 'Virginia'
where agent_routing_group_number in (
5092,
5093,
5095
)
and agent_routing_group_type = 'Precision Queue';

/* MO CS */
update cc_c_agent_rtg_grp
set project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri'
where agent_routing_group_number in (
5110,
5111,
5112
)
and agent_routing_group_type = 'Precision Queue';

/* DC EB */

update cc_c_agent_rtg_grp
set project_name = 'DC EB', program_name = 'Managed Care Medicaid', region_name = 'Eastern', state_name = 'District of Columbia'
where agent_routing_group_number in (
5188,
5189,
5190,
5191,
5192,
5193
)
and agent_routing_group_type = 'Precision Queue';

/* GA IES */

update cc_c_agent_rtg_grp
set project_name = 'GA IES', program_name = 'GA Healthy Babies', region_name = 'Eastern', state_name = 'Georgia'
where agent_routing_group_number in (
5118,
5119,
5120,
5121,
5127,
5145,
5146,
5147
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'GA IES', program_name = 'GA Help Desk', region_name = 'Eastern', state_name = 'Georgia'
where agent_routing_group_number in (
5122,
5123,
5124,
5125,
5126
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia'
where agent_routing_group_number in (
5128,
5129,
5130,
5131,
5143,
5144,
5148
)
and agent_routing_group_type = 'Precision Queue';

/* MI APCC */

update cc_c_agent_rtg_grp
set project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan'
where agent_routing_group_number in (5113,
5114,
5115
)
and agent_routing_group_type = 'Precision Queue';

/* SC EB */

update cc_c_agent_rtg_grp
set project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where agent_routing_group_number in (5185,
5186,
5187,
5214,
5215,
5216,
5217,
5218
)
and agent_routing_group_type = 'Precision Queue';

/* TN 11 */

update cc_c_agent_rtg_grp
set project_name = 'TN 11', program_name = 'Child Support', region_name = 'Eastern', state_name = 'Tennessee'
where agent_routing_group_number in (5137,
5138,
5139,
5140
)
and agent_routing_group_type = 'Precision Queue';

/*Iowa Hawk-i*/

update cc_c_agent_rtg_grp
set project_name = 'Iowa Hawk-i', program_name = 'CHIP', region_name = 'West Des Moines', state_name = 'Iowa'
where agent_routing_group_number in (
5209
,5243
)
and agent_routing_group_type = 'Precision Queue';


commit;


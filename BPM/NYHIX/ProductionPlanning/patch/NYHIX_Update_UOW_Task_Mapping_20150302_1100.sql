update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_HSDE1', jeopardy_inv_age=1, label='HSDE1' where cfg_uow_id=1;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_HSDE2', jeopardy_inv_age=1, label='HSDE2' where cfg_uow_id=2;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_MAILROOM', jeopardy_inv_age=1, label='Mailroom' where cfg_uow_id=3;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_APP_IN_PROCESS', jeopardy_inv_age=3, label='Application in Process' where cfg_uow_id=4;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_ACCT_CORRECTION', jeopardy_inv_age=1, label='Account Correction' where cfg_uow_id=5;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_DOH_APPEALS', jeopardy_inv_age=3, label='DOH - Appeals' where cfg_uow_id=6;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_APPEAL_SCHEDULING', jeopardy_inv_age=3, label='Appeal Scheduling' where cfg_uow_id=7;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_DATA_ENTRY_RESEARCH', jeopardy_inv_age=3, label='Data Entry Research' where cfg_uow_id=8;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_DOCFORM_CORRECTION', jeopardy_inv_age=1, label='Doc/Form Correction' where cfg_uow_id=9;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_HSDE_QC', jeopardy_inv_age=1, label='HSDE-QC' where cfg_uow_id=10;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_LINK_DOC_SET', jeopardy_inv_age=1, label='Link Doc Set' where cfg_uow_id=11;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_TPL', jeopardy_inv_age=1, label='TPL' where cfg_uow_id=12;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_EVIDENCE_PACKET_CORRECTION', jeopardy_inv_age=3, label='Evidence Packet Correction' where cfg_uow_id=13;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_QC', jeopardy_inv_age=1, label='QC' where cfg_uow_id=14;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_FREE_FORM', jeopardy_inv_age=1, label='Free Form' where cfg_uow_id=15;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_RETURNED_MAIL', jeopardy_inv_age=5, label='Returned Mail' where cfg_uow_id=16;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_V_DOCS', jeopardy_inv_age=3, label='V-Docs' where cfg_uow_id=18;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_APP_MISSING_DATA', jeopardy_inv_age=3, label='App - Missing Data' where cfg_uow_id=19;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_APPEALS', jeopardy_inv_age=3, label='Appeals' where cfg_uow_id=21;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_DPR_OTHER', jeopardy_inv_age=5, label='DPR - Other' where cfg_uow_id=22;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_AUTHORIZED_REPRESENTATIVE', jeopardy_inv_age=1, label='Authorized Representative' where cfg_uow_id=23;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_Q_NO_TASK', jeopardy_inv_age=1, label='Q - No Task' where cfg_uow_id=24;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_WRONG_PROGRAM', jeopardy_inv_age=5, label='Wrong Program' where cfg_uow_id=25;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_ORPHAN_DOCUMENTS', jeopardy_inv_age=10, label='Orphan Documents' where cfg_uow_id=27;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_ESCALATE_ARU', jeopardy_inv_age=1, label='Escalate - ARU' where cfg_uow_id=28;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_R_NO_TASK', jeopardy_inv_age=1, label='R - No Task' where cfg_uow_id=29;
update pp_cfg_unit_of_work set unit_of_work_name='NYHIX_CONSUMER_REQUESTS', jeopardy_inv_age=1, label='Consumer Requests' where cfg_uow_id=30;

update pp_d_unit_of_work set jeopardy_inv_age=1, label='HSDE1' where uow_id=1;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='HSDE2' where uow_id=2;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Mailroom' where uow_id=3;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='Application in Process' where uow_id=4;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Account Correction' where uow_id=5;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='DOH - Appeals' where uow_id=6;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='Appeal Scheduling' where uow_id=7;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='Data Entry Research' where uow_id=8;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Doc/Form Correction' where uow_id=9;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='HSDE-QC' where uow_id=10;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Link Doc Set' where uow_id=11;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='TPL' where uow_id=12;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='Evidence Packet Correction' where uow_id=13;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='QC' where uow_id=14;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Free Form' where uow_id=15;
update pp_d_unit_of_work set jeopardy_inv_age=5, label='Returned Mail' where uow_id=16;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='V-Docs' where uow_id=18;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='App - Missing Data' where uow_id=19;
update pp_d_unit_of_work set jeopardy_inv_age=3, label='Appeals' where uow_id=21;
update pp_d_unit_of_work set jeopardy_inv_age=5, label='DPR - Other' where uow_id=22;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Authorized Representative' where uow_id=23;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Q - No Task' where uow_id=24;
update pp_d_unit_of_work set jeopardy_inv_age=5, label='Wrong Program' where uow_id=25;
update pp_d_unit_of_work set jeopardy_inv_age=10, label='Orphan Documents' where uow_id=27;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Escalate - ARU' where uow_id=28;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='R - No Task' where uow_id=29;
update pp_d_unit_of_work set jeopardy_inv_age=1, label='Consumer Requests' where uow_id=30;


update pp_d_uow_source_ref
   set end_date = trunc(sysdate - 2)
 where usr_id in (140,
                  1005,
                  141,
                  144,
                  145,
                  146,
                  43,
                  54,
                  1025,
                  1024,
                  1026,
                  1017,
                  62,
                  1018,
                  57,
                  44,
                  58,
                  1027,
                  7,
                  45,
                  137,
                  138,
                  16,
                  19,
                  64,
                  139,
                  60,
                  1019,
                  1020,
                  56,
                  1001,
                  46,
                  109,
                  130,
                  21,
                  25,
                  55,
                  1000,
                  11,
                  1002,
                  47,
                  114,
                  48,
                  49,
                  12,
                  1023);
                  
                  
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1100  ,  6  ,  1  ,  'Appeal Validity Check'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2015014   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1101  ,  21  ,  1  ,  'Awaiting Documentation'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2015021   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1102  ,  21  ,  1  ,  'Awaiting Documentation'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2015022   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1103  ,  21  ,  1  ,  'Awaiting Validity Amendment - Individual'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2015024   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1104  ,  21  ,  1  ,  'Awaiting Validity Amendment - SHOP'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2015025   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1105  ,  21  ,  1  ,  'Awaiting Written Withdrawal'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2015016   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1106  ,  21  ,  1  ,  'Cancel Hearing'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2015013   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1107  ,  18  ,  1  ,  'Data Entry-Verification Document Task'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2013019   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1108  ,  8  ,  1  ,  'DERT-Account Correction'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2013050   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1109  ,  23  ,  1  ,  'DERT-Authorized Representative'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2013054   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1110  ,  28  ,  1  ,  'DERT-Existing Appeal'  ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2013051   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1111  ,  8  ,  1  ,  'DERT-Other' ,'TASK ID'  , TRUNC(SYSDATE-1),   TO_DATE('20770707','YYYYMMDD'),  2013052   FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT   1112  ,  21  ,  1  ,  'Dismissal - Failed to Attend Hearing'  ,'TASK ID'  , TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015015	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	 1113	,	   9	,	1	,	'Document Problem Resolution'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	3003	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1114	,	21	,	1	,	'Document-Account Review'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2016255	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1115	,	5	,	1	,	'DPR - Account Correction'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013011	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1116	,	28	,	1	,	'DPR - Appeals'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013029	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1117	,	4	,	1	,	'DPR - Application in Process'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013421	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1118	,	19	,	1	,	'DPR - Application-Missing Data'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013058	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1119	,	23	,	1	,	'DPR - Authorized Representative'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013053	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1120	,	28	,	1	,	'DPR - Complaint'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013010	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1121	,	9	,	1	,	'DPR - Doc/Form Type Mismatch Task'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013028	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1122	,	28	,	1	,	'DPR - Existing Appeal'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013422	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1123	,	16	,	1	,	'DPR - Financial Management'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013400	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1124	,	16	,	1	,	'DPR - FM Returned Mail'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013401	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1125	,	15	,	1	,	'DPR - Free Form Follow-Up'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013014	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1126	,	27	,	1	,	'DPR - Orphan Document'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013013	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1127	,	22	,	1	,	'DPR - Other'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013027	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1128	,	16	,	1	,	'DPR - Returned Mail Application'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013420	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1129	,	25	,	1	,	'DPR - Wrong Program'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013012	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1130	,	13	,	1	,	'Evidence Packet Correction Task'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2016234	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1131	,	7	,	1	,	'Expired Clock Document'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	20137008	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1132	,	6	,	1	,	'Hearing Set - Disposition Review Needed'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015008	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1133	,	10	,	1	,	'HSDE-QC'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	3001	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1134	,	8	,	1	,	'Incarceration Proof'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2016254	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1135	,	21	,	1	,	'Incident Open'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015001	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1136	,	21	,	1	,	'Incident Open'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015002	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1137	,	30	,	1	,	'Large Font Notice Request'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2016236	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1138	,	30	,	1	,	'Letter Resend Request'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2016155	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1139	,	14	,	1	,	'Link Doc Set QC Task'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013015	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1140	,	11	,	1	,	'Link Document Set'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	3005	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1141	,	14	,	1	,	'NYHBE MAXIMUS QC Task'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013022	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1142	,	8	,	1	,	'NYHBE Verification Doc Research Task'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2013025	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1143	,	21	,	1	,	'Refer to ES-C'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015004	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1144	,	21	,	1	,	'Refer to ES-C'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015003	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1145	,	21	,	1	,	'Refer to ES-C Supervisor'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015005	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1146	,	21	,	1	,	'Refer to ES-C Supervisor'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015006	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1147	,	30	,	1	,	'Relink Request'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2016156	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1148	,	7	,	1	,	'Reschedule Hearing - Appellant Request'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015012	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1149	,	7	,	1	,	'Reschedule Hearing - DOH Request'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015011	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1150	,	8	,	1	,	'Re-verification Manual Task'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2016194	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1151	,	7	,	1	,	'Schedule Hearing'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015010	 FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 	1152	,	6	,	1	,	'SHOP Desk Review'	,'TASK ID'	, TRUNC(SYSDATE-1),	 TO_DATE('20770707','YYYYMMDD'),	2015023	 FROM DUAL;

commit;

/

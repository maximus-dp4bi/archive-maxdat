set define off;

update engage_form_type set scorecard_group = 'QCT' where form_type_id = 484;
update engage_form_type set scorecard_group = 'QCT' where form_type_id = 485;
update engage_form_type set scorecard_group = 'QCT' where form_type_id = 486;
update engage_form_type set scorecard_group = 'QCT' where form_type_id = 487;
update engage_form_type set scorecard_group = 'QCT' where form_type_id = 488;
update engage_form_type set scorecard_group = 'QCT' where form_type_id = 489;

INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (490, 'QC Training Calibration_NYSOH_CC_Individual Marketplace_v2.1a', 'QC', 'CC', 'script', sysdate, sysdate, null);
INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (491, 'QC_NYSOH_EE_HSDE_NY Access Apps_v2.0', 'QC', 'E&E', 'script', sysdate, sysdate, null);
INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (492, 'QC_NYSOH_EE_Task Team_v1.0', 'QC', 'E&E', 'script', sysdate, sysdate, null);
INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (493, 'QC_NYSOH_Supervisor Review_Evaluation Checks_v1.0', 'QCT','QCT', 'script', sysdate, sysdate, null);
INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (494, 'Supe Review_QC_NYSOH_E&E_Evidence Packet_v1.1', 'QCT','QCT', 'script', sysdate, sysdate, null);
INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (495, 'Supe Review_QC_NYSOH_EE_HSDE_NY Access Apps_v2.0', 'QCT','QCT', 'script', sysdate, sysdate, null);
INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (496, 'Supe Review_QC_NYSOH_EE_HSDE_V Docs_v2.0', 'QCT','QCT', 'script', sysdate, sysdate, null);
INSERT INTO DP_SCORECARD.ENGAGE_FORM_TYPE(FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE) VALUES (497, 'Supe Review_QC_NYSOH_EE_Task Team_v1.0', 'QCT','QCT', 'script', sysdate, sysdate, null);

commit;

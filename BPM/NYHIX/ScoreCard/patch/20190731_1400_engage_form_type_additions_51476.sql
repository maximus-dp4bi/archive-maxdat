-- NYHIX-51476
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (770,'QC_NYSOH_EE_Doc Mgmt_v4.0','QC','E&E','script',sysdate, to_date('01-AUG-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (771,'Supe Review_QC_NYSOH_EE_Doc Mgmt_v4.0','QCT','QCT','script',sysdate, to_date('01-AUG-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (772,'QC_NYSOH_EE_Account Review Unit Evidence Packet_v1.0','QC','E&E','script',sysdate, to_date('12-AUG-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (773,'Supe Review_QC_NYSOH_EE_Account Review Unit Evidence Packet_v1.0','QCT','QCT','script',sysdate, to_date('12-AUG-2019','DD-MON-YYYY'), null);

commit;

-- NYHIX-44154
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (683,'Supe Review_QC_FPBP_Doc Management_v2.0','QCT','QCT','script',sysdate, to_date('26-JAN-2017','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (684,'Supe Review_QC_NYSOH_EE_Research_v1.2','QCT','QCT','script',sysdate, to_date('06-MAR-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (685,'Supe Review_QC_NYSOH_EE_Sorting Mail_v2.0','QCT','QCT','script',sysdate, to_date('07-OCT-2016','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (686,'QC_NYSOH_EE_Account Review Unit_Evidence Packet_v1.0','QC','E&E','script',sysdate, to_date('01-SEP-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (687,'Supe Review_QC_NYSOH_EE_Account Review Unit_Evidence Packet_v1.0','QCT','QCT','script',sysdate, to_date('01-SEP-2018','DD-MON-YYYY'), null);

commit;

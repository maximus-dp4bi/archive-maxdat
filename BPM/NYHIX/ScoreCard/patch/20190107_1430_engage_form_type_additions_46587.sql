-- NYHIX-46587
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (717,'Supe Review_QC_NYSOH_EE_Account Review Unit_v2.3','QCT','QCT','script',sysdate, to_date('07-JAN-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (718,'Supe Review_QC_NYSOH_CC_Individual Marketplace_v3.3','QCT','QCT','script',sysdate, to_date('07-JAN-2019','DD-MON-YYYY'), null);

commit;

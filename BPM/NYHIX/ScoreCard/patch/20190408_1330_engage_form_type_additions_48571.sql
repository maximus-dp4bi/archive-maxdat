-- NYHIX-48571
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (743,'QC_NYSOH_CC_Individual Marketplace_v3.4','QC','CC','script',sysdate, to_date('08-APR-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (744,'Supe Review_QC_NYSOH_CC_Individual Marketplace_v3.4','QCT','QCT','script',sysdate, to_date('08-APR-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (745,'QC_NYSOH_EE_Account Review Unit_v2.4','QC','E&E','script',sysdate, to_date('08-APR-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (746,'Supe Review_QC_NYSOH_EE_Account Review Unit_v2.4','QCT','QCT','script',sysdate, to_date('08-APR-2019','DD-MON-YYYY'), null);

commit;

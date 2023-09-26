-- NYHIX-53844
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (781,'QC_NYSOH_EE_Account Review Unit_v2.6','QC','E&E','script',sysdate, to_date('01-NOV-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (782,'QC_NYSOH_CC_Task Team_v3.6','QC','CC','script',sysdate, to_date('01-NOV-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (783,'QC_NYSOH_CC_Individual Marketplace_v3.6','QC','CC','script',sysdate, to_date('01-NOV-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (784,'QC_NYSOH_CC_Telephone Inquiry_Statewide CC_v4.4','QC','CC','script',sysdate, to_date('01-NOV-2019','DD-MON-YYYY'), null);

commit;

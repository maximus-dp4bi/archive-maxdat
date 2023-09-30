-- NYHIX-51344
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (768,'QC_NYSOH_EE_Data Entry in MAXe_V Docs_v1.0','QC','E&E','script',sysdate, to_date('01-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (769,'Supe Review_QC_NYSOH_EE_Data Entry in MAXe_V Docs_v1.0','QCT','QCT','script',sysdate, to_date('01-JUL-2019','DD-MON-YYYY'), null);

commit;

---- NYHIX-40889
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(666, 'QC_FPBP_Phone_Supe Checklist v1.1','QC','FPBP','script',sysdate, to_date('01-JUN-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(667,'QC_NYSOH_HSDEQC_V Docs_v2.1','QC','E&E','script',sysdate,to_date('08-JUN-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(668, 'Supe Review_QC_NYSOH_HSDEQC_V Docs_v2.1','QCT','QCT','script',sysdate,to_date('08-JUN-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(669,'OPS_NYSOH_CC_Individual Marketplace_v2.2.1','QC','CC','script',sysdate,to_date('08-JUN-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(670, 'Supe Review_OPS_NYSOH_CC_Individual Marketplace_v2.2.1','QCT','QCT','script',sysdate,to_date('08-JUN-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(671,'OPS_NYSOH_CC_Telephone Inquiry_Statewide CC_v4.1','QC','CC','script',sysdate,to_date('08-JUN-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(672,'Supe Review_OPS_NYSOH_CC_Telephone Inquiry_Statewide CC_v4.1','QCT','QCT','script',sysdate,to_date('08-JUN-2018','DD-MON-YYYY'), null);

commit;
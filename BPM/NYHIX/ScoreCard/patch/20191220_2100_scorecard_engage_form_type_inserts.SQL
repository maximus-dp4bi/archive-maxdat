Alter session set current_schema=dp_scorecard;

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_SWCC_v4.5','QC','CC','script',sysdate,'6-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Web Chat_v2.2','QC','CC','script',sysdate,'6-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Small Business Marketplace_v2.1','QC','CC','script',sysdate,'6-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Individual Marketplace_v3.7','QC','CC','script',sysdate,'6-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Task Team_v3.7','QC','CC','script',sysdate,'6-Jan-2020',null);

commit;
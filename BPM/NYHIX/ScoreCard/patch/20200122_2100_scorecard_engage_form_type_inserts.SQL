Alter session set current_schema=dp_scorecard;

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_EE_ARU v2.7','QC',
(select scorecard_group from dp_scorecard.engage_form_type where form_type_id=491),
'script',sysdate,'17-Jan-2020',null);


insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Individual Marketplace_v4.0','QC',
'CC','script',sysdate,'17-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_SWCC_v4.6','QC',
'CC','script',sysdate,'17-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Task Team_v3.8','QC',
'CC','script',sysdate,'17-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Small Business Marketplace_v2.2','QC',
'CC','script',sysdate,'17-Jan-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_EE_Verification_Docs_v4.4','QC',
(select scorecard_group from dp_scorecard.engage_form_type where form_type_id=491),'script',sysdate,'13-Jan-2020',null);

COMMIT;



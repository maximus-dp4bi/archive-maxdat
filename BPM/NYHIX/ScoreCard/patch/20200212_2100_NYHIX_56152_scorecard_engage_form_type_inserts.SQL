Alter session set current_schema=dp_scorecard;

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Individual Marketplace_v4.1','QC',
'CC',
'script',sysdate,'10-Feb-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_SWCC_v4.7','QC',
'CC',
'script',sysdate,'10-Feb-2020',null);

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_CC_Task Team_v3.9','QC',
'CC',
'script',sysdate,'10-Feb-2020',null);



commit;
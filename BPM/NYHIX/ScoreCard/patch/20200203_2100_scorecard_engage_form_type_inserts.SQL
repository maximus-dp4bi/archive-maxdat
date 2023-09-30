Alter session set current_schema=dp_scorecard;

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_EE_Doc Mgmt_v5.0','QC',
(select scorecard_group from dp_scorecard.engage_form_type where form_type_id=491),
'script',sysdate,'01-Feb-2020',null);


commit;
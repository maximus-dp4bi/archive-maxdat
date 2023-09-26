Alter session set current_schema=dp_scorecard;

insert into dp_scorecard.engage_form_type 
values (
(select max( form_type_id)+1 from dp_scorecard.engage_form_type), 'QC_NYSOH_EE_Data Entry in KOFAX_V2.0','QC',
(select scorecard_group from dp_scorecard.engage_form_type where form_type_id=491),
'script',sysdate,'09-Mar-2020',null);


commit;
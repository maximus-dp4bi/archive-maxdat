--1. remove the queue configurations for project / program from the cc_c_lookup table for these queues:

delete from cc_c_lookup where lookup_type in ('ACD_SKILLSET_PROJECT', 'ACD_SKILLSET_PROGRAM')
and lookup_key in ('10042','10041','10040','10039','10038','10037','10036','10035'); 


delete from cc_c_filter where filter_type in ('ACD_SKILLSET_PROJECT', 'ACD_SKILLSET_PROGRAM')
and value in ('10042','10041','10040','10039','10038','10037','10036','10035'); 

--2. delete all rows from cc_f_actuals_queue_interval for these queues
delete from cc_f_actuals_queue_interval where d_contact_queue_id in 
(select d_contact_queue_id from CC_d_CONTACT_QUEUE where queue_name in ('CHP_Eng_s',
'CHP_Spn_s',
'FML_Eng_s',
'FML_Spn_s',
'HC_Eng_s',
'HC_Spn_s',
'OMB_Eng_s',
'OMB_Spn_s'));

--3. remove these contact queues from cc_c_contact_queue and cc_d_contact_queue

delete from CC_C_CONTACT_QUEUE where queue_name in ('CHP_Eng_s',
'CHP_Spn_s',
'FML_Eng_s',
'FML_Spn_s',
'HC_Eng_s',
'HC_Spn_s',
'OMB_Eng_s',
'OMB_Spn_s');

delete from CC_D_CONTACT_QUEUE where queue_name in ('CHP_Eng_s',
'CHP_Spn_s',
'FML_Eng_s',
'FML_Spn_s',
'HC_Eng_s',
'HC_Spn_s',
'OMB_Eng_s',
'OMB_Spn_s');

commit;

/

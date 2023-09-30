insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(36,1,'Resolve Incident EES CSS');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(37,1,'Resolve Incident SUP');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(38,1,'Resolve Incident DOH');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(39,1,'Perform FollowUp');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(40,1,'Withdraw Incident');

insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(41,2,'Resolved EES CSS');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(42,2,'Resolved SUP');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(43,2,'Follow-up Required');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(44,2,'Return to the State');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(45,3,'Closed');
insert into bpm_activity_lkup(bacl_id,bactl_id,activity_name) values(46,3,'Withdrawn');


insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(36,22,36,'ASF_RESOLVE_INCIDENT_EES_CSS','NOT NULL',1);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(37,22,41,'GWF_RESOLVED_EES_CSS','NOT NULL',2);

insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(38,22,37,'ASF_RESOLVE_INCIDENT_SUP','NOT NULL',3);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(39,22,42,'GWF_RESOLVED_SUP','NOT NULL',4);

insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(40,22,38,'ASF_RESOLVE_INCIDENT_DOH','NOT NULL',5);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(41,22,43,'GWF_FOLLOWUP_REQ','NOT NULL',6);

insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(42,22,39,'ASF_PERFORM_FOLLOWUP','NOT NULL',7);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(43,22,44,'GWF_RETURN_TO_STATE','NOT NULL',8);

insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(44,22,45,'ASF_WITHDRAW_INCIDENT','NOT NULL',9);
insert into bpm_activity_attribute(baca_id, bem_id,bacl_id,activity_flag_name,value_on_complete,flow_order) values(45,22,46,'COMPLETE_DT','NOT NULL',10);


Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2587,178,22,'BOTH',to_date('2013-09-22 08:52:50','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Y');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2587,22,'CURRENT_STEP');

delete from nyhx_etl_complaints_incidents;

update corp_etl_control set value = '0' where name = 'PC_LAST_COMPLAINT';

update corp_etl_control set value = '200' where name = 'COMP_LOOK_BACK_DAYS';

commit;

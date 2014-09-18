delete from nyhx_etl_complaints_incidents;

update corp_etl_control set value = '0' where name = 'PC_LAST_COMPLAINT';

update corp_etl_control set value = '200' where name = 'COMP_LOOK_BACK_DAYS';

delete from corp_etl_error_log where process_name = 'PROCESS INCIDENT COMPLAINTS';

update corp_etl_list_lkup set value = 'State Supervisory Review-Transition' where name = 'ProcessComp_Fwding_Target' 
and list_type = 'COMPLAINT'
and value = 'State Supervisory Review-DOH Transition';

update corp_etl_list_lkup set value = 'Refer to State-Transition'  where name = 'ProcessComp_Fwding_Target' 
and list_type = 'COMPLAINT'
and value = 'Refer to State-DOH Transition';

update corp_etl_list_lkup set ref_id = 0 where name = 'ProcessComp_Fwding_Target' 
and list_type = 'COMPLAINT'
and value = 'Refer to Supervisor';

Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1591,2,'Followup Flag','The Follow-Up Checkbox Flag indicates whether the state requests follow-up tasts from Maximus');

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2573,1591,22,'CREATE',to_date('2013-09-22 08:52:50','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2573,22,'FOLLOWUP_FLAG');

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2585,5,22,'BOTH',to_date('2013-09-22 08:52:50','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Y');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2585,22,'COMPLETE_DT');

Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1601,3,'Forward DT','The date when the complaint is forwarded to state the first time');

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2586,1601,22,'BOTH',to_date('2013-09-22 08:52:50','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2586,22,'FORWARD_DT');

update bpm_attribute set RETAIN_HISTORY_FLAG = 'N'
where bem_id = 22 and bal_id not in ( 461, 5) and retain_history_flag = 'Y';

update corp_etl_list_lkup set value = 'State Supervisory Review-Financial Management'
where value = 'State Supervisory Review-Financial ManagementP'
and  name = 'ProcessComp_Fwding_Target'
and list_type = 'COMPLAINT';

commit;
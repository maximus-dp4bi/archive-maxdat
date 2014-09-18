--Document jeopardy threshold
insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Case Maintenance'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Case Maintenance in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Client Request for Home Visit'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Client Request for Home Visit in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Disenrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type EBSSP Online Disenrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Enrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type EBSSP Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'EBSSP Online MPF'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type EBSSP Online MPF in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'General Correspondence Letter'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type General Correspondence Letter in business hours'
					,SYSDATE
					,SYSDATE);
          
insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'IVR Online Enrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type IVR Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);          

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Outreach Request'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Outreach Request in business hours'
					,SYSDATE
					,SYSDATE);           

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Provider Outreach Referral'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Provider Outreach Referral in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'STAR RSA Enrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type STAR RSA Enrollment in business hours'
					,SYSDATE
					,SYSDATE);


          
--Document Timeliness threshold

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Case Maintenance'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Case Maintenance in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Client Request for Home Visit'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Client Request for Home Visit in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Disenrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type EBSSP Online Disenrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Enrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type EBSSP Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'EBSSP Online MPF'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type EBSSP Online MPF in business hours'
					,SYSDATE
					,SYSDATE);
          
 insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'General Correspondence Letter'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type General Correspondence Letter in business hours'
					,SYSDATE
					,SYSDATE);         

insert into corp_etl_list_lkup(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'IVR Online Enrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type IVR Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Outreach Request'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Outreach Request in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Provider Outreach Referral'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Provider Outreach Referral in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'STAR RSA Enrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type STAR RSA Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

update corp_etl_list_lkup set value = 'CHIP Disenrollment Requests'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'CHIP Disenrollment Request';

update corp_etl_list_lkup set value = 'Complaint'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'Complaint Document';

update corp_etl_list_lkup set value = 'Demographic Changes'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'Demographic Change';

update corp_etl_list_lkup set value = 'Medicaid Disenrollment Requests'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'Medicaid Disenrollment Request';

commit;
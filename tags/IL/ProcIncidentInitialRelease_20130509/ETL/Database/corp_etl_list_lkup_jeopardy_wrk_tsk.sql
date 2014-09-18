--Document jeopardy threshold
insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'UNKNOWN'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL jeopardy threshold for doc type Unknown in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Complaint'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL jeopardy threshold for doc type Complaint in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL jeopardy threshold for doc type Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'General Correspondence'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL jeopardy threshold for doc type General Correspondence in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Survey'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL jeopardy threshold for doc type Health Assessment Survey in business hours'
					,SYSDATE
					,SYSDATE);


--Document Timeliness threshold

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'UNKNOWN'
					,'12'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL Timeliness threshold for doc type Unknown in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Complaint'
					,'12'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL Timeliness threshold for doc type Complaint in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Enrollment'
					,'12'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL Timeliness threshold for doc type Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'General Correspondence'
					,'12'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL Timeliness threshold for doc type General Correspondence in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Survey'
					,'12'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL Timeliness threshold for doc type Health Assessment Survey in business hours'
					,SYSDATE
					,SYSDATE);
          
          commit;
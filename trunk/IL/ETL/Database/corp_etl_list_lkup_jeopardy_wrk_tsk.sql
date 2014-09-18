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
					,'16'
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
					,'16'
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
					,'16'
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
					,'16'
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
					,'16'
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
					,'40'
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
					,'40'
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
					,'40'
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
					,'40'
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
					,'40'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL Timeliness threshold for doc type Health Assessment Survey in business hours'
					,SYSDATE
					,SYSDATE);
          
          commit;
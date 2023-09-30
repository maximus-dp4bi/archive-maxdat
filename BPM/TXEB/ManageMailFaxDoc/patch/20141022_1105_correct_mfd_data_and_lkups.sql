insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE1'
  ,'Case Maintenance'
  ,'Medical Payment Form'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medical Payment Form' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Case Maintenance'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE1'
  ,'Enrollment'
  ,'CHIP Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment MI' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
  insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE2'
  ,'Enrollment'
  ,'Medicaid Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medicaid Enrollment MI' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
    insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE3'
  ,'Enrollment'
  ,'NorthSTAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'NorthSTAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
    insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE4'
  ,'Enrollment'
  ,'STAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
      insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE5'
  ,'Enrollment'
  ,'STAR+PLUS Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR+PLUS Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE6'
  ,'Enrollment'
  ,'TP40 STAR Enrollment'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'TP40 STAR Enrollment' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('TASK_MONITOR_TYPE','LIST','Enrollment Data Entry Task','Data Entry Unit','STEP_DEFINITION_ID',1059,to_date('03-SEP-13','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Updated for Maxdat-800 on 12-13-2013!',to_date('03-SEP-13','DD-MON-RR'),to_date('13-DEC-13','DD-MON-RR'));

update corp_etl_list_lkup
set value = 'Outreach Req Data Entry'
where value = 'Outreach Req Data Entry Task'
and name = 'TASK_MONITOR_TYPE';

update corp_etl_list_lkup
set out_var = 'Outreach Req Data Entry'
where name = 'ProcessMail_work_expected'
and list_type = 'DOC_TYPE'
and out_var = 'Outreach Request Data Entry Task';


update corp_etl_list_lkup
set out_var = 'TP40 STAR Enrollment'
where name = 'ProcessMail_work_expected'
and list_type = 'DOC_TYPE'
and value in('TP40 STAR and NorthSTAR Enrollment','TP40 STAR Enrollment');


DECLARE  
  CURSOR temp_cur IS
  select cemfd_id, batch_channel, instance_status,CASE WHEN batch_channel = 'ONLINE' THEN 'Y' ELSE 'N' END gwf_channel_online
  from corp_etl_mailfaxdoc
  where gwf_channel_online is null;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT  LOOP
          UPDATE corp_etl_mailfaxdoc
          SET gwf_channel_online = temp_tab(indx).gwf_channel_online   
          WHERE cemfd_id = temp_tab(indx).cemfd_id;     
          
          IF temp_tab(indx).gwf_channel_online = 'Y' AND temp_tab(indx).instance_status = 'Active' THEN
            UPDATE corp_etl_mailfaxdoc
            SET instance_complete_dt = sysdate
                ,instance_status = 'Complete'
                ,stage_done_dt = sysdate
            WHERE cemfd_id = temp_tab(indx).cemfd_id;
          END IF;
        END LOOP;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

update corp_etl_mailfaxdoc
set gwf_work_identified = null
   ,assd_create_ia_task = null
   ,assd_create_and_route_work = null
   ,ased_create_ia_task = null
   ,ased_create_and_route_work = null
   ,asf_create_ia_task = 'N'
   ,asf_create_and_route_work= 'N'
   ,assd_classify_form_doc_manual = null
   ,ased_classify_form_doc_manual = null
   ,assd_link_images_manual = null
   ,ased_link_images_manual = null
   ,asf_classify_form_doc_manual = 'N'
   ,asf_link_images_manual = 'N'
where  gwf_work_identified = 'Y'
and work_task_type_created is null
and instance_status = 'Active';

commit;
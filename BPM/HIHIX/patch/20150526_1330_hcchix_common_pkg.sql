alter session set plsql_code_type = native;

create or replace package HCCHIX_COMMON_PKG is

-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


   con_pkg Constant  VARCHAR2(30) := 'hcchix_common_pkg';  

  procedure fix_stuck_tasks;

end HCCHIX_COMMON_PKG;

/

create or replace package body HCCHIX_COMMON_PKG is

procedure fix_stuck_tasks
is

 v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'FIX_STUCK_TASKS';
 mw_rec corp_etl_manage_work%Rowtype;
 v_log_message clob := null;
 v_old_create_dt varchar2(10);
 
Begin

   for i in ( select * from corp_etl_manage_work
               where trunc(complete_date) < trunc(create_date))
   loop  
      
      mw_rec := i;
      v_old_create_dt := to_char(i.create_date,'mmddyyyy');
      
      update corp_etl_manage_work 
         set create_date = trunc(complete_Date) 
       where task_id = i.task_id;
       
      mw_rec.create_date := trunc(i.complete_date);       

     Delete from bpm_update_event_queue where identifier =  to_char(i.task_id);

     Delete from f_mw_by_date where mw_bi_id in (select mw_bi_id from d_mw_current where "Task ID" = i.task_id) ; 

     Delete from d_mw_current where "Task ID" = i.task_id;
     
     Delete from corp_etl_manage_Work where task_id = i.task_id;
     
     insert into corp_etl_manage_work values mw_rec;
     
     v_log_message := 'Task ID :'|| mw_rec.task_id || ' was updated for create date value from '||v_old_create_dt||' to '|| to_char(mw_rec.complete_date,'mmddyyyy');
     
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,1,null,mw_rec.task_id,null,v_log_message,null); 

   end loop;  

  End;
  


end HCCHIX_COMMON_PKG;

/

alter session set plsql_code_type = interpreted;



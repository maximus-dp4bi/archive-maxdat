Update Corp_Etl_Manage_Work
set 
Complete_date = NULL
,OWNER_name = NULL
,Cancel_Work_date = to_date('31-OCT-2013','DD-MON-YYYY')
,Cancel_Work_flag = 'Y'
,complete_flag = 'N'
,Task_Status = 'CANCEL'
,Cancel_reason = 'Cancelled Test Task'
,Cancel_By = 'MAXIMUS\62310'
Where Task_id in (2157,2158, 2160);
   
commit;   
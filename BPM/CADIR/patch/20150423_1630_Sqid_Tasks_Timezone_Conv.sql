  Alter Trigger TRG_AI_CORP_ETL_MANAGE_WORK_Q disable ;
  Alter Trigger TRG_AU_CORP_ETL_MANAGE_WORK_Q disable ;

BEGIN

  -- Update corp_etl_manage_work sqid tasks
  
  DBMS_OUTPUT.PUT_LINE('Before Update to CORP_ETL_MANAGE_WORK table');
  
  Update Corp_etl_manage_Work 
     set Complete_date = Complete_date + 3/24
       , Create_date = Create_date + 3/24
       , Last_update_date = Last_update_date + 3/24
       , Status_date = Status_date + 3/24
       , Instance_Start_date = Instance_Start_date + 3/24
       , Instance_End_date = Instance_End_date + 3/24
       , Received_date = Received_date + 3/24
       , Original_Creation_date =  Original_Creation_date + 3/24
   Where source_reference_type = 'DocumentID';

   DBMS_OUTPUT.PUT_LINE('After Update to CORP_ETL_MANAGE_WORK table, rows affected - '||TO_Char(SQL%ROWCOUNT));
   
   Commit;
  --  
END;
/

 Alter trigger TRG_AI_CORP_ETL_MANAGE_WORK_Q enable ;
 Alter trigger TRG_AU_CORP_ETL_MANAGE_WORK_Q enable ;

BEGIN 
  
  -- Update Sqid stage records  
  DBMS_OUTPUT.PUT_LINE('Before Update to SQID_TASKS_HIST_STG table');
  
  Update Sqid_Task_Hist_Stg
     set Start_Date = Start_Date + 3/24
       , End_Date = End_Date + 3/24
       , Status_Date = Status_Date + 3/24
       , Release_Date = Release_Date + 3/24
       , Received_Date = Received_Date + 3/24
       , Create_date = Create_date + 3/24
       , Update_date = Update_date + 3/24;

   DBMS_OUTPUT.PUT_LINE('After Update to SQID_TASKS_HIST_STG table, rows affected - '||TO_Char(SQL%ROWCOUNT));
   
   Commit;
   --

   -- Update D_MW_CURRENT table
   DBMS_OUTPUT.PUT_LINE('Before Update to D_MW_CURRENT table');
   
   Update D_MW_CURRENT
      set "Create Date" = "Create Date" + 3/24
        , "Complete Date" = "Complete Date" + 3/24
        , "Cancel Work Date" = "Cancel Work Date" + 3/24
        , "Current Last Update Date" = "Current Last Update Date" + 3/24
        , "Current Status Date" = "Current Status Date" + 3/24
        ,  received_date = received_date + 3/24
        ,  original_create_date = original_create_date + 3/24
     Where "Source Reference Type" = 'DocumentID' ;
   
   DBMS_OUTPUT.PUT_LINE('After Update to D_MW_CURRENT table, rows affected - '||TO_Char(SQL%ROWCOUNT));

   Commit;
   --
   
   -- Update F_MW_BY_DATE table
   
   DBMS_OUTPUT.PUT_LINE('Before Update to F_MW_BY_DATE table');
   
   Update F_MW_BY_DATE
      set d_date = d_date + 3/24
        , "Last Update Date" = "Last Update Date" + 3/24
        , "Status Date" =  "Status Date" + 3/24
        , received_date = received_date + 3/24
    Where mw_bi_id in ( select mw_bi_id from d_mw_current where "Source Reference Type" = 'DocumentID' );
   
   DBMS_OUTPUT.PUT_LINE('After Update to F_MW_BY_DATE table, rows affected - '||TO_Char(SQL%ROWCOUNT));

   Commit;

  END;
  /

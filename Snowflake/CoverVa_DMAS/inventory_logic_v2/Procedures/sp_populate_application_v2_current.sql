use schema coverva_dmas;
create or replace procedure SP_POPULATE_APPLICATION_V2_CURRENT()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 6: Update if app is in ConnectionPoint */         
       var strSQLText = `INSERT INTO coverva_dmas.dmas_application_v2_current(Tracking_Number,Source,App_Received_Date,Processing_Unit,Application_Type,Current_State,Initial_Review_Complete_Date,  
                            Application_Processing_End_Date,Last_Employee,Applicant_Name,Case_Number,Override_Value_Indicator,FP_Create_Dt,FP_Update_Dt,File_ID,In_CP_Indicator, 
                            Migrated_App_Indicator,Initial_Review_DT_Null_Reason,Last_Employee_Null_Reason,End_Date_Null_Reason,VCL_Due_Date,Intake_Date,Complete_Date,File_Inventory_Date, 
                            maximus_source_date,state_app_received_date,cp_application_type,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,vcl_sent_date,case_type,sd_stage,
                            renewal_closure_date,auto_closure_date,denial_reason) 
                SELECT Tracking_Number,Source,App_Received_Date,Processing_Unit,Application_Type,Current_State,Initial_Review_Complete_Date,  
                   Application_Processing_End_Date,Last_Employee,Applicant_Name,Case_Number,Override_Value_Indicator,current_timestamp() FP_Create_Dt,current_timestamp() FP_Update_Dt,File_ID,In_CP_Indicator, 
                   Migrated_App_Indicator,Initial_Review_DT_Null_Reason,Last_Employee_Null_Reason,End_Date_Null_Reason,VCL_Due_Date,Intake_Date,Complete_Date,File_Inventory_Date, 
                   maximus_source_date,state_app_received_date,cp_application_type,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,vcl_sent_date,case_type,sd_stage,
                   renewal_closure_date,auto_closure_date,denial_reason
               FROM (SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                     FROM coverva_dmas.dmas_application_v2_inventory da) da 
               WHERE rnk = 1 
               AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v2_current dac WHERE da.tracking_number = dac.tracking_number);`;           
         var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
         var ret_value = strSQLStmt.execute();
         
         strSQLText = `UPDATE coverva_dmas.dmas_application_v2_current dac 
              SET dac.Source = da.source 
                 ,dac.App_Received_Date = da.app_received_date 
                 ,dac.Processing_Unit = da.processing_unit 
                 ,dac.Application_Type =  da.application_type 
                 ,dac.Current_State = da.current_state 
                 ,dac.Initial_Review_Complete_Date = da.initial_review_complete_date 
                 ,dac.Application_Processing_End_Date = da.application_processing_end_date 
                 ,dac.Last_Employee = da.last_employee 
                 ,dac.Applicant_Name = da.applicant_name 
                 ,dac.Case_Number = da.case_number 
                 ,dac.Override_Value_Indicator = da.override_value_indicator 
                 ,dac.FP_Update_Dt = current_timestamp() 
                 ,dac.File_ID = da.file_id 
                 ,dac.In_CP_Indicator = da.in_cp_indicator 
                 ,dac.Migrated_App_Indicator = da.migrated_app_indicator 
                 ,dac.Initial_Review_DT_Null_Reason = da.initial_review_dt_null_reason 
                 ,dac.Last_Employee_Null_Reason = da.last_employee_null_reason 
                 ,dac.End_Date_Null_Reason = da.end_date_null_reason 
                 ,dac.VCL_Due_Date = da.vcl_due_date 
                 ,dac.Intake_Date = da.intake_date 
                 ,dac.Complete_Date = da.complete_date 
                 ,dac.File_Inventory_Date = da.file_inventory_date 
                 ,dac.maximus_source_date = da.maximus_source_date 
                 ,dac.state_app_received_date = da.state_app_received_date 
                 ,dac.cp_application_type = da.cp_application_type 
                 ,dac.cm044_verified = da.cm044_verified 
                 ,dac.non_maximus_initial_date = CASE WHEN dac.non_maximus_initial_date IS NULL THEN da.non_maximus_initial_date ELSE dac.non_maximus_initial_date END  
                 ,dac.non_maximus_returned_date = CASE WHEN dac.non_maximus_returned_date IS NULL OR da.non_maximus_returned_date > dac.non_maximus_returned_date THEN da.non_maximus_returned_date ELSE dac.non_maximus_returned_date END  
                 ,dac.vcl_sent_date = CASE WHEN dac.vcl_sent_date IS NULL THEN da.vcl_sent_date ELSE dac.vcl_sent_date END 
                 ,dac.case_type = da.case_type
                 ,dac.sd_stage = CASE WHEN dac.sd_stage IS NULL OR dac.sd_stage != da.sd_stage THEN da.sd_stage ELSE dac.sd_stage END
                 ,dac.renewal_closure_date = da.renewal_closure_date
                 ,dac.auto_closure_date = da.auto_closure_date
                 ,dac.denial_reason = da.denial_reason
             FROM (SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                     FROM coverva_dmas.dmas_application_v2_inventory da 
                       JOIN coverva_dmas.dmas_file_log df ON da.file_id = df.file_id ) da 
               WHERE rnk = 1 AND da.tracking_number = dac.tracking_number;`;
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          ret_value = strSQLStmt.execute();
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;
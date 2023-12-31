CREATE OR REPLACE VIEW coverva_dmas.dmas_app_metric_and_renewal_vw
AS
SELECT appmetric_data_id,
       null renewal_data_id,       
       Tracking_Number, 
       Locality ,
       App_Received_Date,
       FFM_Transfer_Date,
       FFM_Application_Type ,
       TO_CHAR(Case_Number) case_number,
       Application_Status ,
       Application_Source ,
       Worker_ID ,
       Worker_Name ,
       Stage ,
       Range ,
       Pending_due_to_VCL ,
       VCL_Due_Date,
       Applicant_Last_Name ,
       Applicant_First_Name ,
       Disability_Verification_Pending ,
       Application_ABD_Indicator ,
       Case_ABD_Indicator ,
       ABD ,
       Application_LTC_Indicator ,
       Case_LTC_Indicator ,
       LTC ,
       CPU_Assigned ,
       'Application' Application_Type,
       null processing_unit,
       null Case_Incarcerated_Indicator,
       null MA_PG_Indicator,
       Filename 
FROM coverva_dmas.app_metric_full_load
UNION ALL
SELECT null appmetric_data_id,
       renewal_data_id,
       Tracking_Number,
       Locality,
       received_date App_Received_Date,
       null FFM_Transfer_Date,
       null FFM_Application_Type,
       Case_Number,
       processing_status Application_Status,
       Application_Source,
       Worker_ID,
       NULL worker_name,
       null Stage,
       null Range,
       null Pending_due_to_VCL,
       null VCL_Due_Date,
       SUBSTR(case_name,1,REGEXP_INSTR(case_name,',')-1) Applicant_Last_Name,
       SUBSTR(case_name,REGEXP_INSTR(case_name,',')+1) Applicant_First_Name,
       null disability_verification_pending,
       null Application_ABD_Indicator,
       potential_disability Case_ABD_Indicator,
       null ABD,
       null Application_LTC_Indicator,
       null Case_LTC_Indicator,
       null LTC,
       null cpu_assigned,
       'Renewal' Application_Type,
       processing_unit,
       incarcerated Case_Incarcerated_Indicator,
       potential_pregnancy MA_PG_Indicator,
       Filename
FROM coverva_dmas.renewal_data_full_load
;                 
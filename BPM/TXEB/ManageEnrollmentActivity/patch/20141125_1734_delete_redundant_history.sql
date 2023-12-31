--create temporary table
CREATE TABLE bpm_delete_queue_archive_mea
AS
 SELECT IDENTIFIER,
  BUEQ_ID 
  FROM BPM_UPDATE_EVENT_QUEUE_ARCHIVE
WHERE bsl_id   =14
and old_data is not null
and new_data is not null
  and
  COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/AA_DUE_DT'),'X')  = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/AA_DUE_DT'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_AUTO_ASSIGN'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_AUTO_ASSIGN'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_FIRST_FOLLOWUP'),'X') =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_FIRST_FOLLOWUP'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_FOURTH_FOLLOWUP'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_FOURTH_FOLLOWUP'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_SECOND_FOLLOWUP'),'X') =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_SECOND_FOLLOWUP'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_SELECTION_RECD'),'X')  =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_SELECTION_RECD'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_SEND_ENROLL_PACKET'),'X') =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_SEND_ENROLL_PACKET'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_THIRD_FOLLOWUP'),'X')   =    COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_THIRD_FOLLOWUP'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASED_WAIT_FOR_FEE'),'X')    =   COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASED_WAIT_FOR_FEE'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_AUTO_ASSIGN'),'X')     =    COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_AUTO_ASSIGN'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_CANCEL_ENRL_ACTIVITY'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_CANCEL_ENRL_ACTIVITY'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_FIRST_FOLLOWUP'),'X')       = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_FIRST_FOLLOWUP'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_FOURTH_FOLLOWUP'),'X')     = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_FOURTH_FOLLOWUP'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_SECOND_FOLLOWUP'),'X')     = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_SECOND_FOLLOWUP'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_SELECTION_RECD'),'X')      = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_SELECTION_RECD'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_SEND_ENROLL_PACKET'),'X')  = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_SEND_ENROLL_PACKET'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_THIRD_FOLLOWUP'),'X')      = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_THIRD_FOLLOWUP'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASF_WAIT_FOR_FEE'),'X')        =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASF_WAIT_FOR_FEE'),'X')    
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_AUTO_ASSIGN'),'X')        = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_AUTO_ASSIGN'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_FIRST_FOLLOWUP'),'X')     = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_FIRST_FOLLOWUP'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_FOURTH_FOLLOWUP'),'X')    = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_FOURTH_FOLLOWUP'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_SECOND_FOLLOWUP'),'X')    = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_SECOND_FOLLOWUP'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_SELECTION_RECD'),'X')     =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_SELECTION_RECD'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_SEND_ENROLL_PACKET'),'X')  = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_SEND_ENROLL_PACKET'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_THIRD_FOLLOWUP'),'X')     =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_THIRD_FOLLOWUP'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ASSD_WAIT_FOR_FEE'),'X')       = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ASSD_WAIT_FOR_FEE'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CANCEL_BY'),'X')               =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CANCEL_BY'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CANCEL_DT'),'X')               = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CANCEL_DT'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CANCEL_METHOD'),'X')           = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CANCEL_METHOD'),'X')    
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CANCEL_REASON'),'X')           = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CANCEL_REASON'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CASE_ID'),'X')                 = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CASE_ID'),'X')    
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CHIP_EMI_ID'),'X')             = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CHIP_EMI_ID'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CHIP_EMI_MAILED_DT'),'X')      = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CHIP_EMI_MAILED_DT'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CHIP_HPC_ID'),'X')             = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CHIP_HPC_ID'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CHIP_HPC_MAILED_DT'),'X')      = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CHIP_HPC_MAILED_DT'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CLIENT_CIN'),'X')       = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CLIENT_CIN'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CLIENT_ENROLL_STATUS_ID'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CLIENT_ENROLL_STATUS_ID'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CLIENT_ID'),'X')              = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CLIENT_ID'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/COMPLETE_DT'),'X')            = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/COMPLETE_DT'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/COUNTY_CODE'),'X')            =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/COUNTY_CODE'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/CREATE_DT'),'X')              = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/CREATE_DT'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ENRL_PACK_ID'),'X')           = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ENRL_PACK_ID'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ENRL_PACK_REQUEST_DT'),'X')   =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ENRL_PACK_REQUEST_DT'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ENROLLMENT_STATUS_CODE'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ENROLLMENT_STATUS_CODE'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ENROLLMENT_STATUS_DT'),'X')   = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ENROLLMENT_STATUS_DT'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ENROLL_FEE_AMNT_DUE'),'X')    = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ENROLL_FEE_AMNT_DUE'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ENROLL_FEE_AMNT_PAID'),'X')   = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ENROLL_FEE_AMNT_PAID'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ENROLL_FEE_PAID_DT'),'X')     = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ENROLL_FEE_PAID_DT'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/FEE_PAID_FLG'),'X')           =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/FEE_PAID_FLG'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/FIRST_FOLLOWUP_ID'),'X')      =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/FIRST_FOLLOWUP_ID'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/FIRST_FOLLOWUP_TYPE_CODE'),'X') =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/FIRST_FOLLOWUP_TYPE_CODE'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/FOURTH_FOLLOWUP_ID'),'X')      = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/FOURTH_FOLLOWUP_ID'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/FOURTH_FOLLOWUP_TYPE_CODE'),'X') =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/FOURTH_FOLLOWUP_TYPE_CODE'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GENERIC_FIELD_1'),'X')          = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GENERIC_FIELD_1'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GENERIC_FIELD_2'),'X')          =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GENERIC_FIELD_2'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GENERIC_FIELD_3'),'X')          =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GENERIC_FIELD_3'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GENERIC_FIELD_4'),'X')          =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GENERIC_FIELD_4'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GENERIC_FIELD_5'),'X')          =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GENERIC_FIELD_5'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GWF_ENRL_PACK_REQ'),'X')        = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GWF_ENRL_PACK_REQ'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GWF_FIRST_FOLLOWUP_REQ'),'X')   = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GWF_FIRST_FOLLOWUP_REQ'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GWF_FOURTH_FOLLOWUP_REQ'),'X')  = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GWF_FOURTH_FOLLOWUP_REQ'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GWF_REQUIRED_FEE_PAID'),'X')    = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GWF_REQUIRED_FEE_PAID'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GWF_SECOND_FOLLOWUP_REQ'),'X')  = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GWF_SECOND_FOLLOWUP_REQ'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/GWF_THIRD_FOLLOWUP_REQ'),'X')   = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/GWF_THIRD_FOLLOWUP_REQ'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/INSTANCE_STATUS'),'X')          = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/INSTANCE_STATUS'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/NEWBORN_FLG'),'X')              =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/NEWBORN_FLG'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/PLAN_TYPE'),'X')                = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/PLAN_TYPE'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/PROGRAM_TYPE'),'X')             = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/PROGRAM_TYPE'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SECOND_FOLLOWUP_ID'),'X')       = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SECOND_FOLLOWUP_ID'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SECOND_FOLLOWUP_TYPE_CODE'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SECOND_FOLLOWUP_TYPE_CODE'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SERVICE_AREA'),'X')             = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SERVICE_AREA'),'X')  
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SLCT_AUTO_PROC'),'X')           = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SLCT_AUTO_PROC'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SLCT_CREATE_BY_NAME'),'X')      = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SLCT_CREATE_BY_NAME'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SLCT_CREATE_DT'),'X')           = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SLCT_CREATE_DT'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SLCT_LAST_UPDATE_BY_NAME'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SLCT_LAST_UPDATE_BY_NAME'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SLCT_LAST_UPDATE_DT'),'X')      = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SLCT_LAST_UPDATE_DT'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SLCT_METHOD'),'X')              =  COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SLCT_METHOD'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/SUBPROGRAM_TYPE'),'X')          = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/SUBPROGRAM_TYPE'),'X')   
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/THIRD_FOLLOWUP_ID'),'X')        = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/THIRD_FOLLOWUP_ID'),'X')
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/THIRD_FOLLOWUP_TYPE_CODE'),'X') = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/THIRD_FOLLOWUP_TYPE_CODE'),'X') 
 and COALESCE(extractValue (NEW_DATA,'ROWSET/ROW/ZIP_CODE'),'X')                 = COALESCE(extractValue (OLD_DATA,'ROWSET/ROW/ZIP_CODE'),'X')
;

--use temporary table to loop through records to delete
DECLARE  
  CURSOR temp_cur IS
 SELECT IDENTIFIER, BUEQ_ID  
 FROM bpm_delete_queue_archive_mea;


  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
  --v_ased_selection_recd date;
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT LOOP
           -- v_ased_selection_recd := temp_tab(indx).ASED_SELECTION_RECD; 
DELETE
FROM BPM_UPDATE_EVENT_QUEUE_ARCHIVE
WHERE bsl_id = 14
AND BUEQ_ID= temp_tab(indx).BUEQ_ID
AND IDENTIFIER= temp_tab(indx).IDENTIFIER; 
END LOOP; 
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


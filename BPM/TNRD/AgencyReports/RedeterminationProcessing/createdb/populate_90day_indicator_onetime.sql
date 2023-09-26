begin
PROCESS_APP_RECON_INDICATOR_PKG.INS_APPS_ONETIME;
PROCESS_APP_RECON_INDICATOR_PKG.UPD_APPS_TERM_LTR_ONETIME;
end;
/

MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  app_header_stg s
   USING (SELECT ah.application_id,ah.rcvd_90day_indicator,tmp.rcvd_90day_indicator nw_rcvd_90day_indicator
          FROM (SELECT ar.application_id
                      ,CASE WHEN app_receipt_date > term_ltr_response_due_date AND app_receipt_date <= term_ltr_response_due_date + 90 THEN 'Y' ELSE 'N' END  rcvd_90day_indicator          
                FROM app_reconsideration_data_stg ar)  tmp 
            JOIN app_header_stg ah ON tmp.application_id = ah.application_id
          WHERE COALESCE(ah.rcvd_90day_indicator, '*') != COALESCE(tmp.rcvd_90day_indicator,'*')                       
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  rcvd_90day_indicator = tmp.nw_rcvd_90day_indicator        
   --  Log Errors INTO Errlog_AppRecon ('UPD_90DAY_INDICATOR') Reject Limit Unlimited
     ;
     
commit;     

truncate table app_reconsideration_data_stg;
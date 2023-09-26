alter session set plsql_code_type = native;

create or replace package CORP_ETL_COMPLAINTS_PKG as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.

  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
  
  procedure PC_PROCESS_UPD2_TO_11(p_success IN OUT VARCHAR2,
                                  p_error IN OUT VARCHAR2);
                                  
  procedure PC_INSERT_TEMP_TABS(p_success IN OUT VARCHAR2,
                                  p_error IN OUT VARCHAR2);
end;
/

create or replace package body CORP_ETL_COMPLAINTS_PKG as


procedure PC_INSERT_TEMP_TABS(p_success IN OUT VARCHAR2,
                                  p_error IN OUT VARCHAR2)
AS
 CURSOR temp_cur IS
    SELECT        CECI_ID
             ,INCIDENT_ID
             ,CHANNEL               
             ,CREATED_BY_GROUP      
             ,CREATED_BY_NAME                    
             ,TRACKING_NUMBER       
             ,CREATE_DT             
             ,ASED_RESOLVE_INCIDENT_EES_CSS     
             ,ASSD_RESOLVE_INCIDENT_EES_CSS     
             ,ASED_RESOLVE_INCIDENT_SUP         
             ,ASSD_RESOLVE_INCIDENT_SUP        
             ,ASED_RESOLVE_INCIDENT_DOH               
             ,ASSD_RESOLVE_INCIDENT_DOH               
             ,ASED_WITHDRAW_INCIDENT            
             ,ASSD_WITHDRAW_INCIDENT            
             ,ASED_PERFORM_FOLLOWUP             
             ,ASSD_PERFORM_FOLLOWUP             
             ,ABOUT_PLAN_CODE                   
             ,ABOUT_PROVIDER_ID                 
             ,ACTION_COMMENTS                    
             ,ACTION_TYPE                       
             ,CANCEL_BY 	                      
             ,CANCEL_DT CUR_CANCEL_DT                        
             ,CANCEL_METHOD                    
             ,CANCEL_REASON 	                   
             ,CURRENT_TASK_ID                   
             ,DE_TASK_ID                        
             ,INCIDENT_ABOUT                    
             ,INCIDENT_DESCRIPTION              
             ,INCIDENT_REASON                  
             ,INCIDENT_STATUS CUR_INCIDENT_STATUS                 
             ,INCIDENT_STATUS_DT   CUR_INCIDENT_STATUS_DT           
             ,INSTANCE_COMPLETE_DT            
             ,INSTANCE_STATUS                  
             ,LAST_UPDATE_BY_NAME              
             ,LAST_UPDATE_BY_DT                
             ,UPDATED_BY                      
             ,CLIENT_ID                        
             ,OTHER_PARTY_NAME                
             ,PRIORITY                         
             ,REPORTED_BY                      
             ,REPORTER_RELATIONSHIP            
             ,RESOLUTION_DESCRIPTION           
             ,RESOLUTION_TYPE                 
             ,CASE_ID     
             ,CASE_CIN
             ,FORWARDED                        
             ,INCIDENT_TYPE                    
             ,FORWARDED_TO                     
             ,GWF_RESOLVED_EES_CSS             
             ,GWF_RESOLVED_SUP                 
             ,GWF_FOLLOWUP_REQ                 
             ,GWF_RETURN_TO_STATE             
             ,ASF_RESOLVE_INCIDENT_EES_CSS     
             ,ASF_RESOLVE_INCIDENT_SUP         
             ,ASF_RESOLVE_INCIDENT_DOH         
             ,ASF_PERFORM_FOLLOWUP             
             ,ASF_WITHDRAW_INCIDENT            
             ,STG_EXTRACT_DATE  
             ,STG_LAST_UPDATE_DATE  
             ,NVL(MAX_INCI_STAT_HIST_ID,0) MAX_INCI_STAT_HIST_ID
             ,STAFF_TYPE_CD
			 ,FORWARD_DT
             ,received_dt
			 ,PLAN_NAME
			 ,REPORTER_NAME
			 ,REPORTER_PHONE
             ,SLA_SATISFIED
			 ,CREATED_BY_SUP
			 ,CREATED_BY_EID
			 ,CREATED_BY_SUP_NAME
			 ,GWF_ESCALATE_TO_STATE
             ,SLA_COMPLETE_DT
FROM CORP_ETL_COMPLAINTS_INCIDENTS A
 WHERE  A.COMPLETE_DT is null
    ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;  
  v_bulk_limit NUMBER := 500;
  v_err_code NUMBER;
  v_err_msg VARCHAR2(200);
  v_step VARCHAR2(200);
  v_oltp_incident_status_dt DATE;
  v_oltp_incident_status VARCHAR2(256);
  
BEGIN 
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CORP_ETL_COMPL_INCIDENTS_OLTP';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CORP_ETL_COMPL_INCIDN_WIP_BPM';
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
     
     FOR indx IN 1..temp_tab.COUNT LOOP
       BEGIN  
         v_oltp_incident_status_dt := null;    
         v_oltp_incident_status := null;
         
         v_step := 'Insert to OLTP temp table';
         FOR oltp IN(SELECT incident_header_stat_hist_id, incident_status, hs.create_ts incident_status_dt
                            ,CASE WHEN status_cd = 'CLOSED' THEN create_ts ELSE NULL END complete_dt
                            ,CASE WHEN status_cd = 'WITHDRAWN' THEN create_ts ELSE NULL END cancel_dt
                            ,(select s.staff_type_cd from staff_stg s where TO_CHAR(s.staff_id) = hs.created_by) staff_type_cd
                      FROM incident_header_stat_hist_stg hs
                      WHERE incident_header_id= temp_tab(indx).incident_id
                      AND incident_header_stat_hist_id >= temp_tab(indx).max_inci_stat_hist_id  --e MAX_INCI_STAT_HIST_ID here
                      --ORDER BY hs.create_ts,incident_header_stat_hist_id
                      )
          LOOP
             INSERT INTO CORP_ETL_COMPL_INCIDENTS_OLTP(ceci_id,incident_id,channel,created_by_group,created_by_name,tracking_number,
                                                       create_dt,ased_resolve_incident_ees_css,assd_resolve_incident_ees_css,
                                                       ased_resolve_incident_sup,assd_resolve_incident_sup,ased_resolve_incident_doh,assd_resolve_incident_doh,
                                                       ased_withdraw_incident,assd_withdraw_incident,ased_perform_followup,assd_perform_followup,about_plan_code,
                                                       about_provider_id,action_comments,action_type,cancel_by,cancel_dt,cancel_method,cancel_reason,
                                                       current_task_id,de_task_id,incident_about,incident_description,incident_reason,incident_status,
                                                       incident_status_dt,instance_complete_dt,instance_status,last_update_by_name,last_update_by_dt,updated_by,
                                                       client_id,other_party_name,priority,reported_by,reporter_relationship,resolution_description,resolution_type,
                                                       case_id,case_cin,forwarded,incident_type,forwarded_to,gwf_resolved_ees_css,gwf_resolved_sup,gwf_followup_req,
                                                       gwf_return_to_state,asf_resolve_incident_ees_css, asf_resolve_incident_sup,asf_resolve_incident_doh,
                                                       asf_perform_followup,asf_withdraw_incident,stg_extract_date,stg_last_update_date,max_inci_stat_hist_id,
                                                       staff_type_cd,forward_dt,received_dt,plan_name,reporter_name,reporter_phone,sla_satisfied,created_by_sup,
                                                       created_by_eid,created_by_sup_name,gwf_escalate_to_state,sla_complete_dt,complete_dt)
            VALUES(temp_tab(indx).ceci_id,temp_tab(indx).incident_id,temp_tab(indx).channel,temp_tab(indx).created_by_group,temp_tab(indx).created_by_name,temp_tab(indx).tracking_number,
                   temp_tab(indx).create_dt,temp_tab(indx).ased_resolve_incident_ees_css,temp_tab(indx).assd_resolve_incident_ees_css,
                   temp_tab(indx).ased_resolve_incident_sup,temp_tab(indx).assd_resolve_incident_sup,temp_tab(indx).ased_resolve_incident_doh,temp_tab(indx).assd_resolve_incident_doh,
                   temp_tab(indx).ased_withdraw_incident,temp_tab(indx).assd_withdraw_incident,temp_tab(indx).ased_perform_followup,temp_tab(indx).assd_perform_followup,temp_tab(indx).about_plan_code,
                   temp_tab(indx).about_provider_id,temp_tab(indx).action_comments,temp_tab(indx).action_type,temp_tab(indx).cancel_by,oltp.cancel_dt,temp_tab(indx).cancel_method,temp_tab(indx).cancel_reason,
                   temp_tab(indx).current_task_id,temp_tab(indx).de_task_id,temp_tab(indx).incident_about,temp_tab(indx).incident_description,temp_tab(indx).incident_reason,oltp.incident_status,
                   oltp.incident_status_dt,temp_tab(indx).instance_complete_dt,temp_tab(indx).instance_status,temp_tab(indx).last_update_by_name,temp_tab(indx).last_update_by_dt,temp_tab(indx).updated_by,
                   temp_tab(indx).client_id,temp_tab(indx).other_party_name,temp_tab(indx).priority,temp_tab(indx).reported_by,temp_tab(indx).reporter_relationship,temp_tab(indx).resolution_description,temp_tab(indx).resolution_type,
                   temp_tab(indx).case_id,temp_tab(indx).case_cin,temp_tab(indx).forwarded,temp_tab(indx).incident_type,temp_tab(indx).forwarded_to,temp_tab(indx).gwf_resolved_ees_css,temp_tab(indx).gwf_resolved_sup,temp_tab(indx).gwf_followup_req,
                   temp_tab(indx).gwf_return_to_state,temp_tab(indx).asf_resolve_incident_ees_css,temp_tab(indx).asf_resolve_incident_sup,temp_tab(indx).asf_resolve_incident_doh,
                   temp_tab(indx).asf_perform_followup,temp_tab(indx).asf_withdraw_incident,temp_tab(indx).stg_extract_date,temp_tab(indx).stg_last_update_date,oltp.incident_header_stat_hist_id,
                   oltp.staff_type_cd,temp_tab(indx).forward_dt,temp_tab(indx).received_dt,temp_tab(indx).plan_name,temp_tab(indx).reporter_name,temp_tab(indx).reporter_phone,temp_tab(indx).sla_satisfied,temp_tab(indx).created_by_sup,
                   temp_tab(indx).created_by_eid,temp_tab(indx).created_by_sup_name,temp_tab(indx).gwf_escalate_to_state,temp_tab(indx).sla_complete_dt,oltp.complete_dt);                          

             
             IF oltp.incident_header_stat_hist_id = temp_tab(indx).max_inci_stat_hist_id THEN
                v_oltp_incident_status_dt := oltp.incident_status_dt;    
                v_oltp_incident_status := oltp.incident_status;
             END IF;
             
          END LOOP;
      
          v_step := 'Insert to BPM temp table';
          INSERT INTO CORP_ETL_COMPL_INCIDN_WIP_BPM(ceci_id,incident_id,channel,created_by_group,created_by_name,tracking_number,
                                                    create_dt,ased_resolve_incident_ees_css,assd_resolve_incident_ees_css,
                                                    ased_resolve_incident_sup,assd_resolve_incident_sup,ased_resolve_incident_doh,assd_resolve_incident_doh,
                                                    ased_withdraw_incident,assd_withdraw_incident,ased_perform_followup,assd_perform_followup,about_plan_code,
                                                    about_provider_id,action_comments,action_type,cancel_by,cancel_dt,cancel_method,cancel_reason,
                                                    current_task_id,de_task_id,incident_about,incident_description,incident_reason,incident_status,
                                                    incident_status_dt,instance_complete_dt,instance_status,last_update_by_name,last_update_by_dt,updated_by,
                                                    client_id,other_party_name,priority,reported_by,reporter_relationship,resolution_description,resolution_type,
                                                    case_id,case_cin,forwarded,incident_type,forwarded_to,gwf_resolved_ees_css,gwf_resolved_sup,gwf_followup_req,
                                                    gwf_return_to_state,asf_resolve_incident_ees_css, asf_resolve_incident_sup,asf_resolve_incident_doh,
                                                    asf_perform_followup,asf_withdraw_incident,stg_extract_date,stg_last_update_date,max_inci_stat_hist_id,
                                                    staff_type_cd,forward_dt,received_dt,plan_name,reporter_name,reporter_phone,sla_satisfied,created_by_sup,
                                                    created_by_eid,created_by_sup_name,gwf_escalate_to_state,sla_complete_dt)
          VALUES(temp_tab(indx).ceci_id,temp_tab(indx).incident_id,temp_tab(indx).channel,temp_tab(indx).created_by_group,temp_tab(indx).created_by_name,temp_tab(indx).tracking_number,
                 temp_tab(indx).create_dt,temp_tab(indx).ased_resolve_incident_ees_css,temp_tab(indx).assd_resolve_incident_ees_css,
                 temp_tab(indx).ased_resolve_incident_sup,temp_tab(indx).assd_resolve_incident_sup,temp_tab(indx).ased_resolve_incident_doh,temp_tab(indx).assd_resolve_incident_doh,
                 temp_tab(indx).ased_withdraw_incident,temp_tab(indx).assd_withdraw_incident,temp_tab(indx).ased_perform_followup,temp_tab(indx).assd_perform_followup,temp_tab(indx).about_plan_code,
                 temp_tab(indx).about_provider_id,temp_tab(indx).action_comments,temp_tab(indx).action_type,temp_tab(indx).cancel_by,temp_tab(indx).cur_cancel_dt,temp_tab(indx).cancel_method,temp_tab(indx).cancel_reason,
                 temp_tab(indx).current_task_id,temp_tab(indx).de_task_id,temp_tab(indx).incident_about,temp_tab(indx).incident_description,temp_tab(indx).incident_reason,COALESCE(v_oltp_incident_status,temp_tab(indx).cur_incident_status),
                 COALESCE(v_oltp_incident_status_dt,temp_tab(indx).cur_incident_status_dt),temp_tab(indx).instance_complete_dt,temp_tab(indx).instance_status,temp_tab(indx).last_update_by_name,temp_tab(indx).last_update_by_dt,temp_tab(indx).updated_by,
                 temp_tab(indx).client_id,temp_tab(indx).other_party_name,temp_tab(indx).priority,temp_tab(indx).reported_by,temp_tab(indx).reporter_relationship,temp_tab(indx).resolution_description,temp_tab(indx).resolution_type,
                 temp_tab(indx).case_id,temp_tab(indx).case_cin,temp_tab(indx).forwarded,temp_tab(indx).incident_type,temp_tab(indx).forwarded_to,temp_tab(indx).gwf_resolved_ees_css,temp_tab(indx).gwf_resolved_sup,temp_tab(indx).gwf_followup_req,
                 temp_tab(indx).gwf_return_to_state,temp_tab(indx).asf_resolve_incident_ees_css,temp_tab(indx).asf_resolve_incident_sup,temp_tab(indx).asf_resolve_incident_doh,
                 temp_tab(indx).asf_perform_followup,temp_tab(indx).asf_withdraw_incident,temp_tab(indx).stg_extract_date,temp_tab(indx).stg_last_update_date,temp_tab(indx).max_inci_stat_hist_id,
                 temp_tab(indx).staff_type_cd,temp_tab(indx).forward_dt,temp_tab(indx).received_dt,temp_tab(indx).plan_name,temp_tab(indx).reporter_name,temp_tab(indx).reporter_phone,temp_tab(indx).sla_satisfied,temp_tab(indx).created_by_sup,
                 temp_tab(indx).created_by_eid,temp_tab(indx).created_by_sup_name,temp_tab(indx).gwf_escalate_to_state,temp_tab(indx).sla_complete_dt);                                
      
      EXCEPTION
        WHEN OTHERS THEN
           v_err_code := SQLCODE;
           v_err_msg := SUBSTR(SQLERRM, 1, 200);
           INSERT INTO corp_etl_error_log 
           VALUES(SEQ_CEEL_ID.nextval,--CEEL_ID
                  sysdate,--ERR_DATE
                  'CRITICAL',--ERR_LEVEL
                  'PROCESS INCIDENT COMPLAINTS',--PROCESS_NAME
                  'Process_Complaints_RUN_ALL',--JOB_NAME
                  '1',--NR_OF_ERROR
                  v_step||' '||v_err_msg,--ERROR_DESC
                  null,--ERROR_FIELD
                  v_err_code,--ERROR_CODES
                  sysdate,--CREATE_TS
                  sysdate,--UPDATE_TS
                  'CORP_ETL_COMPL_INCIDN_WIP_BPM',--DRIVER_TABLE_NAME
                  temp_tab(indx).incident_id);--DRIVER_KEY_NUMBER     
      END;   
    END LOOP;       
    COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
  p_success := 'Y';
 EXCEPTION
    WHEN OTHERS THEN    
       p_success := 'N';
       p_error     := 'PROCESS INCIDENT COMPLAINTS : '||v_step || ': ' || SQLERRM;  
END;

PROCEDURE PC_PROCESS_UPD2_TO_11 (p_success IN OUT VARCHAR2,
                                 p_error IN OUT VARCHAR2) AS  
  CURSOR temp_cur IS
    SELECT *
    FROM corp_etl_compl_incidn_wip_bpm
    WHERE cancel_dt is NULL --may not be needed???
    AND instance_status = 'Active'
    --and incident_id = 26106543
    ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;  
  v_bulk_limit NUMBER := 500;
  v_err_code NUMBER;
  v_err_msg VARCHAR2(200);
  v_step VARCHAR2(200);
  v_supervisor_status VARCHAR2(40) := 'Supervisor';
  v_state_status VARCHAR2(40) := 'State';
  v_close_status VARCHAR2(40) := 'Close';
  v_withdrawn_status VARCHAR2(40) := 'Withdrawn';
  v_followup_status VARCHAR2(40) := 'Follow up Required';
  v_error_status VARCHAR2(40) := 'Sent In Error';
BEGIN 

   FOR l IN(SELECT value   
            FROM corp_etl_list_lkup
            WHERE name = 'PC_SUPERVISOR_STATUS')
   LOOP
     v_supervisor_status := l.value;
   END LOOP;
   
   FOR l IN(SELECT value   
            FROM corp_etl_list_lkup
            WHERE name = 'PC_STATE_STATUS')
   LOOP
     v_state_status := l.value;
   END LOOP;
   
   FOR l IN(SELECT value   
            FROM corp_etl_list_lkup
            WHERE name = 'PC_CLOSE_STATUS')
   LOOP
     v_close_status := l.value;
   END LOOP;
   
   FOR l IN(SELECT value   
            FROM corp_etl_list_lkup
            WHERE name = 'PC_WITHDRAWN_STATUS')
   LOOP
     v_withdrawn_status := l.value;
   END LOOP;
   
   FOR l IN(SELECT value   
            FROM corp_etl_list_lkup
            WHERE name = 'PC_FOLLOWUP_STATUS')
   LOOP
     v_followup_status := l.value;
   END LOOP;
   
   FOR l IN(SELECT value   
            FROM corp_etl_list_lkup
            WHERE name = 'PC_ERROR_STATUS')
   LOOP
     v_error_status := l.value;
   END LOOP;

   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     FOR indx IN 1..temp_tab.COUNT LOOP
       BEGIN  
         FOR oltp IN(SELECT *
                     FROM(
                        SELECT incident_id, max_inci_stat_hist_id,incident_status_dt,
                               LAG(ostg.incident_status,1) OVER (PARTITION BY incident_id ORDER BY max_inci_stat_hist_id) prev_incident_status,
                               incident_status,staff_type_cd,last_update_by_name
                        FROM corp_etl_compl_incidents_oltp ostg
                        WHERE incident_id = temp_tab(indx).incident_id)
                     WHERE prev_incident_status IS NOT NULL)
         LOOP
           --UPD2           
           IF temp_tab(indx).assd_resolve_incident_ees_css IS NOT NULL AND temp_tab(indx).ased_resolve_incident_ees_css IS NULL THEN
             IF (INSTR(oltp.incident_status,v_supervisor_status) > 0 AND INSTR(oltp.incident_status,v_state_status) = 0) --Refer to Supervisor
              OR INSTR(oltp.incident_status,v_state_status) > 0 --Refer to State
              OR INSTR(oltp.incident_status,v_close_status) > 0 --Closed
             THEN            
               v_step := 'UPD2';
               temp_tab(indx).ased_resolve_incident_ees_css := oltp.incident_status_dt;
               temp_tab(indx).asf_resolve_incident_ees_css := 'Y';                             
               --UPD3_20
               IF INSTR(oltp.incident_status,v_close_status) > 0 THEN
                 v_step := 'UPD3_20';
                 temp_tab(indx).gwf_resolved_ees_css := 'Y';
                 temp_tab(indx).instance_status := 'Complete';
                 temp_tab(indx).instance_complete_dt := oltp.incident_status_dt;
                 temp_tab(indx).complete_dt := oltp.incident_status_dt;
                 temp_tab(indx).stage_done_dt := oltp.incident_status_dt; 
               ELSE
                 --UPD3_10
                 v_step := 'UPD3_10';
                 temp_tab(indx).gwf_resolved_ees_css := 'N';                 
               END IF;
               
               --UPD3.1_10
               IF temp_tab(indx).gwf_resolved_ees_css = 'N' AND temp_tab(indx).gwf_escalate_to_state IS NULL THEN
                 IF INSTR(oltp.incident_status,v_state_status) > 0 THEN --Refer to State
                    v_step := 'UPD3.1_10';
                    temp_tab(indx).gwf_escalate_to_state := 'Y';
                    temp_tab(indx).assd_resolve_incident_doh := temp_tab(indx).ased_resolve_incident_ees_css;                 
                 ELSE               
                   IF (INSTR(oltp.incident_status,v_supervisor_status) > 0 AND INSTR(oltp.incident_status,v_state_status) = 0) THEN --Refer to Supervisor
                     v_step := 'UPD3.1_20';
                     temp_tab(indx).gwf_escalate_to_state := 'N';
                     temp_tab(indx).assd_resolve_incident_sup := temp_tab(indx).ased_resolve_incident_ees_css;                   
                   END IF; --3.1_20
                 END IF;
               END IF;               
             END IF;
          END IF;
          
          --UPD4_10
          IF temp_tab(indx).assd_resolve_incident_sup IS NOT NULL AND temp_tab(indx).ased_resolve_incident_sup IS NULL THEN            
            IF --((INSTR(oltp.prev_incident_status,v_supervisor_status) > 0 AND INSTR(oltp.prev_incident_status,v_state_status) = 0)   AND
               (INSTR(oltp.incident_status,v_state_status) > 0 OR INSTR(oltp.incident_status,v_close_status) > 0) --) -- Refer to State or Close
              OR (INSTR(oltp.incident_status,v_supervisor_status) > 0 AND INSTR(oltp.incident_status,v_state_status) = 0 --referred to sup by a sup
                  AND temp_tab(indx).assd_resolve_incident_ees_css IS NULL) 
            THEN
              v_step := 'UPD4_10';
              temp_tab(indx).ased_resolve_incident_sup := oltp.incident_status_dt;
              temp_tab(indx).asf_resolve_incident_sup := 'Y';
            END IF;
          END IF;
          
          IF (INSTR(oltp.incident_status,v_state_status) > 0 OR INSTR(oltp.incident_status,v_close_status) > 0)  --Refer to State or Closed
            AND temp_tab(indx).asf_resolve_incident_sup = 'Y' 
            AND temp_tab(indx).gwf_resolved_sup IS NULL THEN
              --UPD5_10
              IF INSTR(oltp.incident_status,v_state_status) > 0 THEN  --Refer to State
                v_step := 'UPD5_10';
                temp_tab(indx).gwf_resolved_sup := 'N';
                temp_tab(indx).assd_resolve_incident_doh := temp_tab(indx).ased_resolve_incident_sup;
              ELSE
                --UPD5_20
                 IF INSTR(oltp.incident_status,v_close_status) > 0 THEN   --Closed
                   v_step := 'UPD5_20';
                   temp_tab(indx).gwf_resolved_sup := 'Y';
                   temp_tab(indx).instance_status := 'Complete';
                   temp_tab(indx).instance_complete_dt := oltp.incident_status_dt;
                   temp_tab(indx).complete_dt := oltp.incident_status_dt;     
                   temp_tab(indx).stage_done_dt := oltp.incident_status_dt; 
                 END IF;
              END IF;
          END IF;
         
          --UPD6_10
          IF (temp_tab(indx).assd_resolve_incident_doh IS NOT NULL AND temp_tab(indx).ased_resolve_incident_doh IS NULL) 
            OR (temp_tab(indx).ased_resolve_incident_doh < temp_tab(indx).assd_resolve_incident_doh  ) THEN
            IF INSTR(oltp.prev_incident_status,v_state_status) > 0 AND
                ( oltp.incident_status IN(v_followup_status, v_error_status) --Refer to State to Followup/Sent in Error
                  OR (INSTR(oltp.incident_status,v_close_status) > 0 AND COALESCE(oltp.staff_type_cd,'X') = 'STATE')) --Closed by State user
            THEN
              v_step := 'UPD6_10';
              temp_tab(indx).ased_resolve_incident_doh := oltp.incident_status_dt;
              temp_tab(indx).asf_resolve_incident_doh := 'Y';
              --UPD7_10
              IF  oltp.incident_status IN(v_followup_status, v_error_status) THEN --Followup/Sent in Error
                v_step := 'UPD7_10';
                temp_tab(indx).gwf_followup_req := 'Y';
                temp_tab(indx).assd_perform_followup := temp_tab(indx).ased_resolve_incident_doh;
              END IF;
              --UPD7_20
              IF (INSTR(oltp.incident_status,v_close_status) > 0 AND COALESCE(oltp.staff_type_cd,'X') = 'STATE') THEN  --Closed by State user
                 v_step := 'UPD7_20';
                 temp_tab(indx).gwf_followup_req := 'N';
                 temp_tab(indx).instance_status := 'Complete';
                 temp_tab(indx).instance_complete_dt := oltp.incident_status_dt;
                 temp_tab(indx).complete_dt := oltp.incident_status_dt;  
                 temp_tab(indx).stage_done_dt := oltp.incident_status_dt; 
              END IF;
            END IF;
          END IF;
       
          --UPD8_10
          IF (temp_tab(indx).assd_perform_followup IS NOT NULL AND temp_tab(indx).ased_perform_followup IS NULL) 
            OR (temp_tab(indx).ased_perform_followup < temp_tab(indx).assd_perform_followup  ) THEN
            IF (oltp.prev_incident_status IN(v_followup_status, v_error_status) AND INSTR(oltp.incident_status,v_state_status) > 0) --Followup/Sent in Error to Refer to State
              OR (COALESCE(oltp.staff_type_cd,'X') != 'STATE' AND
                ((INSTR(oltp.prev_incident_status,v_state_status) > 0 AND INSTR(oltp.incident_status,v_close_status) > 0) --Refer to State to Close
                  OR INSTR(oltp.incident_status,v_state_status) > 0) ) --Refer to State changed by Maximus user
            THEN
              v_step := 'UPD8_10';
              temp_tab(indx).ased_perform_followup := oltp.incident_status_dt;
              temp_tab(indx).asf_perform_followup := 'Y';
              --UPD9_10
              IF INSTR(oltp.incident_status,v_state_status) > 0 AND COALESCE(oltp.staff_type_cd,'X') != 'STATE' THEN --Refer to State by Maximus user
                v_step := 'UPD9_10';
                temp_tab(indx).gwf_return_to_state := 'Y';
                temp_tab(indx).assd_resolve_incident_doh := temp_tab(indx).ased_perform_followup;
              END IF;
              
              --UPD9_20
              IF INSTR(oltp.incident_status,v_close_status) > 0 AND COALESCE(oltp.staff_type_cd,'X') != 'STATE' THEN
                 v_step := 'UPD9_20';
                 temp_tab(indx).gwf_return_to_state := 'N';
                 temp_tab(indx).instance_status := 'Complete';
                 temp_tab(indx).instance_complete_dt := oltp.incident_status_dt;
                 temp_tab(indx).complete_dt := oltp.incident_status_dt;  
                 temp_tab(indx).stage_done_dt := oltp.incident_status_dt;               
              END IF;              
            END IF;  
          END IF;
          
          --UPD10_10
          IF INSTR(oltp.incident_status,v_withdrawn_status) > 0 THEN --Withdrawn
             v_step := 'UPD10_10';
             temp_tab(indx).asf_withdraw_incident := 'Y';
             temp_tab(indx).instance_status := 'Complete';
             temp_tab(indx).instance_complete_dt := oltp.incident_status_dt;
             temp_tab(indx).complete_dt := oltp.incident_status_dt;  
             temp_tab(indx).stage_done_dt := oltp.incident_status_dt; 
             temp_tab(indx).cancel_dt := oltp.incident_status_dt;  
             temp_tab(indx).cancel_by := oltp.last_update_by_name;
             temp_tab(indx).cancel_method := 'Normal';
             temp_tab(indx).cancel_reason := 'Withdrawn';
             temp_tab(indx).assd_withdraw_incident := oltp.incident_status_dt;
             temp_tab(indx).ased_withdraw_incident := oltp.incident_status_dt;
          END IF;
          
          --UPD11_10
          IF INSTR(oltp.incident_status,v_close_status) > 0 THEN  --Closed status catchall
            v_step := 'UPD11_10';
            temp_tab(indx).instance_status := 'Complete';            
            temp_tab(indx).complete_dt := oltp.incident_status_dt;   
            temp_tab(indx).stage_done_dt := oltp.incident_status_dt;   
            
            IF temp_tab(indx).assd_resolve_incident_doh IS NOT NULL 
              AND (temp_tab(indx).ased_resolve_incident_doh < temp_tab(indx).assd_resolve_incident_doh 
                 OR temp_tab(indx).ased_resolve_incident_doh IS NULL) THEN
              temp_tab(indx).ased_resolve_incident_doh :=  oltp.incident_status_dt;   
            END IF;
            
            IF temp_tab(indx).assd_perform_followup IS NOT NULL 
              AND (temp_tab(indx).ased_perform_followup < temp_tab(indx).assd_perform_followup 
                 OR temp_tab(indx).ased_perform_followup IS NULL) THEN
              temp_tab(indx).ased_perform_followup :=  oltp.incident_status_dt;   
            END IF;           
       
          END IF;  
          temp_tab(indx).staff_type_cd := oltp.staff_type_cd;
          temp_tab(indx).incident_status := oltp.incident_status;
          temp_tab(indx).incident_status_dt := oltp.incident_status_dt;
          temp_tab(indx).max_inci_stat_hist_id := oltp.max_inci_stat_hist_id;          
          temp_tab(indx).updated := 'Y';
        END LOOP; --oltp
        
        CASE WHEN temp_tab(indx).complete_dt IS NOT NULL THEN 
             temp_tab(indx).current_step := 'Closed';
          WHEN temp_tab(indx).cancel_dt IS NOT NULL THEN
             temp_tab(indx).current_step := 'Cancelled';
           WHEN temp_tab(indx).asf_withdraw_incident = 'Y' THEN
             temp_tab(indx).current_step := 'Withdraw Incident';
           WHEN temp_tab(indx).asf_perform_followup = 'Y' THEN
             temp_tab(indx).current_step := 'Perform FollowUp';
           WHEN temp_tab(indx).asf_resolve_incident_doh = 'Y' THEN
             temp_tab(indx).current_step := 'Resolve Incident DOH End';
           WHEN temp_tab(indx).assd_resolve_incident_doh IS NOT NULL THEN
             temp_tab(indx).current_step := 'Resolve Incident DOH Start';
           WHEN temp_tab(indx).asf_resolve_incident_sup = 'Y' THEN
             temp_tab(indx).current_step := 'Resolve Incident SUP End';
           WHEN temp_tab(indx).assd_resolve_incident_sup IS NOT NULL THEN
             temp_tab(indx).current_step := 'Resolve Incident SUP Start';          
           WHEN temp_tab(indx).asf_resolve_incident_ees_css = 'Y' THEN
             temp_tab(indx).current_step := 'Resolve Incident EES CSS End';
           WHEN temp_tab(indx).assd_resolve_incident_ees_css IS NOT NULL THEN
             temp_tab(indx).current_step := 'Resolve Incident EES CSS Start';             
           WHEN temp_tab(indx).create_dt IS NOT NULL THEN 
             temp_tab(indx).current_step := 'Incident Received';  
        ELSE 
           temp_tab(indx).current_step := 'Unknown';
        END CASE;
        
        IF temp_tab(indx).updated = 'Y' THEN
          v_step := 'Update WIP table';
          UPDATE corp_etl_compl_incidn_wip_bpm
          SET row = temp_tab(indx)
          WHERE incident_id = temp_tab(indx).incident_id;    
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
           v_err_code := SQLCODE;
           v_err_msg := SUBSTR(SQLERRM, 1, 200);
           INSERT INTO corp_etl_error_log 
           VALUES(SEQ_CEEL_ID.nextval,--CEEL_ID
                  sysdate,--ERR_DATE
                  'CRITICAL',--ERR_LEVEL
                  'PROCESS INCIDENT COMPLAINTS',--PROCESS_NAME
                  'Process_Complaints_RUN_ALL',--JOB_NAME
                  '1',--NR_OF_ERROR
                  v_step||' '||v_err_msg,--ERROR_DESC
                  null,--ERROR_FIELD
                  v_err_code,--ERROR_CODES
                  sysdate,--CREATE_TS
                  sysdate,--UPDATE_TS
                  'CORP_ETL_COMPL_INCIDN_WIP_BPM',--DRIVER_TABLE_NAME
                  temp_tab(indx).incident_id);--DRIVER_KEY_NUMBER      
      
      END;  
    END LOOP; 
    COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
  p_success := 'Y';
 EXCEPTION
    WHEN OTHERS THEN    
       p_success := 'N';
       p_error     := 'PROCESS INCIDENT COMPLAINTS : '||v_step || ': ' || SQLERRM;
 END PC_PROCESS_UPD2_TO_11;
end;
/

alter session set plsql_code_type = interpreted;


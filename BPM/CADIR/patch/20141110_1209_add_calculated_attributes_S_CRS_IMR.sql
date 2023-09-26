ALTER TABLE S_CRS_IMR ADD (
IMR_DUPLICATE_DATE                                DATE
,IMR_INELIGIBLE_DATE                               DATE
,IMR_CLOSED_DATE                                   DATE
,IMR_CURRENT_QUEUE_ROLE                            VARCHAR2(100)
,IMR_INELIGIBLE_TYPE			           VARCHAR2(100)
,IMR_ASSIGNEE_NAME                                 VARCHAR2(100)
,IMR_DUPLICATE_DT_FLG                              VARCHAR2(1) DEFAULT 'N'
,IMR_INELIGIBLE_TYPE_FLG                           VARCHAR2(1) DEFAULT 'N'
,IMR_INELIGIBLE_DT_FLG                             VARCHAR2(1) DEFAULT 'N'
,UPDATED                                           VARCHAR2(1) DEFAULT 'Y'
)    ;


CREATE OR REPLACE VIEW S_CRS_IMR_SV AS
SELECT 
 SCI_ID                         
,IMR_ID                         
,IMR_RECEIVED_DATE		
,CASE_NUMBER			
,CLAIM_NUMBER			
,IMR_ASSIGNED_DATE		
,CURRENT_IMR_STATUS_ID		
,UR_DATE			
,INJURY_DATE			
,CLAIM_EXAMINER_NAME_PREFIX	
,CLAIM_EXAMINER_FIRST_NAME	
,CLAIM_EXAMINER_LAST_NAME	
,CLAIM_EXAMINER_MI		
,CLAIM_ADMIN_COMPANY_NAME	
,CLAIM_ADMIN_ZIP_CODE		
,CLAIM_ADMIN_CITY		
,CLAIM_ADMIN_STATE_ID		
,PROVIDER_SPECIALTY		
,CLAIM_ADMN_DISPUT_LIABILTY_FLG	
,EDI_CONTRIBUTOR_ID		
,CLAIM_PRIORITY_ID		
,IMR_FORM_SIGNED_FLAG		
,INJURED_WORKER_STATE_ID	
,TERMINATION_REASON_ID		
,IMR_SUBMITTED_FLAG		
,CLAIM_MODIFIED_FLAG		
,CLOSED_REASON_ID		
,IMR_RECEIVED_CHANNEL	
,IMR_DUPLICATE_DATE        
,IMR_INELIGIBLE_DATE       
,IMR_CLOSED_DATE           
,IMR_CURRENT_QUEUE_ROLE    
,IMR_INELIGIBLE_TYPE	
,IMR_ASSIGNEE_NAME         
,IMR_DUPLICATE_DT_FLG      
,IMR_INELIGIBLE_TYPE_FLG   
,IMR_INELIGIBLE_DT_FLG     
,UPDATED                   
,CREATE_DT                      
,CREATED_BY                     
,LAST_UPDATE_DT                 
,LAST_UPDATED_BY                
FROM S_CRS_IMR
WITH READ ONLY;
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

CREATE OR REPLACE VIEW D_CRS_CLOSED_REASONS_SV AS
SELECT
 DCCR_ID    	   		
,CLOSED_REASON_ID          
,CLOSED_REASON_CODE        
,CLOSED_REASON_NAME        
,CLOSED_REASON_EFF_DT      
,CLOSED_REASON_END_DT      
,CLOSED_REASON_ACTIVE_FLAG 
,CREATE_DT                 
,UPDATE_DT                 
FROM  D_CRS_CLOSED_REASONS;

CREATE OR REPLACE VIEW D_CRS_CLAIM_PRIORITIES_SV AS
SELECT
 DCCP_ID                    
,CLAIM_PRIORITY_ID          
,CLAIM_PRIORITY_SORT_ORDER  
,CLAIM_PRIORITY_NAME        
,CLAIM_PRIORITY_CODE        
,CLAIM_PRIORITY_ACTIVE_FLAG 
,CREATE_DT                  
,UPDATE_DT                  
FROM D_CRS_CLAIM_PRIORITIES;

CREATE OR REPLACE VIEW D_CRS_STATES_SV AS
SELECT
 DCS_ID            
,STATE_ID          
,STATE_ABBREVIATION
,STATE_NAME        
,STATE_CODE        
,STATE_ACTIVE_FLAG 
,CREATE_DT         
,UPDATE_DT         
FROM D_CRS_STATES;

CREATE OR REPLACE VIEW D_CRS_EDI_CONTRIBUTORS_SV AS
SELECT
 DCEC_ID    	   		 
,EDI_CONTRIBUTOR_ID           
,EDI_CONTRIBUTOR_CODE         
,EDI_CONTRIBUTOR_NAME         
,EDI_CONTRIBUTOR_ACTIVE_FLAG  
,CREATE_DT                    
,UPDATE_DT  
FROM  D_CRS_EDI_CONTRIBUTORS;

CREATE OR REPLACE VIEW D_CRS_TERMINATION_REASONS_SV AS
SELECT
DCTR_ID    	   		   
,TERMINATION_REASON_ID          
,TERMINATION_REASON_CODE        
,TERMINATION_REASON_NAME        
,TERMINATION_REASON_EFF_DT      
,TERMINATION_REASON_END_DT      
,TERMINATION_REASON_ACTIVE_FLAG 
,CREATE_DT                      
,UPDATE_DT  
FROM D_CRS_TERMINATION_REASONS;

CREATE OR REPLACE VIEW S_CRS_IMR_ISSUES_IN_DISPUTE_SV AS
SELECT
 SCIIID_ID
,ISSUE_IN_DISPUTE_ID
,IMR_ID
,ISSUE_TYPE_ID
,ISSUE_ELIGIBLE_FLAG
,INELIGIBILE_REASON_ID
,IMR_DECISION_ID
,CA_CITATION_PROVIDED_ID
,AGREE_CA_CITATION_FLAG
,CA_MTUS_ACOEM_FLAG
,CA_MTUS_ACUPUNCTURE_FLAG
,CA_MTUS_CHRONIC_PAIN_FLAG
,CA_MTUS_FLAG
,CA_MTUS_POSTSURGICAL_FLAG
,CA_NON_MTUS_FLAG
,HAS_MTUS_FLAG
,MTUS_ACOEM_FLAG
,MTUS_ACUPUNCTURE_FLAG
,MTUS_CHRONIC_PAIN_FLAG
,MTUS_POSTSURGICAL_FLAG
,NON_MTUS_FLAG
,CREATE_DT
,CREATED_BY
,LAST_UPDATE_DT
,LAST_UPDATED_BY
,DELETE_DT
FROM S_CRS_IMR_ISSUES_IN_DISPUTE;
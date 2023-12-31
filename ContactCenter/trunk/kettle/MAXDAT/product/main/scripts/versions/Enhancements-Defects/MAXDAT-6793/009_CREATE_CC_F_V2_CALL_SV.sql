-- Semantic view

CREATE OR REPLACE VIEW CC_F_V2_CALL_SV AS
SELECT
 F.F_V2_CALL_ID  		
,F.D_DATE_ID                   
,F.DATETIME
,F.CALLTYPE_REPORTING_DATETIME                   
,F.D_CONTACT_QUEUE_ID          
,F.QUEUE_NUMBER                
,F.D_AGENT_ID			
,F.AGENT_LOGIN_ID		
,F.ROUTER_CALL_KEY_DAY         
,F.ROUTER_CALL_KEY             
,F.PERIPHERAL_CALL_KEY         
,F.PERIPHERAL_CALL_TYPE        
,F.PERIPHERAL_ID   
,F.SKILL_GROUP_ID
,F.PRECISION_QUEUE_ID
,F.SOURCE_D_AGENT_ID           
,F.SOURCE_AGENT_LOGIN_ID       
,F.CALL_REFERENCE_ID		
,F.CALLGUID                    
,F.CALL_SEGMENT_ID		
,F.SOURCE_CALL_ID		
,F.ACTIVITY_ID			
,F.DIGITS_DIALED               
,F.ANI_PHONE_NUMBER            
,F.CALL_DISPOSITION 
,DL.CALL_DISPOSITION_DESC
,F.CALL_DISPOSITION_FLAG  
,DFL.CALL_DISPOSITION_FLG_DESC
,F.DNIS			
,(SELECT COALESCE((select lookup_value from cc_c_lookup where lookup_type = 'LANGUAGE_CODE' and lookup_key = F.QUEUE_NUMBER), 'UNKNOWN') from dual) LANGUAGE
,F.QUEUE_TIME_SECONDS          
,F.RING_TIME_SECONDS  		
,F.HOLD_TIME_SECONDS           
,F.WORK_TIME_SECONDS	        
,F.TALK_TIME_SECONDS           
,F.IVR_TIME_SECONDS  		
,F.NETWORK_TIME_SECONDS        
,F.LOCAL_Q_TIME_SECONDS        
,F.DELAY_TIME_SECONDS          
,F.TIME_TO_ABAND_SECONDS       
,F.CALL_DURATION		
,F.TRANSFER_TO			
,F.XFERRED_OUT_FLAG		
,CASE WHEN 
	D.QUEUE_TYPE in  (SELECT distinct rtrim(ltrim(regexp_substr(OUT_VAR, '[^,]+', 1, level),''''),'''') 
  FROM (SELECT OUT_VAR  FROM CC_A_LIST_LKUP WHERE NAME = 'VM_call_types') 
CONNECT BY instr(OUT_VAR, ',', 1, level - 1) > 0)
	THEN 'Y' 	ELSE 'N' END VOICEMAIL_FLAG
,CASE WHEN TIME_TO_ABAND_SECONDS > 0 THEN 1 ELSE 0 END CALL_ABANDONED_FLAG         
,CASE WHEN 
	D.QUEUE_TYPE in  (SELECT distinct rtrim(ltrim(regexp_substr(OUT_VAR, '[^,]+', 1, level),''''),'''') 
  FROM (SELECT OUT_VAR  FROM CC_A_LIST_LKUP WHERE NAME = 'Handled_Inbound_call_types') 
CONNECT BY instr(OUT_VAR, ',', 1, level - 1) > 0)
	THEN 1 	ELSE 0 END CALL_OFFERED_FLAG
,CASE WHEN TALK_TIME_SECONDS >0 THEN 1 ELSE 0 END CALL_ANSWERED_FLAG		
,CASE WHEN CALL_DISPOSITION in (8,9,11) THEN 1 ELSE 0 END CALL_BUSY_FLAG              
,CASE WHEN CALL_DISPOSITION in (10,12) THEN 1 ELSE 0 END CALL_DROPPED_FLAG           
,CASE
   WHEN F.D_CONTACT_QUEUE_ID IS NOT NULL THEN D.QUEUE_TYPE
   WHEN F.PERIPHERAL_CALL_TYPE = 9 THEN 'Agent'
   WHEN F.CALL_HANDLE_METHOD = 'Predictive Dialer' THEN CALL_HANDLE_METHOD 
ELSE NULL
END CALL_HANDLE_METHOD       
,'Manual' as CALL_DIAL_METHOD            
,F.CALL_SEGMENT_END_DT		
,F.CREATE_DATE                
,F.LAST_UPDATE_DATE            
,F.LAST_UPDATED_BY 
,NULL AS CUSTOMER_ACCOUNT_NUMBER
, CASE
   WHEN F.D_CONTACT_QUEUE_ID IS NOT NULL THEN D.D_PROJECT_ID
   WHEN (F.PERIPHERAL_CALL_TYPE = 9 AND F.D_AGENT_ID IS NOT NULL) THEN  (select PROJECT_ID 
FROM CC_D_PROJECT P
, CC_S_AGENT S
, CC_C_PROJECT_CONFIG C
WHERE S.LOGIN_ID = F.AGENT_LOGIN_ID
AND S.PROJECT_CONFIG_ID = C.PROJECT_CONFIG_ID
AND C.PROJECT_NAME = P.PROJECT_NAME)
   ELSE NULL
   END D_PROJECT_ID
, CASE
   WHEN F.D_CONTACT_QUEUE_ID IS NOT NULL THEN D.D_PROGRAM_ID
   WHEN (F.PERIPHERAL_CALL_TYPE = 9 AND F.D_AGENT_ID IS NOT NULL) THEN  (select PROGRAM_ID 
FROM CC_D_PROGRAM P
, CC_S_AGENT S
, CC_C_PROJECT_CONFIG C
WHERE S.LOGIN_ID = F.AGENT_LOGIN_ID
AND S.PROJECT_CONFIG_ID = C.PROJECT_CONFIG_ID
AND C.PROGRAM_NAME = P.PROGRAM_NAME)
   ELSE NULL
   END D_PROGRAM_ID
FROM CC_F_V2_CALL F
LEFT OUTER JOIN CC_D_CONTACT_QUEUE D ON F.D_CONTACT_QUEUE_ID = D.D_CONTACT_QUEUE_ID
LEFT OUTER JOIN CC_C_CALL_DISPOSITION_LKUP DL ON F.CALL_DISPOSITION = DL.CALL_DISPOSITION_CODE
LEFT OUTER JOIN CC_C_CALL_DISPOSITION_FLG_LKUP DFL ON F.CALL_DISPOSITION_FLAG = DFL.CALL_DISPOSITION_FLG_CODE
UNION ALL
SELECT
D.F_DIALER_ID AS F_V2_CALL_ID  		
,D.D_DATE_ID      
,D.DATETIME
,NULL AS CALLTYPE_REPORTING_DATETIME                   
,NULL AS D_CONTACT_QUEUE_ID          
,NULL AS QUEUE_NUMBER                
,D.D_AGENT_ID			
,D.AGENT_LOGIN_ID		
,D.ROUTER_CALL_KEY_DAY         
,D.ROUTER_CALL_KEY             
,D.PERIPHERAL_CALL_KEY         
,NULL AS PERIPHERAL_CALL_TYPE        
,D.PERIPHERAL_ID   
,D.SKILL_GROUP_ID
,NULL AS PRECISION_QUEUE_ID
,NULL AS SOURCE_D_AGENT_ID           
,NULL AS SOURCE_AGENT_LOGIN_ID       
,NULL AS CALL_REFERENCE_ID		
,D.CALLGUID                    
,NULL AS CALL_SEGMENT_ID		
,NULL AS SOURCE_CALL_ID		
,NULL AS ACTIVITY_ID			
,D.PHONE AS DIGITS_DIALED               
,NULL AS ANI_PHONE_NUMBER            
,D.CALL_RESULT AS CALL_DISPOSITION 
,R.CALL_RESULT_DESC AS CALL_DISPOSITION_DESC
,NULL AS CALL_DISPOSITION_FLAG  
,NULL AS CALL_DISPOSITION_FLG_DESC
,NULL AS DNIS						
,NULL AS LANGUAGE			
,NULL AS QUEUE_TIME_SECONDS          
,NULL AS RING_TIME_SECONDS  		
,NULL AS HOLD_TIME_SECONDS           
,NULL AS WORK_TIME_SECONDS	        
,NULL AS TALK_TIME_SECONDS           
,NULL AS IVR_TIME_SECONDS  		
,NULL AS NETWORK_TIME_SECONDS        
,NULL AS LOCAL_Q_TIME_SECONDS        
,NULL AS DELAY_TIME_SECONDS          
,NULL AS TIME_TO_ABAND_SECONDS       
,D.CALL_DURATION		
,NULL AS TRANSFER_TO			
,NULL AS XFERRED_OUT_FLAG		
,NULL AS VOICEMAIL_FLAG
,NULL AS  CALL_ABANDONED_FLAG         
,NULL AS CALL_OFFERED_FLAG
,NULL AS CALL_ANSWERED_FLAG		
,NULL AS CALL_BUSY_FLAG              
,NULL AS CALL_DROPPED_FLAG           
,D.CALL_HANDLE_METHOD
,D.CALL_DIAL_METHOD            
,NULL AS CALL_SEGMENT_END_DT		
,D.EXTRACT_DATE                
,D.LAST_UPDATE_DATE            
,D.LAST_UPDATED_BY 
,D.CUSTOMER_ACCOUNT_NUMBER
,(SELECT PROJECT_ID FROM CC_D_PROJECT WHERE PROJECT_NAME = C.PROJECT_NAME) D_PROJECT_ID
,(SELECT PROGRAM_ID FROM CC_D_PROGRAM WHERE PROGRAM_NAME = C.PROGRAM_NAME) D_PROGRAM_ID
FROM CC_F_DIALER_BY_DATE D
LEFT OUTER JOIN CC_C_CALL_RESULT_LKUP R ON D.CALL_RESULT = R.CALL_RESULT_CODE
LEFT OUTER JOIN CC_C_CAMPAIGN_SV C ON D.CAMPAIGN_ID = C.CAMPAIGN_ID;

GRANT SELECT ON CC_F_V2_CALL_SV TO MAXDAT_READ_ONLY;  
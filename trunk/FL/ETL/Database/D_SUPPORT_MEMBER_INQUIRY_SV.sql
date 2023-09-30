--------------------------------------------------------
--  File created - Tuesday-September-17-2013   
--------------------------------------------------------
DROP VIEW "D_SUPPORT_MEMBER_INQUIRY_SV";
--------------------------------------------------------
--  DDL for View D_SUPPORT_MEMBER_INQUIRY_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_SUPPORT_MEMBER_INQUIRY_SV" ("FEMSI_ID", "CONTACT_ID", "CONTACT_SOURCE", "COMPLETE_DATE", "CALL_START_TIME", "CALL_END_TIME", "CONTACT_NAME", "CALL_HANDLE_TIME", "CALLER_SOURCE", "ACCOUNT_ID", "CONTACT_REASON", "CONTACT_NOTE", "MATERIAL_REQUEST", "CREATED_NAME", "STAGE_DONE_DATE", "STG_EXTRACT_DATE", "STG_LAST_UPDATE_DATE", "INSTANCE_STATUS", "INSTANCE_STATUS_DATE", "INSTANCE_CREATE_DATE", "ACCOUNT_NUMBER", "CHANNEL") AS 
  SELECT
FEMSI_ID                ,
CONTACT_ID               ,    
CONTACT_SOURCE        ,
COMPLETE_DATE          ,            
CALL_START_TIME         ,          
CALL_END_TIME            ,      
CONTACT_NAME              ,
CALL_HANDLE_TIME           ,    
CALLER_SOURCE,
ACCOUNT_ID    ,           
CONTACT_REASON ,           
CONTACT_NOTE    ,          
MATERIAL_REQUEST ,     
CREATED_NAME      ,       
STAGE_DONE_DATE    ,               
STG_EXTRACT_DATE    ,              
STG_LAST_UPDATE_DATE ,             
INSTANCE_STATUS       ,      
INSTANCE_STATUS_DATE,
INSTANCE_CREATE_DATE,
ACCOUNT_NUMBER,
CHANNEL
   FROM
FLHK_ETL_SUPP_MEMBR_INQY;
/

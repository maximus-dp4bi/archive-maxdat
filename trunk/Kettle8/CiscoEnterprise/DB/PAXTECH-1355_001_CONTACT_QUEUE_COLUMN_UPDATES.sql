alter session set current_schema = cisco_enterprise_cc;

ALTER TABLE CC_C_CONTACT_QUEUE
  MODIFY (  
  DISTRICT_NAME DEFAULT 'Unknown'
  ,PROVINCE_NAME DEFAULT 'Unknown'
  );
  
  
  
  


  

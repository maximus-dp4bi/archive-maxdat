ALTER TABLE CC_S_ACD_INTERVAL_PERIOD ADD (Bucket_Interval_ID NUMBBER(19,0) NOT NULL, Enterprise_Name varchar2(500) NOT NULL, DateTime date);

ALTER TABLE CC_S_ACD_INTERVAL_PERIOD MODIFY
(
PERIOD_1_UPPER_BOUND    NULL     
PERIOD_2_UPPER_BOUND    NULL ,    
PERIOD_3_UPPER_BOUND    NULL ,   
PERIOD_4_UPPER_BOUND    NULL ,    
PERIOD_5_UPPER_BOUND    NULL ,    
PERIOD_6_UPPER_BOUND    NULL ,    
PERIOD_7_UPPER_BOUND    NULL ,    
PERIOD_8_UPPER_BOUND    NULL ,    
PERIOD_9_UPPER_BOUND    NULL ,    
PERIOD_10_UPPER_BOUND   NULL ,  

);

ALTER TABLE CC_S_CONTACT_QUEUE ADD (Bucket_Interval_ID  NUMBER(19,0));

ALTER TABLE CC_D_CONTACT_QUEUE ADD (Bucket_Interval_ID  NUMBER(19,0));

CREATE OR REPLACE VIEW CC_D_CONTACT_QUEUE_SV as
select * from CC_D_CONTACT_QUEUE;
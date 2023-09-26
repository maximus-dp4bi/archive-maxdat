ALTER TABLE EMRS_S_CLIENT_ELIGIBILITY_STG
ADD ( reasons VARCHAR2(256)
     ,mvx_core_reason VARCHAR2(256)
     ,sub_status_codes VARCHAR2(32)
     ,disposition_cd VARCHAR2(32));
     
ALTER TABLE EMRS_D_CLIENT_PLAN_ELIGIBILITY
ADD ( reasons VARCHAR2(256)
     ,mvx_core_reason VARCHAR2(256)
     ,sub_status_codes VARCHAR2(32)
     ,disposition_cd VARCHAR2(32));
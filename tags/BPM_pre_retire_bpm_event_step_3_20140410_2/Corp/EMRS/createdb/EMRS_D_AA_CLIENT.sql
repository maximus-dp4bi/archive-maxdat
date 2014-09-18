CREATE TABLE EMRS_D_AA_CLIENT
(aa_client_id NUMBER(*,0)
 ,source_record_id NUMBER(*,0)
 ,aa_job_id NUMBER(*,0)
 ,client_number NUMBER(*,0)
 ,cin VARCHAR2(30)
 ,source_plan_id NUMBER(*,0)
 ,aa_action_cd VARCHAR2(30)
 ,program_type VARCHAR2(10)
 ,subprogram_type VARCHAR2(1)
 ,source_provider_id NUMBER(*,0)
 ,record_date DATE
 ,record_time VARCHAR2(10)
 ,record_name VARCHAR2(256)
 ,order_by_default NUMBER(*,0)
 ,modified_date DATE
 ,modified_time VARCHAR2(10)
 ,modified_name VARCHAR2(256)
 ,date_created DATE
 ,created_by VARCHAR2(80)
 ,date_updated DATE
 ,updated_by VARCHAR2(80)
      )SEGMENT CREATION IMMEDIATE 
 PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
 STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
 TABLESPACE "MAXDAT_DATA" ;
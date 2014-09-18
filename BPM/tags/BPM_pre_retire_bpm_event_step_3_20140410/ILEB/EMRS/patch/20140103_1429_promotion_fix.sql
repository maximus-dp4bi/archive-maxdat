TRUNCATE TABLE emrs_s_provider_stg_adhoc;
TRUNCATE TABLE emrs_d_alert;

CREATE UNIQUE INDEX "ALERT_PK" ON "EMRS_D_ALERT" ("ALERT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;

  ALTER TABLE "EMRS_D_ALERT" ADD CONSTRAINT "ALERT_PK" PRIMARY KEY ("ALERT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;

CREATE OR REPLACE VIEW EMRS_D_ALERT_SV 
AS
SELECT alert_id
 ,source_record_id
 ,case_number
 ,client_number
 ,message
 ,source_alert_start_date
 ,source_alert_end_date
 ,void_ind
 ,system_alert_ind
 ,ref_type
 ,ref_id
 ,lock_id
 ,record_count
 ,alert_handler
 ,record_date
 ,record_time
 ,record_name 
 ,modified_date
 ,modified_time
 ,modified_name
 ,date_updated
 ,date_created
 ,created_by
 ,updated_by
FROM emrs_d_alert; 

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_ALERT_SV FOR EMRS_D_ALERT_SV;

GRANT SELECT ON EMRS_D_ALERT_SV TO "MAXDAT_READ_ONLY";
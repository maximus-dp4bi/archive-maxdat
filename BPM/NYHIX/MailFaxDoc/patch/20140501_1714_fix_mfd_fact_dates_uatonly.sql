 --cron job has to be turned off while this update is running

alter trigger TRG_BIU_NYHIX_ETL_MFD disable;
alter trigger TRG_AI_NYHIX_ETL_MFD_Q disable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q disable;

--Backfill Instance Start and End Dates for Complete instances
DECLARE  
CURSOR cmfd_cur IS

  SELECT eemfdb_id, stg_extract_dt, stg_last_update_dt, instance_start_date,
    CASE WHEN complete_dt IS NOT NULL AND complete_dt >= instance_start_date THEN complete_dt
      ELSE CASE WHEN cancel_dt IS NOT NULL AND cancel_dt >= instance_start_date THEN cancel_dt
         ELSE stg_last_update_dt END END instance_end_date
  FROM(
  SELECT eemfdb_id,stg_extract_dt, stg_last_update_dt,cancel_dt, complete_dt,
    CASE WHEN create_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND create_dt <= scan_dt AND create_dt <= SYSDATE THEN create_dt 
          ELSE CASE WHEN scan_dt  >= TO_DATE('10-01-2013','MM-DD-YYYY') AND scan_dt <= origination_dt AND scan_dt <= SYSDATE THEN scan_dt
                  ELSE CASE WHEN origination_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND origination_dt <= SYSDATE THEN origination_dt 
                     ELSE stg_extract_dt END END END instance_start_date
  FROM NYHIX_ETL_MAIL_FAX_DOC
  WHERE complete_dt IS NOT NULL);
   
   TYPE t_cmfd_tab IS TABLE OF cmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cmfd_tab t_cmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cmfd_cur;
   LOOP
     FETCH cmfd_cur BULK COLLECT INTO cmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cmfd_tab.COUNT
         UPDATE NYHIX_ETL_MAIL_FAX_DOC
         SET instance_start_date = cmfd_tab(indx).instance_start_date
             ,instance_end_date = cmfd_tab(indx).instance_end_date
         WHERE eemfdb_id = cmfd_tab(indx).eemfdb_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cmfd_cur;
END;
/

--Backfill Instance Start Date for Active instances
DECLARE  
CURSOR amfd_cur IS
  SELECT eemfdb_id,stg_extract_dt, stg_last_update_dt,
    CASE WHEN create_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND create_dt <= scan_dt AND create_dt <= SYSDATE THEN create_dt 
          ELSE CASE WHEN scan_dt  >= TO_DATE('10-01-2013','MM-DD-YYYY') AND scan_dt <= origination_dt AND scan_dt <= SYSDATE THEN scan_dt
                  ELSE CASE WHEN origination_dt >= TO_DATE('10-01-2013','MM-DD-YYYY') AND origination_dt <= SYSDATE THEN origination_dt 
                     ELSE SYSDATE END END END instance_start_date 
  FROM NYHIX_ETL_MAIL_FAX_DOC
  WHERE instance_status = 'Active';
   
   TYPE t_amfd_tab IS TABLE OF amfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   amfd_tab t_amfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN amfd_cur;
   LOOP
     FETCH amfd_cur BULK COLLECT INTO amfd_tab LIMIT v_bulk_limit;
     EXIT WHEN amfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..amfd_tab.COUNT
         UPDATE NYHIX_ETL_MAIL_FAX_DOC
         SET instance_start_date = amfd_tab(indx).instance_start_date             
         WHERE eemfdb_id = amfd_tab(indx).eemfdb_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE amfd_cur;
END;
/


--Backfill Instance Start and End Dates for current dimension
DECLARE  
CURSOR mfdcur_cur IS
   SELECT nyhix_mfd_bi_id, mfd.instance_start_date, mfd.instance_end_date
   FROM NYHIX_ETL_MAIL_FAX_DOC mfd, D_NYHIX_MFD_CURRENT cur
   WHERE mfd.dcn = cur.dcn;
   
   TYPE t_mfdcur_tab IS TABLE OF mfdcur_cur%ROWTYPE INDEX BY PLS_INTEGER;
   mfdcur_tab t_mfdcur_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mfdcur_cur;
   LOOP
     FETCH mfdcur_cur BULK COLLECT INTO mfdcur_tab LIMIT v_bulk_limit;
     EXIT WHEN mfdcur_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mfdcur_tab.COUNT
         UPDATE D_NYHIX_MFD_CURRENT
         SET instance_start_date = mfdcur_tab(indx).instance_start_date   
             ,instance_end_date = mfdcur_tab(indx).instance_end_date
         WHERE nyhix_mfd_bi_id = mfdcur_tab(indx).nyhix_mfd_bi_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfdcur_cur;
END;
/

 alter table f_nyhix_mfd_by_date enable row movement;
 
  DECLARE  
CURSOR cfmfd_cur IS

  SELECT f.fnmfdbd_id, cmfd.instance_start_date instance_start_date 
  FROM F_NYHIX_MFD_BY_DATE f,D_NYHIX_MFD_CURRENT cmfd
  WHERE f.nyhix_mfd_bi_id = cmfd.nyhix_mfd_bi_id
  AND creation_count = 1
  AND cmfd.instance_start_date <> f.d_date;
  
   TYPE t_cfmfd_tab IS TABLE OF cfmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cfmfd_tab t_cfmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cfmfd_cur;
   LOOP
     FETCH cfmfd_cur BULK COLLECT INTO cfmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cfmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cfmfd_tab.COUNT
         UPDATE F_NYHIX_MFD_BY_DATE
         SET bucket_start_date =  TRUNC(cfmfd_tab(indx).instance_start_date),
             d_date =  cfmfd_tab(indx).instance_start_date
         WHERE fnmfdbd_id = cfmfd_tab(indx).fnmfdbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cfmfd_cur;
END;
/

 DECLARE  
CURSOR cfmfd_cur IS

  SELECT f.fnmfdbd_id, TRUNC(cmfd.instance_end_date) instance_end_date 
  FROM F_NYHIX_MFD_BY_DATE f,D_NYHIX_MFD_CURRENT cmfd
  WHERE f.nyhix_mfd_bi_id = cmfd.nyhix_mfd_bi_id
  AND completion_count = 1
  AND cmfd.instance_end_date IS NOT NULL
  AND TRUNC(cmfd.instance_end_date) <> f.bucket_end_date;
  
   TYPE t_cfmfd_tab IS TABLE OF cfmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cfmfd_tab t_cfmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cfmfd_cur;
   LOOP
     FETCH cfmfd_cur BULK COLLECT INTO cfmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cfmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cfmfd_tab.COUNT
         UPDATE F_NYHIX_MFD_BY_DATE
         SET bucket_end_date =  cfmfd_tab(indx).instance_end_date           
         WHERE fnmfdbd_id = cfmfd_tab(indx).fnmfdbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cfmfd_cur;
END;
/

COMMIT;

alter table f_nyhix_mfd_by_date disable row movement;

alter trigger TRG_BIU_NYHIX_ETL_MFD enable;
alter trigger TRG_AI_NYHIX_ETL_MFD_Q enable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q enable;

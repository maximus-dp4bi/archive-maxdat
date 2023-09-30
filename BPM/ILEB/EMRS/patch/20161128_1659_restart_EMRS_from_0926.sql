/*
Created on 11/28/2016 by Raj A.
ILEB-6249. Redeploying original ETL code and running ETL from 09/26/2016 to get EMRS catch up.
*/
UPDATE corp_etl_job_statistics
   SET job_status_cd = 'ERRORED'
   WHERE job_name = 'ETL_Enrollment'
   AND job_start_date >= to_date('11/11/2016','mm/dd/yyyy');
 COMMIT;
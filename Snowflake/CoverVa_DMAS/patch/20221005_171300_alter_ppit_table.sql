DELETE FROM coverva_dmas.dmas_file_load_lkup 
WHERE filename_prefix = 'PPIT';

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,file_day_received)
VALUES('PPIT','PPIT_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Applicant,App_Received_Date,Worker_LDSS,Locality,Program,Delay,Number_of_Days_Pending,Worker_ID,Filename,interview_held_date,worker_name,stage,application_source,vcl_due_date,num_days_app_held_before_transfer,transfer_app_entity,indicator,minimal_information,extend_pend_performed,expedited_snap,resource_assessment_only,snap_expedited_ppv_application,snap_expedited_ppv_case,ppv_overdue_non_expedited'
       ,'TRIM(CASE WHEN LENGTH(application_) > 10 THEN SUBSTR(application_,1,REGEXP_INSTR(application_,'' '')-1) ELSE application_ END),case_,applicant,CAST(regexp_replace(application_receivedscreening_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker_processing_unit,locality,programs,delay,no_of_days_pending,worker_id,filename,interview_held_date,worker_name,stage,application_source,CAST(regexp_replace(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS vcl_due_date,_of_days_app_held_before_transfer,entity_that_transferred_app,indicator,minimal_information,extend_pend_performed,expedited_snap,resource_assessment_only,snap_expedited_ppv_application,snap_expedited_ppv_case,ppv_overdue__nonexpedited'
       ,'WHERE 1=1','Y','Y','Y','SAME_DAY');
       
ALTER TABLE coverva_dmas.ppit_data_full_load 
ADD(interview_held_date	VARCHAR,
    worker_name VARCHAR,
    stage VARCHAR,
    application_source VARCHAR,
    vcl_due_date DATE,
    num_days_app_held_before_transfer NUMBER,
    transfer_app_entity VARCHAR,
    indicator VARCHAR,
    minimal_information VARCHAR,
    extend_pend_performed VARCHAR,
    expedited_snap VARCHAR,
    resource_assessment_only VARCHAR,
    snap_expedited_ppv_application VARCHAR,
    snap_expedited_ppv_case VARCHAR,
    ppv_overdue_non_expedited VARCHAR);       

ALTER TABLE coverva_dmas.dmas_application ADD(vcl_sent_date DATE);
ALTER TABLE coverva_dmas.dmas_application_current ADD(vcl_sent_date DATE);


MERGE INTO coverva_dmas.dmas_application dmas
USING (SELECT da.dmas_application_id,da.tracking_number,file_inventory_date, CASE WHEN e.cm044_status IS NOT NULL THEN 'Y' ELSE 'N' END cm044_verified
       FROM coverva_dmas.dmas_application da
         JOIN coverva_dmas.dmas_application_event e ON da.tracking_number = e.tracking_number AND cast(da.file_inventory_date as date) = e.event_date  
       WHERE cm044_status IS NOT NULL) da ON (dmas.dmas_application_id = da.dmas_application_id)
WHEN MATCHED THEN UPDATE
SET dmas.cm044_verified = da.cm044_verified;

UPDATE coverva_dmas.dmas_application
SET  cm044_verified = 'Y'
WHERE dmas_application_id in(
SELECT da.dmas_application_id--,da.tracking_number,file_inventory_date latest_inventory_date,state_app_received_date,current_state,cm044_verified,e.cm044_status
FROM(SELECT da.dmas_application_id,da.tracking_number,file_inventory_date,state_app_received_date, current_state,cm044_verified,RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk                               
FROM coverva_dmas.dmas_application da)  da
  join coverva_dmas.dmas_application_event e ON e.tracking_number = da.tracking_number and e.event_date = cast('10/31/2022' as date)
WHERE rnk = 1
AND current_state in('Approved','Denied')
AND cm044_status is not null
AND cm044_verified is null);

MERGE INTO coverva_dmas.dmas_application dmas
USING(SELECT da.dmas_application_id,da.tracking_number,da.fp_create_dt,daw.vcl_sent_date
      FROM coverva_dmas.dmas_application da
        JOIN (SELECT tracking_number, MIN(fp_create_dt) vcl_sent_date
              FROM coverva_dmas.dmas_application  
              WHERE current_state = 'Waiting for Verification Documents'
              GROUP BY tracking_number) daw ON da.tracking_number = daw.tracking_number ) da ON(dmas.dmas_application_id = da.dmas_application_id AND da.vcl_sent_date >= dmas.fp_create_dt)
WHEN MATCHED THEN UPDATE
SET dmas.vcl_sent_date = da.vcl_sent_date;


CREATE OR REPLACE sequence coverva_dmas.seq_dmas_cviu_dailyrelease_id;

delete from coverva_dmas.dmas_file_load_lkup
where filename_prefix = 'DOC_OFFENDER_RELEASE_FILES';
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('DOC_OFFENDER_RELEASE_FILES','CVIU_DAILY_RELEASE_FULL_LOAD','COVERVA_DMAS',
      'offender_id,offender_location_type,medicaid_number,medicaid_category,offender_release_person,offender_proposed_address_state,filename'
      ,'offender_id,offender_location_type,medicaid_number,medicaid_category,offender_release_person,offender_proposed_address_state,filename'
      ,'WHERE 1=1','Y','N','N');

--DROP TABLE coverva_dmas.cviu_daily_release_full_load;
CREATE TABLE coverva_dmas.cviu_daily_release_full_load
(cviu_dailyrelease_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_cviu_dailyrelease_id.nextval
,offender_id NUMBER
,offender_location_type VARCHAR
,medicaid_number VARCHAR
,medicaid_category VARCHAR
,offender_release_person VARCHAR
,offender_proposed_address_city VARCHAR
,offender_proposed_address_state VARCHAR
,filename VARCHAR);

alter table COVERVA_DMAS.cviu_daily_release_full_load add primary key (cviu_dailyrelease_id);

CREATE TABLE coverva_dmas.cviu_daily_release_history
(dr_file_dmonth VARCHAR,
 dr_file_dyearmon NUMBER,
 dr_file_date DATE,
 dr_mtd_ytd_indicator VARCHAR,
 record_count NUMBER,
 doc_record_count NUMBER,
 scb_record_count NUMBER,
 release_process_count NUMBER,
 doc_release_process_count NUMBER,
 scb_release_process_count NUMBER,
 transfer_process_count NUMBER,
 doc_transfer_process_count NUMBER,
 scb_transfer_process_count NUMBER,
 moved_outof_state_count NUMBER,
 doc_moved_outof_state_count NUMBER,
 scb_moved_outof_state_count NUMBER);
 
 alter table COVERVA_DMAS.cviu_daily_release_history add primary key (dr_file_dyearmon);

--script to insert historical data broken down by month
INSERT INTO coverva_dmas.cviu_daily_release_history
(dr_file_dmonth, dr_file_dyearmon, dr_file_date, record_count, doc_record_count, scb_record_count, release_process_count, doc_release_process_count, scb_release_process_count,transfer_process_count,
 doc_transfer_process_count, scb_transfer_process_count, moved_outof_state_count, doc_moved_outof_state_count, scb_moved_outof_state_count,dr_mtd_ytd_indicator )
SELECT d_month,to_number(d_yearmon), d_date, to_number(record_count),
 to_number(doc_record_count), 
 to_number(scb_record_count), 
 to_number(release_process_count),
 to_number(doc_release_process_count),
 to_number(scb_release_process_count),
 to_number(doc_transfer_process_count) + to_number(scb_transfer_process_count) transfer_process_count,
 to_number(doc_transfer_process_count),
 to_number(scb_transfer_process_count),
 to_number(moved_outof_state_count),
 to_number(doc_moved_outof_state_count),
 to_number(scb_moved_outof_state_count),
 mtd_ytd_indicator
 FROM COVERVA_DMAS.DAILYRELEASE_HISTORY_20220526;
 
--script to insert historical data broken down by day
INSERT INTO coverva_dmas.cviu_daily_release_history
(dr_file_dmonth, dr_file_dyearmon, dr_file_date, record_count, doc_record_count, scb_record_count, release_process_count, moved_outof_state_count,dr_mtd_ytd_indicator )
select d_month_year,d_yearmonth_num,mtd.d_date,
  to_number(record_count),
 to_number(doc_record_count), 
 to_number(scb_record_count), 
 to_number(release_process_count),
 to_number(moved_outof_state_count),
 'MTD'
FROM COVERVA_DMAS.DAILYRELEASE_HISTORY_MTD_20220527 mtd
 JOIN(SELECT d_year,
 d_month,
 TRIM(CONCAT(d_month_name,'-',d_year)) d_month_year,
 d_date,
 d_day_name,
 CONCAT('WE - ',LAST_DAY(d_date,'week')) week_ending,
 CONCAT('Quarter',DATE_PART('quarter',d_date),'-',d_year) d_quarter,
 TO_NUMBER(CONCAT(d_year,LPAD(d_month_num,2,'0'))) d_yearmonth_num
 FROM d_dates
 WHERE project_id = 115
 AND d_date >= CAST('01/01/2021' AS DATE) 
 AND d_date <= LAST_DAY(current_date(),'week')) dd ON dd.d_date = mtd.d_date; 
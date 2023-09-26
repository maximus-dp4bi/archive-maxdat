create table coverva_dmas.cviu_daily_release_history_bak as
select * from  coverva_dmas.cviu_daily_release_history ;
 
 truncate table  coverva_dmas.cviu_daily_release_history;
  
 INSERT INTO coverva_dmas.cviu_daily_release_history
(dr_file_dmonth, dr_file_dyearmon, dr_file_date, record_count, doc_record_count, scb_record_count, release_process_count, moved_outof_state_count,scb_transfer_process_count,dr_mtd_ytd_indicator )
 select d_month_year,d_yearmonth_num,mtd.d_date,
  to_number(record_count) record_count,
 to_number(doc_record_count) doc_record_count, 
 to_number(scb_record_count) scb_record_count, 
 to_number(release_process_count) release_process_count,
 to_number(moved_outof_state_count) moved_outof_state_count,
 to_number(scb_transfers) scb_transfer_process_count,
 'MTD' dr_mtd_ytd_indicator
FROM COVERVA_DMAS.DAILYRELEASE_HISTORY_MTD_20220601 mtd
 JOIN(SELECT d_year,
 d_month,
 TRIM(CONCAT(d_month_name,'-',d_year)) d_month_year,
 d_date,
 d_day_name,
 CONCAT('WE - ',LAST_DAY(d_date,'week')) week_ending,
 CONCAT('Quarter',DATE_PART('quarter',d_date),'-',d_year) d_quarter,
 TO_NUMBER(CONCAT(d_year,LPAD(d_month_num,2,'0'))) d_yearmonth_num
 FROM d_dates
 WHERE project_id = 117
 AND d_date >= CAST('01/01/2021' AS DATE) 
 AND d_date <= LAST_DAY(current_date(),'week')) dd ON dd.d_date = mtd.d_date;
 
 delete from coverva_dmas.cviu_intake_data_full_load
 where upper(filename) in(select upper(filename)from coverva_dmas.dmas_file_log
                          where filename_prefix = 'CVIU_INTAKE'
                          and cast(file_date as date) between cast('06/11/2022' as date) and cast('08/11/2022' as date));
                          
 delete from coverva_dmas.dmas_file_log
 where filename_prefix = 'CVIU_INTAKE'
 and cast(file_date as date) between cast('06/11/2022' as date) and cast('08/11/2022' as date);
                           
--rollback
truncate table  coverva_dmas.cviu_daily_release_history;

insert into coverva_dmas.cviu_daily_release_history
select * from  coverva_dmas.cviu_daily_release_history_bak ;

                         

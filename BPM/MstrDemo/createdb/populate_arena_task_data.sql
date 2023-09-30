/*
Load file through SQL Developer

1.  Right click on Tables folder
2.  Choose Import Data
3.  Choose the file to upload (Choose "none" on the left/right enclosures), hit next
4.  Enter the table name ARENA_DATA_STG, hit next
5.  Leave the selected fields, hit next
6.  Leave all the datatypes to varchar2 but fix the size/precision (should be big enough for the values), hit next
7.  After the load, run the insert script below then drop the stage table
8.  To populate the MW tables, execute LOAD_MW_AND_ACTUALS_PKG.LOAD_MW_SIM_DATA
9.  To populate the PP Actuals tables, execute LOAD_MW_AND_ACTUALS_PKG.LOAD_ACTUALS_DATA
10. To populate Process Instance tables, execute LOAD_MW_AND_ACTUALS_PKG.POPULATE_PROCESS_INSTANCE
*/

TRUNCATE TABLE arena_task_data;

INSERT INTO arena_task_data(task_id,task_type_id,create_date,instance_start_date,last_update_date,status_date,task_status,work_receipt_date,claim_date,complete_date,source_process_instance_id,owner_staff_id,program,stg_create_date,stg_file_num)
select to_number(task_id) task_id,
to_number(task_type_id) task_type_id,
to_date(start_date,'mm/dd/yyyy hh24:mi:ss') create_date,
to_date(inst_start_date,'mm/dd/yyyy hh24:mi:ss') inst_start_date,
to_date(last_update_date,'mm/dd/yyyy hh24:mi:ss') last_update_date,
to_date(status_date,'mm/dd/yyyy hh24:mi:ss') status_date,
trim(task_status) task_status,
to_date(recd_date,'mm/dd/yyyy hh24:mi:ss') work_receipt_date,
to_date(claim_date,'mm/dd/yyyy hh24:mi:ss') claim_date,
to_date(complete_date,'mm/dd/yyyy hh24:mi:ss') complete_date,
to_number(instance_id) source_process_instance_id,
to_number(staff_id) owner_staff_id,
trim(program) program,
sysdate,
1 --increment for each file loaded
from arena_data_stg;

commit;

DROP TABLE arena_data_stg;

CREATE TABLE arena_task_data_orig as select * from arena_task_data;
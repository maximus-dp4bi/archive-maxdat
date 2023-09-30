/*
Created on 07/22/2015 by Raj A.
Description: Created for NYHIX-16293

Below are the steps to reprocess the errored out MW V2 queue rows.
1. Manually add the dimension 103336 to the dimension table.
2. Manually update the ETL stage table and step_instance_stg with business_unit_id = 103040 where ever there is 103336.
3. Reset and reprocess queue rows; all should process now.
4. Now, update the D_MW_v2_History table to update all recs with 103336 to 103040.
5. Manually delete the dimension, Business_Unit_ID = 103336.
*/
insert into d_business_units
values (103336,'Call Center Supervisor Team','Created for MAXDat NYHIX-16293. Manually adding and delete after queue procesing.');
commit;

update step_instance_stg
   set group_id = 103040
 where step_instance_id in (select distinct identifier
							  from bpm_update_event_queue
							 where bsl_id = 2001
							 )
   and group_id = 103336;
 commit;
 
update corp_etl_mw_v2
   set business_unit_id = 103040
 where task_id in (select distinct identifier
							  from bpm_update_event_queue
							 where bsl_id = 2001
							 )  
and business_unit_id = 103336;
commit;							   	

execute maxdat.maxdat_admin.shutdown_jobs;
execute maxdat.maxdat_admin.reset_bpm_queue_rows_by_bsl_id(p_bsl_id => 2001);
execute maxdat.maxdat_admin.startup_jobs;

--*********
--PLEASE CONTACT DEVELOPER BEFORE RUNNING THE BELOW PIECE.
--*********
Update D_MW_V2_HISTORY
   set business_unit_id = 103040
 where business_unit_id = 103336
   and mw_bi_id in (select distinct bi_id
				   FROM bpm_logging
				  WHERE bsl_id = 2001
				    AND log_date >= '28-SEP-2015'
					AND bi_id is not null
				 );
commit;				 
   
delete d_business_units
where business_unit_id = 103336;
commit;
/*
Created on 03-Feb-2014 by Raj A.
Description:
This script will do below.
1.Set the job stats last succesfull run times to 9/1/2013 so that the next run of the ETL will insert any missing instances in between.
2.Doing a data fix for ten instances where assd_identify_rsrch_incident is null because of a bug in the instance_status & instances_status_dt calculation in the insert
ktr. 
*/

update corp_etl_job_statistics
   set job_start_date = to_date('2013/09/01','yyyy/mm/dd')
      --  job_end_date = to_date('2013/09/01','yyyy/mm/dd')
 where  job_id = (select max(job_id)            
                    from corp_etl_job_statistics
                   where job_status_cd = 'COMPLETED'
                     and job_name = 'Process_Incidents_RUN_ALL');
commit;



begin
  for cur_rec in (select cepi_id
					from corp_etl_process_incidents
			       where  assd_identify_rsrch_incident  is null
				   )
  loop  
			update corp_etl_process_incidents  
			  set assd_identify_rsrch_incident = incident_status_dt
			where cepi_id = cur_rec.cepi_id;
  end loop;
commit;
end;	
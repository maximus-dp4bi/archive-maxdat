declare
/*
Created on 11/14/2014 by Raj A.
Description: There is an issue with Step_Instance_STG table. From Devin's explanation in an email on 11/14/2014, I understand that this data issue does
NOT happen on records prior to 04/01/2014. So, code is working correctly since which is why we are doing a data fix.

Only 27 recs don't have a process_id in SIS; so for these I will have to create a ktr (for one-time only)to pop them from source.
23,626 recs have them in SIS; so that is good, I do not have to hit the source and a database script we can run will fix it.
*/ 
  v_count number := 0;
  v_process_id number := null;
  v_process_instance_id number := null; 
   
begin

    for cur_rec in (
            select sis_1.step_instance_id, sis_1.step_instance_history_id
            from step_instance_stg sis_1
            where process_id is null
              and  exists (select 1 
                                from step_instance_stg sis_2
                                where sis_1.step_instance_id = sis_2.step_instance_id
                                and sis_2.process_id is not null)
             -- and sis_1.step_instance_id = 246022                  
                       )
    loop
     
        v_process_id := null;
        v_process_instance_id := null;   
        select distinct process_id, process_instance_id
          into v_process_id, v_process_instance_id
          from step_instance_stg
         where step_instance_id = cur_rec.step_instance_id
           and process_id is not null; 
        
        update step_instance_stg
          set process_id = v_process_id,
              process_instance_id = v_process_instance_id,
              mw_v2_processed = 'N'
        where step_instance_history_id = cur_rec.step_instance_history_id;    
      
      if mod(v_count,1000)=0
      then 
        commit;
      end if;  
       
    
    end loop;
    commit;

end;
/
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 220751, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 585976 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 479025, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1575731 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 479026, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1575733 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 479027, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1575755 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 483979, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1591050 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 483980, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1591053 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 485101, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1593912 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 485792, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1595421 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 486199, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1597580 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 490679, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1610989 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 490680, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1610992 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 490682, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1611076 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 493075, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1617677 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 493076, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1617678 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 493077, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1617681 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 494601, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1621945 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 495068, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1623215 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 6, PROCESS_INSTANCE_ID = 499306, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1631804 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 2013, PROCESS_INSTANCE_ID = 248227, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1661878 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 2013, PROCESS_INSTANCE_ID = 464259, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1667566 and process_id is null;
update STEP_INSTANCE_STG set PROCESS_ID = 2013, PROCESS_INSTANCE_ID = 596186, MW_V2_PROCESSED = 'N' where STEP_INSTANCE_ID = 1994264 and process_id is null;
COMMIT;
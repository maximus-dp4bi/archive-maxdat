DECLARE
 I number := 0;
BEGIN

DBMS_OUTPUT.PUT_LINE ( 'Process Started at : ' || to_char(sysdate,'mm/dd/yyyy HH24:Mi:ss AM') );

/* Identify records that were created before 5/1 and completed after 5/1 and Currently does not exist in step instance stg table */

For Def_Cur in (select distinct(step_instance_id) New_Step_Instance_Id 
                 from  STEP_INSTANCE_STG_BKUP070914 b
                 where Completed_ts > to_date('01-MAY-2014','DD-MON-YYYY')
                   and Create_TS < to_date('01-MAY-2014','DD-MON-YYYY')
                   and Status = 'COMPLETED'
                   and not exists ( select 1 from step_instance_stg c
                                     where c.step_instance_id = b.step_instance_id)
                 ) 
LOOP

insert into step_instance_stg 
select * from step_instance_stg_bkup070914 
where step_instance_id =  Def_Cur.New_Step_Instance_Id;  

update step_instance_stg set mw_processed = 'N' where step_instance_id =  Def_Cur.New_Step_Instance_Id; 

I := I + 1;

Commit;

END LOOP;                 
   
DBMS_OUTPUT.PUT_LINE ( 'Process Ended at : ' || to_char(sysdate,'mm/dd/yyyy HH24:Mi:ss AM') ||' Updated records # : '||I);   
   
END;
/
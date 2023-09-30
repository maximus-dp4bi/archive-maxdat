Update bpm_update_event_queue
  set PROCESS_BUEQ_ID = null
    , new_data = updatexml( new_data,'/ROWSET/ROW/COMPLETE_DATE/text()', extractValue(new_data,'/ROWSET/ROW/LAST_UPDATE_DATE') )
where bsl_id = 1
and bil_id = 3
and  Identifier = '195071';

commit;


DECLARE
 v_step varchar2(100) := 'Start';
 v_num number := 0;                
BEGIN

/ ** For error in inserts ** /

For instance_rec in ( 

select bi_id, bem_id, bsl_id , bil_id, identifier
  from bpm_instance i
 where BSL_ID = 1 
   and exists ( select 1 from  bpm_update_event_queue q
               where q.old_data is null
                 and q.bsl_id = i.bsl_id
                 and q.bil_id = i.bil_id
                 and q.identifier = i.identifier
                 and trunc(q.event_date) != trunc(sysdate)
               )

)
Loop

BEGIN

v_step := 'Delete Attributes';
delete from bpm_instance_attribute where bi_id = instance_rec.bi_id ;

v_step := 'Update Event Queue';
update BPM_UPDATE_EVENT_QUEUE
   set PROCESS_BUEQ_ID = null
       ,BUE_ID = null
       ,wrote_bpm_event_date = null
where BSL_ID = instance_rec.bsl_id
  and BIL_ID = instance_rec.bil_id 
  and IDENTIFIER = instance_rec.identifier ;

v_step := 'Delete events';
delete from bpm_update_event where bi_id = instance_rec.bi_id ;

v_step := 'Delete Instance';
delete from bpm_instance where bi_id = instance_rec.bi_id ;

commit;

Exception 
 when others then
   dbms_output.put_line('ERROR: ' || SqlErrM || ' For Instance : '|| instance_rec.bi_id || ' - ' ||v_step);
   rollback;
END;

End Loop;



/ ** For error in update ** /

For instance_rec in ( 

select  bueq_id, bsl_id, bil_id, process_bueq_id, bue_id, wrote_bpm_event_date, wrote_bpm_semantic_date, identifier 
from bpm_update_event_queue
where bsl_id = 1
 and identifier = '187453'
 order by bueq_id desc

)
Loop

BEGIN

v_step := 'Delete Attributes';
delete from bpm_instance_attribute where bue_id = instance_rec.bue_id ;

v_step := 'Update Event Queue';
update BPM_UPDATE_EVENT_QUEUE
   set PROCESS_BUEQ_ID = null
      ,BUE_ID = null
      ,WROTE_BPM_EVENT_DATE = null
where BUEQ_ID = instance_rec.bueq_id;

v_step := 'Delete events';
delete from bpm_update_event where bue_id = instance_rec.bue_id ;

commit;

Exception 
 when others then
   dbms_output.put_line('ERROR: ' || SqlErrM || ' For Instance : '|| instance_rec.bueq_id || ' - ' ||v_step);
   rollback;
END;

End Loop;


END;   

/
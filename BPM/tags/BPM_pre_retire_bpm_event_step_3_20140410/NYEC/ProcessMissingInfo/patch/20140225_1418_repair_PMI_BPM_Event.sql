Prompt Deleting Process MI Instance where OLD and NEW XMLDATA are identical

delete from bpm_update_event 
where BUE_ID = 55629719
and BI_ID = 56687505;
                     
commit;

delete from bpm_update_event_queue
where bueq_id = 43349809
  and bsl_id = 5
  and bil_id = 7
  and Identifier = '11150327';

commit;

Update bpm_update_event_queue
  set PROCESS_BUEQ_ID = null
    , new_data = updatexml( new_data,'/ROWSET/ROW/INSTANCE_COMPLETE_DT/text()', extractValue(new_data,'/ROWSET/ROW/MI_TASK_COMPLETE_DATE'),'/ROWSET/ROW/MI_CYCLE_END_DT/text()', extractValue(new_data,'/ROWSET/ROW/MI_TASK_COMPLETE_DATE') )
where bsl_id = 5
and bil_id = 7
and  Identifier = '11150327';

commit;

Update bpm_update_event_queue
  set PROCESS_BUEQ_ID = null
    , new_data = updatexml( new_data,'/ROWSET/ROW/INSTANCE_COMPLETE_DT/text()', extractValue(new_data,'/ROWSET/ROW/STG_LAST_UPDATE_DATE'),'/ROWSET/ROW/MI_CYCLE_END_DT/text()', extractValue(new_data,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') )
where bsl_id = 5
and bil_id = 7
and  Identifier = '11431754';

commit;
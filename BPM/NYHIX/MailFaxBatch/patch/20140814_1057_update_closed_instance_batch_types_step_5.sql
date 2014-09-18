update bpm_update_event_queue_archive qa set new_data=
updatexml(new_data,'/ROWSET/ROW/BATCH_TYPE/text()',
coalesce(( 
  select batch_type from TMP_MFB_UPD_C_JJH_20140827 wip
  where qa.IDENTIFIER = wip.batch_guid and ROWNUM = 1
),'Undetermined')
)
where extractvalue(qa.new_data,'/ROWSET/ROW/INSTANCE_STATUS')='Complete'
and bsl_id=16;
commit;

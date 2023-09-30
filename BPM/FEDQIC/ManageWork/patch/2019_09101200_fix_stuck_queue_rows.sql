UPDATE maxdat.bpm_update_event_queue SET new_data =
APPENDCHILDXML(new_data,'ROWSET/ROW',XMLTYPE('<APPEAL_STAGE></APPEAL_STAGE>'))
WHERE new_data is not null and EXISTSNODE(new_data, '/ROWSET/ROW/APPEAL_STAGE') = 0;

UPDATE maxdat.bpm_update_event_queue SET old_data =
APPENDCHILDXML(old_data,'ROWSET/ROW',XMLTYPE('<APPEAL_STAGE></APPEAL_STAGE>'))
WHERE old_data is not null and EXISTSNODE(old_data, '/ROWSET/ROW/APPEAL_STAGE') = 0;

UPDATE maxdat.bpm_update_event_queue SET new_data =
APPENDCHILDXML(new_data,'ROWSET/ROW',XMLTYPE('<PREVIOUS_TASK_TYPE_ID></PREVIOUS_TASK_TYPE_ID>'))
WHERE new_data is not null and EXISTSNODE(new_data, '/ROWSET/ROW/PREVIOUS_TASK_TYPE_ID') = 0;

UPDATE maxdat.bpm_update_event_queue SET old_data =
APPENDCHILDXML(old_data,'ROWSET/ROW',XMLTYPE('<PREVIOUS_TASK_TYPE_ID></PREVIOUS_TASK_TYPE_ID>'))
WHERE old_data is not null and EXISTSNODE(old_data, '/ROWSET/ROW/PREVIOUS_TASK_TYPE_ID') = 0;

UPDATE maxdat.bpm_update_event_queue SET new_data =
APPENDCHILDXML(new_data,'ROWSET/ROW',XMLTYPE('<NON_STANDARD_WORK_FLAG></NON_STANDARD_WORK_FLAG>'))
WHERE new_data is not null and EXISTSNODE(new_data, '/ROWSET/ROW/NON_STANDARD_WORK_FLAG') = 0;

UPDATE maxdat.bpm_update_event_queue SET old_data =
APPENDCHILDXML(old_data,'ROWSET/ROW',XMLTYPE('<NON_STANDARD_WORK_FLAG></NON_STANDARD_WORK_FLAG>'))
WHERE old_data is not null and EXISTSNODE(old_data, '/ROWSET/ROW/NON_STANDARD_WORK_FLAG') = 0;

UPDATE maxdat.bpm_update_event_queue SET new_data =
APPENDCHILDXML(new_data,'ROWSET/ROW',XMLTYPE('<HANDLE_TIME></HANDLE_TIME>'))
WHERE new_data is not null and EXISTSNODE(new_data, '/ROWSET/ROW/HANDLE_TIME') = 0;

UPDATE maxdat.bpm_update_event_queue SET old_data =
APPENDCHILDXML(old_data,'ROWSET/ROW',XMLTYPE('<HANDLE_TIME></HANDLE_TIME>'))
WHERE old_data is not null and EXISTSNODE(old_data, '/ROWSET/ROW/HANDLE_TIME') = 0;

UPDATE maxdat.bpm_update_event_queue SET new_data =
UPDATEXML(new_data,
   '/ROWSET/ROW/TASK_TYPE_ID/text()',9286496)
   WHERE   new_data is not null and extractValue(new_data,'/ROWSET/ROW/TASK_TYPE_ID')= 92864969286944;
   
UPDATE maxdat.bpm_update_event_queue SET old_data =
UPDATEXML(old_data,
   '/ROWSET/ROW/TASK_TYPE_ID/text()',9286496)
   WHERE   old_data is not null and extractValue(old_data,'/ROWSET/ROW/TASK_TYPE_ID')= 92864969286944;   
   
UPDATE maxdat.bpm_update_event_queue SET new_data =
UPDATEXML(new_data,
   '/ROWSET/ROW/TASK_TYPE_ID/text()',9286497)
   WHERE new_data is not null and extractValue(new_data,'/ROWSET/ROW/TASK_TYPE_ID')= 92864979286944;   
   
UPDATE maxdat.bpm_update_event_queue SET old_data =
UPDATEXML(old_data,
   '/ROWSET/ROW/TASK_TYPE_ID/text()',9286497)
   WHERE old_data is not null and extractValue(old_data,'/ROWSET/ROW/TASK_TYPE_ID')= 92864979286944; 


UPDATE maxdat.bpm_update_event_queue SET new_data =
UPDATEXML(new_data,
   '/ROWSET/ROW/TASK_TYPE_ID/text()',40)
   WHERE new_data is not null and extractValue(new_data,'/ROWSET/ROW/TASK_TYPE_ID')= 401578;   
   
UPDATE maxdat.bpm_update_event_queue SET old_data =
UPDATEXML(old_data,
   '/ROWSET/ROW/TASK_TYPE_ID/text()',40)
   WHERE old_data is not null and extractValue(old_data,'/ROWSET/ROW/TASK_TYPE_ID')= 401578;   

commit;
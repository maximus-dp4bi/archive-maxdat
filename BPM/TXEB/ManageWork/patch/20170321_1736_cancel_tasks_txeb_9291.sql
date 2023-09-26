update corp_etl_manage_work
set cancel_work_flag = 'Y'
   ,complete_flag = 'N'
   ,complete_date = null
   ,cancel_work_date = to_date('03/20/2017 17:03:44','mm/dd/yyyy hh24:mi:ss')
   ,asf_cancel_work = 'Y'
   ,asf_complete_work = 'N'
   ,cancel_method = 'Normal'
   ,cancel_reason = 'TXEB-9291 task assigned incorrectly, work no longer required'
   ,cancel_by = 'TXEB-9291'
   ,task_status = 'INVALID'
where task_id = 279299406;  

commit;
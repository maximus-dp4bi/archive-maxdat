  update f_complaint_by_date
  set bucket_end_date = to_date('07/07/2077','mm/dd/yyyy'),dcmplac_id = 443691,dcmplia_id = 405
      ,dcmplid_id = 259551,dcmplir_id = 745,dcmplis_id = 285,last_update_date = incident_status_date
  where fcmplbd_id = 1391195;
      
  delete from f_complaint_by_date
  where fcmplbd_id = 1391296;

update f_complaint_by_date
set  creation_count = 1
where fcmplbd_id = 1433889;

delete from f_complaint_by_date
where fcmplbd_id = 1433800;

delete from f_complaint_by_date
where fcmplbd_id = 1444526;

update f_complaint_by_date
set creation_count = 1
where fcmplbd_id = 1444537;

  commit;
  
execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(22);


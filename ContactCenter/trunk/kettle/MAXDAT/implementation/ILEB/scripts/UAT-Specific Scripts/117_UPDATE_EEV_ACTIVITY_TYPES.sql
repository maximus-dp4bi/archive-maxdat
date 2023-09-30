
update 
  cc_c_activity_type
set 
  activity_type_category = 'Available'
  , is_paid_flag = 1
  , is_available_flag = 1
  , is_ready_flag = 1
  , is_absence_flag = 0
where activity_type_name in (
  'Spanish CSR'
  ,'Senior CSR Spanish'
  ,'Long Term Care- LTC'
  ,'English CSR'
  ,'Senior CSR English'
);

update 
  cc_d_activity_type
set 
  activity_type_category = 'Available'
  , is_paid_flag = 1
  , is_available_flag = 1
  , is_ready_flag = 1
  , is_absence_flag = 0
where activity_type_name in (
  'Spanish CSR'
  ,'Senior CSR Spanish'
  ,'Long Term Care- LTC'
  ,'English CSR'
  ,'Senior CSR English'
);


insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('0.3.1', 117, '117_UPDATE_EEV_ACTIVITY_TYPES');
commit;

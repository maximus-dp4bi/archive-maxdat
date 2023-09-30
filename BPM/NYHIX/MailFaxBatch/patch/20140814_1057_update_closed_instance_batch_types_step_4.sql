update d_mfb_current f set batch_type=
coalesce(( 
  select batch_type from TMP_MFB_UPD_C_JJH_20140827 wip
  where f.batch_guid = wip.batch_guid and ROWNUM = 1
),'Undetermined')
where f.instance_status='Complete';
commit;


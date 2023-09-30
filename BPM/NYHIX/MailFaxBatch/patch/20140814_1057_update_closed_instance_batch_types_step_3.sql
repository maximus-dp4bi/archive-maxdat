alter trigger "MAXDAT"."TRG_AI_CORP_ETL_MFB_BATCH_Q" disable;
alter trigger "MAXDAT"."TRG_AU_CORP_ETL_MFB_BATCH_Q" disable;
execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

CREATE INDEX BUEQA_LX1 ON BPM_UPDATE_EVENT_QUEUE_ARCHIVE (BSL_ID,IDENTIFIER) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

update corp_etl_mfb_batch f set batch_type=
coalesce(( 
  select batch_type from TMP_MFB_UPD_C_JJH_20140827 wip
  where f.batch_guid = wip.batch_guid and ROWNUM = 1
),'Undetermined')
where f.instance_status='Complete';
commit;

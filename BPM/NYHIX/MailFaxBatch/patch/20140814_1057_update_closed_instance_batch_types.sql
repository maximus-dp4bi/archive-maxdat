alter trigger "MAXDAT"."TRG_AI_CORP_ETL_MFB_BATCH_Q" disable;
alter trigger "MAXDAT"."TRG_AU_CORP_ETL_MFB_BATCH_Q" disable;
execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

CREATE INDEX BUEQA_LX1 ON BPM_UPDATE_EVENT_QUEUE_ARCHIVE (BSL_ID,IDENTIFIER) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

update corp_etl_mfb_batch f set batch_type=
coalesce(( 
select --batch_guid,--orig_batch_type,
  (case when atype=1 and rtype=0 and vtype=0 then 'Application Only'
   when atype=1 and (rtype=1 or vtype=1) then 'Application + Other Docs'
   when rtype=1 and atype=0 and vtype=0 then 'Renewal Only'
   when rtype=1 and (atype=1 or vtype=1) then 'Renewal + Other Docs'
   when vtype=1 then 'Other Docs Only'
   else 'Undetermined' end) batch_type
from(
  select batch_guid,
    orig_batch_type,
    batch_module_id,
    sum(rtype) rtype,
    sum(atype) atype,
    sum(vtype) vtype
  from(
  select wip.batch_guid,
    wip.orig_batch_type,
    wip.batch_module_id,
  case when doc_class_name like '%Renew#' then 1 else 0 end rtype,
  case when doc_class_name like '%Appl%' then 1 else 0 end atype,
  case when doc_class_name like '%Verification%' then 1 else 0 end vtype
  from(
  select bwip.batch_guid,bwip.batch_type orig_batch_type,
      max(wip.batch_module_id) batch_module_id
    from corp_etl_mfb_batch_events wip,
     corp_etl_mfb_batch bwip,
       (select batch_guid,max(module_end_dt) module_end_dt
       from corp_etl_mfb_batch_events
       group by batch_guid) curr_mod --batch guids and latest module end date
    where wip.batch_guid=curr_mod.batch_guid
      and wip.module_end_dt=curr_mod.module_end_dt 
      and bwip.batch_guid=wip.batch_guid
    group by bwip.batch_guid,bwip.batch_type
  ) wip,
   corp_etl_mfb_form fwip
  where wip.batch_module_id=fwip.batch_module_id
    and (fwip.doc_count > 0 and fwip.COMPLETED_DOCS > 0)
  ) wip
  group by batch_guid,
    orig_batch_type,
    batch_module_id
 ) wip
where wip.orig_batch_type<>(case when atype=1 and rtype=1 and vtype=0 then 'Application Only'
   when atype=1 and (rtype=1 or vtype=1) then 'Application + Other Docs'
   when rtype=1 and atype=0 and vtype=0 then 'Renewal Only'
   when rtype=1 and (atype=1 or vtype=1) then 'Renewal + Other Docs'
   when vtype=1 then 'Other Docs Only'
   else 'Undetermined' end)
and f.batch_guid = wip.batch_guid and ROWNUM = 1
),'Undetermined')
where f.instance_status='Complete';
commit;

update d_mfb_current f set batch_type=
( 
  select batch_type from corp_etl_mfb_batch wip
  where wip.instance_status='Complete'
  and f.batch_guid = wip.batch_guid and ROWNUM = 1
)
where f.instance_status='Complete';
commit;

update bpm_update_event_queue_archive qa set new_data=
updatexml(new_data,'/ROWSET/ROW/BATCH_TYPE/text()',(select dc.batch_type
  from d_mfb_current dc,bpm_update_event_queue_archive qa2
  where extractvalue(qa2.new_data,'/ROWSET/ROW/INSTANCE_STATUS')='Complete'
    and qa2.IDENTIFIER=dc.BATCH_GUID
    and qa2.bsl_id=16
    and qa.IDENTIFIER=dc.BATCH_GUID
    and qa.bueq_id=qa2.bueq_id
    and rownum=1
))
where extractvalue(qa.new_data,'/ROWSET/ROW/INSTANCE_STATUS')='Complete'
  and bsl_id=16;
commit;

drop INDEX BUEQA_LX1;

alter trigger "MAXDAT"."TRG_AI_CORP_ETL_MFB_BATCH_Q" enable;
alter trigger "MAXDAT"."TRG_AU_CORP_ETL_MFB_BATCH_Q" enable;
execute MAXDAT_ADMIN.STARTUP_JOBS;


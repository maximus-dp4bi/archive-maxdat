CREATE GLOBAL TEMPORARY TABLE CORP_ETL_MFB_batch_temp 
on commit preserve rows
as
select
  batch_guid, 
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
       from corp_etl_mfb_batch_events wip
       where wip.module_start_dt > to_date('2/16/2016','mm/dd/yyyy')
       group by batch_guid) curr_mod --batch guids and latest module end date
    where wip.batch_guid=curr_mod.batch_guid
      and wip.module_end_dt=curr_mod.module_end_dt
      and bwip.batch_guid=wip.batch_guid
      and wip.module_start_dt > to_date('2/16/2016','mm/dd/yyyy')
    group by bwip.batch_guid,bwip.batch_type
  ) wip,
   corp_etl_mfb_form fwip
  where wip.batch_module_id=fwip.batch_module_id
   and (fwip.doc_count > 0)
  ) wip
  group by batch_guid,
    orig_batch_type,
    batch_module_id
 ) wip
where wip.orig_batch_type<>(case when atype=1 and rtype=0 and vtype=0 then 'Application Only'
   when atype=1 and (rtype=1 or vtype=1) then 'Application + Other Docs'
   when rtype=1 and atype=0 and vtype=0 then 'Renewal Only'
   when rtype=1 and (atype=1 or vtype=1) then 'Renewal + Other Docs'
   when vtype=1 then 'Other Docs Only'
   else 'Undetermined' end)
;

update corp_etl_mfb_batch b
set batch_type = (select batch_type from corp_etl_mfb_batch_temp t where b.batch_guid = t.batch_guid)
where exists (select batch_type from corp_etl_mfb_batch_temp t where b.batch_guid = t.batch_guid)
;

update corp_etl_mfb_batch_stg b
set batch_type = (select batch_type from corp_etl_mfb_batch_temp t where b.batch_guid = t.batch_guid)
where exists (select batch_type from corp_etl_mfb_batch_temp t where b.batch_guid = t.batch_guid)
;

truncate table corp_etl_mfb_batch_temp;
drop table corp_etl_mfb_batch_temp;

commit;



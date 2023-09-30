create table TMP_MFB_UPD_A_JJH_20140827
(batch_guid varchar2(38) not null,
orig_batch_type varchar2(38) null,
batch_type varchar2(38) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

insert into TMP_MFB_UPD_A_JJH_20140827
select batch_guid,
  orig_batch_type,
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
       group by batch_guid) curr_mod --batch guids and latest module end date
    where wip.batch_guid=curr_mod.batch_guid
      and bwip.instance_status='Active'
      and wip.module_end_dt=curr_mod.module_end_dt 
      and bwip.batch_guid=wip.batch_guid
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
;

create table TMP_MFB_UPD_C_JJH_20140827
(batch_guid varchar2(38) not null,
orig_batch_type varchar2(38) null,
batch_type varchar2(38) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

insert into TMP_MFB_UPD_C_JJH_20140827
select batch_guid,
  orig_batch_type,
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
       group by batch_guid) curr_mod --batch guids and latest module end date
    where wip.batch_guid=curr_mod.batch_guid
      and bwip.instance_status='Complete'
      and wip.module_end_dt=curr_mod.module_end_dt 
      and bwip.batch_guid=wip.batch_guid
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
;


commit;

CREATE UNIQUE INDEX TMPMFBAJJH27_LX1 ON TMP_MFB_UPD_A_JJH_20140827 (batch_guid) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE UNIQUE INDEX TMPMFBCJJH27_LX1 ON TMP_MFB_UPD_C_JJH_20140827 (batch_guid) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);


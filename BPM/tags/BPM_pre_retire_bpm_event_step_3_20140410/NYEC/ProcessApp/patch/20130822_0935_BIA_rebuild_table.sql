-- MAXDAT-350 Drop Instance Attribute to rebuild data without PA's SLA records

create table BPM_INSTANCE_ATTR_TEMP as
select * from BPM_INSTANCE_ATTRIBUTE
 where BA_ID not in (67,68,131,132,135,140,416);

drop table BPM_INSTANCE_ATTRIBUTE;

-- NYECMXDP table definition
create table BPM_INSTANCE_ATTRIBUTE
(
  bia_id       NUMBER not null,
  bi_id        NUMBER not null,
  ba_id        NUMBER not null,
  value_number NUMBER,
  value_date   DATE,
  value_char   VARCHAR2(100),
  start_date   DATE not null,
  end_date     DATE,
  bue_id       NUMBER not null
)
partition by range (BA_ID)
interval(1)
  (partition PT_BIA_BA_LT_0 values less than (0))
tablespace MAXDAT_DATA parallel;


-- Temp table needed for 20130821_1545_restore_BPM_INSTANCE_ATTRIBUTE.sql
--drop table BPM_INSTANCE_ATTR_TEMP;

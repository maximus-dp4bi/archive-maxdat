ALTER TABLE d_mj_current
  ADD (RECORD_COUNT_MIN_THRESHOLD NUMBER, 
RECORD_COUNT_MAX_THRESHOLD NUMBER,
PER_ERR_ALERT NUMBER);



create or replace view D_MJ_CURRENT_SV as
select * from D_MJ_CURRENT 
with read only;
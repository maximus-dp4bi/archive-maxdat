alter table D_PL_CURRENT add (CHAR_SLA_DAYS varchar2(10));

update D_PL_CURRENT
set CHAR_SLA_DAYS = to_char(SLA_DAYS);

commit;

alter table D_PL_CURRENT modify (CHAR_SLA_DAYS varchar2(10) not null);

alter table D_PL_CURRENT drop column SLA_DAYS;

alter table D_PL_CURRENT rename column CHAR_SLA_DAYS to SLA_DAYS;

create or replace view D_PL_CURRENT_SV as
select * from D_PL_CURRENT
with read only;


update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  BSL_ID = 12
  and PROCESS_BUEQ_ID is not null;

commit;
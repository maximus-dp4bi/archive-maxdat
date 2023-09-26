create table STAFF_KEY_LKUP
(
staff_id  number,
staff_key varchar2(80)
);

create index staff_key_lkup_idx1 on STAFF_KEY_LKUP(staff_key) TABLESPACE MAXDAT_INDX;

create or replace public synonym STAFF_KEY_LKUP for STAFF_KEY_LKUP;
grant select on  STAFF_KEY_LKUP to MAXDAT_READ_ONLY;


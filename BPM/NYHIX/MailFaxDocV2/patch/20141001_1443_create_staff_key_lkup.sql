create table STAFF_KEY_LKUP
(
staff_id  number,
staff_key varchar2(80)
);
create or replace public synonym STAFF_KEY_LKUP for STAFF_KEY_LKUP;
grant select on  STAFF_KEY_LKUP to MAXDAT_READ_ONLY;

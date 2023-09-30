create index staff_key_lkup_idx1 on STAFF_KEY_LKUP(staff_key) TABLESPACE MAXDAT_INDX;

exec dbms_stats.gather_table_stats(ownname=>'MAXDAT', tabname=>'STAFF_KEY_LKUP', degree=>4,cascade=>true);
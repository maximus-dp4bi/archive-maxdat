UPDATE corp_etl_list_lkup
SET value = 'StarPlus Expansion Reminder Letter', end_date = to_date('07/07/7777','mm/dd/yyyy')
WHERE value = 'STAR+PLUS Manadatory Reminder letter'
and name like 'ProcLetters%';

COMMIT;

CREATE INDEX DPLCUR_CASELTR_IX1 ON D_PL_CURRENT(case_id, letter_type,letter_status) online tablespace MAXDAT_INDX parallel compute statistics;
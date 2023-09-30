------ NYHIX-44467 

ALTER TABLE maxdat.corp_etl_proc_letters          modify  REJECT_REASON VARCHAR2(256);
ALTER TABLE maxdat.corp_etl_proc_letters_oltp     modify  REJECT_REASON VARCHAR2(256);
ALTER TABLE maxdat.corp_etl_proc_letters_wip_bpm  modify  REJECT_REASON VARCHAR2(256);
ALTER TABLE maxdat.d_pl_current                   modify  REJECTION_REASON VARCHAR2(256);

commit;

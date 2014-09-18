alter table BPM_ATTRIBUTE add RETAIN_HISTORY_FLAG varchar2(1);
alter table BPM_ATTRIBUTE add constraint BA_RETAIN_HISTORY_FLAG_CK check (RETAIN_HISTORY_FLAG in ('Y','N'));
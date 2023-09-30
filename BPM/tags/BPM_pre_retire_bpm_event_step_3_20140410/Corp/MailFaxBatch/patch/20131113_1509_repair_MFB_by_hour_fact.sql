alter table F_MFB_BY_HOUR rename partition PT_BUCKET_START_DATE_LT_20123 to PT_BUCKET_START_DATE_LT_2013;

create or replace public synonym BPM_D_DATE_HOUR_SV for BPM_D_DATE_HOUR_SV;

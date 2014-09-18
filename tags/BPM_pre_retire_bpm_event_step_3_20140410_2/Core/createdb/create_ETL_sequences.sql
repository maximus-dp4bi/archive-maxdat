-- Create ETL sequences.

create sequence CELL_HISTORY_SEQ;

create sequence SEQ_CEC;
grant select on SEQ_CEC to MAXDAT_READ_ONLY; 

create sequence SEQ_CECT_ID;

create sequence SEQ_CECT_HS_ID;

create sequence SEQ_CEEL_ID;

create sequence SEQ_CELL_ID;
grant select on SEQ_CELL_ID to MAXDAT_READ_ONLY; 

create sequence SEQ_CICT_ID;

create sequence SEQ_HOLIDAY_ID;
grant select on SEQ_HOLIDAY_ID to MAXDAT_READ_ONLY; 

create sequence SEQ_JOB_ID;

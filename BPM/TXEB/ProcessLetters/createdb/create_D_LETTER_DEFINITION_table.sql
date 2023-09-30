CREATE TABLE D_LETTER_DEFINITION
(lmdef_id   NUMBER(18,0)
 ,letter_name VARCHAR2(40)
 ,letter_type  VARCHAR2(4000)
 ,request_driver_type  VARCHAR2(32)
 ,letter_program  VARCHAR2(128)      
 ,effective_from_date DATE
 ,effective_thru_date DATE
 ,letter_frequency VARCHAR2(40)
 ,dupe_cnt_trigger NUMBER(18,0)
 ,no_dupes_days NUMBER(18,0)
 ,letter_min_sent_per_day NUMBER(18,0)
 ,letter_max_sent_per_day NUMBER(18,0)
 ,min_alert_threshold NUMBER(18,0)
 ,max_alert_threshold NUMBER(18,0)
 ,max_NCOA_threshold  NUMBER(18,0)
 ,max_ACS_threshold  NUMBER(18,0)
 ,max_mailhouse_threshold  NUMBER(18,0)
 ,mailhouse_program VARCHAR2(128)
) TABLESPACE MAXDAT_DATA;


GRANT SELECT ON D_LETTER_DEFINITION TO MAXDAT_READ_ONLY;

alter table D_LETTER_DEFINITION add constraint D_LETTER_DEFINITION_PK primary key (LMDEF_ID) using index tablespace MAXDAT_INDX;

create or replace view D_LETTER_DEFINITION_SV as
select * 
from D_LETTER_DEFINITION
with read only;


grant select on D_LETTER_DEFINITION_SV to MAXDAT_READ_ONLY;
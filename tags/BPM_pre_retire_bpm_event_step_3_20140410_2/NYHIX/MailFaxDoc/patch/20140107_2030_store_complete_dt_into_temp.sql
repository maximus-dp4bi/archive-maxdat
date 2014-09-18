Create table MFD_COMPLETE_DT_TMP 
(
 DCN varchar2(256) NOT NULL,
 COMPLETE_DT date
)TABLESPACE MAXDAT_DATA PARALLEL;

create or replace public synonym MFD_COMPLETE_DT_TMP for MFD_DOC_COMPLETE_DT_TMP;

Grant select on MFD_COMPLETE_DT_TMP to MAXDAT_READ_ONLY;


create unique index  NYHIX_MFD_TEMP_IX1 on  MFD_COMPLETE_DT_TMP (DCN)  tablespace MAXDAT_INDX;

insert into MFD_COMPLETE_DT_TMP 
select DCN,DOC_COMPLETE_DT
from NYHIX_ETL_MAIL_FAX_DOC
where DOC_COMPLETE_DT is not null;

commit;
/*
v1 Created on 26-Feb-2014 by Raj A.
---------------------------------------------------
v2 Update on 06-Mar-2014 by Raj A.
Description:
Fee_paid_flag attribute was added in the script, 20140226_0930_MEA_add_subprogram.sql but per MAXDTDEV FEE_PAID_FLG already existed and should have 
been BAL_ID = 1266. So changed to 1266 now.
Deleting previously added BAL_ID, BA_ID & BAST_ID.
---------------------------------------------------
*/
alter table CORP_ETL_MANAGE_ENROLL add SUBPROGRAM_TYPE varchar2(32);
alter table CORP_ETL_MANAGE_ENROLL_OLTP add SUBPROGRAM_TYPE varchar2(32);
alter table CORP_ETL_MANAGE_ENROLL_WIP add SUBPROGRAM_TYPE varchar2(32);

alter table CORP_ETL_MANAGE_ENROLL add FEE_PAID_FLG varchar2(1);
alter table CORP_ETL_MANAGE_ENROLL_OLTP add FEE_PAID_FLG varchar2(1);
alter table CORP_ETL_MANAGE_ENROLL_WIP add FEE_PAID_FLG varchar2(1);

alter table D_ME_CURRENT add SUBPROGRAM_TYPE varchar2(32);
alter table D_ME_CURRENT add FEE_PAID_FLG varchar2(1);

create or replace public synonym D_ME_CURRENT_SV for D_ME_CURRENT_SV;
grant select on D_ME_CURRENT_SV to MAXDAT_READ_ONLY;

begin
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(807,2,'Subprogram Type','The Subprogram associated with the Case associated with the Outreach Request.');
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1266,2,'Fee Paid Flag','Indicates if the fee payment has been successfully recorded in the source system.');

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2182,807,14,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2181,1266,14,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2182,14,'SUBPROGRAM_TYPE');
Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2181,14,'FEE_PAID_FLG');

commit;

end;
/
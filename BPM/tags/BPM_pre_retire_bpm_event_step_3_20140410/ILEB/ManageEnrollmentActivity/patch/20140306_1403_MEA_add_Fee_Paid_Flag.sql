/*
Created on 06-Mar-2014 by Raj A.
Description:
Fee_paid_flag attribute was added in the script, 20140226_0930_MEA_add_subprogram.sql but per MAXDTDEV FEE_PAID_FLG already existed and should have 
been BAL_ID = 1266. So changed to 1266 now.
Deleting previously added BAL_ID, BA_ID & BAST_ID.
*/
delete BPM_ATTRIBUTE_STAGING_TABLE where ba_id = 2183;

delete BPM_ATTRIBUTE where bal_id = 808;

delete bpm_attribute_lkup where bal_id = 808;
commit;

begin
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1266,2,'Fee Paid Flag','Indicates if the fee payment has been successfully recorded in the source system.');

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2181,1266,14,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2181,14,'FEE_PAID_FLG');
commit;
end;
/
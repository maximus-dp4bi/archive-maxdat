/* Soundra 12/20/2016 for MAXDAT_pa@coeemx
List of AMP Export Projects and their available sources. All projects need ACD, Additional non-mandatory sources are configured.
*/
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD','PA EAP','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP STAR+PLUS Re-enrollment Letter','Dual Eligibility Letter','MMP12',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Unauthorized Disenrollment Request Letter','Dual Eligibility Letter','MMP13',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Loss of Medicare Eligibility Letter','Dual Eligibility Letter','MMP14',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);

commit;
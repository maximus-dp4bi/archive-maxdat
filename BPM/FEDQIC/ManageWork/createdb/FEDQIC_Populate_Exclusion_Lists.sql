delete maxdat.corp_etl_list_lkup where list_type in ('QIC_EXCLUDE','QIC_INCLUDE_ONLY');
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cell_id.nextval,'AppealIDIncludeOnlyList','QIC_INCLUDE_ONLY','IncludeOnlyIDList1',null,null,null,
trunc(sysdate-1),to_date('07077777','mmddyyyy'),
'Used in Load_Maxdat_Stg.kjb to limit inclusion of records when loading fedqic_maxdat_stg table from source',
sysdate,sysdate);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cell_id.nextval,'AppealPartIncludeOnlyList','QIC_INCLUDE_ONLY','IncludeOnlyPartList1',1579,null,null,
trunc(sysdate-1),to_date('07077777','mmddyyyy'),
'Used in Load_Maxdat_Stg.kjb to limit inclusion of records when loading fedqic_maxdat_stg table from source',
sysdate,sysdate);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cell_id.nextval,'AppealIDExcludeList','QIC_EXCLUDE','ExcludeIDList1',null,null,null,
trunc(sysdate-1),to_date('07077777','mmddyyyy'),
'Used in Load_Maxdat_Stg.kjb to exclude records when loading fedqic_maxdat_stg table from source',
sysdate,sysdate);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cell_id.nextval,'AppealPartExcludeList','QIC_EXCLUDE','ExcludePartList1',null,null,null,
trunc(sysdate-1),to_date('07077777','mmddyyyy'),
'Used in Load_Maxdat_Stg.kjb to exclude records when loading fedqic_maxdat_stg table from source',
sysdate,sysdate);
commit;
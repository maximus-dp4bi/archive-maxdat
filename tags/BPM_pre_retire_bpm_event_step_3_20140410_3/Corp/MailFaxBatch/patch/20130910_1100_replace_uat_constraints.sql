declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BATCH_STG_BATCH_TYPE';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH_STG drop constraint CHECK_MFB_BATCH_STG_BATCH_TYPE';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BS_BATCH_CLASS';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH_STG drop constraint CHECK_MFB_BS_BATCH_CLASS';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BS_BATCH_TYPE';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH_STG drop constraint CHECK_MFB_BS_BATCH_TYPE';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BATCH_WIP_BATCH_TYPE';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH_WIP drop constraint CHECK_MFB_BATCH_WIP_BATCH_TYPE';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BATCH_BATCH_CLASS';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH drop constraint CHECK_MFB_BATCH_BATCH_CLASS';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BATCH_BATCH_TYPE';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH drop constraint CHECK_MFB_BATCH_BATCH_TYPE';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_FS_FORM_TYPE_NM';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_FORM_STG drop constraint CHECK_MFB_FS_FORM_TYPE_NM';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_FS_DOC_CLASS_NM';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_FORM_STG drop constraint CHECK_MFB_FS_DOC_CLASS_NM';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_F_FORM_TYPE_NM';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_FORM drop constraint CHECK_MFB_F_FORM_TYPE_NM';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_F_DOC_CLASS_NM';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_FORM drop constraint CHECK_MFB_F_DOC_CLASS_NM';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_DS_DOC_TYPE_NM';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_DOCUMENT_STG drop constraint CHECK_MFB_DS_DOC_TYPE_NM';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_DS_DOC_CLASS';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_DOCUMENT_STG drop constraint CHECK_MFB_DS_DOC_CLASS';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_D_DOC_TYPE_NM';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_DOCUMENT drop constraint CHECK_MFB_D_DOC_TYPE_NM';
   end if;
end;
/
declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_D_DOC_CLASS';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_DOCUMENT drop constraint CHECK_MFB_D_DOC_CLASS';
   end if;
end;
/
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_BATCH_CLASS check (BATCH_CLASS in('SHOP Application SIT','NYHIXINT - Individual Apps'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_BATCH_CLASS check (BATCH_CLASS in('SHOP Application SIT','NYHIXINT - Individual Apps'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_INSTANCE_STATUS check (INSTANCE_STATUS in('Active','Complete'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_BATCH_PRIORITY check (BATCH_PRIORITY in(0,1,2,3,4,5,6,7,8,9,10));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_BATCH_DELETED check (BATCH_DELETED in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_PAGES_SCAN_F check (PAGES_SCANNED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_DOCS_CREATED_F check (DOCS_CREATED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_DOCS_DEL_F check (DOCS_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_PAGES_REPL_F check (PAGES_REPLACED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_PAGES_DEL_F check (PAGES_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_SCAN_BATCH check (ASF_SCAN_BATCH in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_PERFORM_QC check (ASF_PERFORM_QC in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_CLASS check (ASF_CLASSIFICATION in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_REC check (ASF_RECOGNITION in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_VAL_DATA check (ASF_VALIDATE_DATA in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_CREATE_PDF check (ASF_CREATE_PDF in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_POP_REPORTS check (ASF_POPULATE_REPORTS in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_REL_DMS check (ASF_RELEASE_DMS in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_BATCH_CLASS check (BATCH_CLASS in('SHOP Application SIT','NYHIXINT - Individual Apps'));

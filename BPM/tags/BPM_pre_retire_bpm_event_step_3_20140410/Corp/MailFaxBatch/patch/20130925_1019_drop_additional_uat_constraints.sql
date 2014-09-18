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
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BATCH_BATCH_CLASS';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH drop constraint CHECK_MFB_BATCH_BATCH_CLASS';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_B_BATCH_CLASS';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH drop constraint CHECK_MFB_B_BATCH_CLASS';
   end if;
end;
/


declare  c int;
begin
   select count(*) into c from user_constraints where constraint_name ='CHECK_MFB_BW_BATCH_CLASS';
   if c = 1 then
      execute immediate 'alter table CORP_ETL_MFB_BATCH_WIP drop constraint CHECK_MFB_BW_BATCH_CLASS';
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

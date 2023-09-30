column tablespacename new_value tablespace_name noprint 
select 'MAXDAT_MIEB_DATA' tablespacename from dual;
column role_name new_value role_name noprint
select 'MAXDAT_MIEB_READ_ONLY' role_name from dual;
@@D_PROJECT.sql
@@D_PROGRAM.sql
@@D_SUBPROGRAM.sql
@@D_SUBPROGRAM_CON_XWALK.sql
@@D_LETTER_LOOKUP_TABLES.sql
@@D_LETTER_ADJUST_REASON.sql
@@D_LETTER_TYPE_SV.sql
@@LETTER_ADJUSTMENT_FORM.sql
@@create_letter_adjust_form_procs.sql
@@insert_lookup_tables_project.sql
@@insert_lookup_tables.sql
@@insert_lookup_tables_2.sql
@@001_CREATE_TABLE_D_LETTER_REQUEST.sql
@@001_CREATE_TABLE_D_LETTER_REQUEST_LINK.sql
@@001_CREATE_TABLE_ERRLOG_LETTER .sql
@@001_CREATE_TABLE_ERRLOG_LTRLINK.sql
@@001_CREATE_TABLE_ETL_L_MAILHOUSE.sql
@@001_CREATE_TABLE_S_LETTER_LINK_STG.sql
@@001_CREATE_TABLE_S_LETTER_REQUEST_STG.sql
@@001_INSERT_TABLE_D_LETTER_SOURCE.sql
@@001_ALTER_TABLE_D_LETTER_DEFINITION.sql
@@001_ALTER_TABLE_D_LETTER_REJECT_REASON.sql
@@001_ALTER_TABLE_D_LETTER_STATUS.sql
@@001_ALTER_TABLE_LETTER_ADJUSTMENT_FORM.sql
@@F_LETTER_REQUEST_DETAILS_SV.sql
@@F_LETTER_COUNTS_BY_DAY_SV.sql
@@MIEB_LETTERS_ETL_PKG.sql
@@get_filename_from_path.sql
@@try_parse_date.sql
@@002_CREATE_TABLE_ETL_L_MAILHOUSE.sql
@@002_INS_CORP_ETL_CONTROL.sql
@@CREATE_LOAD_EYR_FILES_REQ.sql
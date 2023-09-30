--------------------------------------------------------
--  Deploy LAEB tables 
--------------------------------------------------------
column tablespacen new_value tablespace_name noprint 
select 'MAXDAT_LAEB_DATA' tablespacen from dual;
column role_nm new_value role_name noprint
select 'MAXDAT_LAEB_READ_ONLY' role_nm from dual;
@@D_LETTER_LOOKUP_TABLES.sql
@@D_LETTER_REQUEST.sql
@@D_MVX_XWALK.sql
@@D_STAFF.sql
@@D_CALL_RECORD.sql
@@D_PI_AFFECTED_PARTY_TYPE.sql
@@D_PI_AFFECTED_PARTY_SUBTYPE.sql
@@D_PI_INCIDENT_ORIGIN.sql
@@D_PI_INCIDENT_STATUS.sql
@@D_INCIDENT_HEADER.sql
@@Create_LAEB_413_REPORT_OE_ELIG.sql
@@LAEB_DemographicsReport_Data_SV.sql
@@LAEB_CRM_ETL_PKG.sql
@@LAEB_LETTERS_ETL_PKG.sql
@@populate_corp_etl_control_callsvar.sql
@@populate_corp_etl_control_lettersvar.sql
@@ins_pi_lookup_tables.sql
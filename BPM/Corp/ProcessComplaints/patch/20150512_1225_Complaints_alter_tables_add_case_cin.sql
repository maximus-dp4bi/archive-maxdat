Alter table CORP_ETL_COMPLAINTS_INCIDENTS add  (CASE_CIN VARCHAR2(30));

Alter table CORP_ETL_COMPL_INCIDENTS_OLTP add  (CASE_CIN VARCHAR2(30));

Alter table CORP_ETL_COMPL_INCIDN_WIP_BPM add  (CASE_CIN VARCHAR2(30));

Alter table D_COMPLAINT_CURRENT add (CASE_CIN VARCHAR2(30));
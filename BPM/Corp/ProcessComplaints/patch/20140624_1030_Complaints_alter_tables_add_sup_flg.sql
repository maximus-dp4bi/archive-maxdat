
Alter table CORP_ETL_COMPLAINTS_INCIDENTS add  (CREATED_BY_SUP         VARCHAR2(1),
                                                GWF_ESCALATE_TO_STATE  VARCHAR2(1),
                                                CREATED_BY_EID         VARCHAR2(80),
                                                CREATED_BY_SUP_NAME    VARCHAR2(100));

Alter table CORP_ETL_COMPL_INCIDENTS_OLTP add  (CREATED_BY_SUP          VARCHAR2(1),
                                                GWF_ESCALATE_TO_STATE   VARCHAR2(1),
                                                CREATED_BY_EID          VARCHAR2(80),
                                                CREATED_BY_SUP_NAME     VARCHAR2(100));

Alter table CORP_ETL_COMPL_INCIDN_WIP_BPM add  (CREATED_BY_SUP          VARCHAR2(1),
                                                GWF_ESCALATE_TO_STATE   VARCHAR2(1),
                                                CREATED_BY_EID          VARCHAR2(80),
                                                CREATED_BY_SUP_NAME     VARCHAR2(100));

Alter table D_COMPLAINT_CURRENT add ( CREATED_BY_SUP          VARCHAR2(1),
                                      GWF_ESCALATE_TO_STATE   VARCHAR2(1),
                                      CREATED_BY_EID          VARCHAR2(80),
                                      CREATED_BY_SUP_NAME     VARCHAR2(100));

create or replace view D_COMPLAINT_CURRENT_SV as
select * from D_COMPLAINT_CURRENT
with read only;



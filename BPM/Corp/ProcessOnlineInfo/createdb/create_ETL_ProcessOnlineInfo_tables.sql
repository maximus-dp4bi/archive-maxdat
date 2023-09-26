CREATE TABLE MAXDAT.CORP_ETL_PROCESS_ONLINE_INFO
(                                               
CEPOI_ID                   NUMBER      ,       
TRANSACTION_ID              NUMBER  ,       
TRANSACTION_TYPE            VARCHAR2(50),       
CREATE_DT                   DATE        ,       
CREATE_BY                   VARCHAR2(80),       
CLIENT_ID                   NUMBER  ,       
CASE_ID                     NUMBER  ,       
WORK_REQUIRED_FLAG          VARCHAR2(1) ,       
INSTANCE_STATUS             VARCHAR2(10),       
SOURCE_RECORD_TYPE          VARCHAR2(50),       
SOURCE_RECORD_ID            NUMBER  ,       
LAST_UPDATED_DT             DATE        ,       
LAST_UPDATED_BY             VARCHAR2(80),       
LANGUAGE                    VARCHAR2(2) ,       
ASSD_PROCESS_NEW_INFO       DATE        ,       
ASED_PROCESS_NEW_INFO       DATE        ,       
ASF_PROCESS_NEW_INFO        VARCHAR2(1) DEFAULT 'N',       
ASSD_CREATE_ROUTE_WORK      DATE        ,       
ASED_CREATE_ROUTE_WORK      DATE        ,       
ASF_CREATE_ROUTE_WORK       VARCHAR2(1) DEFAULT 'N',     
GWF_WORK_IDENTIFIED         VARCHAR2(1) ,       
CANCEL_REASON               VARCHAR2(50),       
CANCEL_METHOD               VARCHAR2(32),       
CANCEL_BY                   VARCHAR2(80),       
CANCEL_DT                   DATE        ,       
COMPLETE_DT               DATE        ,       
STG_EXTRACT_DATE            DATE        ,       
STG_LAST_UPDATE_DATE        DATE        ,       
STAGE_DONE_DATE             DATE    ,
CONSTRAINT CORP_ETL_PROCESS_ONLINE_I_PK PRIMARY KEY (TRANSACTION_ID)
)TABLESPACE MAXDAT_DATA ;                       

create index CEPOI_IX1 on CORP_ETL_PROCESS_ONLINE_INFO (CEPOI_ID) online tablespace MAXDAT_INDX parallel compute statistics;
  
Grant select on CORP_ETL_PROCESS_ONLINE_INFO to MAXDAT_READ_ONLY;


CREATE TABLE MAXDAT.CORP_ETL_PROC_ONLINE_INFO_OLTP
(                                               
CEPOI_ID                   NUMBER      ,       
TRANSACTION_ID              NUMBER  ,       
TRANSACTION_TYPE            VARCHAR2(50),       
CREATE_DT                   DATE        ,       
CREATE_BY                   VARCHAR2(80),       
CLIENT_ID                   NUMBER  ,       
CASE_ID                     NUMBER  ,       
WORK_REQUIRED_FLAG          VARCHAR2(1) ,       
INSTANCE_STATUS             VARCHAR2(10),       
SOURCE_RECORD_TYPE          VARCHAR2(50),       
SOURCE_RECORD_ID            NUMBER  ,       
LAST_UPDATED_DT             DATE        ,       
LAST_UPDATED_BY             VARCHAR2(80),       
LANGUAGE                    VARCHAR2(2) ,       
ASSD_PROCESS_NEW_INFO       DATE        ,       
ASED_PROCESS_NEW_INFO       DATE        ,       
ASF_PROCESS_NEW_INFO        VARCHAR2(1) ,       
ASSD_CREATE_ROUTE_WORK      DATE        ,       
ASED_CREATE_ROUTE_WORK      DATE        ,       
ASF_CREATE_ROUTE_WORK       VARCHAR2(1) ,       
GWF_WORK_IDENTIFIED         VARCHAR2(1) ,       
CANCEL_REASON               VARCHAR2(50),       
CANCEL_METHOD               VARCHAR2(32),       
CANCEL_BY                   VARCHAR2(80),       
CANCEL_DT                   DATE        ,       
COMPLETE_DT               DATE        ,       
STG_EXTRACT_DATE            DATE        ,       
STG_LAST_UPDATE_DATE        DATE        ,       
STAGE_DONE_DATE             DATE    ,
CONSTRAINT CORP_ETL_PROC_ONLINE_OLTP_PK PRIMARY KEY (TRANSACTION_ID)
)TABLESPACE MAXDAT_DATA ;        

create index CEPOIOL_IX1 on CORP_ETL_PROC_ONLINE_INFO_OLTP (CEPOI_ID) online tablespace MAXDAT_INDX parallel compute statistics;

grant select on CORP_ETL_PROC_ONLINE_INFO_OLTP to MAXDAT_READ_ONLY;


CREATE TABLE MAXDAT.CORP_ETL_PROC_ONLINE_INFO_WIP
(                                               
CEPOI_ID                   NUMBER      ,       
TRANSACTION_ID              NUMBER  ,       
TRANSACTION_TYPE            VARCHAR2(50),       
CREATE_DT                   DATE        ,       
CREATE_BY                   VARCHAR2(80),       
CLIENT_ID                   NUMBER  ,       
CASE_ID                     NUMBER ,       
WORK_REQUIRED_FLAG          VARCHAR2(1) ,       
INSTANCE_STATUS             VARCHAR2(10),       
SOURCE_RECORD_TYPE          VARCHAR2(50),       
SOURCE_RECORD_ID            NUMBER ,       
LAST_UPDATED_DT             DATE        ,       
LAST_UPDATED_BY             VARCHAR2(80),       
LANGUAGE                    VARCHAR2(2) ,       
ASSD_PROCESS_NEW_INFO       DATE        ,       
ASED_PROCESS_NEW_INFO       DATE        ,       
ASF_PROCESS_NEW_INFO        VARCHAR2(1) ,       
ASSD_CREATE_ROUTE_WORK      DATE        ,       
ASED_CREATE_ROUTE_WORK      DATE        ,       
ASF_CREATE_ROUTE_WORK       VARCHAR2(1) ,       
GWF_WORK_IDENTIFIED         VARCHAR2(1) ,       
CANCEL_REASON               VARCHAR2(50),       
CANCEL_METHOD               VARCHAR2(32),       
CANCEL_BY                   VARCHAR2(80),       
CANCEL_DT                   DATE        ,       
COMPLETE_DT               DATE        ,       
STG_EXTRACT_DATE            DATE        ,       
STG_LAST_UPDATE_DATE        DATE        ,       
STAGE_DONE_DATE             DATE    ,
UPDATED VARCHAR2(20 BYTE),
CONSTRAINT CORP_ETL_PROC_ONLINE_WIP_PK PRIMARY KEY (TRANSACTION_ID)
)TABLESPACE MAXDAT_DATA ; 

create index CEPOIWI_IX1 on CORP_ETL_PROC_ONLINE_INFO_WIP (CEPOI_ID) online tablespace MAXDAT_INDX parallel compute statistics;

grant select on CORP_ETL_PROC_ONLINE_INFO_WIP to MAXDAT_READ_ONLY;

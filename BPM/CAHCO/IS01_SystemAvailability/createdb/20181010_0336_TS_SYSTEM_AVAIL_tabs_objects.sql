CREATE TABLE TS_SYSTEM_AVAILABILITY
   (
     
SYSTEM_AVAIL_ID	Integer,
SYSTEM_TYPE     VARCHAR2(100 BYTE),
SYSTEM_NAME	VARCHAR2(250 BYTE),
REPORTING_MONTH	Date,
REQD_AVAIL_MINS	Integer,
SCHD_DOWN_MINS	Integer,
SYSTEM_UPTIME_MINS	Integer,
SYSTEM_AVAIL_MINS	Integer,
ALWD_UNSCHD_DOWN_PERWK_MINS	Integer,
UNSCHD_DOWN_MINS	Integer,
REQUIREMENT_MET	Varchar2(3 BYTE),
CREATE_BY	Varchar2(10 BYTE),
CREATE_DATE	Date,
LAST_UPDATE_BY	Varchar2(10 BYTE),
LAST_UPDATE_DATE	Date,
    CONSTRAINT
 	     pk_system_availabilty
    PRIMARY KEY (SYSTEM_AVAIL_ID)
  ) TABLESPACE MAXDAT_DATA;


CREATE OR REPLACE VIEW TS_SYSTEM_AVAILABILITY_SV AS
select
SYSTEM_AVAIL_ID,
SYSTEM_TYPE,
SYSTEM_NAME,
REPORTING_MONTH,
REQD_AVAIL_MINS,
SCHD_DOWN_MINS,
SYSTEM_UPTIME_MINS,
SYSTEM_AVAIL_MINS,
ALWD_UNSCHD_DOWN_PERWK_MINS,
UNSCHD_DOWN_MINS,
REQUIREMENT_MET,
CREATE_BY,
CREATE_DATE
LAST_UPDATE_BY,
LAST_UPDATE_DATE
  from TS_SYSTEM_AVAILABILITY;

CREATE TABLE TS_GENERAL_COMMENTS
    (
    GENERAL_COMMENTS_ID				 INTEGER,
    REPORT_DATE DATE,
    SYSTEM_TYPE     VARCHAR2(100 BYTE),
    GEN_COMMENTS varchar2(512 BYTE),
    AVAIL_REQ_COMMENTS varchar2(512 BYTE),
    AVAIL_TIME_COMMENTS varchar2(512 BYTE), 
    SCHED_DOWNTIME_COMMENTS varchar2(512 BYTE),
    UNSCHED_DOWNTIME_COMMENTS varchar2(512 BYTE),
    TOT_DOWNTIME_DUR  INTEGER,
    DOWNTIME_ROOT_CAUSE varchar2(512 BYTE),
    RESOLUTION_MIT_STRTGY varchar2(512 BYTE),
    CREATE_BY					 VARCHAR2(50 BYTE),
    CREATE_DATE				 DATE,
    LAST_UPDATE_BY				 VARCHAR2(50 BYTE),
    LAST_UPDATE_DATE				 DATE,
    CONSTRAINT
   	   pk_GENERAL_COMMENTS_id
   PRIMARY KEY (GENERAL_COMMENTS_ID)
   )TABLESPACE MAXDAT_DATA;

CREATE OR REPLACE VIEW TS_GENERAL_COMMENTS_SV AS
    select
    GENERAL_COMMENTS_ID,
    REPORT_DATE,
    SYSTEM_TYPE,
    GEN_COMMENTS,
    AVAIL_REQ_COMMENTS,
    AVAIL_TIME_COMMENTS,
    SCHED_DOWNTIME_COMMENTS,
    UNSCHED_DOWNTIME_COMMENTS,
    TOT_DOWNTIME_DUR,
    DOWNTIME_ROOT_CAUSE,
    RESOLUTION_MIT_STRTGY,
    CREATE_BY,
    CREATE_DATE
    LAST_UPDATE_BY,
    LAST_UPDATE_DATE
    from TS_GENERAL_COMMENTS;


/*Grant privileges to Sequence*/
CREATE SEQUENCE  "SEQ_SYSTEM_AVAIL_ID"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 265 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
Grant SELECT ON  SEQ_SYSTEM_AVAIL_ID TO MAXDAT_MSTR_TRX_RPT;
CREATE SEQUENCE  "SEQ_GENERAL_COMMENTS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
GRANT SELECT ON "SEQ_GENERAL_COMMENTS_ID" TO "MAXDAT_READ_ONLY";


/*Grants - to allow MSTR Transactions to perform U,D,I*/
GRANT select on TS_SYSTEM_AVAILABILITY_SV to MAXDAT_READ_ONLY; 
GRANT insert, update ON TS_SYSTEM_AVAILABILITY TO MAXDAT_MSTR_TRX_RPT;
GRANT execute ON TS_SYSTEM_AVAILABILITY_INSERT TO MAXDAT_MSTR_TRX_RPT;
GRANT execute ON TS_SYSTEM_AVAILABILITY_UPDATE TO MAXDAT_MSTR_TRX_RPT;
GRANT select on MAXDAT.TS_GENERAL_COMMENTS_SV to MAXDAT_READ_ONLY;
GRANT insert, update ON MAXDAT.TS_GENERAL_COMMENTS TO MAXDAT_MSTR_TRX_RPT;
GRANT execute ON MAXDAT.TS_GENERAL_COMMENTS_INSERT TO MAXDAT_MSTR_TRX_RPT;
GRANT execute ON MAXDAT.TS_GENERAL_COMMENTS_UPDATE TO MAXDAT_MSTR_TRX_RPT;



/*Create individual indexes on columns of TS_SYSTEM_AVAILABILITY below*/

CREATE INDEX IN_SYSTEM_TYPE ON TS_SYSTEM_AVAILABILITY
(SYSTEM_TYPE) TABLESPACE MAXDAT_INDX;

CREATE INDEX IN_SYSTEM_NAME ON TS_SYSTEM_AVAILABILITY
(SYSTEM_NAME) TABLESPACE MAXDAT_INDX;

/
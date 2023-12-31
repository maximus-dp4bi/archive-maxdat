CREATE TABLE TS_NETWORK_USAGE
    (
    NETWORK_USAGE_ID				 INTEGER,
    NETWORK_LANGUAGE				 VARCHAR2(100 BYTE),
    NETWORK_USAGE_DATETIME			 DATE,
    NETWORK_USAGE_VOLUME			 NUMBER(38,2),
    CREATE_BY					 VARCHAR2(50 BYTE),
    CREATE_DATE				 DATE,
    LAST_UPDATE_BY				 VARCHAR2(50 BYTE),
    LAST_UPDATE_DATE				 DATE,
    CONSTRAINT
   	   pk_NETWORK_usage_id
   PRIMARY KEY (NETWORK_USAGE_ID)
   )TABLESPACE MAXDAT_DATA;

CREATE OR REPLACE VIEW TS_NETWORK_USAGE_SV AS
    select
    NETWORK_USAGE_ID,
    NETWORK_USAGE_DATETIME,
    NETWORK_USAGE_VOLUME,
    CREATE_BY,
    CREATE_DATE
    LAST_UPDATE_BY,
    LAST_UPDATE_DATE
    from TS_NETWORK_USAGE;

/*Grant privileges to Sequence*/
CREATE SEQUENCE  "SEQ_NETWORK_USAGE_ID"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 265 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
Grant SELECT ON  SEQ_NETWORK_USAGE_ID TO MAXDAT_MSTR_TRX_RPT;

/*Grants - to allow MSTR Transactions to perform U,D,I*/
GRANT select on TS_NETWORK_USAGE_SV to MAXDAT_READ_ONLY;
GRANT insert, update ON TS_NETWORK_USAGE TO MAXDAT_MSTR_TRX_RPT;




CREATE OR REPLACE Procedure TS_NETWORK_USAGE_INSERT
    (
    IN_NETWORK_USAGE_DATETIME	      IN DATE,
    IN_NETWORK_USAGE_VOLUME  IN NUMBER,
    IN_STAFF_ID      IN VARCHAR2
   )
    
AS

BEGIN
 If  IN_NETWORK_USAGE_DATETIME is null  or IN_STAFF_ID is null or trunc(IN_NETWORK_USAGE_DATETIME) > trunc(sysdate) then
     /*do nothing*/
      null;
   else
      
      insert into TS_NETWORK_USAGE
(
   NETWORK_USAGE_ID,
   NETWORK_USAGE_DATETIME,
   NETWORK_USAGE_VOLUME,
   CREATE_BY,
   CREATE_DATE,
   LAST_UPDATE_BY,
   LAST_UPDATE_DATE
)
      values
(
SEQ_NETWORK_USAGE_ID.Nextval,
   IN_NETWORK_USAGE_DATETIME,
   IN_NETWORK_USAGE_VOLUME,
   IN_STAFF_ID,
   SYSDATE,
   IN_STAFF_ID,
   SYSDATE
);

       commit;

   end if;
   NULL;
END;
/

CREATE OR REPLACE Procedure TS_NETWORK_USAGE_UPDATE
    (
   IN_NETWORK_USAGE_ID	      IN NUMBER,
   IN_NETWORK_USAGE_DATETIME	      IN DATE,
   IN_NETWORK_USAGE_VOLUME  IN NUMBER,
   IN_STAFF_ID      IN VARCHAR2
   )
     
AS
   
BEGIN

if  
length(IN_NETWORK_USAGE_VOLUME) is NULL then
     /*do nothing*/
      null;
   else
       
       update TS_NETWORK_USAGE
      set NETWORK_USAGE_VOLUME = case when (length(IN_NETWORK_USAGE_VOLUME)> 0) then IN_NETWORK_USAGE_VOLUME else  NETWORK_USAGE_VOLUME end,
      LAST_UPDATE_BY = IN_STAFF_ID,
      LAST_UPDATE_DATE = sysdate
      where NETWORK_USAGE_ID = IN_NETWORK_USAGE_ID;

       commit;

   end if;
   NULL;

END;
/    

GRANT execute ON TS_NETWORK_USAGE_INSERT TO MAXDAT_MSTR_TRX_RPT;
GRANT execute ON TS_NETWORK_USAGE_UPDATE TO MAXDAT_MSTR_TRX_RPT;


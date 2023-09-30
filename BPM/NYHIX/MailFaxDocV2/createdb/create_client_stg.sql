declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CLIENT_STG';
   if c = 1 then
      execute immediate 'drop table CLIENT_STG cascade constraints';
   end if;
end;
/

CREATE TABLE CLIENT_STG
    (
      CLNT_CLIENT_ID            NUMBER (18) NOT NULL
    , CLNT_CIN                  VARCHAR2 (30)
    , CREATION_DATE             DATE
    , LAST_UPDATED_BY           VARCHAR2 (80)
    , LAST_UPDATE_DATE          DATE
    , CONSTRAINT PK_CLIENT_STG PRIMARY KEY (CLNT_CLIENT_ID)
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);


GRANT SELECT ON MAXDAT.CLIENT_STG TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.CLIENT_STG TO DP_SCORECARD;


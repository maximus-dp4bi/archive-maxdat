declare  c int;
begin
   select count(*) into c from user_tables where table_name ='DOC_LINK_HIST_STG';
   if c = 1 then
      execute immediate 'drop table DOC_LINK_HIST_STG cascade constraints';
   end if;
end;
/

CREATE TABLE MAXDAT.DOC_LINK_HIST_STG
    (
      DOC_LINK_HIST_ID NUMBER (18) NOT NULL
    , DOCUMENT_ID      NUMBER (18)
    , LINK_TYPE_CD     VARCHAR2 (32)
    , AUTO_LINKED_IND  NUMBER (1)
    , CREATED_BY       VARCHAR2 (80)
    , CREATE_TS        DATE
    , CASE_ID          VARCHAR2 (32)
    , CLIENT_ID        VARCHAR2 (32)
    , LINK_REF_ID      VARCHAR2 (32),
    CONSTRAINT DOC_LINK_HIST_PK PRIMARY KEY (DOC_LINK_HIST_ID)
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

GRANT SELECT ON MAXDAT.DOC_LINK_HIST_STG TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.DOC_LINK_HIST_STG TO DP_SCORECARD;


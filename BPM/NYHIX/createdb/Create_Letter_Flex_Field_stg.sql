CREATE TABLE D_PL_LETTER_SUBTYPE 
(
  LETTER_FLEX_ID NUMBER NOT NULL 
, LETTER_REQUEST_ID NUMBER 
, LETTER_HEADER_ID NUMBER 
, LETTER_MEMBER_ID NUMBER 
, LETTER_MEMBER_DETAIL_ID NUMBER 
, LETTER_SUBTYPE VARCHAR2(80 BYTE) 
, DOCUMENT_TYPE VARCHAR2(80 BYTE) 
, TYPE VARCHAR2(40 BYTE) 
, CREATED_BY VARCHAR2(80 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE
, row_insert_ts DATE
, row_update_ts DATE
, LMDEF_ID NUMBER 
) 
TABLESPACE MAXDAT_DATA 
;

COMMIT;
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.LETTER_FLEX_ID IS 'Unique identifier for the MAXe letter_out_flex_field table. Associated with the letter_request_id in a one-to-many relationship, one letter_request_id to many letter_flex_id.';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.LETTER_REQUEST_ID IS 'Unique identifier for the MAXe letter_request table.';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.LETTER_HEADER_ID IS 'Unique identifier for the MAXe letter_out_header table, one-to-one relationship with letter_request_id.';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.LETTER_MEMBER_ID IS 'Identifier for the MAXe letter_out_flex_field table. Associated with the document_type in a one-to-one relationship';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.LETTER_MEMBER_DETAIL_ID IS 'Identifier for the MAXe letter_out_flex_field table.';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.LETTER_SUBTYPE IS 'Identifier identified by a lmdef_id of 61 and specfic letter_subtype column values';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.DOCUMENT_TYPE IS 'Identifier associated with the letter_subtype in a one-to-many relationship, one letter_subtype to many document_types.';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.TYPE IS 'Identifier associated with the letter_flex_id.';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.CREATED_BY IS 'Record created by MAXe user';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.CREATE_TS IS 'Record created MAXe timestamp';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.UPDATED_BY IS 'Record updated by MAXe user';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.UPDATE_TS IS 'Record updated MAXe timestamp';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.row_insert_ts IS 'Record inserted in timestamp.';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.row_update_ts IS 'Record updated in timestamp';
COMMENT ON COLUMN D_PL_LETTER_SUBTYPE.LMDEF_ID IS 'Identifier associated with the letter_request_id, can contain numeric values and is used to determine if flex_field column is associated with a desired letter_subtype.';

CREATE INDEX LETTER_REQUEST_ID_IDX ON D_PL_LETTER_SUBTYPE (LETTER_REQUEST_ID ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_HEADER_ID_IDX ON D_PL_LETTER_SUBTYPE (LETTER_HEADER_ID ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_MEMBER_ID_IDX ON D_PL_LETTER_SUBTYPE (LETTER_MEMBER_ID ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_MEMBER_DTL_ID_DX ON D_PL_LETTER_SUBTYPE (LETTER_MEMBER_DETAIL_ID ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_SUBTYPE_IDX ON D_PL_LETTER_SUBTYPE (LETTER_SUBTYPE ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_DOCUMENT_TYPE_IDX ON D_PL_LETTER_SUBTYPE (DOCUMENT_TYPE ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_TYPE_IDX ON D_PL_LETTER_SUBTYPE (TYPE ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_LMDEF_ID_IDX ON D_PL_LETTER_SUBTYPE (LMDEF_ID ASC) 
TABLESPACE MAXDAT_INDX 
;
CREATE INDEX LETTER_SUBTYPE_CVR_IDX ON D_PL_LETTER_SUBTYPE (LETTER_REQUEST_ID ASC, LETTER_SUBTYPE ASC, DOCUMENT_TYPE ASC, LETTER_MEMBER_ID ASC) 
TABLESPACE MAXDAT_INDX 
;
alter table D_PL_LETTER_SUBTYPE
  add constraint DPLLST_PK primary key (LETTER_FLEX_ID) using index tablespace MAXDAT_INDX
;


Create or replace view D_PL_LETTER_SUBTYPE_SV (LETTER_REQUEST_ID,LETTER_SUBTYPE,DOCUMENT_TYPE,LETTER_MEMBER_ID) as
SELECT distinct LF.LETTER_REQUEST_ID
, LF.LETTER_SUBTYPE
, LF.DOCUMENT_TYPE
, LF.LETTER_MEMBER_ID
FROM D_PL_LETTER_SUBTYPE LF
WHERE LF.LMDEF_ID IN ('61')
AND LF.LETTER_SUBTYPE IN (SELECT VALUE
      FROM CORP_ETL_LIST_LKUP where LIST_TYPE like 'PL_LETTER_SUBTYPE_LIST')
with read only	  
;

COMMIT;

alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_D_PL_LETTER_SUBTYPE
before insert or update on D_PL_LETTER_SUBTYPE
for each row 

begin 
  if inserting then 
    if :new.row_insert_ts is null then :new.row_insert_ts := sysdate;
    end if;
  end if;

 :new.row_update_ts := sysdate;
end;
/

alter session set plsql_code_type = interpreted;

SET DEFINE OFF;

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('ProcLetters_Letter_Subtype','PL_LETTER_SUBTYPE_LIST','MISSING_INFO',null,null,null,null,null,'Process Letter Subtype Value',null,null);
Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('ProcLetters_Letter_Subtype','PL_LETTER_SUBTYPE_LIST','INCOMPLETE_INFO',null,null,null,null,null,'Process Letter Subtype Value',null,null);


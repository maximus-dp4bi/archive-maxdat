CREATE SEQUENCE  "EMRS_SEQ_SEGMENTDTL_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_SEGMENTDTL_ID" TO &role_name;


create table EMRS_D_ELIG_SEGMENT_DETAILS
 (dp_segment_detail_id NUMBER not null, 
  elig_segment_and_details_id NUMBER(18,0),
  segment_type_cd VARCHAR2(32),
  client_id NUMBER(18,0),
  start_date DATE,
  end_date DATE,
  segment_detail_value_1 VARCHAR2(32),
  segment_detail_value_2 VARCHAR2(32),
  segment_detail_value_3 VARCHAR2(32),
  segment_detail_value_4 VARCHAR2(32),
  segment_detail_value_5 VARCHAR2(32),
  segment_detail_value_6 VARCHAR2(32),
  segment_detail_value_7 VARCHAR2(32),
  segment_detail_value_8 VARCHAR2(32),
  segment_detail_value_9 VARCHAR2(32),
  segment_detail_value_10 VARCHAR2(32),
  start_nd NUMBER(8,0),
  end_nd NUMBER(8,0),
  sequence_num NUMBER(8,0),
  comparable_key VARCHAR2(2000),
  modified_date DATE,
  modified_name VARCHAR2(50),
  modified_time VARCHAR2(10),
  record_date   DATE,
  record_time   VARCHAR2(10),
  record_name   VARCHAR2(80),
  updated_by    VARCHAR2(20),
  created_by    VARCHAR2(80),
  date_created  DATE,
  date_updated  DATE
)
TABLESPACE &tablespace_name
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index IDX2_SEGMENTDTLNUM on EMRS_D_ELIG_SEGMENT_DETAILS (elig_segment_and_details_id)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

create index IDX2_SEGMENTDTLCLNUM on EMRS_D_ELIG_SEGMENT_DETAILS (CLIENT_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  

create index IDX3_SEGMENTDTLVAL1 on EMRS_D_ELIG_SEGMENT_DETAILS (SEGMENT_DETAIL_VALUE_1)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  

create index IDX4_SEGMENTDTLVAL2 on EMRS_D_ELIG_SEGMENT_DETAILS (SEGMENT_DETAIL_VALUE_2)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
create index IDX5_SEGMENTTYPE on EMRS_D_ELIG_SEGMENT_DETAILS (SEGMENT_TYPE_CD)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
create index IDX6_ENDND on EMRS_D_ELIG_SEGMENT_DETAILS (END_ND)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  

alter table EMRS_D_ELIG_SEGMENT_DETAILS
  add constraint SEGMENTDTL_PK primary key (dp_segment_detail_id)
  using index 
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

grant select on EMRS_D_ELIG_SEGMENT_DETAILS to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_SEGMENTDTL"
 BEFORE INSERT OR UPDATE
 ON emrs_d_elig_segment_details
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ELIG_SEGMENT_DETAILS.dp_segment_detail_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_segment_detail_id IS NULL THEN
        SElECT EMRS_SEQ_SEGMENTDTL_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_segment_detail_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;
  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;


END BUIR_SEGMENTDTL;
/


ALTER TRIGGER "BUIR_SEGMENTDTL" ENABLE;
/

create table EMRS_S_SEGMENT_DETAIL_STG
(elig_segment_and_details_id NUMBER(18,0),
  segment_type_cd VARCHAR2(32),
  client_id NUMBER(18,0),
  start_date DATE,
  end_date DATE,
  created_by VARCHAR2(80),
  create_ts DATE,
  updated_by VARCHAR2(80),
  update_ts DATE,
  segment_detail_value_1 VARCHAR2(32),
  segment_detail_value_2 VARCHAR2(32),
  segment_detail_value_3 VARCHAR2(32),
  segment_detail_value_4 VARCHAR2(32),
  segment_detail_value_5 VARCHAR2(32),
  segment_detail_value_6 VARCHAR2(32),
  segment_detail_value_7 VARCHAR2(32),
  segment_detail_value_8 VARCHAR2(32),
  segment_detail_value_9 VARCHAR2(32),
  segment_detail_value_10 VARCHAR2(32),
  start_nd NUMBER(8,0),
  end_nd NUMBER(8,0),
  sequence_num NUMBER(8,0),
  comparable_key VARCHAR2(2000)
)
tablespace &tablespace_name
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

create index STG_IDX2_SEGMENTDTLNUM on EMRS_S_SEGMENT_DETAIL_STG (elig_segment_and_details_id)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Grant/Revoke object privileges 
grant select on EMRS_S_SEGMENT_DETAIL_STG to &role_name;

begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_ELIG_SEGMENT_DETAILS','ERRLOG_SEGMENT_DTL');
  end;
  /

CREATE TABLE EMRS_D_ELIG_SEGMENT_DETAILS_DPCOUNT
(record_date DATE
 ,segment_type_cd VARCHAR2(32)
 ,segment_detail_record_count NUMBER
 ,min_elig_segment_and_details_id NUMBER
 ,max_elig_segment_and_details_id NUMBER) TABLESPACE &tablespace_name;
 
GRANT SELECT ON EMRS_D_ELIG_SEGMENT_DETAILS_DPCOUNT TO &role_name;

CREATE UNIQUE INDEX ELIGSEGMENT_DPCOUNT_UDX01 ON EMRS_D_ELIG_SEGMENT_DETAILS_DPCOUNT(RECORD_DATE,SEGMENT_TYPE_CD) TABLESPACE &tablespace_name;

CREATE TABLE EMRS_S_ELIG_SEGMENT_DETAILS_COUNT_STG
(record_date DATE
 ,segment_type_cd VARCHAR2(32)
 ,segment_detail_record_count NUMBER
 ,min_elig_segment_and_details_id NUMBER
 ,max_elig_segment_and_details_id NUMBER
 ,load_data_flag VARCHAR2(1)) TABLESPACE &tablespace_name;
 
GRANT SELECT ON EMRS_S_ELIG_SEGMENT_DETAILS_COUNT_STG TO &role_name;

CREATE INDEX ELIGSEGMENT_STGCOUNT_IDX01 ON EMRS_S_ELIG_SEGMENT_DETAILS_COUNT_STG(RECORD_DATE,SEGMENT_TYPE_CD) TABLESPACE &tablespace_name;    

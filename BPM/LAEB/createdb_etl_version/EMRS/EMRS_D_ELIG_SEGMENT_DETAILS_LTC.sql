CREATE SEQUENCE  "EMRS_SEQ_SEGMENTDTL_LTC_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_SEGMENTDTL_LTC_ID" TO MAXDAT_LAEB_READ_ONLY;


create table EMRS_D_ELIG_SEGMENT_DETAILS_LTC
 (dp_segment_detail_ltc_id NUMBER not null, 
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
TABLESPACE MAXDAT_LAEB_DATA
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
create index IDX1_SEGMENTDTLNUMLTC on EMRS_D_ELIG_SEGMENT_DETAILS_LTC (elig_segment_and_details_id)
  TABLESPACE MAXDAT_LAEB_DATA
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

create index IDX2_SEGMENTDTLCLNUMLTC on EMRS_D_ELIG_SEGMENT_DETAILS_LTC (CLIENT_ID)
  TABLESPACE MAXDAT_LAEB_DATA
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

create index IDX3_SEGMENTDTLVAL1LTC on EMRS_D_ELIG_SEGMENT_DETAILS_LTC (SEGMENT_DETAIL_VALUE_1)
  TABLESPACE MAXDAT_LAEB_DATA
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

create index IDX4_SEGMENTDTLVAL2LTC on EMRS_D_ELIG_SEGMENT_DETAILS_LTC (SEGMENT_DETAIL_VALUE_2)
  TABLESPACE MAXDAT_LAEB_DATA
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
  
create index IDX5_SEGMENTTYPELTC on EMRS_D_ELIG_SEGMENT_DETAILS_LTC (SEGMENT_TYPE_CD)
  TABLESPACE MAXDAT_LAEB_DATA
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
  
create index IDX6_ENDNDLTC on EMRS_D_ELIG_SEGMENT_DETAILS_LTC (END_ND)
  TABLESPACE MAXDAT_LAEB_DATA
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
  

alter table EMRS_D_ELIG_SEGMENT_DETAILS_LTC
  add constraint SEGMENTDTLLTC_PK primary key (dp_segment_detail_ltc_id)
  using index 
  TABLESPACE MAXDAT_LAEB_DATA
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

grant select on EMRS_D_ELIG_SEGMENT_DETAILS_LTC to MAXDAT_LAEB_READ_ONLY;

CREATE OR REPLACE TRIGGER "BUIR_SEGMENTDTL_LTC"
 BEFORE INSERT OR UPDATE
 ON emrs_d_elig_segment_details_ltc
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ELIG_SEGMENT_DETAILS_LTC.dp_segment_detail_ltc_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_segment_detail_ltc_id IS NULL THEN
        SElECT EMRS_SEQ_SEGMENTDTL_LTC_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_segment_detail_ltc_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;
  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;


END BUIR_SEGMENTDTL_LTC;
/


ALTER TRIGGER "BUIR_SEGMENTDTL_LTC" ENABLE;
/

create table EMRS_S_SEGMENT_DETAIL_LTC_STG
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
TABLESPACE MAXDAT_LAEB_DATA
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

create index STG_IDX2_SEGMENTDTLNUM_LTC on EMRS_S_SEGMENT_DETAIL_LTC_STG (elig_segment_and_details_id)
  TABLESPACE MAXDAT_LAEB_DATA
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
grant select on EMRS_S_SEGMENT_DETAIL_LTC_STG to MAXDAT_LAEB_READ_ONLY;

begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_ELIG_SEGMENT_DETAILS_LTC','ERRLOG_SEGMENT_DTL_LTC');
  end;
  /

 

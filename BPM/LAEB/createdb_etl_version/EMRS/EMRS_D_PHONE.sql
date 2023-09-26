CREATE SEQUENCE  "EMRS_SEQ_PHONE_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_PHONE_ID" TO &role_name;

-- Create table
CREATE TABLE EMRS_D_PHONE
 (  dp_phone_id NUMBER not null, 
    phone_id NUMBER(38,0),
    client_id NUMBER(18,0),
    case_id NUMBER(18,0),
    phon_begin_date DATE,
    phon_type_cd VARCHAR2(32),
    phon_end_date DATE,  
    phon_area_code VARCHAR2(3),
    phon_phone_number VARCHAR2(7),
    phon_ext VARCHAR2(10),
    phon_prov_id NUMBER(38,0),
    phon_cntt_id NUMBER(38,0),
    phon_dolk_id VARCHAR2(32),
    start_ndt NUMBER(18,0),
    end_ndt NUMBER(18,0),
    phon_carrier_info VARCHAR2(128),
    sms_enabled_ind NUMBER(1,0),
    phon_bad_date DATE,
    phon_bad_date_satisfied DATE,
    comparable_key VARCHAR2(2000),
    contact_method_fax_ind NUMBER(1,0),
    record_name VARCHAR2(80),
    record_date DATE,
    record_time VARCHAR2(10),
    modified_name VARCHAR2(80),
    modified_date DATE,
    modified_time VARCHAR2(10),
    updated_by VARCHAR2(80),
    date_updated DATE,
    created_by VARCHAR2(80),
    date_created DATE  
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
-- Create/Recreate indexes 
create index IDX2_PHONENUM on EMRS_D_PHONE (PHONE_ID)
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
  
create index IDX3_PHONECLIENTNUM on EMRS_D_PHONE (CLIENT_ID)
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
  
create index IDX4_PHONECASENUM on EMRS_D_PHONE (CASE_ID)
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
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table EMRS_D_PHONE
  add constraint PHONE_PK primary key (DP_PHONE_ID)
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
 
-- Grant/Revoke object privileges 
grant select on EMRS_D_PHONE to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_PHONE"
 BEFORE INSERT OR UPDATE
 ON emrs_d_phone
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PHONE.dp_phone_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_phone_id IS NULL THEN
        SElECT EMRS_SEQ_PHONE_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_phone_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_PHONE;
/

ALTER TRIGGER "BUIR_PHONE" ENABLE;
/


CREATE OR REPLACE VIEW EMRS_D_CASE_BUS_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.case_id) AS PHONE_ID
  ,c.CASE_ID AS CASE_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.PHONE_TYPE, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.client_id ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT  --may need to put this as a table field because this may slow down performance
FROM emrs_d_case c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('BF','B2')  
                                AND c.case_id = p.case_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CASE_BUS_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CASE_HOME_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.case_id) AS PHONE_ID
  ,c.CASE_ID AS CASE_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_case c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('HM','CH', 'H2', 'PR') 
                                AND c.case_id = p.case_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CASE_HOME_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CASE_MISC_1_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.case_id) AS PHONE_ID
  ,c.CASE_ID AS CASE_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_case c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('BL','CB', 'B1')   
                                AND c.case_id = p.case_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CASE_MISC_1_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CASE_MISC_2_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.case_id) AS PHONE_ID
  ,c.CASE_ID AS CASE_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_case c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD = 'PR'  
                                AND c.case_id = p.case_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CASE_MISC_2_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CASE_MOBILE_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.case_id) AS PHONE_ID
  ,c.CASE_ID AS CASE_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_case c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('MB', 'CM') 
                                AND c.case_id = p.case_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CASE_MOBILE_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_BUS_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.client_id) AS PHONE_ID
  ,c.CLIENT_ID AS CLIENT_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_client c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('BF','B2') 
                                AND c.client_id = p.client_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CLIENT_BUS_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_HOME_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.client_id) AS PHONE_ID
  ,c.CLIENT_ID AS CLIENT_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_client c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('HM','CH', 'H2', 'PR') 
                                AND c.client_id = p.client_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CLIENT_HOME_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_MISC_1_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.client_id) AS PHONE_ID
  ,c.CLIENT_ID AS CLIENT_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_client c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('BL','CB', 'B1') 
                                AND c.client_id = p.client_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CLIENT_MISC_1_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_MISC_2_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.client_id) AS PHONE_ID
  ,c.CLIENT_ID AS CLIENT_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_client c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD = 'PR'  
                                AND c.client_id = p.client_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CLIENT_MISC_2_PHONE_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_MOBILE_PHONE_SV
AS
SELECT COALESCE(p.PHONE_ID, -1*c.client_id) AS PHONE_ID
  ,c.CLIENT_ID AS CLIENT_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.phone_type, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.RECORD_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.record_name AS RECORD_NAME
  ,p.modified_date AS MODIFIED_DATE
  ,p.modified_name AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLIENT_ID ORDER BY COALESCE(p.PHONE_ID, -1*c.client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM emrs_d_client c
LEFT JOIN emrs_d_phone p ON (p.PHON_TYPE_CD IN ('MB', 'CM')
                                AND c.client_id = p.client_id)
LEFT JOIN emrs_d_phone_type t ON (p.PHON_TYPE_CD = t.phone_type_code);

GRANT SELECT ON EMRS_D_CLIENT_MOBILE_PHONE_SV TO &role_name;

begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_PHONE','ERRLOG_PHONE');
  end;
/


-- Create table
create table EMRS_S_PHONE_STG
( phon_id NUMBER(38,0),
  phon_begin_date DATE,
  phon_type_cd VARCHAR2(32),
  phon_end_date DATE,
  clnt_client_id NUMBER(18,0),
  phon_area_code VARCHAR2(3),
  phon_phone_number VARCHAR2(7),
  phon_ext VARCHAR2(10),
  phon_prov_id NUMBER(38,0),
  phon_cntt_id NUMBER(38,0),
  phon_dolk_id VARCHAR2(32),
  created_by VARCHAR2(30),
  creation_date DATE,
  last_updated_by VARCHAR2(30),
  last_update_date DATE,
  phon_case_id NUMBER(18,0),
  start_ndt NUMBER(18,0),
  end_ndt NUMBER(18,0),
  phon_carrier_info VARCHAR2(128),
  sms_enabled_ind NUMBER(1,0),
  phon_bad_date DATE,
  phon_bad_date_satisfied DATE,
  comparable_key VARCHAR2(2000),
  contact_method_fax_ind NUMBER(1,0)
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
  
-- Grant/Revoke object privileges 
grant select on EMRS_S_PHONE_STG to &role_name;

create index STG_IDX2_PHONENUM on EMRS_S_PHONE_STG (PHON_ID)
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



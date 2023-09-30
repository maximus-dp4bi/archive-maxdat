CREATE TABLE D_STAFF
(
  staff_id               NUMBER(18) not null,
  ext_staff_number       VARCHAR2(80),
  dob                    DATE,
  ssn                    VARCHAR2(30),
  first_name             VARCHAR2(50),
  first_name_canon       VARCHAR2(50),
  first_name_sound_like  VARCHAR2(64),
  gender_cd              VARCHAR2(32),
  start_date             DATE,
  end_date               DATE,
  phone_number           VARCHAR2(20),
  last_name              VARCHAR2(50),
  last_name_canon        VARCHAR2(50),
  last_name_sound_like   VARCHAR2(64),
  created_by             VARCHAR2(80),
  create_ts              DATE,
  updated_by             VARCHAR2(80),
  update_ts              DATE,
  middle_name            VARCHAR2(25),
  middle_name_canon      VARCHAR2(20),
  middle_name_sound_like VARCHAR2(64),
  email                  VARCHAR2(80),
  fax_number             VARCHAR2(32),
  note_refid             NUMBER(18),
  deployment_staff_num   VARCHAR2(80),
  default_group_id       NUMBER(18),
  staff_type_cd          VARCHAR2(20),
  unique_staff_id        VARCHAR2(80),
  void_ind               NUMBER(1) default 0
)
TABLESPACE &tablespace_name;
  
ALTER TABLE D_STAFF ADD CONSTRAINT D_STAFF_PK PRIMARY KEY (STAFF_ID)  USING INDEX TABLESPACE &tablespace_name;
  
GRANT SELECT ON D_STAFF TO &role_name;

CREATE OR REPLACE VIEW D_STAFF_SV
AS
 SELECT update_ts ,
      create_ts ,
      end_date ,
      start_date ,
      ext_staff_number AS staff_id ,
      middle_name ,
      first_name ,
      ext_staff_number ,
      last_name,
      CASE WHEN LENGTH(TRIM(last_name)) IS NULL THEN TRIM(first_name) 
            WHEN LENGTH(TRIM(first_name)) IS NULL THEN TRIM(last_name)
            ELSE TRIM(last_name) || ', ' || TRIM(first_name) 
            END AS full_name
  FROM d_staff 
  UNION
  SELECT update_ts ,
      create_ts ,
      end_date ,
      start_date ,
      TO_CHAR(staff_id) AS staff_id ,
      middle_name ,
      first_name ,
      ext_staff_number ,
      last_name,
      CASE WHEN LENGTH(TRIM(last_name)) < 1 THEN TRIM(first_name) 
            WHEN LENGTH(TRIM(first_name)) < 1 THEN TRIM(last_name) 
            ELSE TRIM(last_name) || ', ' || TRIM(first_name) 
            END AS full_name
  FROM d_staff ;
  
  GRANT SELECT ON "D_STAFF_SV" TO &role_name;


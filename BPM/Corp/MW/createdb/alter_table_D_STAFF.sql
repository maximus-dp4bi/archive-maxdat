CREATE TABLE D_STAFF
(
    STAFF_ID                NUMBER(18,0)    NOT NULL ENABLE, 
	EXT_STAFF_NUMBER        VARCHAR2(80), 
	DOB                     DATE, 
	SSN                     VARCHAR2(30), 
	FIRST_NAME              VARCHAR2(50), 
	FIRST_NAME_CANON        VARCHAR2(50), 
	FIRST_NAME_SOUND_LIKE   VARCHAR2(64), 
	GENDER_CD               VARCHAR2(32), 
	START_DATE              DATE, 
	END_DATE                DATE, 
	PHONE_NUMBER            VARCHAR2(20), 
	LAST_NAME               VARCHAR2(50), 
	LAST_NAME_CANON         VARCHAR2(50), 
	LAST_NAME_SOUND_LIKE    VARCHAR2(64), 
	CREATED_BY              VARCHAR2(80), 
	CREATE_TS               DATE, 
	UPDATED_BY              VARCHAR2(80), 
	UPDATE_TS               DATE, 
	MIDDLE_NAME             VARCHAR2(25), 
	MIDDLE_NAME_CANON       VARCHAR2(20), 
	MIDDLE_NAME_SOUND_LIKE  VARCHAR2(64), 
	EMAIL                   VARCHAR2(80), 
	FAX_NUMBER              VARCHAR2(32), 
	NOTE_REFID              NUMBER(18,0), 
	DEPLOYMENT_STAFF_NUM    VARCHAR2(80), 
	DEFAULT_GROUP_ID        NUMBER(18,0), 
	STAFF_TYPE_CD           VARCHAR2(20), 
	UNIQUE_STAFF_ID         VARCHAR2(80), 
	VOID_IND                NUMBER(1,0) DEFAULT 0, 
	EXEMPT_FLAG             VARCHAR2(1) DEFAULT 'N', 
    CONSTRAINT STAFF_STG_PK PRIMARY KEY (STAFF_ID) ENABLE
   )
  TABLESPACE MAXDAT_DATA;

GRANT SELECT ON D_STAFF TO MAXDAT_READ_ONLY;
  
CREATE OR REPLACE VIEW D_STAFF_SV
AS select STAFF_ID,
  EXT_STAFF_NUMBER,
  FIRST_NAME,
  MIDDLE_NAME,
  LAST_NAME,
  START_DATE,
  END_DATE,
  CREATE_TS,
  UPDATE_TS
from D_STAFF;

GRANT SELECT ON D_STAFF_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW STAFF_LKUP
AS Select Staff_id, First_Name, Last_Name, Middle_Name
       ,TRIM(LAST_NAME) || DECODE(LAST_NAME, NULL, NULL, ',') || TRIM(FIRST_NAME) || RTRIM(LPAD(SUBSTR(MIDDLE_NAME, 1, 1),2, ' ')) AS Display_Name
From
        (
        SELECT TO_CHAR(staff_id) Staff_ID, First_Name, Last_Name, Middle_Name FROM D_STAFF
         UNION
        SELECT 'IMG' Staff_ID, 'IMG' First_Name, '' Last_Name, '' Middle_Name FROM DUAL
         UNION
        SELECT '' Staff_ID, '' First_Name, '' Last_Name, '' Middle_Name FROM DUAL S6
        ) Staff_View;

GRANT SELECT ON STAFF_LKUP TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW STAFF_STG
AS select "STAFF_ID","EXT_STAFF_NUMBER","DOB","SSN","FIRST_NAME","FIRST_NAME_CANON","FIRST_NAME_SOUND_LIKE","GENDER_CD","START_DATE","END_DATE","PHONE_NUMBER","LAST_NAME","LAST_NAME_CANON","LAST_NAME_SOUND_LIKE","CREATED_BY","CREATE_TS","UPDATED_BY","UPDATE_TS","MIDDLE_NAME","MIDDLE_NAME_CANON","MIDDLE_NAME_SOUND_LIKE","EMAIL","FAX_NUMBER","NOTE_REFID","DEPLOYMENT_STAFF_NUM","DEFAULT_GROUP_ID","STAFF_TYPE_CD","UNIQUE_STAFF_ID","VOID_IND" from D_STAFF;

GRANT SELECT ON STAFF_STG TO MAXDAT_READ_ONLY;
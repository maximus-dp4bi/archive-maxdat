CREATE TABLE CC_S_DELTEK_LABOR_DETAIL(
ACCOUNT VARCHAR2(10),
ACCOUNT_NAME VARCHAR2(255),
PROJECT_ID VARCHAR2(255),
PROJECT_NAME VARCHAR2(255),
ACCOUNT_GROUP VARCHAR2(50),
ACCOUNT_GRP_DESC vARCHAR2(255),
BILLABLE_PROJECT VARCHAR2(1),
PROJECT_ORGANIZATION_ID VARCHAR2(255),
PROJECT_ORGANIZATION_NAME VARCHAR2(255),
PROJECT_MANAGER_ID INTEGER,
PROJECT_MANAGER_NAME VARCHAR2(255),
GL_ORGANIZATION_ID VARCHAR2(255),
GL_ORGANIZATION_NAME VARCHAR2(255),
EMPLOYEE_ID VARCHAR2(255),
EMPLOYEE_NAME VARCHAR2(255),
TITLE_DESC VARCHAR2(255),
ORGANIZATION_ID VARCHAR2(255),
ORGANIZATION_NAME VARCHAR2(255),
LABOR_DESCRIPTION VARCHAR2(255),
RATE NUMBER(10,2),
HOURLY_SALARY_CD VARCHAR2(1),
FISCAL_YEAR INTEGER,
PERIOD INTEGER,
PD_ACTUAL_HOURS NUMBER(10,2),
PD_ALLOWABLE_HOURS NUMBER(10,2),
PD_ACTUAL_AMOUNT NUMBER(10,2),
REVENUE_RATE INTEGER,
REVENUE_AMOUNT NUMBER(10,2),
BENEFITS_FLAG VARCHAR2(255),
GLC_DESC VARCHAR2(255),
GLC_CD VARCHAR2(255)
);

CREATE TABLE CC_D_AGENT_RATE(
AGENT_RATE_ID NUMBER (19) NOT NULL,
LOGIN_ID VARCHAR2(255),
FISCAL_YEAR INTEGER,
FISCAL_PERIOD INTEGER,
RATE NUMBER(10,2),
CREATE_DATE DATE,
LAST_MODIFIED_DATE DATE);

CREATE SEQUENCE SEQ_CC_D_AGENT_RATE START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;


alter session set plsql_code_type = native;


CREATE OR REPLACE TRIGGER BIU_CC_D_AGENT_RATE 
    BEFORE INSERT OR UPDATE ON CC_D_AGENT_RATE 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.AGENT_RATE_ID IS NULL THEN 
          SELECT SEQ_CC_D_AGENT_RATE.NEXTVAL INTO :NEW.AGENT_RATE_ID FROM DUAL;      
END IF;
IF INSERTING THEN
  :NEW.CREATE_DATE := SYSDATE;
END IF;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;   
/

alter session set plsql_code_type = interpreted;

COMMIT;
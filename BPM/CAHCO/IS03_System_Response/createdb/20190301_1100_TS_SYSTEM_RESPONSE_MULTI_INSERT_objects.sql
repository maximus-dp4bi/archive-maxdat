CREATE OR REPLACE Procedure TS_SYSTEM_RESPONSE_MULTI_INSERT
    (
    IN_TEST_DATETIME	      IN DATE,
    IN_CUBE_LOCATION	      IN VARCHAR2,
    IN_TRANS_DESC_1    IN VARCHAR2,
    IN_TRANS_DESC_2    IN VARCHAR2,
    IN_TRANS_DESC_3    IN VARCHAR2,
    IN_TRANS_DESC_4    IN VARCHAR2,
    IN_TRANS_DESC_5    IN VARCHAR2,
    IN_TRANS_DESC_6    IN VARCHAR2,
    IN_TRANS_DESC_7    IN VARCHAR2,
    IN_TRANS_DESC_8    IN VARCHAR2,
    IN_TRANS_DESC_9    IN VARCHAR2,
    IN_TRANS_DESC_10    IN VARCHAR2,
    IN_SYSTEM_RESPONSE_TIME_1  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_2  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_3  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_4  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_5  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_6  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_7  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_8  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_9  IN NUMBER,
    IN_SYSTEM_RESPONSE_TIME_10  IN NUMBER,
    IN_STAFF_ID      IN VARCHAR2
   )

AS

BEGIN
 If  IN_TEST_DATETIME is null  or IN_STAFF_ID is null or trunc(IN_TEST_DATETIME) > trunc(sysdate) then
     /*do nothing*/
      null;
   else
  /*insert transaction 1*/    
 IF IN_SYSTEM_RESPONSE_TIME_1 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_1, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_1, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_1, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_1,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 2*/
IF IN_SYSTEM_RESPONSE_TIME_2 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_2, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_2, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_2, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_2,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 3*/
 IF IN_SYSTEM_RESPONSE_TIME_3 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_3, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_3, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_3, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_3,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 4*/
 IF IN_SYSTEM_RESPONSE_TIME_4 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_4, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_4, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_4, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_4,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 5*/
IF IN_SYSTEM_RESPONSE_TIME_5 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_5, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_5, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_5, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_5,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 6*/
 IF IN_SYSTEM_RESPONSE_TIME_6 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_6, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_6, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_6, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_6,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 7*/
 IF IN_SYSTEM_RESPONSE_TIME_7 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_7, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_7, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_7, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_7,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 8*/
 IF IN_SYSTEM_RESPONSE_TIME_8 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_8, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_8, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_8, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_8,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 9*/
 IF IN_SYSTEM_RESPONSE_TIME_9 IS NOT NULL THEN
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_9, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_9, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_9, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_9,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
/*insert transaction 10*/ 
 IF IN_SYSTEM_RESPONSE_TIME_10 IS NOT NULL THEN      
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(SYSTEM_RESPONSE_ID,DEPARTMENT_NAME,TEST_DATETIME,CUBE_LOCATION,TRANS_NUM,TRANS_DESC,SYSTEM_RESPONSE_TIME,CREATE_BY,CREATE_DATE,LAST_UPDATE_BY,LAST_UPDATE_DATE)
      values
(SEQ_SYSTEM_RESPONSE_ID.Nextval,regexp_substr (IN_TRANS_DESC_10, '[^-]+', 1, 2),IN_TEST_DATETIME,IN_CUBE_LOCATION,
regexp_substr (IN_TRANS_DESC_10, '[^-]+', 1, 1),regexp_substr (IN_TRANS_DESC_10, '[^-]+', 1, 3),IN_SYSTEM_RESPONSE_TIME_10,IN_STAFF_ID,SYSDATE,IN_STAFF_ID,SYSDATE);
       commit;
 END IF;
   
   end if;
   NULL;
END;
/

GRANT execute ON TS_SYSTEM_RESPONSE_MULTI_INSERT TO MAXDAT_MSTR_TRX_RPT;
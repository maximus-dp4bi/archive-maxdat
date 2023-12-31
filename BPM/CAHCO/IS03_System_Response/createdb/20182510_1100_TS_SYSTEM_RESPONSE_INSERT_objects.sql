CREATE OR REPLACE Procedure TS_SYSTEM_RESPONSE_INSERT
    (
    --IN_DEPARTMENT_NAME       IN VARCHAR2,
    IN_TEST_DATETIME	      IN DATE,
    IN_CUBE_LOCATION	      IN VARCHAR2,
    --IN_TRANS_NUM     IN NUMBER,
    IN_TRANS_DESC    IN VARCHAR2,
    IN_SYSTEM_RESPONSE_TIME  IN NUMBER,
    IN_STAFF_ID      IN VARCHAR2
   )

AS

BEGIN
 If  IN_TEST_DATETIME is null  or IN_STAFF_ID is null or trunc(IN_TEST_DATETIME) > trunc(sysdate) then
     /*do nothing*/
      null;
   else
      
      insert into MAXDAT.TS_SYSTEM_RESPONSE
(
SYSTEM_RESPONSE_ID,
DEPARTMENT_NAME,
TEST_DATETIME,
CUBE_LOCATION,
TRANS_NUM,
TRANS_DESC,
SYSTEM_RESPONSE_TIME,
CREATE_BY,
CREATE_DATE,
LAST_UPDATE_BY,
LAST_UPDATE_DATE
)
      values
(
SEQ_SYSTEM_RESPONSE_ID.Nextval,
--IN_DEPARTMENT_NAME ,
regexp_substr (IN_TRANS_DESC, '[^-]+', 1, 2),
IN_TEST_DATETIME,
IN_CUBE_LOCATION,
--IN_TRANS_NUM,
regexp_substr (IN_TRANS_DESC, '[^-]+', 1, 1),
--IN_TRANS_DESC,
regexp_substr (IN_TRANS_DESC, '[^-]+', 1, 3),
IN_SYSTEM_RESPONSE_TIME,
IN_STAFF_ID,
SYSDATE,
IN_STAFF_ID,
SYSDATE
);

       commit;

   end if;
   NULL;
END;
/
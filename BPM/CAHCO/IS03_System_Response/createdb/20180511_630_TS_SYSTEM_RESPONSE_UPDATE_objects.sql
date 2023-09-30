CREATE OR REPLACE Procedure TS_SYSTEM_RESPONSE_UPDATE
    (
    IN_SYSTEM_RESPONSE_ID    IN NUMBER,
    IN_DEPARTMENT_NAME       IN VARCHAR2,
    IN_TEST_DATETIME	      IN DATE,
    IN_CUBE_LOCATION	      IN VARCHAR2,
    IN_TRANS_NUM	      IN NUMBER,
    IN_TRANS_DESC	      IN VARCHAR2,
    IN_SYSTEM_RESPONSE_TIME  IN NUMBER,
    IN_STAFF_ID	      IN VARCHAR2
   )

AS
   
BEGIN

if  
length(IN_SYSTEM_RESPONSE_TIME) is NULL then
     /*do nothing*/
      null;
   else
       
       update TS_SYSTEM_RESPONSE
       set    SYSTEM_RESPONSE_TIME = case when (length(IN_SYSTEM_RESPONSE_TIME)> 0) then IN_SYSTEM_RESPONSE_TIME else  SYSTEM_RESPONSE_TIME end,
              TEST_DATETIME = case when (length(IN_TEST_DATETIME)> 0) then IN_TEST_DATETIME else  TEST_DATETIME end,
              CUBE_LOCATION = case when (length(IN_CUBE_LOCATION)> 0) then IN_CUBE_LOCATION else  CUBE_LOCATION end,
	      LAST_UPDATE_BY = IN_STAFF_ID,
              LAST_UPDATE_DATE = sysdate
        where SYSTEM_RESPONSE_ID = IN_SYSTEM_RESPONSE_ID;

       commit;

   end if;
   NULL;

END;
/
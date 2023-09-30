alter session set plsql_code_type = native;

CREATE OR REPLACE FUNCTION MAXDAT.IMR_MONTH_REPORT_CHECK RETURN NUMBER IS
   v_Result NUMBER;
   v_Days   VARCHAR2(100);
   v_Month  VARCHAR2(6);
BEGIN
   v_Result := 0; -- Don't run ETL

   SELECT VALUE 
   INTO v_Days
   FROM corp_etl_control
   WHERE NAME = 'IMR_MONTHLY_DWC_RUN_DAYS';

   SELECT VALUE
   INTO v_Month
   FROM corp_etl_control
   WHERE NAME = 'IMR_MONTHLY_DWC_LAST_RUN';

   IF InStr(v_Days, To_Char(SYSDATE,'DD')) > 0  AND  To_Date(v_Month,'YYYYMM') < Trunc(SYSDATE,'MM') THEN
      v_Result := 1;  -- Run ETL
   END IF;

   RETURN(v_Result);
END IMR_MONTH_REPORT_CHECK;
/
alter session set plsql_code_type = interpreted;

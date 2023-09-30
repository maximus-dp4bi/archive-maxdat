alter session set plsql_code_type = native;
/

CREATE OR REPLACE PACKAGE RA_Report_pkg as
--  Do not edit these four SVN_* variable values.  They are populated when you commit code
--  to SVN and used later to identify deployed code.
   SVN_FILE_URL varchar2(200) := '$URL$';
   SVN_REVISION varchar2(20) := '$Revision$';
   SVN_REVISION_DATE varchar2(60) := '$Date$';
   SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


FUNCTION IMR_MONTH_REPORT_CHECK 
  RETURN NUMBER parallel_enable;

END ;
/

CREATE OR REPLACE PACKAGE BODY RA_Report_pkg as
   g_Error   VARCHAR2(4000);
   g_Limit   NUMBER;
   gPKG VARCHAR2(30) := 'RA_Report_pkg';
   
FUNCTION IMR_MONTH_REPORT_CHECK RETURN NUMBER parallel_enable as 
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
END;


END;
/

alter session set plsql_code_type = interpreted;
/

CREATE OR REPLACE PACKAGE txkpr10_util_PKG AS

  function f_strtodate (p_str in varchar2) return date;
  PROCEDURE INS_ERROR_LOG(P_JOB_NAME IN VARCHAR2, P_ERROR_CODE IN VARCHAR2, P_ERROR_MSG IN VARCHAR2, P_TABLE_NAME IN VARCHAR2, P_TABLE_ID IN VARCHAR2);

END;
/
CREATE OR REPLACE PACKAGE BODY txkpr10_util_PKG AS

function f_strtodate (p_str in varchar2) return date is
    ex_date_format exception;
  pragma exception_init(ex_date_format, -1830);
v_date date;
begin
  v_date := to_date(p_str, 'dd-mon-yyyy');
  return v_date;
exception when ex_date_format then
  begin
    v_date := to_date(p_str, 'mm/dd/yyyy');
    return v_date;
  exception when   ex_date_format then
      v_date := to_date(p_str, 'dd-mm-yyyy');
      return v_date;
  end;
  exception when others then
            return v_date;
end;

PROCEDURE INS_ERROR_LOG(P_JOB_NAME IN VARCHAR2, P_ERROR_CODE IN VARCHAR2, P_ERROR_MSG IN VARCHAR2, P_TABLE_NAME IN VARCHAR2, P_TABLE_ID in varchar2) IS
  BEGIN
        INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
          ,ERR_LEVEL
          ,PROCESS_NAME
          ,JOB_NAME
          ,NR_OF_ERROR
          ,ERROR_DESC
          ,ERROR_CODES
          ,DRIVER_TABLE_NAME
          ,DRIVER_KEY_NUMBER
      ) VALUES (
          SYSDATE
          , 'CRITICAL'
          , 'TXKPR10_xls_PKG'
          , P_JOB_NAME
          , 1
          , P_ERROR_MSG
          , P_ERROR_CODE
          , P_TABLE_NAME
          , P_TABLE_ID
      );
  EXCEPTION WHEN OTHERS THEN
  DECLARE
    V_CODE VARCHAR2(30);
    V_ERROR VARCHAR2(200);
  BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
            INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
          ,ERR_LEVEL
          ,PROCESS_NAME
          ,JOB_NAME
          ,NR_OF_ERROR
          ,ERROR_DESC
          ,ERROR_CODES
          ,DRIVER_TABLE_NAME
          ,DRIVER_KEY_NUMBER
      ) VALUES (
          SYSDATE
          , 'CRITICAL'
          , 'TXKPR10_XLS_PKG'
          , 'INS_ERROR_LOG'
          , 1
          , SUBSTR(V_ERROR,1,200)
          , V_CODE
          , NULL
          , NULL
      );
  END;
  END;

end;
/

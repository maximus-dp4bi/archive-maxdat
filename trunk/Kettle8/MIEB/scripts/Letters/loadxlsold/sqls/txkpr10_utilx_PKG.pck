CREATE OR REPLACE PACKAGE txkpr10_utilx_PKG AS

  function f_strtodate (p_str in varchar2) return date;
  PROCEDURE INS_ERROR_LOG(P_JOB_NAME IN VARCHAR2, P_ERROR_CODE IN VARCHAR2, P_ERROR_MSG IN VARCHAR2, P_TABLE_NAME IN VARCHAR2, P_TABLE_ID IN VARCHAR2);

END;
/
CREATE OR REPLACE PACKAGE BODY txkpr10_utilx_PKG AS

function f_strtodate (p_str in varchar2) return date is
    ex_date_format exception;
  pragma exception_init(ex_date_format, -1830);
v_date date;
begin
with tz as (select p_str indate from dual)
select to_date( indate
              , case
                  when regexp_like(indate,'^[A-Z]{3,} [A-Z]{3,} [0-9]{1,2} [0-9]{1,2}(:[0-9]{2}){1,2} [[:print:]]{5,} [0-9]{2,4}','i') then 'DY MON DD HH24:MI:SS TZR YYYY'
                  when regexp_like(indate,'^[A-Z]{4,},? [A-Z]{3,},? [0-9]{1,2},? [0-9]{2,4}','i') then 'DAY MONTH DD YYYY'
                  when regexp_like(indate,'^[A-Z]{3},? [A-Z]{3,},? [0-9]{1,2},? [0-9]{2,4}','i') then 'DY MONTH DD YYYY'
                  when regexp_like(indate,'^[0-9]{1,2}[-/][0-9]{1,2}[-/]([0-9]{2}){1,2}') then 'MM-DD-RRRR'
                  when regexp_like(indate,'^[0-9]{1,2}[-/ ][A-Z]{3,}[-/ ]([0-9]{2}){1,2}','i') then 'DD-MON-RRRR'
                  when regexp_like(indate,'^[A-Z]{3,}[-/ ][0-9]{1,2},?[-/ ]([0-9]{2}){1,2}','i') then 'MON-DD-RRRR'
                  when regexp_like(indate,'^(19|20)[0-9]{6}') then 'RRRRMMDD'
                  when regexp_like(indate,'^[23][0-9]{5}') then 'DDMMRR'
                  when regexp_like(indate,'^[0-9]{6}') then 'MMDDRR'
                  when regexp_like(indate,'^[01][0-9]{7}') then 'MMDDRRRR'
                  when regexp_like(indate,'^[23][0-9]{7}') then 'DDMMRRRR'
                  ELSE NULL
                end
              ||case
                  when regexp_like(indate, '[0-9]{1,2}(:[0-9]{2}){1,2}$') then ' HH24:MI:SS'
                  when regexp_like(indate, '[0-9]{1,2}(:[0-9]{2}){1,2} ?(am|pm)$','i') then ' HH:MI:SS AM'
                  else null
                end
              )
              outdate
              into v_date
from tz;
return v_date;
exception when others then
  return null;
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

CREATE OR REPLACE FORCE VIEW MAXDAT_SUPPORT.D_PL_CLIENT_SUB_SV
AS
  SELECT DISTINCT    
    LR.LMREQ_ID PL_BI_ID,
    LR.CREATE_TS CREATE_DT,
    LL.CLIENT_ID CLIENT_ID,
    CL.CLNT_GENERIC_FIELD5_TXT AS UNIQUE_APPLICATION_ID,    
    CASE WHEN LL.REFERENCE_TYPE = 'APP_HEADER' THEN LL.REFERENCE_ID ELSE NULL END AS APPLICATION_ID,
    CL.CLNT_FNAME AS FIRST_NAME,    
    CL.CLNT_LNAME AS LAST_NAME    
  FROM LETTER_REQUEST LR
  INNER JOIN enum_lm_status st           ON lr.status_cd = st.value
  LEFT OUTER JOIN LETTER_REQUEST_LINK LL ON LL.LMREQ_ID= LR.LMREQ_ID
  LEFT OUTER JOIN CLIENT CL ON LL.CLIENT_ID = CL.CLNT_CLIENT_ID
  WHERE  (LR.CREATE_TS >= (ADD_MONTHS(TRUNC(sysdate,'mm'),-3)) OR LR.STATUS_CD NOT IN('MAIL','COMBND','OBE','REJ','VOID','ERR','COMPLETED')) ;
   
GRANT SELECT ON MAXDAT_SUPPORT.D_PL_CLIENT_SUB_SV TO MAXDAT_REPORTS;
  GRANT SELECT ON MAXDAT_SUPPORT.D_PL_CLIENT_SUB_SV TO MAXDAT_SUPPORT_READ_ONLY;

--- NYHIX-35000 update the received_count on F_NYHIX_MFD_BY_DATE
---IF Received Date = Create Date - Then RECEIVED_COUNT = 1 on the Received Date
---IF Received Date < Create Date - Then RECEIVED_COUNT = 1 on the Received Date
----IF Received Date > Create Date - Then RECEIVED_COUNT = 0
---
BEGIN
  FOR x IN(SELECT NYHIX_MFD_BI_ID, RECEIVED_COUNT
           FROM MAXDAT.D_NYHIX_MFD_CURRENT_V2
           WHERE NYHIX_MFD_BI_ID NOT IN (
                  SELECT DISTINCT NYHIX_MFD_BI_ID
                  FROM MAXDAT.F_NYHIX_MFD_BY_DATE
                  WHERE RECEIVED_COUNT > 0)
           AND RECEIVED_DT <= CREATE_DT         
    ) LOOP
    UPDATE MAXDAT.F_NYHIX_MFD_BY_DATE
    SET RECEIVED_COUNT = x.RECEIVED_COUNT         
    WHERE NYHIX_MFD_BI_ID = x.NYHIX_MFD_BI_ID;
  END LOOP;
END;
/
COMMIT;

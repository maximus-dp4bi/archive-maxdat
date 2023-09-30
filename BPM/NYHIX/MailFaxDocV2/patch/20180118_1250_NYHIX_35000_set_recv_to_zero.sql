--- NYHIX-35000 update the received_count on F_NYHIX_MFD_BY_DATE
---IF Received Date = Create Date - Then RECEIVED_COUNT = 1 on the Received Date
---IF Received Date < Create Date - Then RECEIVED_COUNT = 1 on the Received Date
----IF Received Date > Create Date - Then RECEIVED_COUNT = 0
---
BEGIN
  FOR x IN (SELECT F.NYHIX_MFD_BI_ID, F.Received_Count
            FROM MAXDAT.F_NYHIX_MFD_BY_DATE_SV_V2 F
            right JOIN MAXDAT.D_NYHIX_MFD_CURRENT_SV_V2 D ON (D.NYHIX_MFD_BI_ID = F.NYHIX_MFD_BI_ID AND F.Received_Count > 0)
            WHERE (TRUNC(RECEIVED_DT) > TRUNC(CREATE_DT))
              AND F.RECEIVED_COUNT = 1        
    ) LOOP
    UPDATE MAXDAT.F_NYHIX_MFD_BY_DATE
    SET RECEIVED_COUNT = 0         
    WHERE NYHIX_MFD_BI_ID = x.NYHIX_MFD_BI_ID;
	commit;
  END LOOP;
END;
/


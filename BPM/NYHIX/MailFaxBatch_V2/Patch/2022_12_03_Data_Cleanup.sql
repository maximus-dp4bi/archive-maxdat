-- update CANCEL_DT, CANCEL_BY, CANCEL_METHOD, CANCEL_REASON to match V1
UPDATE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY V2
   SET (CANCEL_DT,
        CANCEL_BY,
        CANCEL_METHOD,
        CANCEL_REASON) =
           (SELECT CANCEL_DT,
                   CANCEL_BY,
                   CANCEL_METHOD,
                   CANCEL_REASON
              FROM D_MFB_CURRENT V1
             WHERE V1.BATCH_GUID = V2.BATCH_GUID)
 WHERE V2.BATCH_GUID IN (SELECT BATCH_GUID
                           FROM maxdat.NYHIX_MFB_V2_BATCH_SUMMARY
                          WHERE CANCEL_DT IS NULL
                         INTERSECT
                         SELECT BATCH_GUID
                           FROM maxdat.D_MFB_CURRENT
                          WHERE CANCEL_DT IS NOT NULL);
						  
-- **** COMIT ONLY IF AND ONLY IF 17 ROWS UPDATED *****			

			  
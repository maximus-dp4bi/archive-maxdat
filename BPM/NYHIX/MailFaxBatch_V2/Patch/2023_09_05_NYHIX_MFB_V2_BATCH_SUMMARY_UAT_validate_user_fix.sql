-- Update the NYHIX_MFB_V2_BATCH_SUMMARY table validate user and user_id columns
CREATE TABLE tempNYHIX_MFB_V2_BATCH_SUMMARY(batch_guid VARCHAR2(38),ASPB_VALIDATE_DATA_USER_ID VARCHAR2(32), ASPB_VALIDATE_DATA VARCHAR2(80) )
;

ALTER TABLE tempNYHIX_MFB_V2_BATCH_SUMMARY
ADD CONSTRAINT batch_guid_PK 
PRIMARY KEY (batch_guid);

INSERT INTO tempNYHIX_MFB_V2_BATCH_SUMMARY
SELECT batch_guid, ASPB_VALIDATE_DATA_USER_ID, ASPB_VALIDATE_DATA
FROM NYHIX_MFB_V2_BATCH_SUMMARY;
WHERE ased_validate_data > to_date('2/25/2020 16:37:43','mm/dd/yyyy hh24:mi:ss')

UPDATE 
(SELECT old.ASPB_VALIDATE_DATA as OLDASPB_VALIDATE_DATA,
        old.ASPB_VALIDATE_DATA_USER_ID as OLDASPB_VALIDATE_DATA_USER_ID,
        new.ASPB_VALIDATE_DATA_USER_ID as NEWASPB_VALIDATE_DATA_USER_ID,
        new.ASPB_VALIDATE_DATA as NEWASPB_VALIDATE_DATA
 FROM NYHIX_MFB_V2_BATCH_SUMMARY old
 INNER JOIN tempNYHIX_MFB_V2_BATCH_SUMMARY new
 ON old.BATCH_GUID = NEW.BATCH_GUID
 WHERE old.ased_validate_data > to_date('2/25/2020 16:37:43','mm/dd/yyyy hh24:mi:ss')
) t
SET t.OLDASPB_VALIDATE_DATA = t.NEWASPB_VALIDATE_DATA_USER_ID,
    t.oldASPB_VALIDATE_DATA_USER_ID = t.NEWASPB_VALIDATE_DATA;

COMMIT;

drop table tempNYHIX_MFB_V2_BATCH_SUMMARY;
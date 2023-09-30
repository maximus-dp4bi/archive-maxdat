-- 5/28/13 Remove remaining ETL attributes non-standardized from BPM/Semantic lookups
--         STAGE_UPDATE_DATE, STAGE_EXTRACT_DATE. Update CANCEL_DT to CANCEL_DATE.


-- Update global control
UPDATE corp_etl_control SET value = '0'
 WHERE name = 'CLIENT_INQUIRY_LAST_CALL_ID';

-- Update BPM lookup - CANCEL_DATE.
UPDATE bpm_attribute SET bal_id = 47 WHERE ba_id = 1679;
UPDATE bpm_attribute_staging_table ast
   SET ba_id = 47
 WHERE ba_id = 1679 AND ast.staging_table_column = 'CANCEL_DT';
DELETE FROM bpm_attribute_lkup WHERE bal_id = 697;

-- Update STAGE attribute names
/* per Randy, to remove instead of update
UPDATE bpm_attribute_staging_table ast SET staging_table_column = 'STG_LAST_UPDATE_DATE' WHERE ba_id = 1680;
UPDATE bpm_attribute_staging_table ast SET staging_table_column = 'STG_EXTRACT_DATE' WHERE ba_id = 1681;
*/
DELETE FROM bpm_attribute_staging_table WHERE ba_id IN (1680, 1681);
DELETE FROM bpm_attribute WHERE ba_id IN (1680, 1681);
DELETE FROM bpm_attribute_lkup WHERE bal_id IN (698, 699);


COMMIT;

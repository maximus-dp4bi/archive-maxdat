-- The TRG_AI_CORP_ETL_MANAGE_WORK trigger mistakenly inserted data in both the 
-- BPM_INSTANCE_ATTRIBUTE .VALUE_NUMBER and .VALUE_CHAR columns for CORP_ETL_MANAGE_WORK.SOURCE_REFERENCE_ID (BA_ID = 24).
-- Should only have data in the VALUE_NUMBER column for this attribute.

update BPM_INSTANCE_ATTRIBUTE
set VALUE_CHAR = null
where BA_ID = 24
and VALUE_CHAR is not null;

commit;




alter session set current_schema = MAXDAT;

-- create a backup of rows to be updated
create table D_MFB_v2_CURRENT_SV_BAK_20220822
as select * 
from D_MFB_v2_CURRENT_SV
where batch_guid 
in ( select batch_guid 
    from D_MFB_v2_CURRENT_SV
    where nvl(reprocessed_flag,'N') = 'N'
    intersect
    select batch_guid 
    from D_MFB_CURRENT_SV
    where nvl(reprocessed_flag,'N') = 'Y'
    )
or batch_guid = '{340578f8-04a8-448f-9057-d199afc004e5}';

create table NYHIX_MFB_v2_STATS_BATCH_BAK_20220822
as select * 
from NYHIX_MFB_V2_STATS_BATCH
where batch_guid 
in ( select batch_guid 
    from D_MFB_v2_CURRENT_SV
    where nvl(reprocessed_flag,'N') = 'N'
    intersect
    select batch_guid 
    from D_MFB_CURRENT_SV
    where nvl(reprocessed_flag,'N') = 'Y'
    )
or batch_guid = '{340578f8-04a8-448f-9057-d199afc004e5}';


-- insert rows into NYHIX_MFB_V2_REPROCESSED_BACTH
INSERT INTO MAXDAT.NYHIX_MFB_V2_REPROCESSED_BATCH 
	(
   NYHIX_MFB_V2_REPROCESSED_ID,  
   BATCH_NAME, CREATION_USER_ID, REPROCESSED_FLAG, 
   REPROCESSED_DATE, JIRA_NUMBER, REPROCESSING_COMPLETED_DATE
   ) 
SELECT  SEQ_NYHIX_MFB_V2_REPROCESSED_ID.nextval, /* NYHIX_MFB_V2_REPROCESSED_ID */
	BATCH_NAME, 			/* BATCH_NAME */
	'MAXDAT',			/* CREATION_USER_ID */
	'Y',					/* REPROCESSED_FLAG */
	INSTANCE_STATUS_DT,	/* REPROCESSED_DATE */
	'NYSOH-48379',		/* JIRA_NUMBER */
	INSTANCE_STATUS_DT	/* REPROCESSING_COMPLETED_DATE */
FROM D_MFB_v2_CURRENT_SV_BAK_20220822
WHERE batch_guid <> '{340578f8-04a8-448f-9057-d199afc004e5}';

--
    UPDATE NYHIX_MFB_V2_STATS_BATCH SB
    SET
        (REPROCESSED_FLAG,REPROCESSED_DATE)
		= 
		( SELECT 'Y', INSTANCE_STATUS_DT
		FROM D_MFB_v2_CURRENT_SV_BAK_20220822 BAK
		WHERE SB.BATCH_GUID = BAK.BATCH_GUID
		)
    WHERE BATCH_GUID 
	IN ( SELECT BATCH_GUID 
		FROM D_MFB_v2_CURRENT_SV_BAK_20220822
		);
		
-- COMMIT only if 540 rows updated



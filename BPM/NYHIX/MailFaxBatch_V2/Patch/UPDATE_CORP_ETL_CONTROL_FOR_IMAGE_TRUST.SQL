set echo on;
set feedback on;

DELETE FROM MAXDAT.CORP_ETL_CONTROL
WHERE NAME LIKE 'MFB_V2%IMAGE_TRUST%';

INSERT INTO MAXDAT.CORP_ETL_CONTROL (
   NAME, VALUE_TYPE, VALUE, 
   DESCRIPTION) 
VALUES ( 'MFB_V2_IMAGE_TRUST_LOOKBACK_DAYS'  /* NAME */,
        'N'             /* VALUE_TYPE */,
        5               /* VALUE */,
        'Number of days to lookback in Image_trust statsbatch' /* DESCRIPTION */
        );
COMMIT;

INSERT INTO MAXDAT.CORP_ETL_CONTROL (
   NAME, VALUE_TYPE, VALUE, 
   DESCRIPTION) 
VALUES ( 'MFB_V2_IMAGE_TRUST_LAST_UPDATE_DATE'  /* NAME */,
        'D'             /* VALUE_TYPE */,
        '01/01/2022'               /* VALUE */,
        'Last update for Image_trust StatsBatch FORMAT MM/DD/YYYY' /* DESCRIPTION */
        );

COMMIT;


INSERT INTO MAXDAT.CORP_ETL_CONTROL (
   NAME, VALUE_TYPE, VALUE, 
   DESCRIPTION) 
VALUES ( 'MFB_V2_IMAGE_TRUST_LAST_STATS_BATCH_ID'  /* NAME */,
        'N'             /* VALUE_TYPE */,
        0               /* VALUE */,
        'Last STATS_BATCH_ID from Image_trust StatsBatch' /* DESCRIPTION */
        );
COMMIT;

        

INSERT INTO MAXDAT.CORP_ETL_CONTROL (
   NAME, VALUE_TYPE, VALUE, 
   DESCRIPTION) 
VALUES ( 'MFB_V2_IMAGE_TRUST_RUN_FLAG'  /* NAME */,
        'V'             /* VALUE_TYPE */,
        'Y'               /* VALUE */,
        'Signal to run Image_trust' /* DESCRIPTION */
        );
COMMIT;

SELECT *FROM MAXDAT.CORP_ETL_CONTROL
WHERE NAME LIKE 'MFB_V2_%TRU%';

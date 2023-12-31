DELETE FROM MAXDAT.CORP_ETL_CONTROL
WHERE NAME = 'APP_DOC_DATA_RM_MAILING_ADDRESS_DATE';

COMMIT;

INSERT INTO MAXDAT.CORP_ETL_CONTROL (
     NAME, VALUE_TYPE, VALUE, 
     DESCRIPTION, CREATED_TS, UPDATED_TS) 
 VALUES ( 'APP_DOC_DATA_RM_MAILING_ADDRESS_DATE', /* NAME */
         'D',        /* VALUE_TYPE */
         '2022/01/01 00:00:00', /* VALUE */
         'Last UPDATE_TS or CREATE_TS from APP_DOC_DATA_RM_MAILING_ADDRESS',/* DESCRIPTION */
         SYSDATE, /* CREATED_TS */
         TO_DATE(NULL)/* UPDATED_TS */ 
         );
COMMIT;

DELETE FROM MAXDAT.CORP_ETL_CONTROL
WHERE NAME = 'APP_DOC_DATA_RM_MAILING_ADDRESS_ID';

COMMIT;


INSERT INTO MAXDAT.CORP_ETL_CONTROL (
     NAME, VALUE_TYPE, VALUE, 
     DESCRIPTION, CREATED_TS, UPDATED_TS) 
 VALUES ( 'APP_DOC_DATA_RM_MAILING_ADDRESS_ID', /* NAME */
         'N',        /* VALUE_TYPE */
         '0', /* VALUE */
         'Last RM_MAILING_ADDRESS_ID from APP_DOC_DATA_RM_MAILING_ADDRESS',/* DESCRIPTION */
         SYSDATE, /* CREATED_TS */
         TO_DATE(NULL)/* UPDATED_TS */ 
         );
  
COMMIT;

select 
	( 
	select value as MAX_APP_DOC_DATA_RM_MAILING_ADDRESS_DATE
	from CORP_ETL_CONTROL where name = 'APP_DOC_DATA_RM_MAILING_ADDRESS_DATE'
	)  as APP_DOC_DATA_RM_MAILING_ADDRESS_DATE,
	( 
	select value as MAX_APP_DOC_DATA_RM_MAILING_ADDRESS_DATE
	from CORP_ETL_CONTROL where name = 'APP_DOC_DATA_RM_MAILING_ADDRESS_ID'
	) as APP_DOC_DATA_RM_MAILING_ADDRESS_ID
from dual;
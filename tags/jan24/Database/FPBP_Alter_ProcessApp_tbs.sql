PROMPT 'Add Columns to Process APP Stage Table'

alter table PROCESS_APP_STG add   HEART_INCMPLT_APP_IND            VARCHAR2(1);
alter table PROCESS_APP_STG add   HEART_REPROCESS_STATUS           VARCHAR2(50);
alter table PROCESS_APP_STG add   HEART_REPROCESS_STATUS_DT        DATE;

-- FPBP Columns
alter table PROCESS_APP_STG add   CIN             		   VARCHAR2(30);
alter table PROCESS_APP_STG add   CIN_DT       	  	  	   DATE;
alter table PROCESS_APP_STG add   DAYS_UNTIL_TIMEOUT               NUMBER(5);
alter table PROCESS_APP_STG add   FPBP_TYPE             	   VARCHAR2(30);
alter table PROCESS_APP_STG add   INVOICE_READY_DT       	   DATE;
alter table PROCESS_APP_STG add   REV_CLEAR_IND             	   VARCHAR2(22);
alter table PROCESS_APP_STG add   REV_CLEAR_IND_DT       	   DATE;
alter table PROCESS_APP_STG add   REV_CLEAR_OUTCOME                VARCHAR2(22);
alter table PROCESS_APP_STG add   UPSTATE_INDICATOR                VARCHAR2(20);
alter table PROCESS_APP_STG add   WMS_REASON           		   VARCHAR2(50);
alter table PROCESS_APP_STG add   PROVIDER_NAME               	   VARCHAR2(80);
--alter table PROCESS_APP_STG add   PROVIDER_AGENCY             	   VARCHAR2(80);

PROMPT 'Add Columns to NYEC_ETL_PROCESS_APP Table'

alter table NYEC_ETL_PROCESS_APP add   HEART_INCMPLT_APP_IND       VARCHAR2(1);
alter table NYEC_ETL_PROCESS_APP add   HEART_REPROCESS_STATUS      VARCHAR2(50);
alter table NYEC_ETL_PROCESS_APP add   HEART_REPROCESS_STATUS_DT   DATE;

-- FPBP Columns
alter table NYEC_ETL_PROCESS_APP add   CIN             		   VARCHAR2(30);
alter table NYEC_ETL_PROCESS_APP add   CIN_DT       	  	   DATE;
alter table NYEC_ETL_PROCESS_APP add   DAYS_UNTIL_TIMEOUT          NUMBER(5);
alter table NYEC_ETL_PROCESS_APP add   FPBP_TYPE             	   VARCHAR2(30);
alter table NYEC_ETL_PROCESS_APP add   INVOICE_READY_DT       	   DATE;
alter table NYEC_ETL_PROCESS_APP add   REV_CLEAR_IND               VARCHAR2(22);
alter table NYEC_ETL_PROCESS_APP add   REV_CLEAR_IND_DT       	   DATE;
alter table NYEC_ETL_PROCESS_APP add   REV_CLEAR_OUTCOME           VARCHAR2(22);
alter table NYEC_ETL_PROCESS_APP add   UPSTATE_INDICATOR           VARCHAR2(20);
alter table NYEC_ETL_PROCESS_APP add   WMS_REASON           	   VARCHAR2(50);
alter table NYEC_ETL_PROCESS_APP add   PROVIDER_NAME               VARCHAR2(80);
--alter table NYEC_ETL_PROCESS_APP add   PROVIDER_AGENCY           VARCHAR2(80);

PROMPT 'Add columns to Process APP MI Stage Table'

alter table PROCESS_APP_MI_STG add   HEART_MI_DUE_DT  	  	   DATE;
alter table PROCESS_APP_MI_STG add   MAXE_MI_DUE_DT  	  	   DATE;
alter table PROCESS_APP_MI_STG add   MI_LETTER_NAME  	  	   VARCHAR2(60);
alter table PROCESS_APP_MI_STG add   MI_ITEM_SATISFIED_REASON  	   VARCHAR2(60);
alter table PROCESS_APP_MI_STG add   MI_TYPE_NAME		   VARCHAR2(100);


PROMPT 'Add columns to NYEC_ETL_PROCESS_APP_MI Table'

alter table NYEC_ETL_PROCESS_APP_MI add   HEART_MI_DUE_DT  	   DATE;
alter table NYEC_ETL_PROCESS_APP_MI add   MAXE_MI_DUE_DT  	   DATE;
alter table NYEC_ETL_PROCESS_APP_MI add   MI_LETTER_NAME  	   VARCHAR2(60);
alter table NYEC_ETL_PROCESS_APP_MI add   MI_ITEM_SATISFIED_REASON VARCHAR2(60);
alter table NYEC_ETL_PROCESS_APP_MI add   MI_TYPE_NAME		   VARCHAR2(100); 

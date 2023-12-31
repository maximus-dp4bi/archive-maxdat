CREATE TABLE "_CDC_OHPNM_RAW_DATA_LOGS" (
    "SOURCE_TABLE_NAME"     STRING,
    "SOURCE_START_LSN"      STRING,
    "SOURCE_OPERATION_TYPE" STRING,
    "SOURCE_CDC_RAW_DATA"   STRING, 
    "LOG_CREATED_DTM" 	    TIMESTAMP,
	constraint pkey_1 primary key (SOURCE_TABLE_NAME, SOURCE_START_LSN, LOG_CREATED_DTM) not enforced
);

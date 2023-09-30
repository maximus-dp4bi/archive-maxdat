create schema RAW;

create or replace TABLE "RAW".CLIENT_RAW_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".ADDRESS_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_DOC_DATA_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_HEADER_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_MISSING_INFO_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".DOCUMENT_SET_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".DOC_FLEX_FIELD_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_CASE_LINK_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_INDIVIDUAL_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".LETTER_REQUEST_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_STATUS_HISTORY_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".STEP_INSTANCE_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_ELIG_OUTCOME_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_STATUS_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".DOCUMENT_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".LETTER_REQUEST_LINK_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".APP_HEADER_EXT_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".DOC_LINK_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE "RAW".NOTIFICATION_REQUEST_RAW (
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);
alter table corp_etl_mw add
(
    DCN                             VARCHAR2(20),
    DOCUMENT_RECEIVED_DATE          DATE
);

COMMENT ON COLUMN "CORP_ETL_MW"."DCN" IS 'The Document Control Number of the document.';
COMMENT ON COLUMN "CORP_ETL_MW"."DOCUMENT_RECEIVED_DATE" IS 'The date the document was received.';

alter table corp_etl_mw_wip add
(
    DCN                             VARCHAR2(20),
    DOCUMENT_RECEIVED_DATE          DATE
);

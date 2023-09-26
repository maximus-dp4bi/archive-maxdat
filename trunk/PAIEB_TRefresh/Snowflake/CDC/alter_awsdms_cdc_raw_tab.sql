ALTER TABLE raw.awsdms_cdc_raw ADD (PROCESSED BOOLEAN);

UPDATE raw.awsdms_cdc_raw
SET PROCESSED = 0;

alter table raw.awsdms_cdc_raw add (rownumber number(32), filenum number(32));

-- 6/7 New cancellation attributes for Client Inquiry

INSERT INTO bpm_attribute (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1690 , 722, 13, 'BOTH' , SYSDATE, bpm_common.get_max_date, 'N');
INSERT INTO bpm_attribute (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1691 , 547, 13, 'BOTH' , SYSDATE, bpm_common.get_max_date, 'N');
INSERT INTO bpm_attribute (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1692 , 576, 13, 'BOTH' , SYSDATE, bpm_common.get_max_date, 'N');

INSERT INTO bpm_attribute_staging_table (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(seq_bast_id.NEXTVAL, 1690, 13, UPPER('cancel_method'));
INSERT INTO bpm_attribute_staging_table (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(seq_bast_id.NEXTVAL, 1691, 13, UPPER('cancel_reason'));
INSERT INTO bpm_attribute_staging_table (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(seq_bast_id.NEXTVAL, 1692, 13, UPPER('cancel_by'));

COMMIT;
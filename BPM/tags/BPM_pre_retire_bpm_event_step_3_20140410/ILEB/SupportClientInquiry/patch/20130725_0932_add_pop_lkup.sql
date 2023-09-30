-- TXEB 7/2/13

INSERT INTO bpm_attribute_lkup (BAL_ID,BDL_ID,NAME,PURPOSE)  VALUES (800,2,'Cancel By Unit','The business unit that the staff member who created the contact is assigned to.  ');
INSERT INTO bpm_attribute_lkup (BAL_ID,BDL_ID,NAME,PURPOSE)  VALUES (802,2,'Cancel By Role','The default role that the staff member who created the contact is assigned to.');

INSERT INTO bpm_attribute (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1790 , 800, 13, 'BOTH' , SYSDATE, bpm_common.get_max_date, 'N');
INSERT INTO bpm_attribute (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1792 , 802, 13, 'BOTH' , SYSDATE, bpm_common.get_max_date, 'N');

INSERT INTO bpm_attribute_staging_table (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(seq_bast_id.NEXTVAL, 1790, 13, UPPER('created_by_unit'));
INSERT INTO bpm_attribute_staging_table (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(seq_bast_id.NEXTVAL, 1792, 13, UPPER('created_by_role'));

COMMIT;
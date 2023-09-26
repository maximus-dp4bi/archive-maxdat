CREATE TABLE CONTROL.PAIEB_AWSDMS_COLUMN_COMPARE_EXCLUDE
(source_table_name VARCHAR(100)
 ,column_name VARCHAR(100)
 ,created_on TIMESTAMP_NTZ(9) default current_timestamp());
 
 INSERT INTO  CONTROL.PAIEB_AWSDMS_COLUMN_COMPARE_EXCLUDE(source_table_name,column_name)
 SELECT source_table_name,'COMMITTIMESTAMP'
 FROM control.paieb_awsdms_tables_list;
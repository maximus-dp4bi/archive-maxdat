
delete from  CORP_ETL_PROC_LET_MATERIAL_CHD;
Alter table CORP_ETL_PROC_LET_MATERIAL_CHD Add (MEDIA_CD	VARCHAR2(20),
					  EXT_MATERIAL_REF_ID	NUMBER(18,0),
					  NUMBER_REQUESTED	VARCHAR2(32),
					  CREATED_BY		VARCHAR2(80),
					  CREATED_TS		DATE,
					  UPDATED_BY		varchar2(80),
					  UPDATED_TS		DATE);
            
            
commit;
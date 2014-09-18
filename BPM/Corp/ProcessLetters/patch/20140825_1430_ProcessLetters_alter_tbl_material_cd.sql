

alter table D_PL_CURRENT add (MATERIAL_REQUEST_ID NUMBER(18,0),
                              FAMILY_MEMBER_COUNT NUMBER(18,0),
                              AIAN_MEMBER_COUNT   NUMBER(18,0));

alter table CORP_ETL_PROC_LETTERS add (MATERIAL_REQUEST_ID NUMBER(18,0),
                                      FAMILY_MEMBER_COUNT NUMBER(18,0),
                                      AIAN_MEMBER_COUNT   NUMBER(18,0));
                              
alter table CORP_ETL_PROC_LETTERS_OLTP add (MATERIAL_REQUEST_ID NUMBER(18,0),
                                            FAMILY_MEMBER_COUNT NUMBER(18,0),
                                            AIAN_MEMBER_COUNT   NUMBER(18,0));
                              
alter table CORP_ETL_PROC_LETTERS_WIP_BPM add (MATERIAL_REQUEST_ID NUMBER(18,0),
                                                FAMILY_MEMBER_COUNT NUMBER(18,0),
                                                AIAN_MEMBER_COUNT   NUMBER(18,0));

create index CORP_ETL_PROC_LET_MAT_REQ_ID on CORP_ETL_PROC_LETTERS (MATERIAL_REQUEST_ID)
  tablespace MAXDAT_INDX;

create index CORP_LET_OLTP_MAT_REQ_ID on CORP_ETL_PROC_LETTERS_OLTP (MATERIAL_REQUEST_ID)  tablespace MAXDAT_INDX;

create index  CORP_LET_WIP_MAT_REQ_ID on CORP_ETL_PROC_LETTERS_WIP_BPM (MATERIAL_REQUEST_ID)  tablespace MAXDAT_INDX;
 
 
 create table CORP_ETL_PROC_LET_MATERIAL_CHD 
   (MATERIAL_REQUEST_DETAILS_ID number,	  
        MATERIAL_REQUEST_ID     number,
        LETTER_REQUEST_ID       number,
        MATERIAL_CD             varchar2(32), 
        LANGUAGE_CD	            varchar2(32),
        MEDIA_CD	              varchar2(20),
				EXT_MATERIAL_REF_ID   	number(18,0),
				NUMBER_REQUESTED	      varchar2(32),
				CREATED_BY		          varchar2(80),
				CREATED_TS		          date,
				UPDATED_BY		          varchar2(80),
				UPDATED_TS		          DATE,
	CONSTRAINT CORP_ETL_PROC_LET_PK PRIMARY KEY 
	  (
	    MATERIAL_REQUEST_DETAILS_ID 
	  )
  ENABLE 
   ) 
  TABLESPACE MAXDAT_DATA parallel;
  
  
  create index CORP_ETL_PROC_LET_MAT_CHD_IDX1 on CORP_ETL_PROC_LET_MATERIAL_CHD (LETTER_REQUEST_ID) 
  tablespace MAXDAT_INDX ;
  
CREATE OR REPLACE VIEW D_PL_CURRENT_SV AS
SELECT * FROM D_PL_CURRENT
WITH READ ONLY;

create or replace public synonym CORP_ETL_PROC_LET_MATERIAL_CHD for CORP_ETL_PROC_LET_MATERIAL_CHD;
grant select on CORP_ETL_PROC_LET_MATERIAL_CHD to MAXDAT_READ_ONLY;
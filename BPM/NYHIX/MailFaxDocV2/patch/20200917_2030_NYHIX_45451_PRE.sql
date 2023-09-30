ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;

ALTER TABLE MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2 ADD ACTION_STATUS VARCHAR2(50 BYTE);
CREATE OR REPLACE VIEW NYHIX_ETL_MFD_CSC_V2_SV AS SELECT * FROM NYHIX_ETL_MAIL_FAX_DOC_CSC_V2;


CREATE TABLE  MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_HIST 
   (	
   "CSC_DETAIL_ID" NUMBER(18,0) NOT NULL ENABLE, 
	"KOFAX_DCN" VARCHAR2(256 BYTE), 
	"CSC_PROC_STATUS_CD" VARCHAR2(256 BYTE), 
	"CSC_PROC_ERROR_CD" VARCHAR2(256 BYTE), 
	"CSC_PROC_DT" DATE, 
	"ACTION_STATUS" VARCHAR2(50 BYTE), 
	 CONSTRAINT "CD_ID_PK_HIST" PRIMARY KEY ("CSC_DETAIL_ID")
   ) SEGMENT CREATION IMMEDIATE ;
   
   
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."D_NYHIX_MFD_MW_REJECTIONS_SV" ("ECN", "DCN", "TASK_ID", "CURRENT_OWNER_STAFF_ID", "CURRENT_OWNER_STAFF_NAME", "OPERATIONS_GROUP", "ORIGINATOR_STAFF_ID", "ORIGINATOR_STAFF_NAME", "TASK_TYPE_ID", "TASK_NAME", "CURRENT_TASK_STATUS", "CREATE_DATE", "COMPLETE_DATE", "ACTION_STATUS", "SUPERVISOR_NAME", "SUPERVISOR_ID", "NOTICE", "LETTER_TYPE") AS 
  (
SELECT DISTINCT
    A11.ECN                                                                                                 ECN,
    A11.DCN                                                                                                 DCN,
    A12.TASK_ID                                                                                             TASK_ID,
    A12.CURR_OWNER_STAFF_ID                                                                                 CURRENT_OWNER_STAFF_ID,
    CASE WHEN A14.STAFF_ID = 0 THEN 'UNKNOWN' ELSE ( A14.LAST_NAME || ', ' || A14.FIRST_NAME )    END       CURRENT_OWNER_STAFF_NAME, 
    A13.OPERATIONS_GROUP                                                                                    OPERATIONS_GROUP,
    A12.CURR_CREATED_BY_STAFF_ID                                                                            ORIGINATOR_STAFF_ID,
    CASE WHEN A14.STAFF_ID = 0 THEN 'UNKNOWN' ELSE ( A15.LAST_NAME || ', ' || A15.FIRST_NAME )    END       ORIGINATOR_STAFF_NAME, 
    A12.TASK_TYPE_ID                                                                                        TASK_TYPE_ID,
    A13.TASK_NAME                                                                                           TASK_NAME,
    A12.CURR_TASK_STATUS                                                                                    CURRENT_TASK_STATUS,
    TRUNC(A12.CREATE_DATE)                                                                                  CREATE_DATE,
    TRUNC(A12.COMPLETE_DATE)                                                                                COMPLETE_DATE,
    A16.ACTION_STATUS                                                                                       Action_Status,
    case when a110.STAFF_ID = 0 then 'None' ELSE (a110.LAST_NAME || ', ' || a110.FIRST_NAME) end            SUPERVISOR_NAME,
    a110.STAFF_ID                                                                                           SUPERVISOR_ID,
    'NA'                                                                                                    NOTICE, --Link letters
    'NA'                                                                                                    LETTER_TYPE--, --replace later
FROM
     D_NYHIX_MFD_CURRENT_SV_V2 A11
JOIN NYHIX_ETL_MFD_CSC_V2_SV  A16 ON A16.KOFAX_DCN = A11.KOFAX_DCN
JOIN D_MW_V2_CURRENT_SV       A12 ON ( A16.CSC_DETAIL_ID = A12.SOURCE_REFERENCE_ID ) AND A12.SOURCE_REFERENCE_TYPE = 'CSC_ZIP_FILE_DCN_DETAIL'
JOIN D_TASK_TYPES_SV          A13 ON ( A12.TASK_TYPE_ID = A13.TASK_TYPE_ID )
JOIN D_STAFF_SV               A14 ON ( A12.CURR_OWNER_STAFF_ID = A14.STAFF_ID )
JOIN D_STAFF_SV               A15 ON ( A12.CURR_CREATED_BY_STAFF_ID = A15.STAFF_ID )
JOIN D_TEAMS_SV               A17 ON ( A12.CURR_TEAM_ID = A17.TEAM_ID )
JOIN D_STAFF_SV               A110 ON ( A17.TEAM_SUPERVISOR_STAFF_ID = A110.STAFF_ID )
WHERE    A13.TASK_TYPE_ID = 20181001
);
 
GRANT select on MAXDAT.D_NYHIX_MFD_MW_REJECTIONS_SV to MAXDAT_READ_ONLY;
commit;   
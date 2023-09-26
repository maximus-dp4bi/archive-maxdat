ALTER TABLE CC_D_PROJECT ADD INCLUDE_IN_REPORTS_FLAG NUMBER(1);

ALTER TABLE CC_D_PROGRAM ADD INCLUDE_IN_REPORTS_FLAG NUMBER(1);

CREATE OR REPLACE FORCE VIEW CC_D_PROJECT_SV (PROJECT_ID, PROJECT_NAME, SEGMENT_ID, INCLUDE_IN_REPORTS_FLAG) AS 
SELECT CC_D_PROJECT.PROJECT_ID,CC_D_PROJECT.PROJECT_NAME,CC_D_PROJECT.SEGMENT_ID,CC_D_PROJECT.INCLUDE_IN_REPORTS_FLAG  FROM CC_D_PROJECT;


CREATE OR REPLACE FORCE VIEW CC_D_PROGRAM_SV (PROGRAM_ID, PROGRAM_NAME, INCLUDE_IN_REPORTS_FLAG) AS 
SELECT CC_D_PROGRAM.PROGRAM_ID,CC_D_PROGRAM.PROGRAM_NAME, CC_D_PROGRAM.INCLUDE_IN_REPORTS_FLAG FROM CC_D_PROGRAM;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('0.1','013','013_ALTER_CC_D_PROGRAM_FLAG');


COMMIT;
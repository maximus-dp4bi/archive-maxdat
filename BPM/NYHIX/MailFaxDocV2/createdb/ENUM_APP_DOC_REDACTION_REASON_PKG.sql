CREATE OR REPLACE PACKAGE              ENUM_APP_DOC_REDACTION_REASON_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    PROCEDURE INSERT_PROCESS;
    PROCEDURE UPDATE_PROCESS;
    PROCEDURE DELETE_PROCESS;
	PROCEDURE MERGE_PROCESS;
	PROCEDURE PROCESS_ENUM_APP_DOC_REDACTION_REASON;
    PROCEDURE LOG_ERROR;

END ENUM_APP_DOC_REDACTION_REASON_PKG;
/

SHOW ERRORS


CREATE OR REPLACE PACKAGE BODY              ENUM_APP_DOC_REDACTION_REASON_PKG AS


-- A driving loop cursor is used to keep the 'commit' size
-- down because you should not commit from within a 'loop'
 
-- This cursor selects the distinct APP_DOC_DATA_IDs
-- STG (source) has already been filtered based on the create_dt
-- and update_dt.
-- The target table need to be filtered unig the same varriable
-- from CORP_ETL_CONTROL

	CURSOR DOC_CSR IS
		SELECT VALUE               
		FROM ENUM_APP_DOC_REDACTION_REASON_STG
		UNION
		SELECT VALUE 
		FROM ENUM_APP_DOC_REDACTION_REASON
		WHERE CREATE_TS >= (SELECT TO_DATE(VALUE,'YYYY/MM/DD HH24:MI:SS') FROM CORP_ETL_CONTROL WHERE NAME = 'MAX_APP_DOC_REDACTION_DATE')
		OR UPDATE_TS >= (SELECT TO_DATE(VALUE,'YYYY/MM/DD HH24:MI:SS') FROM CORP_ETL_CONTROL WHERE NAME = 'MAX_APP_DOC_REDACTION_DATE');
		
		DOC_REC		DOC_CSR%ROWTYPE;
    
    ---------------------------------------------------------------
    
	CURSOR JOIN_STAGE_CSR IS
	SELECT
		STAGE_ROWID								AS STAGE_ROWID,
		TARGET_ROWID							AS TARGET_ROWID,
	-------------------------------------------------------
		STAGE_VALUE,
		STAGE_DESCRIPTION,
		STAGE_REPORT_LABEL,
		STAGE_SCOPE,
		STAGE_CREATED_BY,
		STAGE_CREATE_TS,
		STAGE_UPDATED_BY,
		STAGE_UPDATE_TS,
		STAGE_ORDER_BY_DEFAULT,
		STAGE_EFFECTIVE_START_DATE,
		STAGE_EFFECTIVE_END_DATE,
		TARGET_VALUE,
		TARGET_DESCRIPTION,
		TARGET_REPORT_LABEL,
		TARGET_SCOPE,
		TARGET_CREATED_BY,
		TARGET_CREATE_TS,
		TARGET_UPDATED_BY,
		TARGET_UPDATE_TS,
		TARGET_ORDER_BY_DEFAULT,
		TARGET_EFFECTIVE_START_DATE,
		TARGET_EFFECTIVE_END_DATE	
		-------------------------------------------------------
	FROM ( SELECT ROWID                   AS STAGE_ROWID, 
	       ----------------------------------------------
				STAGE.VALUE                              AS STAGE_VALUE,
				STAGE.DESCRIPTION                        AS STAGE_DESCRIPTION,
				STAGE.REPORT_LABEL                       AS STAGE_REPORT_LABEL,
				STAGE.SCOPE                              AS STAGE_SCOPE,
				STAGE.CREATED_BY                         AS STAGE_CREATED_BY,
				STAGE.CREATE_TS                          AS STAGE_CREATE_TS,
				STAGE.UPDATED_BY                         AS STAGE_UPDATED_BY,
				STAGE.UPDATE_TS                          AS STAGE_UPDATE_TS,
				STAGE.ORDER_BY_DEFAULT                   AS STAGE_ORDER_BY_DEFAULT,
				STAGE.EFFECTIVE_START_DATE               AS STAGE_EFFECTIVE_START_DATE,
				STAGE.EFFECTIVE_END_DATE                 AS STAGE_EFFECTIVE_END_DATE	 	
			----------------------------------------------
			FROM ENUM_APP_DOC_REDACTION_REASON_STG STAGE
			WHERE STAGE.VALUE = DOC_REC.VALUE
           ) STAGE
	FULL OUTER JOIN
        ( SELECT ROWID AS TARGET_ROWID, 
	       ----------------------------------------------
			TARGET.VALUE                             AS TARGET_VALUE,
			TARGET.DESCRIPTION                       AS TARGET_DESCRIPTION,
			TARGET.REPORT_LABEL                      AS TARGET_REPORT_LABEL,
			TARGET.SCOPE                             AS TARGET_SCOPE,
			TARGET.CREATED_BY                        AS TARGET_CREATED_BY,
			TARGET.CREATE_TS                         AS TARGET_CREATE_TS,
			TARGET.UPDATED_BY                        AS TARGET_UPDATED_BY,
			TARGET.UPDATE_TS                         AS TARGET_UPDATE_TS,
			TARGET.ORDER_BY_DEFAULT                  AS TARGET_ORDER_BY_DEFAULT,
			TARGET.EFFECTIVE_START_DATE              AS TARGET_EFFECTIVE_START_DATE,
			TARGET.EFFECTIVE_END_DATE                AS TARGET_EFFECTIVE_END_DATE	
	       ----------------------------------------------
			FROM ENUM_APP_DOC_REDACTION_REASON TARGET
			WHERE TARGET.VALUE = DOC_REC.VALUE
          ) TARGET
	ON STAGE_VALUE = TARGET_VALUE;


	JOIN_STAGE_REC   JOIN_STAGE_CSR%ROWTYPE;

-- global data used for error logging

	GV_INSERT_COUNT			 	NUMBER(9) 	:= 0;
	GV_UPDATE_COUNT			 	NUMBER(9) 	:= 0;
	GV_DELETE_COUNT			 	NUMBER(9) 	:= 0;
	GV_STAGE_COUNT				NUMBER(9) 	:= 0;
	
	
	GV_ERR_LEVEL	 			VARCHAR2(20 BYTE) 		:= NULL;
	GV_PROCESS_NAME  			VARCHAR2(120 BYTE)		:= NULL; 
	GV_JOB_NAME 				VARCHAR2(120 BYTE)		:= 'ProcessMailFaxDoc_Redactions.kjb'; 
	GV_NR_OF_ERROR 				NUMBER					:= 0;
	GV_ERROR_DESC 				VARCHAR2(32000 BYTE) 	:= NULL; 
	GV_ERROR_FIELD	 			VARCHAR2(400 BYTE)		:= NULL; 
	GV_ERROR_CODES	 			VARCHAR2(400 BYTE)		:= NULL; 
	GV_CREATE_TS	 			DATE					:= SYSDATE; 
	GV_UPDATE_TS	 			DATE					:= SYSDATE; 
	GV_DRIVER_TABLE_NAME	 	VARCHAR2(100 BYTE)		:= 'ENUM_APP_DOC_REDACTION_REASON'; 
	GV_DRIVER_KEY_NUMBER	 	VARCHAR2(100 BYTE)		:= NULL;



-----------------------------------------------------
-------------------------------------------------
PROCEDURE LOG_ERROR IS
	BEGIN
		GV_ERR_LEVEL	 			:= 'CRITICAL';
		GV_PROCESS_NAME  			:= 'NYHIX MAIL FAX DOC V2';
		GV_JOB_NAME 				:= 'ProcessMailFaxDoc_Redactions.kjb'; 
		GV_NR_OF_ERROR 				:= SQLCODE;
		GV_ERROR_DESC 				:= SUBSTR(SQLERRM,1,4000); 
		GV_ERROR_FIELD	 			:= NULL; 
		GV_ERROR_CODES	 			:= NULL; 
		GV_CREATE_TS	 			:= SYSDATE; 
		GV_UPDATE_TS	 			:= SYSDATE; 
		GV_DRIVER_TABLE_NAME	 	:= 'ENUM_APP_DOC_REDACTION_REASON'; 
		GV_DRIVER_KEY_NUMBER	 	:= NVL(JOIN_STAGE_REC.STAGE_VALUE,
										JOIN_STAGE_REC.TARGET_VALUE);
									
	INSERT INTO CORP_ETL_ERROR_LOG(
			ERR_LEVEL,	 	
			PROCESS_NAME,  	
			JOB_NAME, 		
			NR_OF_ERROR, 		
			ERROR_DESC, 		
			ERROR_FIELD,	 	
			ERROR_CODES,	 	
			CREATE_TS,	 	
			UPDATE_TS,	 	
			DRIVER_TABLE_NAME,
			DRIVER_KEY_NUMBER
		)
	VALUES(
			GV_ERR_LEVEL,	 		
			GV_PROCESS_NAME,  		
			GV_JOB_NAME, 			
			GV_NR_OF_ERROR, 			
			GV_ERROR_DESC, 			
			GV_ERROR_FIELD,	 		
			GV_ERROR_CODES,	 		
			GV_CREATE_TS,	 		
			GV_UPDATE_TS,	 		
			GV_DRIVER_TABLE_NAME,	
			GV_DRIVER_KEY_NUMBER	
		);
	
		COMMIT;

	EXCEPTION
        WHEN OTHERS THEN 
		RAISE;

	END LOG_ERROR;

-----------------------------------------------------
-------------------------------------------------

PROCEDURE PROCESS_ENUM_APP_DOC_REDACTION_REASON IS

    BEGIN
	
		GV_INSERT_COUNT		:= 0;
		GV_UPDATE_COUNT		:= 0;
		GV_DELETE_COUNT		:= 0;
		GV_STAGE_COUNT		:= 0;
	
		SELECT COUNT(*) INTO GV_STAGE_COUNT
		FROM ENUM_APP_DOC_REDACTION_REASON_STG;

		-- SAFTY CHECK IF NO STAGE DO NOT FLAG ROWS AS DELETED
		IF GV_STAGE_COUNT = 0
		THEN
			RETURN;
		END IF;	

	

		IF (DOC_CSR%ISOPEN)
		THEN
			CLOSE DOC_CSR;
		END IF;

		OPEN DOC_CSR;

		LOOP

			FETCH DOC_CSR INTO DOC_REC;

			EXIT WHEN DOC_CSR%NOTFOUND;

			DBMS_OUTPUT.PUT_LINE('STARTING '||DOC_REC.VALUE);

			MERGE_PROCESS;

        END LOOP;

		IF (DOC_CSR%ISOPEN)
		THEN
			CLOSE DOC_CSR;
		END IF;


        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Rows Inserted: '||GV_Insert_count);
        DBMS_OUTPUT.PUT_LINE('Rows Updated: '||GV_Update_count);
        DBMS_OUTPUT.PUT_LINE('Rows Deleted: '||GV_Delete_count);


    EXCEPTION

        WHEN NO_DATA_FOUND
            THEN NULL;

        WHEN OTHERS THEN 
			GV_ERROR_CODES := 'PROCESS_ENUM_APP_DOC_REDACTION_REASON';
			LOG_ERROR;

    END PROCESS_ENUM_APP_DOC_REDACTION_REASON;
-----------------------------------------------------
-----------------------------------------------------

PROCEDURE MERGE_PROCESS IS
-----------------------------------------------------
    LV_ROW_COUNT        NUMBER := 0;

	BEGIN

        LV_ROW_COUNT := 0;

   		IF (JOIN_STAGE_CSR%ISOPEN)
		THEN
			CLOSE JOIN_STAGE_CSR;
		END IF;

		OPEN JOIN_STAGE_CSR;

		LOOP

			FETCH JOIN_STAGE_CSR INTO JOIN_STAGE_REC;

			EXIT WHEN JOIN_STAGE_CSR%NOTFOUND;

            LV_ROW_COUNT := LV_ROW_COUNT+1;

			IF 		JOIN_STAGE_REC.STAGE_ROWID IS NOT NULL
			AND 	JOIN_STAGE_REC.TARGET_ROWID IS NOT NULL
				THEN UPDATE_PROCESS;
			ELSIF 	JOIN_STAGE_REC.STAGE_ROWID IS NOT NULL
			AND 	JOIN_STAGE_REC.TARGET_ROWID IS NULL
				THEN 	INSERT_PROCESS;
			ELSIF 	JOIN_STAGE_REC.STAGE_ROWID IS NULL
			AND 	JOIN_STAGE_REC.TARGET_ROWID IS NOT NULL
				THEN DELETE_PROCESS;
			ELSE
				NULL;
			END IF;

		END LOOP;

		COMMIT;

		IF (JOIN_STAGE_CSR%ISOPEN)
		THEN
			CLOSE JOIN_STAGE_CSR;
		END IF;



	EXCEPTION

	    WHEN NO_DATA_FOUND
        THEN NULL;

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('CURSOR FAIL'||' '
            ||'STAGE_ROWID: '||JOIN_STAGE_REC.STAGE_ROWID||' '
            ||'TARGET_ROWID: '||JOIN_STAGE_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'MERGE_PROCESS';
            
            LOG_ERROR;

END MERGE_PROCESS;

-----------------------------------------------------
PROCEDURE UPDATE_PROCESS IS
-----------------------------------------------------

	BEGIN
	
	IF 1=2
	----------------------------------------------------------------------------------------
		OR NVL(JOIN_STAGE_REC.TARGET_VALUE,'-?93333')	  		<>  	NVL(JOIN_STAGE_REC.STAGE_VALUE,'-?93333')
		OR NVL(JOIN_STAGE_REC.TARGET_DESCRIPTION,'-?93333')	  	<>  	NVL(JOIN_STAGE_REC.STAGE_DESCRIPTION,'-?93333')
		OR NVL(JOIN_STAGE_REC.TARGET_REPORT_LABEL,'-?93333')	<>  	NVL(JOIN_STAGE_REC.STAGE_REPORT_LABEL,'-?93333')
		OR NVL(JOIN_STAGE_REC.TARGET_SCOPE,'-?93333')	  		<>  	NVL(JOIN_STAGE_REC.STAGE_SCOPE,'-?93333')
		OR NVL(JOIN_STAGE_REC.TARGET_CREATED_BY,'-?93333')	  	<>  	NVL(JOIN_STAGE_REC.STAGE_CREATED_BY,'-?93333')
		OR NVL(JOIN_STAGE_REC.TARGET_CREATE_TS,SYSDATE - 93333)	<>  	NVL(JOIN_STAGE_REC.STAGE_CREATE_TS,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_UPDATED_BY,'-?93333')	  	<>  	NVL(JOIN_STAGE_REC.STAGE_UPDATED_BY,'-?93333')
		OR NVL(JOIN_STAGE_REC.TARGET_UPDATE_TS,SYSDATE - 93333)	<>  	NVL(JOIN_STAGE_REC.STAGE_UPDATE_TS,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_ORDER_BY_DEFAULT, -93333)	<>  	NVL(JOIN_STAGE_REC.STAGE_ORDER_BY_DEFAULT, -93333)
		OR NVL(JOIN_STAGE_REC.TARGET_EFFECTIVE_START_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_STAGE_REC.STAGE_EFFECTIVE_START_DATE,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_EFFECTIVE_END_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_STAGE_REC.STAGE_EFFECTIVE_END_DATE,SYSDATE - 93333)	
		----------------------------------------------------------------------------------------
	THEN
		UPDATE MAXDAT.ENUM_APP_DOC_REDACTION_REASON
		SET
		----------------------------------------------------------------------------------------
			VALUE                     =  JOIN_STAGE_REC.STAGE_VALUE,
			DESCRIPTION               =  JOIN_STAGE_REC.STAGE_DESCRIPTION,
			REPORT_LABEL              =  JOIN_STAGE_REC.STAGE_REPORT_LABEL,
			SCOPE                     =  JOIN_STAGE_REC.STAGE_SCOPE,
			CREATED_BY                =  JOIN_STAGE_REC.STAGE_CREATED_BY,
			CREATE_TS                 =  JOIN_STAGE_REC.STAGE_CREATE_TS,
			UPDATED_BY                =  JOIN_STAGE_REC.STAGE_UPDATED_BY,
			UPDATE_TS                 =  JOIN_STAGE_REC.STAGE_UPDATE_TS,
			ORDER_BY_DEFAULT          =  JOIN_STAGE_REC.STAGE_ORDER_BY_DEFAULT,
			EFFECTIVE_START_DATE      =  JOIN_STAGE_REC.STAGE_EFFECTIVE_START_DATE,
			EFFECTIVE_END_DATE        =  JOIN_STAGE_REC.STAGE_EFFECTIVE_END_DATE,
		----------------------------------------------------------------------------------------
            MAXDAT_UPDATE_DATE        =  SYSDATE
            WHERE ROWID = JOIN_STAGE_REC.TARGET_ROWID;
			
			GV_UPDATE_COUNT := GV_UPDATE_COUNT+1;

	ELSE
		NULL;
	END IF;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAIL'||' '
            ||JOIN_STAGE_REC.STAGE_ROWID||' '
            ||JOIN_STAGE_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'UPDATE_PROCESS';

		LOG_ERROR;	


END UPDATE_PROCESS;


-----------------------------------------------------
PROCEDURE INSERT_PROCESS IS
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.ENUM_APP_DOC_REDACTION_REASON
		    (
			----------------------------------------------------------------------------------------
			VALUE,                         
			DESCRIPTION,                   
			REPORT_LABEL,                  
			SCOPE,                         
			CREATED_BY,                    
			CREATE_TS,                     
			UPDATED_BY,                    
			UPDATE_TS,                     
			ORDER_BY_DEFAULT,              
			EFFECTIVE_START_DATE,          
			EFFECTIVE_END_DATE,            
			----------------------------------------------------------------------------------------
            MAXDAT_INSERT_DATE
            )
		VALUES (
				----------------------------------------------------------------------------------------
				JOIN_STAGE_REC.STAGE_VALUE,
				JOIN_STAGE_REC.STAGE_DESCRIPTION,
				JOIN_STAGE_REC.STAGE_REPORT_LABEL,
				JOIN_STAGE_REC.STAGE_SCOPE,
				JOIN_STAGE_REC.STAGE_CREATED_BY,
				JOIN_STAGE_REC.STAGE_CREATE_TS,
				JOIN_STAGE_REC.STAGE_UPDATED_BY,
				JOIN_STAGE_REC.STAGE_UPDATE_TS,
				JOIN_STAGE_REC.STAGE_ORDER_BY_DEFAULT,
				JOIN_STAGE_REC.STAGE_EFFECTIVE_START_DATE,
				JOIN_STAGE_REC.STAGE_EFFECTIVE_END_DATE,
				----------------------------------------------------------------------------------------
				SYSDATE
			);

		GV_INSERT_COUNT := GV_INSERT_COUNT +1;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('INSERT FAIL'||' '
            ||JOIN_STAGE_REC.STAGE_ROWID||' '
            ||JOIN_STAGE_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'INSERT_PROCESS';

		LOG_ERROR;


END INSERT_PROCESS;

-----------------------------------------------------
PROCEDURE DELETE_PROCESS IS
-----------------------------------------------------

	BEGIN

		UPDATE MAXDAT.ENUM_APP_DOC_REDACTION_REASON
		SET MAXDAT_DELETE_DETECTED_DATE = SYSDATE
		WHERE ROWID = JOIN_STAGE_REC.TARGET_ROWID;
		
		GV_DELETE_COUNT := GV_DELETE_COUNT +1;

	exception

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DELETE FAIL'||' '
             ||JOIN_STAGE_REC.STAGE_ROWID||' '
            ||JOIN_STAGE_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'DELETE_PROCESS';

		LOG_ERROR;
            

END DELETE_PROCESS;


-----------------------------------------------------
-----------------------------------------------------

END ENUM_APP_DOC_REDACTION_REASON_PKG;
/

show errors

grant execute on ENUM_APP_DOC_REDACTION_REASON_PKG to maxdat_reports;
grant execute on ENUM_APP_DOC_REDACTION_REASON_PKG to maxdat_read_only;

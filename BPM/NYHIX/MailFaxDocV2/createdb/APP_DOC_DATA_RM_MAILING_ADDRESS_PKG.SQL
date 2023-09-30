CREATE OR REPLACE PACKAGE MAXDAT.APP_DOC_DATA_RM_MAILING_ADDRESS_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    PROCEDURE INSERT_PROCESS;
    PROCEDURE UPDATE_PROCESS;
    PROCEDURE DELETE_PROCESS;
	PROCEDURE MERGE_PROCESS;
	PROCEDURE UPDATE_ETL_CONTROL;
    PROCEDURE LOG_ERROR;

END APP_DOC_DATA_RM_MAILING_ADDRESS_PKG;
/
SHOW ERRORS

CREATE OR REPLACE PACKAGE BODY MAXDAT.APP_DOC_DATA_RM_MAILING_ADDRESS_PKG AS


    ---------------------------------------------------------------
    
	CURSOR JOIN_CSR IS
	SELECT
		SRC.ROWID								AS SRC_ROWID,
		TARGET_ROWID							AS TARGET_ROWID,
	-------------------------------------------------------
		SRC.RM_MAILING_ADDRESS_ID                AS SRC_RM_MAILING_ADDRESS_ID,          	-- 1 	1
		SRC.APP_DOC_TRACKER_ID                   AS SRC_APP_DOC_TRACKER_ID,                 -- 1 	2
		SRC.LMREQ_ID                             AS SRC_LMREQ_ID,                       	-- 1 	3
		SRC.ECN                                  AS SRC_ECN,                            	-- 1 	4
		SRC.FIRST_NAME                           AS SRC_FIRST_NAME,                     	-- 1 	5
		SRC.LAST_NAME                            AS SRC_LAST_NAME,                      	-- 1 	6
		SRC.STREET_1                             AS SRC_STREET_1,                       	-- 1 	7
		SRC.STREET_2                             AS SRC_STREET_2,                       	-- 1 	8
		SRC.CITY                                 AS SRC_CITY,                           	-- 1 	9
		SRC.STATE                                AS SRC_STATE,                          	-- 1 	10
		SRC.ZIP                                  AS SRC_ZIP,                            	-- 1 	11
		SRC.CREATE_TS                            AS SRC_CREATE_TS,                      	-- 1 	12
		SRC.CREATED_BY                           AS SRC_CREATED_BY,                     	-- 1 	13
		SRC.UPDATE_TS                            AS SRC_UPDATE_TS,                      	-- 1 	14
		SRC.UPDATED_BY                           AS SRC_UPDATED_BY,                     	-- 1 	15
		SRC.MAILING_REQ_IND                      AS SRC_MAILING_REQ_IND,                	-- 1 	16
		SRC.ERROR_MSG                            AS SRC_ERROR_MSG,                      	-- 1 	17
		---
		TARGET.RM_MAILING_ADDRESS_ID             AS TARGET_RM_MAILING_ADDRESS_ID,       	-- 2 	1
		TARGET.APP_DOC_TRACKER_ID                AS TARGET_APP_DOC_TRACKER_ID,              -- 2  	2
		TARGET.LMREQ_ID                          AS TARGET_LMREQ_ID,                    	-- 2 	3
		TARGET.ECN                               AS TARGET_ECN,                         	-- 2 	4
		TARGET.FIRST_NAME                        AS TARGET_FIRST_NAME,                  	-- 2 	5
		TARGET.LAST_NAME                         AS TARGET_LAST_NAME,                   	-- 2 	6
		TARGET.STREET_1                          AS TARGET_STREET_1,                    	-- 2 	7
		TARGET.STREET_2                          AS TARGET_STREET_2,                    	-- 2 	8
		TARGET.CITY                              AS TARGET_CITY,                        	-- 2 	9
		TARGET.STATE                             AS TARGET_STATE,                       	-- 2 	10
		TARGET.ZIP                               AS TARGET_ZIP,                         	-- 2 	11
		TARGET.CREATE_TS                         AS TARGET_CREATE_TS,                   	-- 2 	12
		TARGET.CREATED_BY                        AS TARGET_CREATED_BY,                  	-- 2 	13
		TARGET.UPDATE_TS                         AS TARGET_UPDATE_TS,                   	-- 2 	14
		TARGET.UPDATED_BY                        AS TARGET_UPDATED_BY,                  	-- 2 	15
		TARGET.MAILING_REQ_IND                   AS TARGET_MAILING_REQ_IND,             	-- 2 	16
		TARGET.ERROR_MSG                         AS TARGET_ERROR_MSG                   	-- 2 	17
	FROM ( 
        SELECT ROWID                   		   AS STAGE_ROWID, 
				RM_MAILING_ADDRESS_ID,          	-- 1 	1		
				APP_DOC_TRACKER_ID,             	-- 1 	2
				LMREQ_ID,                       	-- 1 	3
				ECN,                            	-- 1 	4
				FIRST_NAME,                     	-- 1 	5
				LAST_NAME,                      	-- 1 	6
				STREET_1,                       	-- 1 	7
				STREET_2,                       	-- 1 	8
				CITY,                           	-- 1 	9
				STATE,                          	-- 1 	10
				ZIP,                            	-- 1 	11
				CREATE_TS,                      	-- 1 	12
				CREATED_BY,                     	-- 1 	13
				UPDATE_TS,                      	-- 1 	14
				UPDATED_BY,                     	-- 1 	15
				MAILING_REQ_IND,                	-- 1 	16
				ERROR_MSG                      	-- 1 	17
			FROM APP_DOC_DATA_RM_MAILING_ADDRESS_STG STAGE
           ) SRC
	LEFT OUTER JOIN
        ( SELECT ROWID AS TARGET_ROWID, 
				RM_MAILING_ADDRESS_ID,          	-- 1 	1		
				APP_DOC_TRACKER_ID,              	-- 1 	2
				LMREQ_ID,                       	-- 1 	3
				ECN,                            	-- 1 	4
				FIRST_NAME,                     	-- 1 	5
				LAST_NAME,                      	-- 1 	6
				STREET_1,                       	-- 1 	7
				STREET_2,                       	-- 1 	8
				CITY,                           	-- 1 	9
				STATE,                          	-- 1 	10
				ZIP,                            	-- 1 	11
				CREATE_TS,                      	-- 1 	12
				CREATED_BY,                     	-- 1 	13
				UPDATE_TS,                      	-- 1 	14
				UPDATED_BY,                     	-- 1 	15
				MAILING_REQ_IND,                	-- 1 	16
				ERROR_MSG                      	    -- 1 	17
			FROM APP_DOC_DATA_RM_MAILING_ADDRESS
          ) TARGET
	ON SRC.RM_MAILING_ADDRESS_ID = TARGET.RM_MAILING_ADDRESS_ID;


	JOIN_REC   JOIN_CSR%ROWTYPE;

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
	GV_DRIVER_TABLE_NAME	 	VARCHAR2(100 BYTE)		:= 'APP_DOC_REDACTION_DATA'; 
	GV_DRIVER_KEY_NUMBER	 	VARCHAR2(100 BYTE)		:= NULL;



-----------------------------------------------------
PROCEDURE UPDATE_ETL_CONTROL IS
    
    LV_LAST_DATE        VARCHAR2(20) := '20220101 00:00:00';
    LV_LAST_ID          NUMBER := 0;

BEGIN

    -- INITIAL INSERTS INTO CORP_ETL_CONTROL
    --  INSERT INTO MAXDAT.CORP_ETL_CONTROL (
    --      NAME, VALUE_TYPE, VALUE, 
    --      DESCRIPTION, CREATED_TS, UPDATED_TS) 
    --  VALUES ( 'APP_DOC_RM_MAILING_ADDRESS_DATE', /* NAME */
    --          'D',        /* VALUE_TYPE */
    --          '20220101', /* VALUE */
    --          'Last UPDATE_TS or CREATE_TS from APP_DOC_DATA_RM_MAILING_ADDRESS',/* DESCRIPTION */
    --          SYSDATE, /* CREATED_TS */
    --          TO_DATE(NULL)/* UPDATED_TS */ 
    --          );
    
    --  INSERT INTO MAXDAT.CORP_ETL_CONTROL (
    --      NAME, VALUE_TYPE, VALUE, 
    --      DESCRIPTION, CREATED_TS, UPDATED_TS) 
    --  VALUES ( 'APP_DOC_RM_MAILING_ADDRESS_ID', /* NAME */
    --          'N',        /* VALUE_TYPE */
    --          '0', /* VALUE */
    --          'Last RM_MAILING_ADDRESS_ID from APP_DOC_DATA_RM_MAILING_ADDRESS',/* DESCRIPTION */
    --          SYSDATE, /* CREATED_TS */
    --          TO_DATE(NULL)/* UPDATED_TS */ 
    --          );
    
    
    SELECT TO_CHAR(MAX(LAST_DATE),'YYYY/MM/DD HH24:MI:SS'), MAX(LAST_ID)
    INTO LV_LAST_DATE, LV_LAST_ID
    FROM (
        SELECT MAX(COALESCE(UPDATE_TS, CREATE_TS)) AS LAST_DATE,
        MAX(RM_MAILING_ADDRESS_ID) AS LAST_ID
        FROM APP_DOC_DATA_RM_MAILING_ADDRESS
        UNION ALL
        SELECT TO_DATE('2022/01/01 00:00:00','YYYY/MM/DD HH24:MI:SS') AS LAST_DATE, 
        0 AS LAST_ID 
        FROM DUAL
        );
    
    UPDATE CORP_ETL_CONTROL
    SET VALUE = LV_LAST_DATE
    WHERE NAME = 'APP_DOC_DATA_RM_MAILING_ADDRESS_DATE';

    UPDATE CORP_ETL_CONTROL
    SET VALUE = LV_LAST_ID
    WHERE NAME = 'APP_DOC_DATA_RM_MAILING_ADDRESS_ID';
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN RAISE;
    
END;    
-------------------------------------------------
PROCEDURE LOG_ERROR IS
	BEGIN
		GV_ERR_LEVEL	 			:= 'CRITICAL';
		GV_PROCESS_NAME  			:= 'APP_DOC_DATA_RM_ADDRESSES';
		GV_JOB_NAME 				:= 'APP_DOC_DATA_RM_ADDRESSES.kjb'; 
		GV_NR_OF_ERROR 				:= SQLCODE;
		GV_ERROR_DESC 				:= SUBSTR(SQLERRM,1,4000); 
		GV_ERROR_FIELD	 			:= NULL; 
		GV_ERROR_CODES	 			:= NULL; 
		GV_CREATE_TS	 			:= SYSDATE; 
		GV_UPDATE_TS	 			:= SYSDATE; 
		GV_DRIVER_TABLE_NAME	 	:= 'APP_DOC_DATA_RM_MAILING_ADDRESS'; 
		GV_DRIVER_KEY_NUMBER	 	:= NVL(JOIN_REC.SRC_RM_MAILING_ADDRESS_ID,
										   JOIN_REC.TARGET_RM_MAILING_ADDRESS_ID);
									
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

PROCEDURE MERGE_PROCESS IS
-----------------------------------------------------
    LV_ROW_COUNT        NUMBER := 0;

	BEGIN

        LV_ROW_COUNT := 0;

   		IF (JOIN_CSR%ISOPEN)
		THEN
			CLOSE JOIN_CSR;
		END IF;

		OPEN JOIN_CSR;

		LOOP

			FETCH JOIN_CSR INTO JOIN_REC;

			EXIT WHEN JOIN_CSR%NOTFOUND;

            LV_ROW_COUNT := LV_ROW_COUNT+1;

			IF 		JOIN_REC.SRC_ROWID IS NOT NULL
			AND 	JOIN_REC.TARGET_ROWID IS NOT NULL
				THEN UPDATE_PROCESS;
			ELSIF 	JOIN_REC.SRC_ROWID IS NOT NULL
			AND 	JOIN_REC.TARGET_ROWID IS NULL
				THEN 	INSERT_PROCESS;
			ELSIF 	JOIN_REC.SRC_ROWID IS NULL
			AND 	JOIN_REC.TARGET_ROWID IS NOT NULL
				THEN DELETE_PROCESS;
			ELSE
				NULL;
			END IF;

		END LOOP;

		COMMIT;

		IF (JOIN_CSR%ISOPEN)
		THEN
			CLOSE JOIN_CSR;
		END IF;

        UPDATE_ETL_CONTROL;

	EXCEPTION

	    WHEN NO_DATA_FOUND
        THEN NULL;

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('CURSOR FAIL'||' '
            ||'STAGE_ROWID: '||JOIN_REC.SRC_ROWID||' '
            ||'TARGET_ROWID: '||JOIN_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'MERGE_PROCESS';
            
            LOG_ERROR;

END MERGE_PROCESS;

-----------------------------------------------------
PROCEDURE UPDATE_PROCESS IS
-----------------------------------------------------

	BEGIN
	
	IF 
	-----
            1=2
            OR NVL(JOIN_REC.TARGET_APP_DOC_TRACKER_ID, -93333)  <>  	NVL(JOIN_REC.SRC_APP_DOC_TRACKER_ID, -93333)    -- 5 	2	NUMBER
            OR NVL(JOIN_REC.TARGET_LMREQ_ID, -93333)	  		<>  	NVL(JOIN_REC.SRC_LMREQ_ID, -93333)				-- 5 	3	NUMBER
            OR NVL(JOIN_REC.TARGET_ECN,'-?93333')	  			<>  	NVL(JOIN_REC.SRC_ECN,'-?93333')					-- 5 	4	VARCHAR2
            OR NVL(JOIN_REC.TARGET_FIRST_NAME,'-?93333')	  	<>  	NVL(JOIN_REC.SRC_FIRST_NAME,'-?93333')			-- 5 	5	VARCHAR2
            OR NVL(JOIN_REC.TARGET_LAST_NAME,'-?93333')	  		<>  	NVL(JOIN_REC.SRC_LAST_NAME,'-?93333')			-- 5 	6	VARCHAR2
            OR NVL(JOIN_REC.TARGET_STREET_1,'-?93333')	  		<>  	NVL(JOIN_REC.SRC_STREET_1,'-?93333')			-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_STREET_2,'-?93333')	  		<>  	NVL(JOIN_REC.SRC_STREET_2,'-?93333')			-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CITY,'-?93333')	  			<>  	NVL(JOIN_REC.SRC_CITY,'-?93333')				-- 5 	9	VARCHAR2
            OR NVL(JOIN_REC.TARGET_STATE,'-?93333')	  			<>  	NVL(JOIN_REC.SRC_STATE,'-?93333')				-- 5 	10	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ZIP,'-?93333')	  			<>  	NVL(JOIN_REC.SRC_ZIP,'-?93333')					-- 5 	11	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CREATE_TS,SYSDATE - 93333)	<>  	NVL(JOIN_REC.SRC_CREATE_TS,SYSDATE - 93333)		-- 5 	12	DATE
            OR NVL(JOIN_REC.TARGET_CREATED_BY,'-?93333')	  	<>  	NVL(JOIN_REC.SRC_CREATED_BY,'-?93333')			-- 5 	13	VARCHAR2
            OR NVL(JOIN_REC.TARGET_UPDATE_TS,SYSDATE - 93333)	<>  	NVL(JOIN_REC.SRC_UPDATE_TS,SYSDATE - 93333)		-- 5 	14	DATE
            OR NVL(JOIN_REC.TARGET_UPDATED_BY,'-?93333')	  	<>  	NVL(JOIN_REC.SRC_UPDATED_BY,'-?93333')			-- 5 	15	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MAILING_REQ_IND, -93333)	  	<>  	NVL(JOIN_REC.SRC_MAILING_REQ_IND, -93333)		-- 5 	16	NUMBER
            OR NVL(JOIN_REC.TARGET_ERROR_MSG,'-?93333')	  		<>  	NVL(JOIN_REC.SRC_ERROR_MSG,'-?93333')			-- 5 	17	VARCHAR2
	-----
	THEN
		UPDATE MAXDAT.APP_DOC_DATA_RM_MAILING_ADDRESS
		SET
            APP_DOC_TRACKER_ID                        =  JOIN_REC.SRC_APP_DOC_TRACKER_ID,   		-- 6 	2
            LMREQ_ID                                  =  JOIN_REC.SRC_LMREQ_ID,					-- 6 	3
            ECN                                       =  JOIN_REC.SRC_ECN,						-- 6 	4
            FIRST_NAME                                =  JOIN_REC.SRC_FIRST_NAME,				-- 6 	5
            LAST_NAME                                 =  JOIN_REC.SRC_LAST_NAME,				-- 6 	6
            STREET_1                                  =  JOIN_REC.SRC_STREET_1,					-- 6 	7
            STREET_2                                  =  JOIN_REC.SRC_STREET_2,					-- 6 	8
            CITY                                      =  JOIN_REC.SRC_CITY,						-- 6 	9
            STATE                                     =  JOIN_REC.SRC_STATE,					-- 6 	10
            ZIP                                       =  JOIN_REC.SRC_ZIP,						-- 6 	11
            CREATE_TS                                 =  JOIN_REC.SRC_CREATE_TS,				-- 6 	12
            CREATED_BY                                =  JOIN_REC.SRC_CREATED_BY,				-- 6 	13
            UPDATE_TS                                 =  JOIN_REC.SRC_UPDATE_TS,				-- 6 	14
            UPDATED_BY                                =  JOIN_REC.SRC_UPDATED_BY,				-- 6 	15
            MAILING_REQ_IND                           =  JOIN_REC.SRC_MAILING_REQ_IND,			-- 6 	16
            ERROR_MSG                                 =  JOIN_REC.SRC_ERROR_MSG				    -- 6 	17
            WHERE ROWID = JOIN_REC.TARGET_ROWID;

		GV_UPDATE_COUNT := GV_UPDATE_COUNT+1;

	ELSE
		NULL;
	END IF;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAIL'||' '
            ||JOIN_REC.SRC_ROWID||' '
            ||JOIN_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'UPDATE_PROCESS';

		LOG_ERROR;	


END UPDATE_PROCESS;


-----------------------------------------------------
PROCEDURE INSERT_PROCESS IS
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.APP_DOC_DATA_RM_MAILING_ADDRESS
		    (
            RM_MAILING_ADDRESS_ID,                  	-- 7 	1
            APP_DOC_TRACKER_ID,                       	-- 7 	2
            LMREQ_ID,                               	-- 7 	3
            ECN,                                    	-- 7 	4
            FIRST_NAME,                             	-- 7 	5
            LAST_NAME,                              	-- 7 	6
            STREET_1,                               	-- 7 	7
            STREET_2,                               	-- 7 	8
            CITY,                                   	-- 7 	9
            STATE,                                  	-- 7 	10
            ZIP,                                    	-- 7 	11
            CREATE_TS,                              	-- 7 	12
            CREATED_BY,                             	-- 7 	13
            UPDATE_TS,                              	-- 7 	14
            UPDATED_BY,                             	-- 7 	15
            MAILING_REQ_IND,                        	-- 7 	16
            ERROR_MSG                              	    -- 7 	17
            )
		VALUES (
            JOIN_REC.SRC_RM_MAILING_ADDRESS_ID,			-- 8 	1
            JOIN_REC.SRC_APP_DOC_TRACKER_ID,			-- 8 	2
            JOIN_REC.SRC_LMREQ_ID,						-- 8 	3
            JOIN_REC.SRC_ECN,							-- 8 	4
            JOIN_REC.SRC_FIRST_NAME,					-- 8 	5
            JOIN_REC.SRC_LAST_NAME,						-- 8 	6
            JOIN_REC.SRC_STREET_1,						-- 8 	7
            JOIN_REC.SRC_STREET_2,						-- 8 	8
            JOIN_REC.SRC_CITY,							-- 8 	9
            JOIN_REC.SRC_STATE,							-- 8 	10
            JOIN_REC.SRC_ZIP,							-- 8 	11
            JOIN_REC.SRC_CREATE_TS,						-- 8 	12
            JOIN_REC.SRC_CREATED_BY,					-- 8 	13
            JOIN_REC.SRC_UPDATE_TS,						-- 8 	14
            JOIN_REC.SRC_UPDATED_BY,					-- 8 	15
            JOIN_REC.SRC_MAILING_REQ_IND,				-- 8 	16
            JOIN_REC.SRC_ERROR_MSG						-- 8 	17
			);

		GV_INSERT_COUNT := GV_INSERT_COUNT +1;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('INSERT FAIL'||' '
            ||JOIN_REC.SRC_ROWID||' '
            ||JOIN_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'INSERT_PROCESS';

		LOG_ERROR;


END INSERT_PROCESS;

-----------------------------------------------------
PROCEDURE DELETE_PROCESS IS
-----------------------------------------------------

	BEGIN

		NULL;

	exception

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DELETE FAIL'||' '
             ||JOIN_REC.SRC_ROWID||' '
            ||JOIN_REC.TARGET_ROWID);

			GV_ERROR_CODES := 'DELETE_PROCESS';

		LOG_ERROR;
            

END DELETE_PROCESS;


-----------------------------------------------------
-----------------------------------------------------

END APP_DOC_DATA_RM_MAILING_ADDRESS_PKG;
/
SHOW ERRORS
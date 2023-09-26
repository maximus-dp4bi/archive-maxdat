DROP PACKAGE ETL_JOB;

ALTER SESSION SET plsql_code_type = native;

-- BEGIN PACKAGE ETL_JOB
CREATE OR REPLACE PACKAGE ETL_JOB AS

    -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '$URL$'; 
    SVN_REVISION varchar2(20) := '$Revision$'; 
    SVN_REVISION_DATE varchar2(60) := '$Date$'; 
    SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

	-- Package level variables
	gv_DEFAULT_RETENTION_DAYS VARCHAR2(4) := '2000';            -- default number of retention days for AUDIT, LOG, RUN tables if missing in global config table
	gv_DEFAULT_TIMEOUT_SECS VARCHAR2(10) := '9999999999';       -- default job timeout in seconds to identify if job is running long or got stuck, if missing in job control and global control tables    
	gv_DEFAULT_HIGH_DATE VARCHAR2(10) := '2999-12-31';          -- default date for job next execution time when job schedule is missing or null
	gv_DATETIME_FORMAT VARCHAR2(21) := 'YYYY-MM-DD HH24:MI:SS'; -- default format for datetime
	gv_DATE_FORMAT VARCHAR2(10) := 'YYYY-MM-DD';                -- default format for date 
	
    -- List of Functions
    -- F_GET_NEXT_JOB_SCHEDULE calls rest of the functions
    FUNCTION F_PARSE_NUMBER_RANGE (p_Number_Range IN VARCHAR2) 
        RETURN VARCHAR2;
    FUNCTION F_GET_NEXT_NUMBER (p_Search_Number IN NUMBER, 
                                p_Search_Within IN VARCHAR2) 
        RETURN NUMBER;
    FUNCTION F_GET_MIN_NUMBER (p_Search_Within IN VARCHAR2) 
        RETURN NUMBER;
    FUNCTION F_IS_NUMBER_VALID (p_Search_Number IN NUMBER, 
                                p_Search_Within IN VARCHAR2) 
        RETURN VARCHAR2;
    FUNCTION F_GET_NEXT_JOB_SCHEDULE (p_inp_date IN DATE, 
                                      p_job_schedule IN VARCHAR2) 
        RETURN VARCHAR2;

    -- List of Procedures
    PROCEDURE ADD_ETL_LOG (p_log_desc IN VARCHAR2, 
                           p_log_severity IN VARCHAR2, 
                           p_log_code IN NUMBER, 
                           p_job_id IN NUMBER, 
                           p_run_id IN NUMBER, 
                           p_step_id IN NUMBER, 
                           p_step_desc IN VARCHAR2);
    PROCEDURE PURGE_ETL_JOB_DATA;
    PROCEDURE SET_ETL_JOBS;
    PROCEDURE ADD_ETL_JOB (p_job_id IN NUMBER);
    PROCEDURE UPD_ETL_JOB (p_job_id IN NUMBER, 
                           p_job_status IN VARCHAR2, 
                           p_apply_to_childs IN VARCHAR2);

END;
/
-- END PACKAGE ETL_JOB

-- BEGIN PACKAGE BODY ETL_JOB
CREATE OR REPLACE PACKAGE BODY ETL_JOB AS
    
    -- BEGIN FUNCTION F_PARSE_NUMBER_RANGE
    FUNCTION F_PARSE_NUMBER_RANGE (p_Number_Range IN VARCHAR2) 
    RETURN VARCHAR2
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
        
        v_Pos INT;
        v_Pos2 INT;
        v_indx INT;
        v_InStr VARCHAR2(200);
        v_SubStr VARCHAR2(200);
        v_OutStr VARCHAR2(200);
    BEGIN
        
        -- STEP 10: initialize variable to parameter
        v_step_id := 10;
        v_step_desc := 'initialize variable to parameter';
        
        v_InStr := p_Number_Range;
        
        -- STEP 20: Loop through the string after each comma 
        v_step_id := 20;
        v_step_desc := 'Loop through the string after each comma';
        
        LOOP
            v_Pos := INSTR(v_InStr,',');
    
            -- STEP 30: check for multiple values
            v_step_id := 30;
            v_step_desc := 'check for multiple values';
            
            IF (v_Pos = 0) THEN
                v_SubStr := v_InStr;	
            ELSE
                v_SubStr := SUBSTR(v_InStr, 1, v_Pos - 1);
                v_InStr := SUBSTR(v_InStr, v_Pos + 1, LENGTH(v_InStr)- v_Pos);
            END IF;
            
            -- STEP 40: check for range 
            v_step_id := 40;
            v_step_desc := 'check for range';
            
            IF INSTR(v_SubStr,'-') = 0 THEN
                v_OutStr := v_OutStr || v_SubStr || ',';
            ELSE
                v_Pos2 := INSTR(v_SubStr,'-');
                FOR v_indx IN TO_NUMBER(SUBSTR(v_SubStr, 1, v_Pos2 - 1)) .. TO_NUMBER(SUBSTR(v_SubStr, v_Pos2 + 1, LENGTH(v_SubStr)- v_Pos2)) LOOP
                    v_OutStr := v_OutStr || to_char(v_indx) || ',';  
                END LOOP;
            END IF;
            
            -- STEP 50: exit when no more commas 
            v_step_id := 50;
            v_step_desc := 'exit when no more commas';
            
            EXIT WHEN v_Pos = 0;
        END LOOP;
        
        -- STEP 60: return the parsed vaue 
        v_step_id := 60;
        v_step_desc := 'return the parsed vaue';
        
        RETURN SUBSTR(v_OutStr, 1, LENGTH(v_OutStr)-1);
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.F_PARSE_NUMBER_RANGE function : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END FUNCTION F_PARSE_NUMBER_RANGE
    
    -- BEGIN FUNCTION F_GET_NEXT_NUMBER
    FUNCTION F_GET_NEXT_NUMBER (p_Search_Number IN NUMBER, 
                                p_Search_Within IN VARCHAR2) 
    RETURN NUMBER
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
        
        v_Pos INT;
        v_OutNum INT := 0;
        v_SubStr VARCHAR2(200);
    BEGIN
        
        -- STEP 10: find first comma
        v_step_id := 10;
        v_step_desc := 'find first comma';
        
        v_Pos := INSTR(p_Search_Within,',');
    
        -- STEP 20: if there is a single value, return it. If not, keep splitting for each comma
        v_step_id := 20;
        v_step_desc := 'if there is a single value, return it. If not, keep splitting for each comma';
        
        IF (v_Pos = 0) THEN
            v_OutNum := TO_NUMBER(p_Search_Within);
            RETURN v_OutNum;
        ELSE
            v_OutNum := TO_NUMBER(SUBSTR(p_Search_Within, 1, v_Pos - 1));
        END IF;
        
        -- STEP 30: initialize variable to parameter and loop until all commas are covered
        v_step_id := 30;
        v_step_desc := 'initialize variable to parameter and loop until all commas are covered';
        
        v_SubStr := p_Search_Within;	    
        LOOP
            v_Pos := INSTR(v_SubStr,',');
    
            -- STEP 40: check for commas
            v_step_id := 40;
            v_step_desc := 'check for commas';
            
            IF (v_Pos = 0) THEN
                IF TO_NUMBER(v_SubStr) > p_Search_Number THEN
                    v_OutNum := TO_NUMBER(v_SubStr);
                END IF;	
            ELSE
                IF TO_NUMBER(SUBSTR(v_SubStr, 1, v_Pos - 1)) > p_Search_Number THEN
                    v_OutNum := TO_NUMBER(SUBSTR(v_SubStr, 1, v_Pos - 1));
                    v_Pos := 0;
                ELSE
                    v_SubStr := SUBSTR(v_SubStr, v_Pos + 1, LENGTH(v_SubStr)- v_Pos);
                END IF;
            END IF;
            
            -- STEP 50: exit after last comma
            v_step_id := 50;
            v_step_desc := 'exit after last comma';
            
            EXIT WHEN v_Pos = 0;
        END LOOP;
        
        -- STEP 60: return the next number identified
        v_step_id := 60;
        v_step_desc := 'return the next number identified';
        
        RETURN v_OutNum;
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.F_GET_NEXT_NUMBER function : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END FUNCTION F_GET_NEXT_NUMBER
    
    -- BEGIN FUNCTION F_GET_MIN_NUMBER
    FUNCTION F_GET_MIN_NUMBER (p_Search_Within IN VARCHAR2) 
    RETURN NUMBER
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
        
        v_Pos INT;
        v_OutNum INT;
    BEGIN
        
        -- STEP 10: find first comma
        v_step_id := 10;
        v_step_desc := 'find first comma';
        
        v_Pos := INSTR(p_Search_Within,',');
    
        -- STEP 20: if a single value, return it. if not, extract the value before first comma
        v_step_id := 20;
        v_step_desc := 'if a single value, return it. if not, extract the value before first comma';
        
        IF (v_Pos = 0) THEN
            v_OutNum := TO_NUMBER(p_Search_Within);
        ELSE
            v_OutNum := TO_NUMBER(SUBSTR(p_Search_Within, 1, v_Pos - 1));
        END IF;
        
        -- STEP 30: return the minimum number identified
        v_step_id := 30;
        v_step_desc := 'return the minimum number identified';
        
        RETURN v_OutNum;
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.F_GET_MIN_NUMBER function : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END FUNCTION F_GET_MIN_NUMBER
    
    -- BEGIN FUNCTION F_IS_NUMBER_VALID
    FUNCTION F_IS_NUMBER_VALID (p_Search_Number IN NUMBER, 
                                p_Search_Within IN VARCHAR2) 
    RETURN VARCHAR2
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
        
        v_Pos INT;
        v_SubStr VARCHAR2(100);
        v_OutStr VARCHAR2(1) := 'N';
    BEGIN
        
        -- STEP 10: initialize variable to parameter
        v_step_id := 10;
        v_step_desc := 'initialize variable to parameter';
        
        v_SubStr := p_Search_Within;
        
        -- STEP 20: loop through each number and check 
        v_step_id := 20;
        v_step_desc := 'loop through each number and check';
        
        LOOP
            -- STEP 30: check for comma 
            v_step_id := 30;
            v_step_desc := 'check for comma';
            
            v_Pos := INSTR(v_SubStr,',');
    
            -- STEP 40: no more commas - check with last number, if not, get the next number
            v_step_id := 40;
            v_step_desc := 'no more commas - check with last number, if not, get the next number';
            
            IF (v_Pos = 0) THEN
                IF p_Search_Number = TO_NUMBER(v_SubStr) THEN
                    v_OutStr := 'Y';
                END IF;	
            ELSE
                IF p_Search_Number = TO_NUMBER(SUBSTR(v_SubStr, 1, v_Pos - 1)) THEN
                    v_OutStr := 'Y';
                    v_Pos := 0;
                ELSE
                    v_SubStr := SUBSTR(v_SubStr, v_Pos + 1, LENGTH(v_SubStr)- v_Pos);
                END IF;
            END IF;
            
            -- STEP 50: exit when there are no more commas 
            v_step_id := 50;
            v_step_desc := 'exit when there are no more commas';
            
            EXIT WHEN v_Pos = 0;
        END LOOP;
        
        -- STEP 60: return Y/N if number is valid/invalid
        v_step_id := 60;
        v_step_desc := 'return Y/N if number is valid/invalid';
        
        RETURN v_OutStr;
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.F_IS_NUMBER_VALID function : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END FUNCTION F_IS_NUMBER_VALID

    -- BEGIN FUNCTION F_GET_NEXT_JOB_SCHEDULE
    FUNCTION F_GET_NEXT_JOB_SCHEDULE  (p_inp_date IN DATE, 
                                       p_job_schedule IN VARCHAR2) 
    RETURN VARCHAR2
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
        
        v_hr_pos INT;
        v_d_pos INT;
        v_mn_pos INT;
        v_dw_pos INT;
    
        v_i_mi_str VARCHAR2(20);
        v_i_hr_str VARCHAR2(20);
        v_i_dy_str VARCHAR2(20);
        v_i_mn_str VARCHAR2(20);
        v_i_dw_str VARCHAR2(20);
    
        v_i_mi_parse_str VARCHAR2(100);
        v_i_hr_parse_str VARCHAR2(100);
        v_i_dy_parse_str VARCHAR2(100);
        v_i_mn_parse_str VARCHAR2(100);
        v_i_dw_parse_str VARCHAR2(100);
    
        v_o_mi INT;
        v_o_hr INT;
        v_o_dy INT;
        v_o_mn INT;
        v_o_yr INT;
        v_o_dw INT;
       
        v_o_next_schedule DATE;
       
        v_curr_mi INT;
        v_curr_hr INT;
        v_curr_dy INT;
        v_curr_mn INT;
        v_curr_yr INT;
        v_curr_dw INT;
      
        v_next_mi INT;
        v_next_hr INT;
        v_next_dy INT;
        v_next_mn INT;
        v_next_dw INT;
    
        v_min_mi INT;
        v_min_hr INT;
        v_min_dy INT;
        v_min_mn INT;
        v_min_dw INT;
   
    BEGIN
    
        -- STEP 10: get the current system date/time 
        v_step_id := 10;
        v_step_desc := 'get the current system date/time';
        
        v_curr_yr := TO_NUMBER(SUBSTR(TO_CHAR(p_inp_date,gv_DATETIME_FORMAT),1,4));
        v_curr_mn := TO_NUMBER(SUBSTR(TO_CHAR(p_inp_date,gv_DATETIME_FORMAT),6,2));
        v_curr_dy := TO_NUMBER(SUBSTR(TO_CHAR(p_inp_date,gv_DATETIME_FORMAT),9,2));
        v_curr_hr := TO_NUMBER(SUBSTR(TO_CHAR(p_inp_date,gv_DATETIME_FORMAT),12,2));
        v_curr_mi := TO_NUMBER(SUBSTR(TO_CHAR(p_inp_date,gv_DATETIME_FORMAT),15,2));
        v_curr_dw := TO_NUMBER(TO_CHAR(p_inp_date,'D'))-1;
       
        -- STEP 20: set output date/time as current date/time before making changes based on JOB_SCHEDULE 
        v_step_id := 20;
        v_step_desc := 'set output date/time as current date/time before making changes based on JOB_SCHEDULE';
        
        v_o_yr := v_curr_yr;
        v_o_mn := v_curr_mn;
        v_o_dy := v_curr_dy;
        v_o_hr := v_curr_hr;
        v_o_mi := v_curr_mi;
       
        -- STEP 30: extract schedule info in terms of hours, days, months, weeks etc.,
        v_step_id := 30;
        v_step_desc := 'extract schedule info in terms of hours, days, months, weeks etc.,';
        
        v_hr_pos := INSTR(p_job_schedule, ' ',1, 1)+1;
        v_d_pos := INSTR(p_job_schedule, ' ',1, 2)+1;
        v_mn_pos := INSTR(p_job_schedule, ' ',1, 3)+1;
        v_dw_pos := INSTR(p_job_schedule, ' ',1, 4)+1;
     
        v_i_mi_str := SUBSTR(p_job_schedule, 1, v_hr_pos-2);
        v_i_hr_str := SUBSTR(p_job_schedule, v_hr_pos, v_d_pos - v_hr_pos-1);
        v_i_dy_str := SUBSTR(p_job_schedule, v_d_pos, v_mn_pos - v_d_pos-1);
        v_i_mn_str := SUBSTR(p_job_schedule, v_mn_pos, v_dw_pos - v_mn_pos-1);
        v_i_dw_str := SUBSTR(p_job_schedule, v_dw_pos, LENGTH(p_job_schedule)-v_dw_pos+1);
       
        -- STEP 40: get next minute, hour, day, month, year from job schedule   
        v_step_id := 40;
        v_step_desc := 'get next minute, hour, day, month, year from job schedule';
        
        v_i_mi_parse_str := F_PARSE_NUMBER_RANGE(v_i_mi_str);
        IF v_i_hr_str = '*' THEN
            v_i_hr_parse_str := F_PARSE_NUMBER_RANGE('0-23');
        ELSE
            v_i_hr_parse_str := F_PARSE_NUMBER_RANGE(v_i_hr_str);
        END IF;
        IF v_i_dy_str = '*' THEN
            IF v_curr_mn IN (1,3,5,7,8,10,12) THEN
                v_i_dy_parse_str := F_PARSE_NUMBER_RANGE('1-31');
            ELSIF v_curr_mn IN (4,6,9,11) THEN
                v_i_dy_parse_str := F_PARSE_NUMBER_RANGE('1-30');
            ELSIF MOD(v_curr_yr,4)=0 THEN
                v_i_dy_parse_str := F_PARSE_NUMBER_RANGE('1-29');
            ELSE
                v_i_dy_parse_str := F_PARSE_NUMBER_RANGE('1-28');
            END IF;
        else
            v_i_dy_parse_str := F_PARSE_NUMBER_RANGE(v_i_dy_str);
        END IF;
        IF v_i_mn_str = '*' THEN
            v_i_mn_parse_str := F_PARSE_NUMBER_RANGE('1-12');
        ELSE
            v_i_mn_parse_str := F_PARSE_NUMBER_RANGE(v_i_mn_str);
        END IF;
        IF v_i_dw_str = '*' THEN
            v_i_dw_parse_str := F_PARSE_NUMBER_RANGE('0-6');
        ELSE
            v_i_dw_parse_str := F_PARSE_NUMBER_RANGE(v_i_dw_str);
        END IF;
       
        v_next_mi := F_GET_NEXT_NUMBER(v_o_mi,v_i_mi_parse_str);
        v_next_hr := F_GET_NEXT_NUMBER(v_o_hr,v_i_hr_parse_str);
        v_next_dy := F_GET_NEXT_NUMBER(v_o_dy,v_i_dy_parse_str);
        v_next_mn := F_GET_NEXT_NUMBER(v_o_mn,v_i_mn_parse_str);
        v_next_dw := F_GET_NEXT_NUMBER(v_o_mn,v_i_dw_parse_str);
       
        v_min_mi := F_GET_MIN_NUMBER(v_i_mi_parse_str);
        v_min_hr := F_GET_MIN_NUMBER(v_i_hr_parse_str);
        v_min_dy := F_GET_MIN_NUMBER(v_i_dy_parse_str);
        v_min_mn := F_GET_MIN_NUMBER(v_i_mn_parse_str);
        v_min_dw := F_GET_MIN_NUMBER(v_i_dw_parse_str);
      
        -- STEP 50:  Cascade and get next minute, hours, day, month, year, where necessary
        v_step_id := 50;
        v_step_desc := 'Cascade and get next minute, hours, day, month, year, where necessary';
        
        IF v_next_mi > v_o_mi THEN
            v_o_mi := v_next_mi;     
        ELSE
            v_o_mi := v_next_mi;
            IF v_next_hr > v_o_hr THEN
                v_o_hr := v_next_hr;     
            ELSE
                v_o_hr := v_next_hr;
                IF v_next_dy > v_o_dy THEN
                    v_o_dy := v_next_dy;     
                ELSE
                    v_o_dy := v_next_dy;
                    IF v_next_mn > v_o_mn THEN
                        v_o_mn := v_next_mn;     
                    ELSE
                        v_o_mn := v_next_mn;
                        v_o_yr := v_o_yr + 1; 
                    END IF;                 
               END IF;
           END IF;
        END IF;
       
        -- STEP 60: Validate hours from the calculation and make necessary cascading changes if needed
        v_step_id := 60;
        v_step_desc := 'Validate hours from the calculation and make necessary cascading changes if needed';
        
        IF F_IS_NUMBER_VALID(v_o_hr, v_i_hr_parse_str) = 'N' THEN
            v_o_mi := v_min_mi;
            
            v_next_hr := F_GET_NEXT_NUMBER(v_o_hr,v_i_hr_parse_str);
            IF v_next_hr > v_o_hr THEN
                v_o_hr := v_next_hr;
            ELSE
                v_o_hr := v_next_hr;
    
                v_next_dy := F_GET_NEXT_NUMBER(v_o_dy,v_i_dy_parse_str);
                IF v_next_dy > v_o_dy THEN
                    v_o_dy := v_next_dy;     
                ELSE
                    v_o_dy := v_next_dy;
    
                    v_next_mn:= F_GET_NEXT_NUMBER(v_o_mn,v_i_mn_parse_str);
                    IF v_next_mn > v_o_mn THEN
                        v_o_mn := v_next_mn;     
                    ELSE
                        v_o_mn := v_next_mn;
                        v_o_yr := v_o_yr + 1; 
                    END IF;                 
               END IF;
            END IF;
        END IF;
    
        -- STEP 70: Validate hours from the calculation and make necessary cascading changes if needed
        v_step_id := 70;
        v_step_desc := 'Validate hours from the calculation and make necessary cascading changes if needed';
        
        IF F_IS_NUMBER_VALID(v_o_dy, v_i_dy_parse_str) = 'N' THEN
            v_o_mi := v_min_mi;
            v_o_hr := v_min_hr;
    
            v_next_dy := F_GET_NEXT_NUMBER(v_o_dy,v_i_dy_parse_str);
            IF v_next_dy > v_o_dy THEN
                v_o_dy := v_next_dy;     
            ELSE
                v_o_dy := v_next_dy;
    
                v_next_mn:= F_GET_NEXT_NUMBER(v_o_mn,v_i_mn_parse_str);
                IF v_next_mn > v_o_mn THEN
                    v_o_mn := v_next_mn;     
                ELSE
                    v_o_mn := v_next_mn;
                    v_o_yr := v_o_yr + 1; 
                END IF;                 
           END IF;
        END IF;
       
        -- STEP 80: Validate days from the calculation and make necessary cascading changes if needed
        v_step_id := 80;
        v_step_desc := 'Validate days from the calculation and make necessary cascading changes if needed';
        
        IF F_IS_NUMBER_VALID(v_o_mn, v_i_mn_parse_str) = 'N' THEN
            v_o_mi := v_min_mi;
            v_o_hr := v_min_hr;
            v_o_dy := v_min_dy;
            
            v_next_mn:= F_GET_NEXT_NUMBER(v_o_mn,v_i_mn_parse_str);
            IF v_next_mn > v_o_mn THEN
                v_o_mn := v_next_mn;     
            ELSE
                v_o_mn := v_next_mn;
                v_o_yr := v_o_yr + 1; 
            END IF;                 
        END IF;
    
        -- STEP 90: Validate day of the week from the calculation and make necessary cascading changes if needed
        v_step_id := 90;
        v_step_desc := 'Validate day of the week from the calculation and make necessary cascading changes if needed';
        
        v_o_next_schedule := TO_DATE(v_o_yr || '-' || v_o_mn || '-' || v_o_dy || ' ' || v_o_hr || ':' || v_o_mi || ':00',gv_DATETIME_FORMAT);
        v_o_dw := TO_NUMBER(TO_CHAR(v_o_next_schedule,'D'))-1;
       
        IF F_IS_NUMBER_VALID(v_o_dw, v_i_dw_parse_str) = 'N' THEN
            IF v_o_dw < v_next_dw THEN
                v_o_next_schedule := v_o_next_schedule + (v_next_dw-v_o_dw);
            ELSE
                v_o_next_schedule := v_o_next_schedule + 7 - v_o_dw + v_next_dw;
            END IF;
        END IF;
       
        -- STEP 100: return the calculated next schedule
        v_step_id := 100;
        v_step_desc := 'return the calculated next schedule';
        
        RETURN TO_CHAR(v_o_next_schedule,gv_DATETIME_FORMAT);
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.F_GET_NEXT_JOB_SCHEDULE function : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END FUNCTION F_GET_NEXT_JOB_SCHEDULE
    
    -- BEGIN PROCEDURE ADD_ETL_LOG
    PROCEDURE ADD_ETL_LOG (p_log_desc IN VARCHAR2, 
                           p_log_severity IN VARCHAR2, 
                           p_log_code IN NUMBER, 
                           p_job_id IN NUMBER, 
                           p_run_id IN NUMBER, 
                           p_step_id IN NUMBER, 
                           p_step_desc IN VARCHAR2)
    AS
        -- variable declaration
    BEGIN
        -- STEP 10: Insert the log data into ETL_JOB_LOG Table
        INSERT INTO ETL_JOB_LOG (
            LOG_DESC,
            LOG_UPD_DT,
            LOG_SEVERITY_LEVEL,
            LOG_CODE,
            JOB_ID,
            RUN_ID,
            STEP_ID,
            STEP_DESC)
        VALUES (
            p_log_desc,
            SYSDATE,
            p_log_severity,
            p_log_code,
            p_job_id,
            p_run_id,
            p_step_id,
            p_step_desc);
            
        -- STEP 20: Commit
        COMMIT;

        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                RAISE;      
    END;
    -- END PROCEDURE ADD_ETL_LOG
    
    -- BEGIN PROCEDURE PURGE_ETL_JOB_DATA
    PROCEDURE PURGE_ETL_JOB_DATA
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
    BEGIN
        -- STEP 10: Purge records in ETL_JOB_CONFIG_AUDIT table
        v_step_id := 10;
        v_step_desc := 'Purge records in ETL_JOB_CONFIG_AUDIT table';
        
        DELETE FROM ETL_JOB_CONFIG_AUDIT
        WHERE AUDIT_UPD_DT < TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT) - (SELECT TO_NUMBER(COALESCE(PARAM_VALUE,gv_DEFAULT_RETENTION_DAYS))
                                                                                    FROM ETL_JOB_GLOBAL_CONFIG gc
                                                                                    WHERE gc.PARAM_KEY = 'ETL_AUDIT_DATA_RETENTION_DAYS');

        -- STEP 20: Purge records in ETL_JOB_RUN table
        v_step_id := 20;
        v_step_desc := 'Purge records in ETL_JOB_RUN table';
        
        DELETE FROM ETL_JOB_RUN
        WHERE LAST_UPD_DT < TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT) - (SELECT TO_NUMBER(COALESCE(PARAM_VALUE,gv_DEFAULT_RETENTION_DAYS))
                                                                                   FROM ETL_JOB_GLOBAL_CONFIG gc
                                                                                   WHERE gc.PARAM_KEY = 'ETL_RUN_DATA_RETENTION_DAYS');
        
        -- STEP 30: Purge records in ETL_JOB_LOG table
        v_step_id := 30;
        v_step_desc := 'Purge records in ETL_JOB_LOG table';
        
        DELETE FROM ETL_JOB_LOG
        WHERE LOG_UPD_DT < TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT) - (SELECT TO_NUMBER(COALESCE(PARAM_VALUE,gv_DEFAULT_RETENTION_DAYS))
                                                                                  FROM ETL_JOB_GLOBAL_CONFIG gc
                                                                                  WHERE gc.PARAM_KEY = 'ETL_LOG_DATA_RETENTION_DAYS');
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.PURGE_ETL_JOB_DATA procedure : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END PROCEDURE PURGE_ETL_JOB_DATA

    -- BEGIN PROCEDURE SET_ETL_JOBS
    PROCEDURE SET_ETL_JOBS
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
    BEGIN

        -- STEP 10: create records in ETL_JOB_STATUS if not exist for any active jobs
        v_step_id := 10;
        v_step_desc := 'create records in ETL_JOB_STATUS if not exist for any active jobs';
        
        INSERT INTO ETL_JOB_STATUS(
            JOB_ID,
            JOB_STATUS,
            JOB_RUNNABLE,
            JOB_NEXT_EXEC_DT,
            JOB_RUN_ID,
            LAST_UPD_DT,
            LAST_UPD_USER)
        SELECT
            jc.JOB_ID,
            'NEW',
            'Y',
            CASE WHEN COALESCE(jc.JOB_SCHEDULE,'*') = '*' THEN TO_DATE(gv_DEFAULT_HIGH_DATE,gv_DATE_FORMAT)
                 ELSE TO_DATE(ETL_JOB.F_GET_NEXT_JOB_SCHEDULE(SYSDATE, jc.JOB_SCHEDULE),gv_DATETIME_FORMAT)
            END,
            0,
            SYSDATE,
            USER
        FROM
            ETL_JOB_CONFIG jc
        WHERE 
            jc.JOB_ENABLED = 'Y'
            AND NOT EXISTS (SELECT 1 
                            FROM ETL_JOB_STATUS js
                            WHERE js.JOB_ID = jc.JOB_ID);
                            
        -- STEP 20: delete records from ETL_JOB_LIST
        v_step_id := 20;
        v_step_desc := 'delete records from ETL_JOB_LIST';
        
        DELETE FROM ETL_JOB_LIST;
    
        -- STEP 30: select all INDIVIDUAL, PARENT, and ADHOC jobs ready for run
        v_step_id := 30;
        v_step_desc := 'select all INDIVIDUAL, PARENT, and ADHOC jobs ready for run';
        
        INSERT INTO ETL_JOB_LIST(
            JOB_ID,
            PROJECT_NAME,
            JOB_NAME,
            JOB_TYPE,
            PARENT_JOB_ID,
            JOB_SCRIPT_NAME,
            JOB_DEBUG,
            JOB_LOG_PATH,
            JOB_NEXT_EXEC_DT,    
            JOB_STUCK)
        SELECT 
            jc.JOB_ID,
            jc.PROJECT_NAME,
            jc.JOB_NAME,
            jc.JOB_TYPE,
            jc.PARENT_JOB_ID,
            jc.JOB_SCRIPT_NAME,
            jc.JOB_DEBUG,
            jc.JOB_LOG_PATH,
            js.JOB_NEXT_EXEC_DT,
            'N'
        FROM 
            ETL_JOB_CONFIG jc
            JOIN ETL_JOB_STATUS js
              ON jc.JOB_ID = js.JOB_ID
            LEFT JOIN ETL_JOB_STATUS pjs
              ON jc.PARENT_JOB_ID = pjs.JOB_ID
        WHERE 
            jc.JOB_ENABLED = 'Y'
            AND (
                   (jc.JOB_TYPE IN ('STANDALONE', 'PARENT', 'ADHOC') 
                    AND js.JOB_NEXT_EXEC_DT <= SYSDATE 
                    AND js.JOB_RUNNABLE = 'Y')
                OR (jc.JOB_TYPE = 'ADHOC'
                    AND COALESCE(jc.JOB_SCHEDULE,'*') = '*')
                OR (jc.JOB_TYPE = 'CHILD'
                    AND COALESCE(pjs.JOB_STATUS,'NEW') = 'WAITING' 
                    AND COALESCE(pjs.JOB_RUNNABLE,'N') = 'N'
                    AND js.JOB_RUN_ID < pjs.JOB_RUN_ID)
                );
    
        -- STEP 40: Delete jobs more than allowed by Global config
        v_step_id := 40;
        v_step_desc := 'Delete jobs more than allowed by Global config';
        
        DELETE
        FROM ETL_JOB_LIST jc
        WHERE ROWNUM > (SELECT TO_NUMBER(PARAM_VALUE)
                        FROM ETL_JOB_GLOBAL_CONFIG gc
                        WHERE gc.PROJECT_NAME = jc.PROJECT_NAME
                        AND gc.PARAM_KEY = 'MAX_PARALLEL_JOBS_ALLOWED');
       
        -- STEP 50: Select all stuck jobs
        v_step_id := 50;
        v_step_desc := 'Select all stuck jobs';
        
        INSERT INTO ETL_JOB_LIST(
            JOB_ID,
            PROJECT_NAME,
            JOB_NAME,
            JOB_TYPE,
            PARENT_JOB_ID,
            JOB_SCRIPT_NAME,
            JOB_DEBUG,
            JOB_LOG_PATH,
            JOB_NEXT_EXEC_DT,    
            JOB_STUCK)
        SELECT 
            jc.JOB_ID,
            jc.PROJECT_NAME,
            jc.JOB_NAME,
            jc.JOB_TYPE,
            jc.PARENT_JOB_ID,
            jc.JOB_SCRIPT_NAME,
            jc.JOB_DEBUG,
            jc.JOB_LOG_PATH,
            js.JOB_NEXT_EXEC_DT,
            'Y'
        FROM
            ETL_JOB_CONFIG jc
            JOIN ETL_JOB_STATUS js
              ON jc.JOB_ID = js.JOB_ID
            JOIN ETL_JOB_RUN jr
              ON jr.RUN_ID = js.JOB_RUN_ID  
        WHERE 
            jc.JOB_ENABLED = 'Y'
            AND js.JOB_STATUS = 'STARTED' 
            AND (
                    (js.JOB_NEXT_EXEC_DT <= SYSDATE)
                OR  ((SYSDATE - jr.RUN_START_DT)*24*60*60 > COALESCE(jc.JOB_TIMEOUT_SEC,TO_NUMBER(gv_DEFAULT_TIMEOUT_SECS)))
                OR  ((SYSDATE - jr.RUN_START_DT)*24*60*60 > (SELECT TO_NUMBER(COALESCE(gc.PARAM_VALUE,gv_DEFAULT_TIMEOUT_SECS))
                                                             FROM ETL_JOB_GLOBAL_CONFIG gc
                                                             WHERE gc.PROJECT_NAME = jc.PROJECT_NAME
                                                             AND gc.PARAM_KEY = 'JOB_TIMEOUT_SEC'))
                )
            AND NOT EXISTS ( SELECT 1 
                             FROM ETL_JOB_LOG jl
                             WHERE jl.JOB_ID = jr.JOB_ID
                             AND jl.RUN_ID = jr.RUN_ID
                             AND jl.LOG_UPD_DT >= TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT)
                             AND jl.LOG_DESC = 'JOB STUCK - RESET MAY BE REQUIRED'
                );
        
        -- STEP 60: Log all the latest stuck jobs list into ETL_JOB_LOG table
        v_step_id := 60;
        v_step_desc := 'Log all the latest stuck jobs list into ETL_JOB_LOG table';
        
        INSERT INTO ETL_JOB_LOG (
            LOG_DESC,
            LOG_UPD_DT,
            LOG_SEVERITY_LEVEL,
            LOG_CODE,
            JOB_ID,
            RUN_ID,
            STEP_ID,
            STEP_DESC)
        SELECT 
            'JOB STUCK - RESET MAY BE REQUIRED',
            SYSDATE,
            'WARNING',
            0,
            jl.JOB_ID,
            js.JOB_RUN_ID,
            0,
            ''
        FROM    
            ETL_JOB_LIST jl
            JOIN ETL_JOB_STATUS js
              ON jl.JOB_ID = js.JOB_ID
        WHERE
            jl.JOB_STUCK = 'Y';
            
        -- STEP 70: Commit all changes     
        v_step_id := 70;
        v_step_desc := 'Commit all changes';
        
        COMMIT;
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.SET_ETL_JOBS procedure : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END PROCEDURE SET_ETL_JOBS
    
    -- BEGIN PROCEDURE ADD_ETL_JOB
    PROCEDURE ADD_ETL_JOB (p_job_id IN NUMBER)
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
        v_job_run_id NUMBER;
        v_rec_count NUMBER;
    BEGIN

        -- STEP 10: make sure job is active and runnable
        v_step_id := 10;
        v_step_desc := 'make sure job is active and runnable';
        
        SELECT COUNT(*) INTO v_rec_count
        FROM  
            ETL_JOB_CONFIG jc
            JOIN ETL_JOB_STATUS js
              ON jc.JOB_ID = js.JOB_ID
        WHERE 
            jc.JOB_ID = p_job_id
        AND jc.JOB_ENABLED = 'Y'
        AND js.JOB_RUNNABLE = 'Y';
                
        IF (v_rec_count > 0) THEN
        
            -- STEP 20:  Add a new run instance for the job with status as STARTED
            v_step_id := 20;
            v_step_desc := 'Add a new run instance for the job with status as STARTED';
            
            INSERT INTO ETL_JOB_RUN
              (JOB_ID,RUN_STATUS,RUN_START_DT,LAST_UPD_DT,LAST_UPD_USER)
            VALUES
               (p_job_id,'STARTED',SYSDATE,SYSDATE,USER);
            
            -- STEP 30:  Get the latest RUN ID created for the job
            v_step_id := 30;
            v_step_desc := 'Get the latest RUN ID created for the job';
            
            SELECT MAX(RUN_ID) 
            INTO v_job_run_id
            FROM ETL_JOB_RUN
            WHERE JOB_ID =  p_job_id;
    
            -- STEP 40:  Update the status in ETL_JOB_STATUS table
            v_step_id := 40;
            v_step_desc := 'Update the status in ETL_JOB_STATUS table';
            
            UPDATE
                ETL_JOB_STATUS
            SET 
                JOB_STATUS = 'STARTED',
                JOB_RUNNABLE = 'N',
                JOB_RUN_ID = v_job_run_id,
                JOB_NEXT_EXEC_DT = (SELECT CASE WHEN COALESCE(JOB_SCHEDULE,'*') = '*' THEN TO_DATE(gv_DEFAULT_HIGH_DATE,gv_DATE_FORMAT)
                                                ELSE TO_DATE(F_GET_NEXT_JOB_SCHEDULE(SYSDATE, JOB_SCHEDULE),gv_DATETIME_FORMAT)
                                           END 
                                    FROM ETL_JOB_CONFIG jc
                                    WHERE JOB_ID = p_job_id),
                LAST_UPD_DT = SYSDATE,
                LAST_UPD_USER = USER
            WHERE
                JOB_ID = p_job_id;
            
            -- STEP 50: Disable adhoc jobs
            v_step_id := 50;
            v_step_desc := 'Disable adhoc jobs';
            
            UPDATE
                ETL_JOB_CONFIG
            SET
                JOB_ENABLED = 'N'
            WHERE
                JOB_ID = p_job_id
            AND JOB_TYPE = 'ADHOC';
                
            -- STEP 60:  Commit the insert/updates    
            v_step_id := 60;
            v_step_desc := 'Commit the insert/updates';
            
            COMMIT;
        
        END IF;
        
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.ADD_ETL_JOB procedure : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END PROCEDURE ADD_ETL_JOB
    
    -- BEGIN PROCEDURE UPD_ETL_JOB
    PROCEDURE UPD_ETL_JOB (p_job_id IN NUMBER, 
                           p_job_status IN VARCHAR2, 
                           p_apply_to_childs IN VARCHAR2)
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
        
        v_job_run_id NUMBER;
        v_new_job_status VARCHAR2(15);
        v_new_runnable VARCHAR2(1);
        v_job_type VARCHAR2(11);
        v_parent_job_id NUMBER;
        v_active_childs_waiting NUMBER;
        
        -- cursor definition
        CURSOR CURSOR_CHILD_JOBS IS
        SELECT JOB_ID
        FROM ETL_JOB_CONFIG
        WHERE PARENT_JOB_ID = p_job_id;
    BEGIN
        
        -- STEP 10: update JOB_ENABLED with Y/N when the job should be Enabled/Disabled
        -- cascading this all child jobs will be done towards the end of this procedure
        v_step_id := 10;
        v_step_desc := 'update JOB_ENABLED with Y/N when the job should be Enabled/Disabled';
        
        IF (p_job_status in ('ENABLE', 'DISABLE')) THEN
            UPDATE
                ETL_JOB_CONFIG
            SET
                JOB_ENABLED = CASE WHEN p_job_status = 'ENABLE' THEN 'Y'
                                   ELSE 'N'
                              END
            WHERE
                JOB_ID = p_job_id;
        END IF;
        
        -- STEP 20:  update Job Run and Job Status tables when the job should Cancelled or Reset
        -- cascading this all child jobs will be done towards the end of this procedure
        v_step_id := 20;
        v_step_desc := 'update Job Run and Job Status tables when the job should Cancelled or Reset';
        
        IF (p_job_status in ('RESET', 'CANCELLED')) THEN
            
            -- STEP 30: In case of RESET, enable the job if it is disabled
            v_step_id := 30;
            v_step_desc := 'In case of RESET, enable the job if it is disabled';
            
            IF (p_job_status = 'RESET') THEN
                UPDATE
                    ETL_JOB_CONFIG
                SET 
                    JOB_ENABLED = 'Y'
                WHERE 
                    JOB_ID = p_job_id
                AND JOB_ENABLED = 'N';
            END IF;
            
            -- STEP 40: update the job run with COMPLETED if job is in WAITING status, if not set to RESET/CANCELLED
            v_step_id := 40;
            v_step_desc := 'update the job run with COMPLETED if job is in WAITING status, if not set to RESET/CANCELLED';
            
            UPDATE
                ETL_JOB_RUN
            SET 
                RUN_END_DT = CASE WHEN RUN_STATUS = 'STARTED' THEN SYSDATE
                                  else RUN_END_DT
                             END,
                RUN_STATUS = CASE WHEN RUN_STATUS = 'STARTED' THEN p_job_status
                                  ELSE 'COMPLETED'
                             END,
                LAST_UPD_DT = SYSDATE,
                LAST_UPD_USER = USER 
            WHERE
                RUN_STATUS IN ('STARTED', 'WAITING')
            AND RUN_ID = (  SELECT JOB_RUN_ID
                            FROM ETL_JOB_STATUS
                            WHERE JOB_ID = p_job_id);
                            
            -- STEP 50:  update the job status with COMPLETED if job is in WAITING status, if not set to RESET/CANCELLED
            -- In case of RESET, JOB_NEXT_EXEC_DT will be set to SYSDATE to execute it in the next job execution
            v_step_id := 50;
            v_step_desc := 'update the job status with COMPLETED if job is in WAITING status, if not set to RESET/CANCELLED';
            
            UPDATE ETL_JOB_STATUS
            SET 
                JOB_RUNNABLE = 'Y',
                JOB_STATUS = CASE WHEN JOB_STATUS = 'STARTED' THEN p_job_status
                                  ELSE 'COMPLETED'
                             END,
                JOB_NEXT_EXEC_DT = CASE WHEN p_job_status = 'RESET' THEN SYSDATE
                                        ELSE JOB_NEXT_EXEC_DT
                                   END,
                LAST_UPD_DT = SYSDATE,
                LAST_UPD_USER = USER
            WHERE 
                JOB_ID = p_job_id
            AND JOB_STATUS IN ('STARTED', 'WAITING');
        END IF;
        
        -- STEP 60:  when status should be set to COMPLETED
        v_step_id := 60;
        v_step_desc := 'when status should be set to COMPLETED';
        
        IF (p_job_status = 'COMPLETED') THEN 
        
            -- STEP 70:  check how many active childs are waiting for a run
            v_step_id := 70;
            v_step_desc := 'check how many active childs are waiting for a run';
            
            SELECT COUNT(*) 
            INTO v_active_childs_waiting
            FROM ETL_JOB_CONFIG cjc
                 JOIN ETL_JOB_STATUS cjs
                    ON cjc.JOB_ID = cjs.JOB_ID
            WHERE 
                cjc.PARENT_JOB_ID = p_job_id
            AND cjc.JOB_ENABLED = 'Y'
            AND (EXISTS (SELECT 1
                        FROM ETL_JOB_STATUS pjs
                        WHERE JOB_ID = p_job_id
                        AND cjs.JOB_RUN_ID < pjs.JOB_RUN_ID
                        AND cjs.JOB_STATUS IN ('COMPLETED', 'NEW'))
                OR
                EXISTS (SELECT 1
                        FROM ETL_JOB_STATUS pjs
                        WHERE JOB_ID = p_job_id
                        AND cjs.JOB_RUN_ID > pjs.JOB_RUN_ID
                        AND cjs.JOB_STATUS <> 'COMPLETED')
                );            
            -- STEP 80: get the job type and parent job id for later processing
            v_step_id := 80;
            v_step_desc := 'get the job type and parent job id for later processing';
            
            SELECT JOB_TYPE, COALESCE(PARENT_JOB_ID,0) 
            INTO v_job_type, v_parent_job_id
            FROM ETL_JOB_CONFIG
            WHERE JOB_ID = p_job_id;

            -- STEP 90:  update the job run with WAITING (if active child EXISTS waiting run) or COMPLETED (if no active childs need run)
            v_step_id := 90;
            v_step_desc := 'update the job run with WAITING (if active child EXISTS waiting run) or COMPLETED';
            
            UPDATE
                ETL_JOB_RUN
            SET 
                RUN_END_DT = CASE WHEN RUN_STATUS = 'STARTED' THEN SYSDATE
                                  else RUN_END_DT
                             END,
                RUN_STATUS = CASE WHEN (v_active_childs_waiting > 0) THEN 'WAITING'
                                  ELSE p_job_status
                             END,
                LAST_UPD_DT = SYSDATE,
                LAST_UPD_USER = USER 
            WHERE
                RUN_STATUS IN ('STARTED', 'WAITING')
            AND RUN_ID = (  SELECT JOB_RUN_ID
                            FROM ETL_JOB_STATUS
                            WHERE JOB_ID = p_job_id);
            
            -- STEP 100: update the job status with WAITING (if active child EXISTS waiting run) or COMPLETED (if no active childs need run)               
            v_step_id := 100;
            v_step_desc := 'update the job status with WAITING (if active child EXISTS waiting run) or COMPLETED';
            
            UPDATE ETL_JOB_STATUS
            SET 
                JOB_RUNNABLE = CASE WHEN (v_active_childs_waiting > 0) THEN 'N'
                                    ELSE 'Y'
                               END,
                JOB_STATUS = CASE WHEN (v_active_childs_waiting > 0) THEN 'WAITING'
                                  ELSE p_job_status
                             END,
                LAST_UPD_DT = SYSDATE,
                LAST_UPD_USER = USER
            WHERE 
                JOB_ID = p_job_id
            AND JOB_STATUS IN ('STARTED', 'WAITING');
            
            -- STEP 110:  Commit the updates
            v_step_id := 110;
            v_step_desc := 'Commit the updates';
            
            COMMIT;
            
            -- STEP 120:  When a child is set to COMPLETED, check if parent status can be updated from WAITING to COMPLETED
            v_step_id := 120; 
            v_step_desc := 'When a child is set to COMPLETED, check if parent status can be updated from WAITING to COMPLETED';
            
            IF (v_job_type = 'CHILD' AND v_active_childs_waiting = 0 AND v_parent_job_id <> 0) THEN
                UPD_ETL_JOB(v_parent_job_id, p_job_status, 'N');
            END IF;        
        END IF;
        
        -- STEP 130: COMPLETED status cannot be cascaded to the childs, but ENABLE/DISABLE/RESET/CANCELLED can be cascaded
        v_step_id := 130;
        v_step_desc := 'COMPLETED status cannot be cascaded to the childs, but ENABLE/DISABLE/RESET/CANCELLED can be';
        
        IF (p_apply_to_childs = 'Y' AND p_job_status <> 'COMPLETED') THEN
            FOR child_job_rec IN CURSOR_CHILD_JOBS
            LOOP
                UPD_ETL_JOB(child_job_rec.JOB_ID, p_job_status, p_apply_to_childs);
            END LOOP;
        END IF;
            
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_ETL_LOG ($$PLSQL_UNIT || '.UPD_ETL_JOB procedure : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END PROCEDURE UPD_ETL_JOB
   
END;
/
-- BEGIN PACKAGE BODY ETL_JOB

ALTER SESSION SET plsql_code_type = interpreted;

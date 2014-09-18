alter session set plsql_code_type = native;

create or replace package corp_etl_stage_pkg is

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE log_etl_autonomous_critical
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE);

  PROCEDURE log_etl_abort
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE);

  PROCEDURE log_etl_critical
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE);

  PROCEDURE log_etl_msg
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE);

end corp_etl_stage_pkg;
/
CREATE OR REPLACE PACKAGE BODY corp_etl_stage_pkg IS
  PROCEDURE create_etl_error_log
    (in_err_level       IN  corp_etl_error_log.err_level%TYPE
    ,in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE)
  IS
    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;
  BEGIN
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc
                                  , error_field, error_codes, driver_table_name, driver_key_number)
    VALUES( in_err_level, in_job_name, in_process_name, in_nr_of_error, in_error_desc
          , in_error_field, in_error_codes, in_driver_table_name, in_driver_key_number);
  EXCEPTION
    WHEN OTHERS THEN
        v_code := SQLCODE;
        v_desc := SQLERRM;
        INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc
                                      , error_codes, driver_table_name, driver_key_number)
        VALUES( c_critical, con_pkg, 'CREATE_ETL_ERROR_LOG', 1, v_desc
              , v_code, 'CORP_ETL_ERROR_LOG', SUBSTR(in_job_name||'.'||in_process_name,1,100));
  END create_etl_error_log;

  PROCEDURE log_etl_abort
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE)
  IS
  BEGIN
    create_etl_error_log(in_err_level         => c_abort
                        ,in_job_name          => in_job_name
                        ,in_process_name      => in_process_name
                        ,in_nr_of_error       => in_nr_of_error
                        ,in_error_desc        => in_error_desc
                        ,in_error_field       => in_error_field
                        ,in_error_codes       => in_error_codes
                        ,in_driver_table_name => in_driver_table_name
                        ,in_driver_key_number => in_driver_key_number);
  END log_etl_abort;

  PROCEDURE log_etl_critical
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE)
  IS
  BEGIN
    -- Not autonomous for Table triggers
    create_etl_error_log(in_err_level         => c_critical
                        ,in_job_name          => in_job_name
                        ,in_process_name      => in_process_name
                        ,in_nr_of_error       => in_nr_of_error
                        ,in_error_desc        => in_error_desc
                        ,in_error_field       => in_error_field
                        ,in_error_codes       => in_error_codes
                        ,in_driver_table_name => in_driver_table_name
                        ,in_driver_key_number => in_driver_key_number);
  END log_etl_critical;

  PROCEDURE log_etl_autonomous_critical
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE)
  IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    create_etl_error_log(in_err_level         => c_critical
                        ,in_job_name          => in_job_name
                        ,in_process_name      => in_process_name
                        ,in_nr_of_error       => in_nr_of_error
                        ,in_error_desc        => in_error_desc
                        ,in_error_field       => in_error_field
                        ,in_error_codes       => in_error_codes
                        ,in_driver_table_name => in_driver_table_name
                        ,in_driver_key_number => in_driver_key_number);
  END log_etl_autonomous_critical;

  PROCEDURE log_etl_msg
    (in_job_name          IN  corp_etl_error_log.job_name%TYPE
    ,in_process_name      IN  corp_etl_error_log.process_name%TYPE
    ,in_nr_of_error       IN  corp_etl_error_log.nr_of_error%TYPE
    ,in_error_desc        IN  corp_etl_error_log.error_desc%TYPE
    ,in_error_field       IN  corp_etl_error_log.error_field%TYPE
    ,in_error_codes       IN  corp_etl_error_log.error_codes%TYPE
    ,in_driver_table_name IN  corp_etl_error_log.driver_table_name%TYPE
    ,in_driver_key_number IN  corp_etl_error_log.driver_key_number%TYPE)
  IS
  BEGIN
    create_etl_error_log(in_err_level         => c_log
                        ,in_job_name          => in_job_name
                        ,in_process_name      => in_process_name
                        ,in_nr_of_error       => in_nr_of_error
                        ,in_error_desc        => in_error_desc
                        ,in_error_field       => in_error_field
                        ,in_error_codes       => in_error_codes
                        ,in_driver_table_name => in_driver_table_name
                        ,in_driver_key_number => in_driver_key_number);
  END log_etl_msg;

end corp_etl_stage_pkg;
/
alter session set plsql_code_type = interpreted;


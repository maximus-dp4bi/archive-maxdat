alter session set plsql_code_type = native;

create or replace package corp_etl_stage_pkg is

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 declare SVN_FILE_URL varchar= '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  TYPE status_order_rec IS RECORD 
  (status       corp_etl_list_lkup.value%TYPE
  ,status_order corp_etl_list_lkup.out_var%TYPE);
    
  TYPE status_order_tab IS TABLE OF status_order_rec
  INDEX BY BINARY_INTEGER;
  gv_task_status_rec  status_order_tab;


CREATE PROCEDURE CORP_ETL_STAGE_CREATE_ETL_ERROR_LOG
    (@in_err_level varchar
    ,@in_job_name varchar
    ,@in_process_name varchar
    ,@in_nr_of_error numeric(18,0)
    ,@in_error_desc varchar
    ,@in_error_field varchar
    ,@in_error_codes varchar
    ,@in_driver_table_name varchar
    ,@in_driver_key_number varchar)
  as
  begin
    declare @v_code varchar,
    @v_desc varchar,
	@con_pkg varchar=OBJECT_NAME(@@PROCID),
    @c_abort varchar= 'ABORT',
    @c_critical varchar= 'CRITICAL',
    @c_log varchar= 'LOG';
	begin try
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc
                                  , error_field, error_codes, driver_table_name, driver_key_number)
    VALUES( @in_err_level, @in_job_name, @in_process_name, @in_nr_of_error, @in_error_desc
          , @in_error_field, @in_error_codes, @in_driver_table_name, @in_driver_key_number);
  end try
  begin catch
       select @v_code = 'SQLCODE';
        select @v_desc = 'SQLERRM';
        INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc
                                      , error_codes, driver_table_name, driver_key_number)
        VALUES( @c_critical, @con_pkg, 'CREATE_ETL_ERROR_LOG', 1, @v_desc
              , @v_code, 'CORP_ETL_ERROR_LOG', SUBSTRING(@in_job_name + '.' + @in_process_name,1,100));
 end catch
end;

  create PROCEDURE CORP_ETL_STAGE_LOG_ETL_ABORT
    (@in_job_name varchar
    ,@in_process_name varchar
    ,@in_nr_of_error numeric(18,0)
    ,@in_error_desc varchar
    ,@in_error_field varchar
    ,@in_error_codes varchar
    ,@in_driver_table_name varchar
    ,@in_driver_key_number varchar)
  AS
  BEGIN
      declare @v_code varchar,
    @v_desc varchar,
	@con_pkg varchar=OBJECT_NAME(@@PROCID),
    @c_abort varchar= 'ABORT',
    @c_critical varchar= 'CRITICAL',
    @c_log varchar= 'LOG';

    exec dbo.CORP_ETL_STAGE_CREATE_ETL_ERROR_LOG(select @c_abort
                        ,@in_job_name
                        ,@in_process_name
                        ,@in_nr_of_error
                        ,@in_error_desc
                        ,@in_error_field
                        ,@in_error_codes
                        ,@in_driver_table_name
                        ,@in_driver_key_number);
  END;

  create PROCEDURE CORP_ETL_STAGE_LOG_ETL_CRITICAL
    (@in_job_name varchar
    ,@in_process_name varchar
    ,@in_nr_of_error numeric(18,0)
    ,@in_error_desc varchar
    ,@in_error_field varchar
    ,@in_error_codes varchar
    ,@in_driver_table_name varchar
    ,@in_driver_key_number varchar)
  AS
  BEGIN
      declare @v_code varchar,
    @v_desc varchar,
	@con_pkg varchar=OBJECT_NAME(@@PROCID),
    @c_abort varchar= 'ABORT',
    @c_critical varchar= 'CRITICAL',
    @c_log varchar= 'LOG';

    exec dbo.CORP_ETL_STAGE_CREATE_ETL_ERROR_LOG(select @c_critical
                        ,@in_job_name
                        ,@in_process_name
                        ,@in_nr_of_error
                        ,@in_error_desc
                        ,@in_error_field
                        ,@in_error_codes
                        ,@in_driver_table_name
                        ,@in_driver_key_number);
  END;

    create PROCEDURE CORP_ETL_STAGE_LOG_ETL_AUTONOMOUS_CRITICAL
    (@in_job_name varchar
    ,@in_process_name varchar
    ,@in_nr_of_error numeric(18,0)
    ,@in_error_desc varchar
    ,@in_error_field varchar
    ,@in_error_codes varchar
    ,@in_driver_table_name varchar
    ,@in_driver_key_number varchar)
  AS
  BEGIN
  --MAKE THIS AUTONOMOUS
      declare @v_code varchar,
    @v_desc varchar,
	@con_pkg varchar=OBJECT_NAME(@@PROCID),
    @c_abort varchar= 'ABORT',
    @c_critical varchar= 'CRITICAL',
    @c_log varchar= 'LOG';

    exec dbo.CORP_ETL_STAGE_CREATE_ETL_ERROR_LOG(select @c_critical
                        ,@in_job_name
                        ,@in_process_name
                        ,@in_nr_of_error
                        ,@in_error_desc
                        ,@in_error_field
                        ,@in_error_codes
                        ,@in_driver_table_name
                        ,@in_driver_key_number);
  END;


create PROCEDURE CORP_ETL_STAGE_LOG_ETL_MSG
    (@in_job_name varchar
    ,@in_process_name varchar
    ,@in_nr_of_error numeric(18,0)
    ,@in_error_desc varchar
    ,@in_error_field varchar
    ,@in_error_codes varchar
    ,@in_driver_table_name varchar
    ,@in_driver_key_number varchar)
  AS
  BEGIN
      declare @v_code varchar,
    @v_desc varchar,
	@con_pkg varchar=OBJECT_NAME(@@PROCID),
    @c_abort varchar= 'ABORT',
    @c_critical varchar= 'CRITICAL',
    @c_log varchar= 'LOG';

    exec dbo.CORP_ETL_STAGE_CREATE_ETL_ERROR_LOG(select @c_log
                        ,@in_job_name
                        ,@in_process_name
                        ,@in_nr_of_error
                        ,@in_error_desc
                        ,@in_error_field
                        ,@in_error_codes
                        ,@in_driver_table_name
                        ,@in_driver_key_number);
  END;


create FUNCTION CORP_ETL_STAGE_GET_TASK_STATUS_ORDER
  (@in_status VARCHAR)
  RETURNS INTEGER
  AS begin
    declare @a INTEGER = 0;


  TYPE status_order_rec IS RECORD 
  (status       corp_etl_list_lkup.value%TYPE
  ,status_order corp_etl_list_lkup.out_var%TYPE);
    
  TYPE status_order_tab IS TABLE OF status_order_rec
  INDEX BY BINARY_INTEGER;
  gv_task_status_rec  status_order_tab;


    CURSOR crs_lkup
    IS
    SELECT VALUE, out_var
      FROM CORP_ETL_LIST_LKUP
     WHERE name      = 'MW_TASK_STATUS_ORDER'
       AND list_type = 'ORDER';
  BEGIN
    -- For performance, retieve once
    IF gv_task_status_rec.count = 0
    THEN
      FOR c IN crs_lkup
      LOOP gv_task_status_rec(a) := c;
           a := a + 1;
      END LOOP;
    END IF;
    -- Now identify the status order
    IF gv_task_status_rec.count > 0
    THEN
      FOR i IN gv_task_status_rec.first..gv_task_status_rec.last
      loop
        IF gv_task_status_rec(i).status = in_status
        THEN RETURN gv_task_status_rec(i).status_order;
        END IF;
      END LOOP;
    END IF;
    --
    RETURN NULL;
  END;


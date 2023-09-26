use schema sch_stats;

create or replace procedure SP_POPULATE_SCH_HISTORY_TABLE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */
  var strSQLText = "";
  var strSQLStmt = "";
  var ret_value = "";
  var ErrMsg = "";
  var ErrDesc = "";
  
  /* STEP 1: Merge summary jobstats from stg to main tbl */  
    try{
		/* Mark rows that already exists in main tbl as 'complete'*/
     	strSQLText ="update sch_stats.sch_jobstatistics_summary_stg  "
				  +"    set load_status = 'complete' "
				  +" where (jobid,runcount) in (select jobid,runcount from sch_stats.sch_jobstatistics_summary where finishtime is not null); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();
	   
	    /* Mark rows that donot exist in main tbl as 'insert' */
	    strSQLText ="update sch_stats.sch_jobstatistics_summary_stg  "
				  +"    set load_status = 'insert' "
				  +" where (jobid,runcount) not in (select jobid,runcount from sch_stats.sch_jobstatistics_summary); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();
	   
	    /* Mark rows that need to be updated in main tbl with load_status='update' */
	    strSQLText ="update sch_stats.sch_jobstatistics_summary_stg s "
				  +"    set load_status = 'update' "
				  +" where exists (select 1 from sch_stats.sch_jobstatistics_summary h where s.jobid=h.jobid and s.runcount=h.runcount and h.finishtime is null); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();
	
		/* Merge rows marked with 'insert' & 'update' into main tbl  */	
     	strSQLText ="merge into sch_stats.sch_jobstatistics_summary h "
				  +" using (select * from sch_stats.sch_jobstatistics_summary_stg where load_status in ('insert','update')) s "
				  +"		on (h.jobid=s.jobid and h.runcount=s.runcount and s.load_status = 'update') "
				  +" when matched "
				  +"		then update set h.starttime=s.starttime, h.finishtime=s.finishtime, h.status=s.status, h.in_recordcnt=s.in_recordcnt, h.out_recordcnt=s.out_recordcnt, h.err_recordcnt=s.err_recordcnt, h.user=s.user, h.err_info=s.err_msg, h.warning=s.warning "  
				  +" when not matched "
				  +"    	then insert(jobid,jobname,runcount,starttime,finishtime,status,in_recordcnt,out_recordcnt,err_recordcnt,user,err_info,warning) "
				  +"		values(s.jobid,s.jobname,s.runcount,s.starttime,s.finishtime,s.status,s.in_recordcnt,s.out_recordcnt,s.err_recordcnt,s.user,s.err_info,s.warning); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute(); 
		
		/* Delete rows from stg tbl after merge operation is complete */
	    strSQLText ="delete from sch_stats.sch_jobstatistics_summary_stg  "
				  +" where load_status in ('complete','insert','update'); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();	

		return_value = snowflake.execute( {sqlText: "COMMIT;"} );  	
	}
    catch (err) {
		ErrMsg = "Failed to merge jobstats into SCH_JOBSTATISTICS_SUMMARY";
		ErrDesc = err.message.replace(/('|")/g, "_");
	
		strSQLText ="INSERT INTO SCH_STATS.SCH_JOBSTATS_ERROR_LOG (err_dt,err_msg,err_desc) values (sysdate(),'" + ErrMsg + "','" + ErrDesc + "'); ";
        strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();  
        
        /*return ErrDesc; */
    }	
   
    /* STEP 2: Merge detailed jobstats from stg to main tbl */
    try{
		/* Mark rows already exist in main tbl as 'complete' */
     	strSQLText ="update sch_stats.sch_jobstatistics_detail_stg  "
				+"    set load_status = 'complete' "
				+" where (jobid,runcount,dtl_msgid) in (select jobid,runcount,dtl_msgid from sch_stats.sch_jobstatistics_detail); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();
	   
	    /* Mark rows that donot exist in main tbl as 'insert' */
	    strSQLText ="update sch_stats.sch_jobstatistics_detail_stg  "
				+"    set load_status = 'insert' "
				+" where (jobid,runcount,dtl_msgid) not in (select jobid,runcount,dtl_msgid from sch_stats.sch_jobstatistics_detail); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();  
  
		/* Merge rows marked as 'insert' into main tbl  */	
		strSQLText = "insert into sch_stats.sch_jobstatistics_detail (jobid,jobname,runcount,dtl_time,dtl_msg,dtl_status,dtl_user,dtl_msgid) "
				+" select jobid,jobname,runcount,dtl_time,dtl_msg,dtl_status,dtl_user,dtl_msgid"
				+" from sch_stats.sch_jobstatistics_detail_stg "
				+" where load_status = 'insert'; "; 
		strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
		ret_value = strSQLStmt.execute(); 
		
		/* Delete rows from stg tbl after merge operation is complete */
	    strSQLText ="delete from sch_stats.sch_jobstatistics_detail_stg  "
				  +" where load_status in ('complete','insert'); ";
	    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();	

		ret_value = snowflake.execute( {sqlText: "COMMIT;"} );  	
	}
    catch (err) {
		ErrMsg = "Failed to merge jobstats into SCH_JOBSTATISTICS_DETAIL";
		ErrDesc = err.message.replace(/('|")/g, "_");
	
		strSQLText ="INSERT INTO SCH_STATS.SCH_JOBSTATS_ERROR_LOG (err_dt,err_msg,err_desc) values (sysdate(),'" + ErrMsg + "','" + ErrDesc + "'); ";
        strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	    ret_value = strSQLStmt.execute();  
        
        /*return ErrDesc; */
		return 1
    }
	
    snowflake.execute( {sqlText: "COMMIT;"} );          
    return 0; /* SUCCESS */   
    
  $$;
  
--GRANT ALL PRIVILEGES ON PROCEDURE sch_stats.SP_POPULATE_SCH_HISTORY_TABLE() TO PI_DATA_INGEST_DEV_ALERT_USER;  
--GRANT ALL PRIVILEGES ON PROCEDURE sch_stats.SP_POPULATE_SCH_HISTORY_TABLE() TO PI_DATA_INGEST_UAT_ALERT_USER;  
--GRANT ALL PRIVILEGES ON PROCEDURE sch_stats.SP_POPULATE_SCH_HISTORY_TABLE() TO PI_DATA_INGEST_PRD_ALERT_USER;  
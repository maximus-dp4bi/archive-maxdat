
CREATE TABLE S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS (projectid VARCHAR(255), PROJECTNAME VARCHAR(255),
evaluationid VARCHAR(255), 
projectassigneddate DATE,
projectreleasedate DATE,
status VARCHAR(255),
business_days NUMBER,
EVALUATIONS_COUNT NUMBER);

--INSERT INTO STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS (projectid,PROJECTNAME,evaluationid,projectassigneddate,projectreleasedate,status,business_days,EVALUATIONS_COUNT) select projectid,projectname,evaluationid, projectassigneddate,projectreleasedate,status,sum(case when projectreleasedate='1969-12-31' AND status='FINISHED' then 2 when projectreleasedate='1969-12-31' AND status='INPROGRESS' then 0 when business_day_flag = 'Y' and projectassigneddate<>projectreleasedate then 1 else 0 end)/count(distinct evaluationid) as business_days,count(distinct evaluationid) as eval_count from (select distinct projectid,projectname,evaluationid, projectassigneddate, projectreleasedate,status from D_PI_EVALUATIONS_VW where projectid='1201' ) a11 left outer join (select pureinsights_project_id,project_name, date, business_day_flag from D_PROJECT_DATES_SV where pureinsights_project_id='1201' ) a12 on a11.projectid = a12.pureinsights_project_id and date(a12.date) >date(a11.projectassigneddate) and date(a12.date) <= date(a11.projectreleasedate) group by 1,2,3,4,5,6;"; 


CREATE OR REPLACE PROCEDURE "S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD"("PROJECTID" VARCHAR(16777216), "REINGESTFLAG" BOOLEAN, "RUNFROMBASHFLAG" BOOLEAN)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '

    //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = ''INGEST_PI_DATA_DET_LOG'';";
     if (RUNFROMBASHFLAG) {
      sqlCommand = "set log_table = ''INGEST_PI_DATA_DET_LOG_"+PROJECTID+"'';";
     }
     snowflake.execute ({sqlText: sqlCommand});
     
function log(projectid, object_category, object_name, status_string, msg){
    snowflake.createStatement( { sqlText: `call RAW.do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
}

REINGEST_SFX = ""
if (REINGESTFLAG){
REINGEST_SFX=" REINGEST";
} 

   //truncate table
   //log("truncating table");
    sqlCommand = "delete from STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS where projectid = ''" + PROJECTID + "'';";
    //log(sqlCommand);
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD", "FAILED", "Failed to truncate table STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS for projectid " + PROJECTID + ": "+ err); 
        return "1";
        }
     

    //ingest data from parquet file    
    var sqlCommand = "INSERT INTO STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS (projectid,PROJECTNAME,evaluationid,projectassigneddate,projectreleasedate,status,business_days,EVALUATIONS_COUNT) select projectid,projectname,evaluationid, projectassigneddate,projectreleasedate,status,sum(case when projectreleasedate=''1969-12-31'' AND status=''FINISHED'' then 2 when projectreleasedate=''1969-12-31'' AND status=''INPROGRESS'' then 0 when business_day_flag = ''Y'' and projectassigneddate<>projectreleasedate then 1 else 0 end)/count(distinct evaluationid) as business_days,count(distinct evaluationid) as eval_count from (select distinct projectid,projectname,evaluationid, projectassigneddate, projectreleasedate,status from D_PI_EVALUATIONS_VW where projectid=''" + PROJECTID + "'' ) a11 left outer join (select pureinsights_project_id,project_name, date, business_day_flag from D_PROJECT_DATES_SV where pureinsights_project_id=''" + PROJECTID + "'' ) a12 on a11.projectid = a12.pureinsights_project_id and date(a12.date) >date(a11.projectassigneddate) and date(a12.date) <= date(a11.projectreleasedate) group by 1,2,3,4,5,6;"; 
 //log("ingesting data")
try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID,"SP"+REINGEST_SFX, "S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD", "FAILED","Failed to load table STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS for projectid " + PROJECTID + ": "+ err);
        return "1";
        }        

        log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD", "SUCCEEDED","Succeeded loading table STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS for projectid " + PROJECTID);
  return "0";  
  
  ';


 CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(701,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(6666,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(8888,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(5555,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(4444,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(3333,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(1111,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(601,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(201,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(621,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(301,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(801,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(221,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(101,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(401,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(1001,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(901,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(1101,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(2001,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(551,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(903,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(501,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(421,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(321,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(555,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(1201,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(1301,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(361,true,true);
CALL S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(1601,true,true);

SELECT DISTINCT PROJECTNAME FROM S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS;

CREATE OR REPLACE VIEW PUBLIC.F_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_VW 
AS SELECT projectid,PROJECTNAME,evaluationid,projectassigneddate,projectreleasedate,status,business_days,EVALUATIONS_COUNT FROM STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS;


SELECT * FROM PUBLIC.F_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_VW ;
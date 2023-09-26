CREATE OR REPLACE PROCEDURE "MERGEPROJECTLOGSFORINGESTION"("REINGESTFLAG" BOOLEAN, "TEMPLOGTABLE" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
  
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = ''INGEST_PI_DATA_DET_LOG'';";
     snowflake.execute ({sqlText: sqlCommand});
 
function log(projectid, object_category, object_name, status_string, msg){
    snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
} 
       

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}

     //get date string for today
     var today_local = new Date();
     var today = convertTZ(today_local,''America/New_York'')
     var dd = String(today.getDate()).padStart(2, ''0'');
     var mm = String(today.getMonth() + 1).padStart(2, ''0''); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     var todayDateString = yyyy + mm + dd;

REINGEST_SFX = ""
if (REINGESTFLAG){
REINGEST_SFX=" REINGEST";
}         

var logTable="ingest_pi_data_det_log";
if (TEMPLOGTABLE) {
logTable= TEMPLOGTABLE;
}
var project_array=[];
var sqlCommand = "select projectid from public.d_pi_projects where active=true;"
var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();
    while (rs.next()) {
     var projectid = rs.getColumnValue(1);
     project_array.push(projectid);
    }
  
  for (const projectid of project_array) {
//mrge into main log table
    sqlCommand = `insert into raw.`+ logTable +` select * from raw.INGEST_PI_DATA_DET_LOG_`+ projectid +`;`;
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(projectid, "LOG"+REINGEST_SFX, "NA", "FAILED","Failed to insert project log into main log for project " + projectid +  ": "+ err); 
        return "3"; 
}

}     

    return "0";  
  ';

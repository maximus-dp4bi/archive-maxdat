create or replace procedure SP_GET_RECORD_COUNT("argSchemaName" string, "argTableName" string)
  returns double not null
  language javascript
  as
  $$
  
  var strSQLText = "SELECT COUNT(*) AS SF_TABLE_EXIST FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + argSchemaName + "' AND TABLE_NAME = '" + argTableName + "';";
  var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  var ret_value = strSQLStmt.execute();
  ret_value.next();
  
  if  (ret_value.getColumnValue('SF_TABLE_EXIST') == 0)
  {
    return -1;
  }
  else
  {
	strSQLText = "SELECT COUNT(*) AS REC_COUNT FROM " + argSchemaName + "." + argTableName + ";";
	strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
	ret_value = strSQLStmt.execute();  
	ret_value.next();
	
	return ret_value.getColumnValue('REC_COUNT');
  };

  $$;
GO;

GRANT ALL PRIVILEGES ON PROCEDURE OHPNM_DP4BI_DEV.SP_GET_RECORD_COUNT(string, string) TO ROLE OHIO_PROVIDER_DP4BI_DEV_ADMIN;
GO;

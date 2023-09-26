create or replace procedure chkColumnsForTrailingSpaces(table_catalog VARCHAR, table_schema VARCHAR, table_name VARCHAR)
    returns string 
    not null
    language javascript
    as
    $$
    var field_list = "";
    let found_fields = false;
   
    var sqlCommand = "select column_name from INFORMATION_SCHEMA.COLUMNS where table_catalog = '" + TABLE_CATALOG + "' and table_schema = '" + TABLE_SCHEMA + "' and table_name = '" + TABLE_NAME + "' and data_type = 'TEXT'";

    var stmt = snowflake.createStatement(
           {
           sqlText: sqlCommand
           }
        );

    var res_fields = stmt.execute();

    while(res_fields.next()){

        found_fields = true;

        sqlCommand = "select count(*) from " + TABLE_CATALOG + "." + TABLE_SCHEMA + "." + TABLE_NAME + " where " + res_fields.getColumnValue(1) + " like '% '";

        stmt = snowflake.createStatement(
           {
           sqlText: sqlCommand
           }
        );

        var res_count = stmt.execute();
        
        if (res_count.next()) {
        
            if (res_count.getColumnValue(1) > 0){
                
                if(field_list != ""){
                    field_list = field_list + "," + res_fields.getColumnValue(1);
                
                }
                else{
                    field_list = res_fields.getColumnValue(1);                
                }
            }
        }
    }
    
    if(found_fields == false){
        field_list = "Could not find any fields for " + TABLE_CATALOG + "." + TABLE_SCHEMA + "." + TABLE_NAME        
    }
    else{
        field_list = "Fields with trailing spaces:  " + field_list;
    }
    
    return field_list;
    $$
    ;

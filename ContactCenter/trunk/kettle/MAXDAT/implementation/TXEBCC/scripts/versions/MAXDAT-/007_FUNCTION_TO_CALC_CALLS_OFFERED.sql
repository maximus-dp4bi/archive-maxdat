create or replace
function calls_offered_func (OUT_VAR VARCHAR2 , ACD_INTERVAL_ID NUMBER) RETURN NUMBER
is
 calls_offered number(11,2); 
 sql_string VARCHAR2        (1000);
BEGIN

sql_string:= OUT_VAR;
 
execute immediate sql_string  into calls_offered using   ACD_INTERVAL_ID  ;     
return(calls_offered);

END;
/

Dim conn, dbResult
Set conn = CreateObject("ADODB.Connection")
Set dbResult = CreateObject("ADODB.Recordset")
sconnect = "Provider=MSDASQL.1;DSN=MARS_SNOW;" & ";HDR=Yes';Password=^N4]8TmUnL?%7e}];Warehouse=QA_WH"
msgbox(1)
conn.Open (sconnect)
msgbox(2)
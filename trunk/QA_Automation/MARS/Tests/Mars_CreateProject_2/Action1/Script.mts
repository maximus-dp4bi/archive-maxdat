


''
'Wait(1)
'Dim conn, dbResult
'Set conn = CreateObject("ADODB.Connection")
'Set dbResult = CreateObject("ADODB.Recordset")
'sconnect = "Provider=MSDASQL.1;DSN=MARS_SNOW;" & ";HDR=Yes';Password=^N4]8TmUnL?%7e}];Warehouse=QA_WH"
' '
'conn.Open (sconnect)
'
'
'Project_Name = "Project_E41D667A17644B"
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project' and DATA:dataObject:projectName = " & "'" & Project_Name & "'" & ";" '& "" 
'
'dbResult.open(SQLquery), conn
'
'
'Set fso = CreateObject("Scripting.FileSystemObject")
'Set UFT_Log = fso.CreateTextFile("C:\Mars_Logs\Snowflake_Res.txt")
'
'UFT_Log.WriteLine Now
'
'For intCount = 0 To dbResult.Fields.Count - 1
' If Not dbResult.BOF Then
' dbresult.MoveFirst
' End If
'
'intRow = 1
'Do Until dbResult.EOF
'
' strTest = dbResult.Fields(intCount).Value
' UFT_Log.write  strTest
'
' dbResult.MoveNext
' intRow =intCount+1
'Loop
'Next



cDataFileURL = "C:\UFT\MARS\Project\Data\Mars.xls"
Call KillAllExcelProcesses()


iRowValues = ReadExcelFile_LoadStringWithRowsContainsYesValue(cDataFileURL) ' Get list of reports marked as "Y".

ArrayOfValues = Split(iRowValues, ",")

For i = 0 To UBound(ArrayOfValues)

' Performance verification: Start

 iIndex = ArrayOfValues(i)
 
 ' Clear dowload folder.
 Call KillAllExcelProcesses()
 Call ClearCurrentDownloadFolder()
 
' Get variables from external Data file
strBrowser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBrowser, iIndex)
strEnvironment = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEnvironment, iIndex)
strMars_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMars_User, iIndex)
strMars_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMars_Pass, iIndex)
strDB_SF_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_User, iIndex)
strDB_SF_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_Pass, iIndex)
strCP_BaseProject = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseProject, iIndex)
strCP_State = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_State, iIndex)
strCP_BaseProgramName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseProgramName, iIndex)
strCP_BaseContactID = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseContactID, iIndex)
strCP_BaseAgencyName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseAgencyName, iIndex)
strCP_ContractStartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ContractStartDate, iIndex)
strCP_ContractEndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ContractEndDate, iIndex)
strCP_GoLiveDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_GoLiveDate, iIndex)
strCP_ProvStatus = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ProvStatus, iIndex)
strCP_TimeZone = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_TimeZone, iIndex)


' Generate Unique number
strUniqueNumber = GenerateUniqueNumber()

Call GEN_CloseAll_Browsers(strBrowser)
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)

Call Mars_CreateProject(strCP_BaseProject, strCP_State, strCP_BaseProgramName, strCP_BaseContactID, strCP_BaseAgencyName, strCP_ContractStartDate, strCP_ContractEndDate, strCP_GoLiveDate, strCP_ProvStatus, strCP_TimeZone, strUniqueNumber)

Wait(1)







Next


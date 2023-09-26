
Dim strMySQLCount
Dim strSnowflakeCount

Services.StartTransaction "MicroStrategy - Performance"

' Clean up
'Call KillAllChromeProcesses()
Call KillAllExcelProcesses()

'======================================== Run from GLOBAl data driver ==================================================

strTempFileURL = "C:\Temp\tempFile.xlsx" ' Copy of Global data driver with only one record.
iIndex = 2
strColName = "Data Driver"
strDataDriver_FileName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strColName = "Data Driver Location"
strDataDriver_Location = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strColName = "SQL Location"
strSQL_Location = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strColName = "SQL Data Location"
strSQL_Data_Location = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)

' Get last folder name which will be MAIN folder for ALL Reports
strColName = "Script Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strBaseFolderName = ReadExcelFile_GetLastFolderName(strBasicLocation)
cReports = "C:\Maximus\Reports" & "\" & strBaseFolderName

' Copy dataDriver file from original location to Report folder and then use it as normal datadriver.
cDataFileURL = CopyFile_From_To(strDataDriver_Location, cReports, strDataDriver_FileName)

' Copy INI file into report location
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strINI_FileName = "Global_INI"
strFilePathINI = CopyINIFile_From_To(strBasicLocation, cReports, strINI_FileName)
Call WriteINI (strFilePathINI, "FinalReportPath", "value", cDataFileURL) ' Copy path of final summary report file into INI file
Call WriteINI (strFilePathINI, "ExtraColumns_SnowflakePath", "value", strMetadata_ExtraColumns_Snowflake_ReportLocation) ' Copy path of final summary report file into INI file

' Exit script if Alert = FAILED
strAlert = ReadIni( strFilePathINI, "Alert", "value")
If strAlert = "FAILED" Then
ExitTest	
End If

' Snowflake rowcount where clause.
strSnowflakeWhereClause = ReadIni( strFilePathINI, "Snowflake_RowCount", "value")

' ================================================================================================================================


Call KillAllExcelProcesses()

' Get Metadata_Exceptions table full path
strMetadataExceptions_Path = strDataDriver_Location & "\" & "Metadata_Exceptions.xlsx"
strWorkbook_ColumnExceptions = "Column_Exceptions"
strWorkbook_DatatypeExceptions = "Datatype_Exceptions"
' Get Data_Exceptions table full path
strDataExceptionsLookupTable_Path = strDataDriver_Location & "\" & "Data_Exceptions.xlsx"
strDataExceptionsWorkbook = "DataExceptions"

'Call CreateFolder () ' Create local folder to store reports
' Summary tab information
strWorkbook_Global = "Summary"
iRowValues_Global = ReadExcelFile_LoadStringWithRowsContainsYesValue_2(cDataFileURL, strWorkbook_Global) ' Get list of reports marked as "Y".
strTab_Name_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cTab_Name, strWorkbook_Global)

 ' Get Snowflake environment
 strSnowflake_ENV = ReadIni( strFilePathINI, "ENV", "value")
 
 select case strSnowflake_ENV
   case "UAT"
      'strSF_Connection = cSnowflakeConnection_UAT1 & cSnowflakeConnection_UAT2
      strSF_Connection = ReadIni( strFilePathINI, "ENV_UAT", "value")
   case "DEV"
      'strSF_Connection = cSnowflakeConnection_DEV1 & cSnowflakeConnection_DEV2
      strSF_Connection = ReadIni( strFilePathINI, "ENV_DEV", "value")
   case "PRD"
      'strSF_Connection = cSnowflakeConnection_PROD1 & cSnowflakeConnection_PROD2
      strSF_Connection = ReadIni( strFilePathINI, "ENV_PRD", "value")
   case else
     'None
end select

ArrayOfValues = Split(iRowValues_Global, ",")

For i = 0 To UBound(ArrayOfValues)

' Performance verification: Start

 iIndex_Global = ArrayOfValues(i)
 
 ' Clear dowload folder.
 Call KillAllExcelProcesses()
 Call ClearCurrentDownloadFolder()
' Get detail workbook name
strWorkbook_Detail = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTab_Name, iIndex_Global, strWorkbook_Global) 
 
 If strWorkbook_Detail = "D_CONTACT_RECORDS"  or strWorkbook_Detail = "D_PROGRAM" or strWorkbook_Detail = "D_CASE" _ 
 or strWorkbook_Detail = "D_CONSUMER" or strWorkbook_Detail = "D_MW_TASK_INSTANCE" or strWorkbook_Detail = "D_STAFF" _
 or strWorkbook_Detail = "MW_F_TASK_INSTANCE_BY_DAY" or strWorkbook_Detail = "MW_F_TASKS_BY_DAY" or  strWorkbook_Detail = "F_CONTACT_RECORDS_BY_DAY" Then
 	
  ' Get list of rows with flag = "Y"
 iRowValues_Detail = ReadExcelFile_LoadStringWithRowsContainsYesValue_2(cDataFileURL, strWorkbook_Detail) 
 
ArrayOfValues_Detail = Split(iRowValues_Detail, ",")

TargetFlag = true ' Get Target values only ones for TAB
For k = 0 To UBound(ArrayOfValues_Detail)

iIndex_Detail = ArrayOfValues_Detail(k)

' Get some target values only ones per tab
If TargetFlag = true Then
strTargetProjectID = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetProjectID, iIndex_Detail, strWorkbook_Detail)
strTargetSchema = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetSchema, iIndex_Detail, strWorkbook_Detail) 
strTargetView = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetView, iIndex_Detail, strWorkbook_Detail) 
' Get Target view row count
strTargetCountValue = Snowflake_ReadDB_RowCount_CRM(strUser, strPassword, strTargetSchema, strTargetView, strSF_Connection, strTargetProjectID) 
TargetFlag = false
End If

' Get Source and Target information
strTargetProjectID = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetProjectID, iIndex_Detail, strWorkbook_Detail)
strTargetColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetColumn, iIndex_Detail, strWorkbook_Detail)
strTargetWhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetWhereClause, iIndex_Detail, strWorkbook_Detail)
strSourceProjectID = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSourceProjectID, iIndex_Detail, strWorkbook_Detail)
strSourceSchema = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSourceSchema, iIndex_Detail, strWorkbook_Detail) 
strSourceView = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSourceView, iIndex_Detail, strWorkbook_Detail) 
strSourceColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSourceColumn, iIndex_Detail, strWorkbook_Detail)
strSourceWhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSourceWhereClause, iIndex_Detail, strWorkbook_Detail)
strTargetCount_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cTargetCount, strWorkbook_Detail)
strSourceCount_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cSourceCount, strWorkbook_Detail)

'=========== Row Counts ===========
' Get Source view row count
strSourceCountValue = 0
strSourceCountValue = Snowflake_ReadDB_RowCount_CRM(strUser, strPassword, strSourceSchema, strSourceView, strSF_Connection, strSourceProjectID)
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex_Detail, strTargetCount_Index, strSourceCount_Index, strTargetCountValue, strSourceCountValue, strWorkbook_Detail) 
 
 
 
strSourceCountValue = CLng(strSourceCountValue)
strTargetCountValue = CLng(strTargetCountValue)
If strSourceCountValue <> 0 and strTargetCountValue <> 0 Then ' Compare data if MySQL/Snowflake table's rowcount is not zero
 ' Read Snowflake (TARGET/Source) database for single table and return specific dataset
 
If strTargetWhereClause <> "SQL" Then
strValue_Target = Snowflake_ReadDB_ReturnSingleValue(strUser, strPassword, strTargetColumn, strTargetSchema, strTargetView, strTargetProjectID, strTargetWhereClause, strSF_Connection)
Else
strValue_Target = Snowflake_ReadDB_ReturnSingleValue_ExternalSQL(strUser, strPassword, strWorkbook_Detail, strTargetColumn, strTargetSchema, strTargetView, strSQL_Location, strSF_Connection)
End If 


If strSourceWhereClause <> "SQL" Then
strValue_Source = Snowflake_ReadDB_ReturnSingleValue(strUser, strPassword, strSourceColumn, strSourceSchema, strSourceView, strSourceProjectID, strSourceWhereClause, strSF_Connection)
else
strValue_Source = Snowflake_ReadDB_ReturnSingleValue_ExternalSQL(strUser, strPassword, strWorkbook_Detail, strSourceColumn, strSourceSchema, strSourceView, strSQL_Location, strSF_Connection)
End If


' Insert value into TargetValue column
strTargetValue_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cTargetValue, strWorkbook_Detail)
strSourceValue_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cSourceValue, strWorkbook_Detail)
' Insert TargetValue/SourceValue
Call ReadExcelFile_UpdateTwoValues_Color(cDataFileURL, iIndex_Detail, strTargetValue_Index, strSourceValue_Index, strValue_Target, strValue_Source, strWorkbook_Detail)
End  If

wait(1)
 Next ' Detail loop
 
 ElseIf strWorkbook_Detail = "CONNECTIONPOINT" or strWorkbook_Detail = "PUBLIC" or strWorkbook_Detail = "PUREINSIGHTS" Then
 
 
  ' Get list of rows with flag = "Y"
 iRowValues_Detail = ReadExcelFile_LoadStringWithRowsContainsYesValue_2(cDataFileURL, strWorkbook_Detail) 
 
ArrayOfValues_Detail = Split(iRowValues_Detail, ",")

TargetFlag = true ' Get Target values only ones for TAB
For l = 0 To UBound(ArrayOfValues_Detail)

iIndex_Detail = ArrayOfValues_Detail(l)

' Get column's information
strTargetProjectID = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetProjectID, iIndex_Detail, strWorkbook_Detail)
strTargetSchema = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetSchema, iIndex_Detail, strWorkbook_Detail) 
strTargetView = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetView, iIndex_Detail, strWorkbook_Detail) 
strTargetColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetColumn, iIndex_Detail, strWorkbook_Detail)
strTargetWhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTargetWhereClause, iIndex_Detail, strWorkbook_Detail)

If strTargetWhereClause <> "SQL" Then
strValue_Target = Snowflake_ReadDB_ReturnSingleValue(strUser, strPassword, strTargetColumn, strTargetSchema, strTargetView, strTargetProjectID, strTargetWhereClause, strSF_Connection)
Else
strValue_Target = Snowflake_ReadDB_ReturnSingleValue_ExternalSQL(strUser, strPassword, strWorkbook_Detail, strTargetColumn, strTargetSchema, strTargetView, strSQL_Location, strSF_Connection)
End  If

' Convert D_DATE value from "#MM/DD/YYY#" to "YYYY-MM-DD"
strValue_Target = replace(strValue_Target, "#", "")
strIsDate = IsDate(strValue_Target)
If strIsDate = true Then
strValue_Target = ConvertDate_from_MMslashDDslashYYYY_to_YYYYdashMMdashDD(strValue_Target)	
End If


' Update TargetValue entry
strTargetValue_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cTargetValue, strWorkbook_Detail)
Call ReadExcelFile_UpdateCellValue_SendWorkSheet(cDataFileURL, strWorkbook_Detail, iIndex_Detail, strTargetValue_Index, strValue_Target)

' Compare two values (current and expected and update excel)
strExpectedValue_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cExpectedValue, strWorkbook_Detail)
strExpectedValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cExpectedValue, iIndex_Detail, strWorkbook_Detail)
Call ReadExcelFile_CompareTwoValuesUpdateExcel_Simple(cDataFileURL, strWorkbook_Detail, iIndex_Detail, strTargetValue_Index, strValue_Target, strExpectedValue_Index, strExpectedValue)

wait(1)
 Next ' Detail loop
 
 Else
 ' None
 
 End  If
 
 
 wait(1)
 Next ' Global loop







Services.EndTransaction "MicroStrategy - Performance"


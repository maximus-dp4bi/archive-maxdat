

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

' Get last folder name which will be MAIN folder for ALL Reports
strColName = "Script Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strBaseFolderName = ReadExcelFile_GetLastFolderName(strBasicLocation)
cReports = "C:\Maximus\Reports" & "\" & strBaseFolderName

' Copy dataDriver file from original location to Report folder and then use it as normal datadriver.

cDataFileURL = CopyFile_From_To(strDataDriver_Location, cReports, strDataDriver_FileName)

'' Data Driver Path
'strOneDrivePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%") & "\OneDrive - Maximus, Inc"
'cDataFileURL = strDataDriver_Location & "\" & strDataDriver_FileName & ".xlsx"

' Exit script if Alert = FAILED
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strFilePathINI = strBasicLocation & "\" & "Global_INI.ini"
strAlert = ReadIni( strFilePathINI, "Alert", "value")
If strAlert = "FAILED" Then
ExitTest	
End If

' ================================================================================================================================


Call KillAllExcelProcesses()

' Get Metadata_Exceptions table full path
strMetadataExceptions_Path = strDataDriver_Location & "\" & "Metadata_Exceptions.xlsx"
strWorkbook_ColumnExceptions = "Column_Exceptions"
strWorkbook_DatatypeExceptions = "Datatype_Exceptions"

'Call CreateFolder () ' Create local folder to store reports
' Summary tab information
strWorkbook = "Summary"
iRowValues = ReadExcelFile_LoadStringWithRowsContainsYesValue_2(cDataFileURL, strWorkbook) ' Get list of reports marked as "Y".
strMetadata_Verification_Column_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cMetadata_Verification, strWorkbook)
strSnowFlake_RowCount_Column_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cSnowFlake_RowCount, strWorkbook)
strMySQL_RowCount_Column_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cMySQL_RowCount, strWorkbook)
' SampleData_Query tab information
strWorkbook_SampleData_Query = "SampleData_Query"



ArrayOfValues = Split(iRowValues, ",")

For i = 0 To UBound(ArrayOfValues)

' Performance verification: Start

 iIndex = ArrayOfValues(i)
 
 ' Clear dowload folder.
 Call KillAllExcelProcesses()
 Call ClearCurrentDownloadFolder()

' Get variables from external Data file
strSchema_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strTable_MySQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_MySQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)

' Verify metadata is identical for source and target tables
Wait(1)
strFlagGlobal = ReadExcelFile_ColumnsCrossRef_PureInsights_vs_Snowflake_ReadExceptions(cDataFileURL, strTable_MySQL, strTable_Snowflake, strFilePathINI, strMetadataExceptions_Path, strWorkbook_ColumnExceptions, strWorkbook_DatatypeExceptions)
' Update Summary tab - Metadata Verification cell with PASSED/FAILED value
Wait(2)
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strMetadata_Verification_Column_Index, strFlagGlobal, strWorkbook)

' Get SnowFlake table's row count
strSnowflakeCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Snowflake, strTable_Snowflake) 
' Get MySQL table's row count
strMySQLCount = MySQL_ReadDB_RowCount(strUser, strPassword, strSchema_MySQL, strTable_MySQL) 

' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strSnowflakeCount, strMySQLCount, strWorkbook)
' Compare Row counts and update Summary with Passed/Failed result
Call ReadExcelFile_GetRowCounts_Compare_UpdateWith_PassedFailed(cDataFileURL, iIndex, cSnowFlake_RowCount, strSnowFlake_RowCount_Column_Index, cMySQL_RowCount, strMySQL_RowCount_Column_Index, strWorkbook)




Wait(1)

Next

Services.EndTransaction "MicroStrategy - Performance"


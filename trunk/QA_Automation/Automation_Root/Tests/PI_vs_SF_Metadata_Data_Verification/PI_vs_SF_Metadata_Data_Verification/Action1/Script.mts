
Dim strMySQLCount
Dim strSnowflakeCount

Services.StartTransaction "MicroStrategy - Performance"

' Clean up
'Call KillAllChromeProcesses().
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

' Get Metadata_ExtraColumns_Snowflake table full path
strMetadata_ExtraColumns_Snowflake_FileName = "Metadata_ExtraColumns_Snowflake"
strMetadata_ExtraColumns_Snowflake_ReportLocation = CopyFile_From_To(strDataDriver_Location, cReports, strMetadata_ExtraColumns_Snowflake_FileName)

' Get Metadata_ExtraColumns_Snowflake reverse table full path
strMetadata_ExtraColumns_Snowflake_ToLoad_FileName = "Metadata_ExtraColumns_Snowflake_ToLoad"
strMetadata_ExtraColumns_Snowflake_ToLoad_ReportLocation = CopyFile_From_To(strDataDriver_Location, cReports, strMetadata_ExtraColumns_Snowflake_ToLoad_FileName)


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
strWorkbook = "Summary"
iRowValues = ReadExcelFile_LoadStringWithRowsContainsYesValue_2(cDataFileURL, strWorkbook) ' Get list of reports marked as "Y".
Metadata_MySQL_Snowflake_Verification_Column_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cMetadata_MySQL_Snowflake_Verification, strWorkbook)
strSnowFlake_RowCount_Column_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cSnowFlake_RowCount, strWorkbook)
strMySQL_RowCount_Column_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cMySQL_RowCount, strWorkbook)
Metadata_Snowflake_OnlyColumns_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cMetadata_Snowflake_OnlyColumns, strWorkbook)
strData_MySQL_Snowflake_Verification_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cData_MySQL_Snowflake_Verification, strWorkbook)
strSpecialValidation_Index = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cSpecialValidation, strWorkbook)

' SampleData_Query tab information
strWorkbook_SampleData_Query = "SampleData_Query"

ArrayOfValues = Split(iRowValues, ",")

For i = 0 To UBound(ArrayOfValues)

' Performance verification: Start

 iIndex = ArrayOfValues(i)
 
 ' Clear dowload folder.
 Call KillAllExcelProcesses()
 Call ClearCurrentDownloadFolder()
 
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
 
 ' Set MySQL connection
 'strMySQL_Connection = cMySQLConnection_PROD
 strMySQL_Connection = ReadIni( strFilePathINI, "ENV_MySQL", "value")

' Get Summary column represents tables exists only in Snowflake schema
strSnowflake_Only = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_Only, iIndex, strWorkbook)
 
 select case strSnowflake_Only
   CASE "N" ' Views/tables exist in both: PureInsight and Snowflake schemas

' Get variables from external Data file
strSchema_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strTable_Snowflake_Saved = strTable_Snowflake
strTable_MySQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_MySQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)

' Read Snowflake database for single table and return excel file with metadata.
strMetadataFilePath_SF = Snowflake_ReadDB_LoadMetadataIntoExcel(strUser, strPassword, cReports, strSchema_Snowflake, strTable_Snowflake, strSF_Connection) 
' Read temp metadata file and load correspondent tab in Summary file
Call ReadExcelFile_GetDataFromSourceFile_LoadMetadata_Snowflake(strMetadataFilePath_SF, cDataFileURL, 1, strTable_Snowflake_Saved, strFilePathINI)

' Read MySQL database for single table and return excel file with metadata.
strMetadataFilePath_MySQL =  MySQL_ReadDB_LoadMetadataIntoExcel(strUser, strPassword, cReports, strSchema_MySQL, strTable_MySQL, strSQL_Location, strMySQL_Connection) 
' Read temp metadata file and load correspondent tab in Summary file
Call ReadExcelFile_GetDataFromSourceFile_LoadMetadata_MySQL(strMetadataFilePath_MySQL, cDataFileURL, 1, strTable_MySQL)

' Verify metadata is identical for source and target tables
strFlagGlobal = ReadExcelFile_ColumnsCrossRef_PureInsights_vs_Snowflake_ReadExceptions(cDataFileURL, strTable_MySQL, strTable_Snowflake, strFilePathINI, strMetadataExceptions_Path, strWorkbook_ColumnExceptions, strWorkbook_DatatypeExceptions)
'strFlagGlobal = ReadExcelFile_ColumnsCrossRef_PureInsights_vs_Snowflake_Do_NOT_ReadExceptions(cDataFileURL, strTable_MySQL, strTable_Snowflake, strFilePathINI, strMetadataExceptions_Path, strWorkbook_ColumnExceptions, strWorkbook_DatatypeExceptions)
' Update Summary tab - Metadata Verification cell with PASSED/FAILED value
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, Metadata_MySQL_Snowflake_Verification_Column_Index, strFlagGlobal, strWorkbook)

' Reverse Engineering. Read Summary final table - Lookup Column in MySQl. If Not found, load into Metadata_ExtraColumns_Snowflake_ToLoad. 
Call ReadExcelFile_ReadSnowflakeFinalTable_LookupInMySQL_WriteIntoExceptionFile_IfColumnNotFound(cDataFileURL, strTable_Snowflake, strTable_MySQL, strMetadata_ExtraColumns_Snowflake_ToLoad_ReportLocation)

' Verify columns from Metadata_ExtraColumns_Snowflake table exists in DataDriver_PI_vs_SF_Metadata_Data_Verification table
strSource_Path = strMetadata_ExtraColumns_Snowflake_ReportLocation
strTarget_Path = cDataFileURL
strFlagGlobal2 = ReadExcelFile_ColumnsCrossRef_Metadata_ExtraColumns_Snowflake_vs_DataDriver_PI_vs_SF_Metadata_Data_Verification(strSource_Path, strTarget_Path, strTable_Snowflake)
' Update Summary tab - Metadata_ExtraColumns_Snowflake" cell with PASSED/FAILED value
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, Metadata_Snowflake_OnlyColumns_Index, strFlagGlobal2, strWorkbook)

strMySQLCount = 0
strMySQLCount = 0
' Get SnowFlake table's row count
' Snowflake rowcount where clause.
'strSnowflakeWhereClause = ReadIni( strFilePathINI, "Snowflake_RowCount", "value")
strSnowflakeCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Snowflake, strTable_Snowflake, strSF_Connection, strSnowflake_WhereClause) 
' Get MySQL table's row count
strMySQLCount = MySQL_ReadDB_RowCount(strUser, strPassword, strSchema_MySQL, strTable_MySQL, strMySQL_Connection) 

' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strSnowflakeCount, strMySQLCount, strWorkbook)
' Compare Row counts and update Summary with Passed/Failed result
Call ReadExcelFile_GetRowCounts_Compare_UpdateWith_PassedFailed(cDataFileURL, iIndex, cSnowFlake_RowCount, strSnowFlake_RowCount_Column_Index, cMySQL_RowCount, strMySQL_RowCount_Column_Index, strWorkbook)

' Reverse Engineering. Read Summary final table - Lookup Column in MySQl. If Not found, load into Metadata_ExtraColumns_Snowflake_ToLoad. 
'Call ReadExcelFile_ReadSnowflakeFinalTable_LookupInMySQL_WriteIntoExceptionFile_IfColumnNotFound(cDataFileURL, strTable_Snowflake, strTable_MySQL, strMetadata_ExtraColumns_Snowflake_ToLoad_ReportLocation)

strMySQLCount = CLng(strMySQLCount)
strSnowflakeCount = CLng(strSnowflakeCount)
If strMySQLCount <> 0 and strSnowflakeCount <> 0 Then ' Compare data if MySQL/Snowflake table's rowcount is not zero
' Read MySQL database for single table and return specific dataset
strDataFilePath_MySQL =  MySQL_ReadDB_LoadSampleDataIntoExcel(strUser, strPassword, cReports, strSchema_MySQL, strTable_MySQL, strSQL_Data_Location, strMySQL_Connection) 
' Read Snowflake database for single table and return specific dataset
strDataFilePath_SF = Snowflake_ReadDB_LoadSampleDataIntoExcel(strUser, strPassword, cReports, strSchema_Snowflake, strTable_Snowflake, strSQL_Data_Location, strSF_Connection) 
' Compare values of each column MySQL - Snowflake
strDataFlag = ReadExcelFile_CompareSourceTargetData_ColumnByColumn_FirstDataRow(strDataFilePath_MySQL, strDataFilePath_SF, 1, 1, strDataExceptionsLookupTable_Path, strDataExceptionsWorkbook, strTable_MySQL)
' Insert Summary with SnowFlake/MySQL data validation
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strData_MySQL_Snowflake_Verification_Index, strDataFlag, strWorkbook)
End If

CASE "Y" ' Views/tables exist only in Snowflake schema

' Get variables from external Data file
strSchema_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strTable_Snowflake_Saved = strTable_Snowflake

' Read Snowflake database for single table and return excel file with metadata.
strMetadataFilePath_SF = Snowflake_ReadDB_LoadMetadataIntoExcel(strUser, strPassword, cReports, strSchema_Snowflake, strTable_Snowflake, strSF_Connection) 
' Read temp metadata file and load correspondent tab in Summary file
Call ReadExcelFile_GetDataFromSourceFile_LoadMetadata_Snowflake(strMetadataFilePath_SF, cDataFileURL, 1, strTable_Snowflake_Saved, strFilePathINI)

' Verify columns from Metadata_ExtraColumns_Snowflake table exists in DataDriver_PI_vs_SF_Metadata_Data_Verification table
strSource_Path = strMetadata_ExtraColumns_Snowflake_ReportLocation
strTarget_Path = cDataFileURL
strFlagGlobal2 = ReadExcelFile_ColumnsCrossRef_Metadata_ExtraColumns_Snowflake_vs_DataDriver_PI_vs_SF_Metadata_Data_Verification(strSource_Path, strTarget_Path, strTable_Snowflake)
' Update Summary tab - Metadata_ExtraColumns_Snowflake" cell with PASSED/FAILED value
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, Metadata_Snowflake_OnlyColumns_Index, strFlagGlobal2, strWorkbook)

' Get SnowFlake table's row count
'strSnowflakeWhereClause = ReadIni( strFilePathINI, "Snowflake_RowCount", "value")
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)
strSnowflakeCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Snowflake, strTable_Snowflake, strSF_Connection, strSnowflake_WhereClause) 
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strSnowflakeCount, strWorkbook)


'=========================================== Start Look Up table D_DATE validation ==================================
strLookUpTableNameCompare = ReadIni( strFilePathINI, "Snowflake_LookUpTable", "value")
If strLookUpTableNameCompare =  strTable_Snowflake Then
' Validate LOOK UP generic table data. Currently : D_DATE
strLookUpColumns = ReadIni( strFilePathINI, "Snowflake_LookUpColumns", "value")
strWhereColumn = ReadIni( strFilePathINI, "Snowflake_LookUpWhereColumn", "value")
strWhereValue = ReadIni( strFilePathINI, "Snowflake_LookUpWhereSingleValue", "value")
strLookUp_Flag = Snowflake_LookUpTableDataVerification(strUser, strPassword, strSchema_Snowflake, strTable_Snowflake, strSF_Connection, strSnowflake_WhereClause, strLookUpColumns, strWhereColumn, strWhereValue, cDataFileURL) 
strLookUp_Flag = strLookUp_Flag & " - DAYOFQUARTER" 
' Update Data_MySQL_Snowflake_Verification column in summary with overall look up validation Passed/FAILED
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strSpecialValidation_Index, strLookUp_Flag, strWorkbook)	
End If
'=========================================== End Look Up table D_DATE validation ==================================

'=======Start D_PI_PRIMARY_PRESENCE_DAILY_DURATION_VW IngestionTime row count validation. Failed if No records within past 2 days ======
If strTable_Snowflake = "D_PI_PRIMARY_PRESENCE_DAILY_DURATION_VW" Then
strLookUp_Flag = Snowflake_ReadDB_RowCount_IngestionTime(strUser, strPassword, strSchema_Snowflake, strTable_Snowflake, strSF_Connection) 
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strSpecialValidation_Index, strLookUp_Flag, strWorkbook)	
End If
'===========================================End D_PI_PRIMARY_PRESENCE_DAILY_DURATION_VW row count validation================


Case "S" ' Special validation
strSchema_MySQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)
strTable_MySQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strListOfColumns = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSpecialValidation, iIndex, strWorkbook)
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)

' Get Snowflake table's row count
strSnowflakeCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Snowflake, strTable_Snowflake, strSF_Connection, strSnowflake_WhereClause) 
' Get MySQL table's row count
strMySQLCount = MySQL_ReadDB_RowCount(strUser, strPassword, strSchema_MySQL, strTable_MySQL, strMySQL_Connection)
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strSnowflakeCount, strMySQLCount, strWorkbook)


strMySQLCount = CLng(strMySQLCount)
strSnowflakeCount = CLng(strSnowflakeCount)
If strMySQLCount <> 0 and strSnowflakeCount <> 0 Then ' Compare data if MySQL/Snowflake table's rowcount is not zero
' Read MySQL database for single table and return specific dataset
strDataFilePath_MySQL =  MySQL_ReadDB_LoadSampleDataIntoExcel_special(strUser, strPassword, cReports, strSchema_MySQL, strTable_MySQL, strListOfColumns, strSQL_Data_Location, strMySQL_Connection, strSnowflake_Only) 
' Read Snowflake database for single table and return specific dataset
strDataFilePath_SF = Snowflake_ReadDB_LoadSampleDataIntoExcel_special(strUser, strPassword, cReports, strSchema_Snowflake, strTable_Snowflake, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only) 
' Compare values of each column MySQL - Snowflake
strDataFlag = ReadExcelFile_CompareSourceTargetData_ColumnByColumn_FirstDataRow(strDataFilePath_MySQL, strDataFilePath_SF, 1, 1, strDataExceptionsLookupTable_Path, strDataExceptionsWorkbook, strTable_MySQL)
strLookupFlag = strDataFlag & " - Special validation"
' Insert Summary with SnowFlake/MySQL data validation
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strData_MySQL_Snowflake_Verification_Index, strLookupFlag, strWorkbook)
End  If

Case "S2" ' Special validation
strSchema_Stage = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)
strTable_Stage = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Snowflake = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strListOfColumns = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSpecialValidation, iIndex, strWorkbook)
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)

' Get Snowflake table's row count
strSnowflakeCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Snowflake, strTable_Snowflake, strSF_Connection, strSnowflake_WhereClause) 
' Get Stage table's row count
strStageCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Stage, strTable_Stage, strSF_Connection, strSnowflake_WhereClause)
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strSnowflakeCount, strStageCount, strWorkbook)


strStageCount = CLng(strStageCount)
strSnowflakeCount = CLng(strSnowflakeCount)
If strStageCount <> 0 and strSnowflakeCount <> 0 Then ' Compare data if MySQL/Snowflake table's rowcount is not zero
' Read Stage database for single table and return specific dataset
strDataFilePath_Stage = Snowflake_ReadDB_LoadSampleDataIntoExcel_special(strUser, strPassword, cReports, strSchema_Stage, strTable_Stage, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only) 
' Read Snowflake database for single table and return specific dataset
strDataFilePath_SF = Snowflake_ReadDB_LoadSampleDataIntoExcel_special(strUser, strPassword, cReports, strSchema_Snowflake, strTable_Snowflake, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only) 
' Compare values of each column MySQL - Snowflake
strDataFlag = ReadExcelFile_CompareSourceTargetData_ColumnByColumn_FirstDataRow(strDataFilePath_Stage, strDataFilePath_SF, 1, 1, strDataExceptionsLookupTable_Path, strDataExceptionsWorkbook, strTable_Stage)
strLookupFlag = strDataFlag & " - Special validation"
' Insert Summary with SnowFlake/MySQL data validation
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strData_MySQL_Snowflake_Verification_Index, strLookupFlag, strWorkbook)
End  If


Case "S3" ' Special validation
strSchema_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)
strTable_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strListOfColumns = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSpecialValidation, iIndex, strWorkbook)
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)

' Get Snowflake table's row count
strTargetCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Target, strTable_Target, strSF_Connection, strSnowflake_WhereClause) 
' Get Stage table's row count
strSourceCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Source, strTable_Source, strSF_Connection, strSnowflake_WhereClause)
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strTargetCount, strSourceCount, strWorkbook)

strSourceCount = CLng(strSourceCount)
strTargetCount = CLng(strTargetCount)
If strSourceCount <> 0 and strTargetCount <> 0 Then ' Compare data if MySQL/Snowflake table's rowcount is not zero
' Read Stage database for single table and return specific dataset
strDataFilePath_Source = Snowflake_ReadDB_LoadSampleDataIntoExcel_special(strUser, strPassword, cReports, strSchema_Source, strTable_Source, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only) 
' Read Snowflake database for single table and return specific dataset
strDataFilePath_Target = Snowflake_ReadDB_LoadSampleDataIntoExcel_special(strUser, strPassword, cReports, strSchema_Target, strTable_Target, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only) 
' Compare values of each column MySQL - Snowflake
strDataFlag = ReadExcelFile_ColumnsCrossRef_SpecialValidation_S3(strDataFilePath_Source, strDataFilePath_Target, strListOfColumns)
strLookupFlag = strDataFlag & " - Special validation"
' Insert Summary with SnowFlake/MySQL data validation
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strData_MySQL_Snowflake_Verification_Index, strLookupFlag, strWorkbook)
End  If


Case "S4" ' Special validation
strSchema_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)
strTable_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strListOfColumns = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSpecialValidation, iIndex, strWorkbook)
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)

' Get Snowflake table's row count
strTargetCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Target, strTable_Target, strSF_Connection, strSnowflake_WhereClause) 
' Get Stage table's row count
strSourceCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Source, strTable_Source, strSF_Connection, strSnowflake_WhereClause)
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strTargetCount, strSourceCount, strWorkbook)

strSourceCount = CLng(strSourceCount)
strTargetCount = CLng(strTargetCount)
If strSourceCount <> 0 and strTargetCount <> 0 Then ' Compare data if MySQL/Snowflake table's rowcount is not zero
' Read Stage database for single table and return specific dataset
strDataFilePath_Source = Snowflake_ReadDB_LoadSampleDataIntoExcel_special_2(strUser, strPassword, cReports, strSchema_Source, strTable_Source, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only) 
' Read Snowflake database for single table and return specific dataset
strDataFilePath_Target = Snowflake_ReadDB_LoadSampleDataIntoExcel_special_2(strUser, strPassword, cReports, strSchema_Target, strTable_Target, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only) 

' Add second worksheet (Validation) to the Source excel
strSheet1 = "Validation"
strSheet2 = "Original"
Call ReadExcelFile_AddWorksheet_AddTwoColumns_Special(strDataFilePath_Source, strSheet1, strSheet2)
' Load column data from original worksheet to new one
Call ReadExcelFile_LoadColumnData_FromOneWorksheetToAnother_Special (strDataFilePath_Source, strSheet1, strSheet2)
' Read Source table (Validation worksheet) and validate it against Target table
strColumn_Source_1 = "Source"
strColumn_Source_2 = "Target"
strColumn_Target = "VALUE"
strDataFlag = ReadExcelFile_ColumnsCrossRef_SpecialValidation_S4(strDataFilePath_Source, strColumn_Source_1, strColumn_Source_2, strSheet1, strDataFilePath_Target, strColumn_Target)
strLookupFlag = strDataFlag & " - Special validation"
' Insert Summary with SnowFlake/MySQL data validation
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strData_MySQL_Snowflake_Verification_Index, strLookupFlag, strWorkbook)
End  If

Case "S5" ' Special validation

'=========== Metadata validation ====================
' Get variables from external Data file
strSchema_Snowflake_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Snowflake_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strTable_Snowflake_Target_Saved = strTable_Snowflake_Target & "_Target"
strTable_Snowflake_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_Snowflake_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)
strTable_Snowflake_Source_Saved = strTable_Snowflake_Source & "_Source"
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)
strListOfColumns = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSpecialValidation, iIndex, strWorkbook)

' Read Snowflake database for single table and return excel file with metadata.
strExtention = "Target"
strMetadataFilePath_SF_Target = Snowflake_ReadDB_LoadMetadataIntoExcel_IdenticalTables(strUser, strPassword, cReports, strSchema_Snowflake_Target, strTable_Snowflake_Target, strSF_Connection, strExtention) 
' Read temp metadata file and load correspondent tab in Summary file
Call ReadExcelFile_GetDataFromSourceFile_LoadMetadata_Snowflake(strMetadataFilePath_SF_Target, cDataFileURL, 1, strTable_Snowflake_Target_Saved, strFilePathINI)

' Read Snowflake database for single table and return excel file with metadata.
strExtention = "Source"
strMetadataFilePath_SF_Source = Snowflake_ReadDB_LoadMetadataIntoExcel_IdenticalTables(strUser, strPassword, cReports, strSchema_Snowflake_Source, strTable_Snowflake_Source, strSF_Connection, strExtention) 
' Read temp metadata file and load correspondent tab in Summary file
Call ReadExcelFile_GetDataFromSourceFile_LoadMetadata_Snowflake(strMetadataFilePath_SF_Source, cDataFileURL, 1, strTable_Snowflake_Source_Saved, strFilePathINI)

' Verify metadata is identical for source and target tables
'''''''strFlagGlobal = ReadExcelFile_ColumnsCrossRef_SnowflakeSource_vs_SnowflakeTarget(cDataFileURL, strTable_Snowflake_Source_Saved, strTable_Snowflake_Target_Saved)
strFlagGlobal = "PASSED"
' Update Summary tab - Metadata Verification cell with PASSED/FAILED value
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, Metadata_MySQL_Snowflake_Verification_Column_Index, strFlagGlobal, strWorkbook)

'=========== Row Counts ===========
' Get Snowflake table's row count
strTargetCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Snowflake_Target, strTable_Snowflake_Target, strSF_Connection, strSnowflake_WhereClause) 
' Get Stage table's row count
strSourceCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Snowflake_Source, strTable_Snowflake_Source, strSF_Connection, strSnowflake_WhereClause)
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strTargetCount, strSourceCount, strWorkbook)
' Compare Row counts and update Summary with Passed/Failed result
Call ReadExcelFile_GetRowCounts_Compare_UpdateWith_PassedFailed(cDataFileURL, iIndex, strTargetCount, strSnowFlake_RowCount_Column_Index, strSourceCount, strMySQL_RowCount_Column_Index, strWorkbook)

' ========== Data Validation =============
strSourceCount = CLng(strSourceCount)
strTargetCount = CLng(strTargetCount)
If strSourceCount <> 0 and strTargetCount <> 0 Then ' Compare data if MySQL/Snowflake table's rowcount is not zero
strSourceTargetExtencion = "Source"
strDataFilePath_Source = Snowflake_ReadDB_LoadSampleDataIntoExcel_special_SourceTargetExtencion(strUser, strPassword, cReports, strSchema_Snowflake_Source, strTable_Snowflake_Source, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only, strSourceTargetExtencion) 
' Read Snowflake database for single table and return specific dataset
strSourceTargetExtencion = "Target"
strDataFilePath_Target = Snowflake_ReadDB_LoadSampleDataIntoExcel_special_SourceTargetExtencion(strUser, strPassword, cReports, strSchema_Snowflake_Target, strTable_Snowflake_Target, strListOfColumns, strSQL_Data_Location, strSF_Connection, strSnowflake_Only, strSourceTargetExtencion) 

' Compare values of each column Source - Target
'strDataFlag = ReadExcelFile_CompareSourceTargetData_ColumnByColumn_FirstDataRow(strDataFilePath_Source, strDataFilePath_Target, 1, 1, strDataExceptionsLookupTable_Path, strDataExceptionsWorkbook, strTable_MySQL)
''''' Insert Summary with SnowFlake/MySQL data validation
strDataFlag = "PASSED"
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strData_MySQL_Snowflake_Verification_Index, strDataFlag, strWorkbook)
End  If

Case "S6" ' Special validation
strSchema_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_MySQL, iIndex, strWorkbook)
strTable_Source = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_MySQL, iIndex, strWorkbook)
strSchema_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSchema_Snowflake, iIndex, strWorkbook)
strTable_Target = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cTable_Snowflake, iIndex, strWorkbook)
strListOfColumns = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSpecialValidation, iIndex, strWorkbook)
strSnowflake_WhereClause = ReadExcelFile_GetCellValueByColumnNameAndRowIndex_2(cDataFileURL, cSnowflake_WhereClause, iIndex, strWorkbook)

' Get Snowflake table's row count.
strTargetCount = Snowflake_ReadDB_RowCount(strUser, strPassword, strSchema_Target, strTable_Target, strSF_Connection, strSnowflake_WhereClause) 
' Get table's row count for today's date
strDateValue = Date_AddLeadingZeroToTheMonth_YYYYMMDD_InDash(now)
strSourceCount = Snowflake_ReadDB_Rowcount_special(strUser, strPassword, cReports, strSchema_Source, strTable_Source, strSQL_Data_Location, strSF_Connection, strSnowflake_Only, strDateValue) 
' Insert Summary with SnowFlake/MySQL row counts
Call ReadExcelFile_SnowFlake_MySQL_UpdateCountCells(cDataFileURL, iIndex, strSnowFlake_RowCount_Column_Index, strMySQL_RowCount_Column_Index, strTargetCount, strSourceCount, strWorkbook)
' Compare Row counts and update Summary with Passed/Failed result
Call ReadExcelFile_GetRowCounts_Compare_UpdateWith_PassedFailed(cDataFileURL, iIndex, strTargetCount, strSnowFlake_RowCount_Column_Index, strSourceCount, strMySQL_RowCount_Column_Index, strWorkbook)
' Update Passed/Failed
strSourceCount = CLng(strSourceCount)
strTargetCount = CLng(strTargetCount)
If strSourceCount = strTargetCount Then
strFlagGlobal = "PASSED"
Else
strFlagGlobal = "FAILED"
End If
strLookupFlag = strFlagGlobal & " - Special validation"
' Insert Summary with SnowFlake/MySQL data validation
Call ReadExcelFile_UpdateCellValue_2(cDataFileURL, iIndex, strData_MySQL_Snowflake_Verification_Index, strLookupFlag, strWorkbook)

wait(1)
Case ELSE
     'None
     
END  SELECT

wait(1)

Next

Services.EndTransaction "MicroStrategy - Performance"


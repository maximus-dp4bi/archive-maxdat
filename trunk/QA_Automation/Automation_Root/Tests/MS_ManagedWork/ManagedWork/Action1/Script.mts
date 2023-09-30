'
'strTempFileURL = "C:\Temp\tempFile.xlsx"
'strColName = "Data Driver"
'iIndex = 2
'strDataDriver_FileName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
'strColName = "Data Driver Location"
'strDataDriver_Location = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
'strColName = "SQL Location"
'strSQLLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)DataDriver_ManagedWork_7.0 Completed Tasks by Timeliness Status
'strColName = "Test Name"
'strTestName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Create folder (strTestName) under C:Maximus/Reports
'cReports = "C:\Maximus\Reports" & "\" & strTestName
'Call CreateFolderSingleIfNotExists(cReports)
'strOneDrivePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%") & "\OneDrive - Maximus, Inc"
'cDataFileURL = strDataDriver_Location & "\" & strDataDriver_FileName & ".xls"
'
Services.StartTransaction "MicroStrategy - Performance"

strSQLLocation = "C:\Automation_Root\States\NJ\MS_ManagedWork\NJSBE\SQL"
cDataFileURL = "C:\Automation_Root\States\NJ\MS_ManagedWork\NJSBE\Project\Data\DataDriver_ManagedWork_Current Inventory Report (Complaints).xls"
cReports = "C:\Maximus\Reports" & "\" & "PAX704DEV_DataDriver_ManagedWork_Current Inventory Report (Complaints)"
Call CreateFolderSingleIfNotExists(cReports) 

Call KillAllExcelProcesses()

'Call CreateFolder () ' Create local folder to store reports

iRowValues = ReadExcelFile_LoadStringWithRowsContainsYesValue(cDataFileURL) ' Get list of reports marked as "Y".

ArrayOfValues = Split(iRowValues, ",")

For i = 0 To UBound(ArrayOfValues)

' Performance verification: Start

 iIndex = ArrayOfValues(i)
 
 ' Clear dowload folder.
 Call KillAllExcelProcesses()
 Call ClearCurrentDownloadFolder()

' Get variables from external Data file
strUser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_User, iIndex)
strPass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_Pass, iIndex) 
strEnv = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEnvironment, iIndex)
strBrowser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBrowser, iIndex)
strLoginAuthentication = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLoginAuthentication, iIndex)
strLink_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_1, iIndex)
strLink_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_2, iIndex)
strLink_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_3, iIndex)
strLink_4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_4, iIndex)
strLink_5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_5, iIndex)
strLink_6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_6, iIndex)
strReportName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportName, iIndex)
strReportLink = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportLink, iIndex)
strContainerType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportContainerType, iIndex)
strWorkbookName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_WorkbookName, iIndex)
strMS_Report_Suffix = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_Report_Suffix, iIndex)
strReportLink_Substring = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportLink_Substring, iIndex)
strReportType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportType, iIndex)
strSelectOption = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sSelectOption, iIndex)
strTypeValue_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sTypeValue_1, iIndex)
strTypeValue_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sTypeValue_2, iIndex)
strTypeValue_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sTypeValue_3, iIndex)
strValidate_UI_AvailableSelected_Options_Included = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cValidate_UI_AvailableSelected_Options_Included, iIndex)
stsValidate_UI_AvailableSelected_Options_Excluded = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cValidate_UI_AvailableSelected_Options_Excluded, iIndex)
strSingleDropdownList_IncludedValues = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cSingleDropdownList_IncludedValues, iIndex)
strSingleDropdownList_ExcludedValues = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cSingleDropdownList_ExcludedValues, iIndex)
strDB_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_User, iIndex)
strDB_Password = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_Password, iIndex)
strDB_DataSource = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_DataSource, iIndex)
strSQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cSQL, iIndex)
strCompare_ValidateColumnName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCompare_ValidateColumnName, iIndex)
strCompare_ValidateByColumnValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCompare_ValidateByColumnValue, iIndex)
strGrid_ColumnList = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_ColumnList, iIndex)
strGrid_WebList_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_1, iIndex)
strGrid_WebList_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_2, iIndex)
strGrid_WebList_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_3, iIndex)
strGrid_WebList_4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_4, iIndex)
strGrid_WebList_5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_5, iIndex)
strGrid_WebList_6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_6, iIndex)
strGrid_WebList_7 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_7, iIndex)
strReport_Name_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReport_Name_1, iIndex)
strReport_Name_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReport_Name_2, iIndex)
strReport_Name_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReport_Name_3, iIndex)
strR1_FilterByColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_FilterByColumn, iIndex)
strR1_FilterByValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_FilterByValue, iIndex)
strR2_FilterByColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_FilterByColumn, iIndex)
strR2_FilterByValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_FilterByValue, iIndex)
strR3_FilterByColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_FilterByColumn, iIndex)
strR3_FilterByValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_FilterByValue, iIndex)
strR1_ColumnsToTotalNumbers = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToTotalNumbers, iIndex)
strR1_ColumnsToTotalTime_HMS = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToTotalTime_HMS, iIndex)
strR1_ColumnsToAverageNumber = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToAverageNumber, iIndex)
strR1_ColumnsToAveragePercent = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToAveragePercent, iIndex)
strR1_ColumnsToAverageTime_HMS = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToAverageTime_HMS, iIndex)
strR2_ColumnsToTotalNumbers = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToTotalNumbers, iIndex)
strR2_ColumnsToTotalTime_HMS = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToTotalTime_HMS, iIndex)
strR2_ColumnsToAverageNumber = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToAverageNumber, iIndex)
strR2_ColumnsToAveragePercent = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToAveragePercent, iIndex)
strR2_ColumnsToAverageTime_HMS = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToAverageTime_HMS, iIndex)
strR3_ColumnsToTotalNumbers = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_ColumnsToTotalNumbers, iIndex)
strR3_ColumnsToTotalTime_HMS = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_ColumnsToTotalTime_HMS, iIndex)
strR3_ColumnsToAverageNumber = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_ColumnsToAverageNumber, iIndex)
strR3_ColumnsToAveragePercent = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_ColumnsToAveragePercent, iIndex)
strR3_ColumnsToAverageTime_HMS = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_ColumnsToAverageTime_HMS, iIndex)
strCrossreference_ColumnsCompare = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCrossreference_ColumnsCompare, iIndex)
strR1_AutoFilter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_AutoFilter, iIndex)
strR2_AutoFilter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_AutoFilter, iIndex)
strR3_AutoFilter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_AutoFilter, iIndex)
strR1_Filter1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Filter1, iIndex)
strR1_Filter2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Filter2, iIndex)
strR1_Filter3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Filter3, iIndex)
strR1_Filter4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Filter4, iIndex)
strR1_Filter5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Filter5, iIndex)
strR1_Filter6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Filter6, iIndex)
strR1_Filter7 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Filter7, iIndex)
strR2_Filter1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Filter1, iIndex)
strR2_Filter2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Filter2, iIndex)
strR2_Filter3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Filter3, iIndex)
strR2_Filter4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Filter4, iIndex)
strR2_Filter5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Filter5, iIndex)
strR2_Filter6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Filter6, iIndex)
strR2_Filter7 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Filter7, iIndex)
strR3_Filter1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_Filter1, iIndex)
strR3_Filter2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_Filter2, iIndex)
strR3_Filter3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_Filter3, iIndex)
strR3_Filter4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_Filter4, iIndex)
strR3_Filter5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_Filter5, iIndex)
strR3_Filter6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_Filter6, iIndex)
strR3_Filter7 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_Filter7, iIndex)
strR1_TotalNumberOfRows = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_TotalNumberOfRows, iIndex)
strR2_TotalNumberOfRows = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_TotalNumberOfRows, iIndex)
strR3_TotalNumberOfRows = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_TotalNumberOfRows, iIndex)
strR3_DossierReportTitle = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_DossierReportTitle, iIndex)

strBitMapLocation = OptionSelectionScreenshotLocation(cReports, strReportName, strReportType)
strURL =  Dossier_GetEnvironmentURL (strEnv, strDEMO, strDEV, strUAT)

If strReportType <> "SQL" and strReportType <> "Filter-Calculate-Compare" Then ' Skip UI if  Report generated from SQL

' Close all IE browsers
Call GEN_CloseAll_Browsers(strBrowser)

' Log into Micro Starategy
Call  Dossier_LogIn (strBrowser, strURL, strUser, strPass)

' Select folders
If strLink_1 <> "" Then
Call MicroStarategy_LoopThroughPage_SelectLink (strLink_1)
End If

' Click on Continue button if exists
Call MicroStarategy_LoopThroughPage_ContinueButton()

If strLink_2 <> "" Then
Call MicroStarategy_LoopThroughPage_SelectLink (strLink_2)	
End If

If strLink_3 <> "" Then
Call MicroStarategy_LoopThroughPage_SelectLink (strLink_3)	
End If

If strLink_4 <> "" Then
Call MicroStarategy_LoopThroughPage_SelectLink (strLink_4)	
End If

If strLink_5 <> "" Then
Call MicroStarategy_LoopThroughPage_SelectLink (strLink_5)	
End If

If strLink_6 <> "" Then
Call MicroStarategy_LoopThroughPage_SelectLink (strLink_6)	
End If

Call MicroStarategy_DirectAccess_SelectReportLink_ManagedWork(strReportLink, strReportName, strContainerType)


strError = TerminateScript (TestResultLocation)
If strError = true Then
Exit For	
End If

' Select options configuration
Select Case strSelectOption

   Case "Textbox_Single"
' Validate option's values
strSearchIndex = 0 ' index for option's search box
strAddIndex = 0 ' index for option  objects
'Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strSearchIndex)   

If strTypeValue_1 <> "Default"Then ' Do not select any options if Default value is passed.
' Select options
Call MicroStarategy_SingleTextBoxEntrie(strTypeValue_1) ' Choose options in loop
End If

' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType)
Wait(2)' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports) ' Download file
End  If

   Case "Available-Selected"
' Validate option's values
strSearchIndex = 0 ' index for option's search box
strAddIndex = 0 ' index for option  objects
'Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strSearchIndex)   

If strTypeValue_1 <> "Default"Then ' Do not select any options if Default value is passed.
' Select options
'Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_1, strAddIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_1, strAddIndex)
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_1, strSearchIndex, strAddIndex) ' Choose options in loop
End If

' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType)
Wait(2)' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports) ' Download file
End  If


   Case "Dates"
' Dates One()Two single entries
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.
Call MicroStarategy_CalendarOnly_TwoSingleEntries (strTypeValue_1) ' Variable contains one or two dates
End If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports) ' Download file
End  If

   Case "Save As"
' Download Report: Save As
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

   Case "Graphs"
' ???? Graphs
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button

   Case "SingleDropdown"
  ' Validate dropdown options
Call MicroStarategy_SingleDropdownSelection_VerifyDropdownList(strSingleDropdownList_IncludedValues, strSingleDropdownList_ExcludedValues)
' Select option 
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.
Call MicroStarategy_SingleDropdownSelection (strTypeValue_1)
End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

   Case "Dates-Available-Selected"
' Validate option's values
strAddIndex = 0 
Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strAddIndex)   
   
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.
strIndex_D1 = 0
strIndex_D2 = 1
strIndexCal_1 = 0
strIndexCal_2 = 1
Call MicroStarategy_CalendarAndOtherSelections_TwoSingleEntries (strTypeValue_2, strIndex_D1, strIndex_D2, strIndexCal_1, strIndexCal_2) '- Calendar (two single date entries)
strSearchIndex = 2 ' index for option's search box
strAddIndex = 0 ' index for option  objects
' Select options
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_2, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_2, strAddIndex)
End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If


   Case "Dates-SingleDropdown"
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.
strIndex_D1 = 0
strIndex_D2 = 1
strIndexCal_1 = 0
strIndexCal_2 = 1
Call MicroStarategy_CalendarAndOtherSelections_TwoSingleEntries (strTypeValue_2, strIndex_D1, strIndex_D2, strIndexCal_1, strIndexCal_2) '- Calendar (two single date entries)
Call MicroStarategy_SingleDropdownSelection (strTypeValue_2) ' Select dropdown option
End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Wait(1)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

   Case "Available-Selected-DoublePanel"
' Validate options on UI
strAddIndex = 0
Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strAddIndex)
' Validate option's values
strAddIndex = 1
Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strAddIndex)  
 
' Select options 
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.
strSearchIndex = 0 ' index for option's search box
strAddIndex = 0 ' index for option  objects
' Select options
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_1, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_1, strAddIndex)
strSearchIndex = 1 ' index for option's search box
strAddIndex = 1 ' index for option  objects
' Select options
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_2, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_2, strAddIndex)
End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Wait(1)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

   Case "Available-Selected-Dates"
  ' Validate options on UI
strAddIndex = 0 
Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strAddIndex)

' Select options
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.

If strTypeValue_1 <> "" Then
strSearchIndex = 0 ' index for option's search box
strAddIndex = 0 ' index for option  objects
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_1, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_1, strAddIndex)
End  If
If strTypeValue_2 <> "" Then
strIndex_D1 = 1
strIndex_D2 = 2
strIndexCal_1 = 0
strIndexCal_2 = 1
Call MicroStarategy_CalendarAndOtherSelections_TwoSingleEntries (strTypeValue_2, strIndex_D1, strIndex_D2, strIndexCal_1, strIndexCal_2) '- Calendar (two single date entries)
End  If

End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

   Case "Available-Selected-Dates-Available-Selected"
  ' Validate options on UI
strAddIndex = 0 
Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strAddIndex)

' Select options
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.

If strTypeValue_1 <> "" Then
strSearchIndex = 0 ' index for option's search box
strAddIndex = 0 ' index for option  objects
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_1, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_1, strAddIndex)
End  If

If strTypeValue_2 <> "" Then
strIndex_D1 = 2
strIndex_D2 = 5
strIndexCal_1 = 0
strIndexCal_2 = 1
Call MicroStarategy_CalendarAndOtherSelections_TwoSingleEntries(strTypeValue_2, strIndex_D1, strIndex_D2, strIndexCal_1, strIndexCal_2) '- Calendar (two single date entries)
End  If

If strTypeValue_3 <> "" Then
strSearchIndex = 8 ' index for option's search box
strAddIndex = 1 ' index for option  objects
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_3, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_3, strAddIndex)
End  If

End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If


   Case "Dates-Available-Selected_DoublePanel"
   
If strTypeValue_1 <> "" Then
strIndex_D1 = 0
strIndex_D2 = 2
strIndexCal_1 = 0
strIndexCal_2 = 1
Call MicroStarategy_CalendarAndOtherSelections_TwoSingleEntries(strTypeValue_1, strIndex_D1, strIndex_D2, strIndexCal_1, strIndexCal_2) '- Calendar (two single date entries)
End  If 
 
' Select options
If strTypeValue_2 <> "" Then
strSearchIndex = 4 ' index for option's search box
strAddIndex = 0 ' index for option  objects
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_2, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_2, strAddIndex)
End  If

If strTypeValue_3 <> "" Then
strSearchIndex = 5 ' index for option's search box
strAddIndex = 1 ' index for option  objects
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_3, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_3, strAddIndex)
End  If


' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton_2 (strReportType) ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

  Case Else
Reporter.ReportEvent micFail, "Select Option", ("Incorrect option type: " & strSelectOption & " sent to scrit")

End Select

End If ' Report generated from SQL


' ------------------------------------ Validate report data ---------------------------------------------------------------------

Select Case strReportType

Case "SQL"

' Decript DB password
strDB_Password =  DecryptText(strDB_Password)

' SQL Report location.
cReportFileURL_SQL = SQLReportLocation(cReports, strReportLink_Substring, strReportType)
' Get SELECT statment from corresponded text file
strSQL_location = strSQLLocation & "\" & strSQL & ".txt"
strSelect = ReadTXT_ReturnAllData(strSQL_location)
Call Snowflake_ReadDB_LoadExcel_3(strDB_User, strDB_Password, strSelect, cReportFileURL_SQL, strEnv) 
'Call DB_GetDataFromDatabase_LoadExcel(strDB_DataSource,strDB_User,strDB_Password,strSelect, cReportFileURL_SQL)


Case "RunReport_Grid"

Call WaitUntillPageFinishLoading_SmallIcon()
Call Wait_UntillDownloadLoaderDisappeared()
Call Wait_UntillDownloadLoaderDisappeared_Grid()

strReportData = GUIReport_VerifyReportIsEmpty_or_InError() ' Check if report is not empty

If strReportData = False Then ' Skip validation if report is empty

' Select dropdown Lists options
strTitle = "Selection #1"
Call ReadGrid_SelectDropdownList(strGrid_WebList_1, strTitle, 0)
strTitle = "Selection #2"
Call ReadGrid_SelectDropdownList(strGrid_WebList_2, strTitle, 1)
strTitle = "Selection #3"
Call ReadGrid_SelectDropdownList(strGrid_WebList_3, strTitle, 2)
strTitle = "Selection #4"
Call ReadGrid_SelectDropdownList(strGrid_WebList_4, strTitle, 3)
strTitle = "Selection #5"
Call ReadGrid_SelectDropdownList(strGrid_WebList_5, strTitle, 4)
strTitle = "Selection #6"
Call ReadGrid_SelectDropdownList(strGrid_WebList_6, strTitle, 5)
strTitle = "Selection #7"
Call ReadGrid_SelectDropdownList(strGrid_WebList_7, strTitle, 6)

' Validate column's names
Call ReadExcelFile_ReadGrid_ValidateColumns_2(strGrid_ColumnList)

' Create Excel report from Grid
Wait(1)
Call Wait_UntillDownloadLoaderDisappeared()
Call CaptureBitmap_Desktop (strBitMapLocation)
' Export excel report from grid
Call GUIReport_ExportGridReport_2()
Call MicroStarategy_ExportOptions_SelectExportButtonONLY()
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)

' Report location.
strReportName_Grid = cReports & "\" & strReportLink_Substring & "_Grid.xlsx"
cReportFileURL = ReportLocation( cReports, strReportLink_Substring)

Call ReadExcelFile_CopyFile(cReportFileURL, strReportName_Grid)
' Delete original report
Call ReadExcelFile_DeleteFile (cReportFileURL)
' Delete informational rows above the header row
Call ReadExcelFile_DeleteEmptyRowsAboveColumnsRow(strReportName_Grid, strCompare_ValidateColumnName, 1)

End If 

Case "Filter-Calculate-Compare"

' Apply filters to grid report.
If strReport_Name_1 <> "" Then ' Do calculation if GRID report is available
cReportFileURL_Grid = cReports & "\" &strReport_Name_1 & ".xlsx"
cReportFileURL_Grid_Filtered = cReports & "\" &strReport_Name_1 & strMS_Report_Suffix & ".xlsx"
'Call ReadExcelFile_FilterByColumnsValues(cReportFileURL_Grid, strR1_AutoFilter, cReportFileURL_Grid_Filtered)
'Call ReadExcelFile_ClearFilter(cReportFileURL_Grid)
Call ReadExcelFile_CopyFile(cReportFileURL_Grid, cReportFileURL_Grid_Filtered)
Call ReadExcelFile_InsertLastColumn(cReportFileURL_Grid_Filtered)
Call ReadExcelFile_RemoveRowsByFilterData(strR1_Filter1, strR1_Filter2, strR1_Filter3, strR1_Filter4, strR1_Filter5, strR1_Filter6, strR1_Filter7, cReportFileURL_Grid_Filtered)
 ' get original number of rows
iRows = ReadExcelFile_GetNumberOfRowsInExcel (cReportFileURL_Grid_Filtered, strWorkbookName)
If strR1_TotalNumberOfRows = "" Then
' Calculate totals for columns with numbers
Call ReadExcelFile_CalculateFilteredTotalByColumn_AppendResult(cReportFileURL_Grid_Filtered, strR1_ColumnsToTotalNumbers, strR1_FilterByColumn, strR1_FilterByValue, strWorkbookName, ",", iRows)
' Calculate average percentage
Call ReadExcelFile_CalculateFilteredAveragePercentByColumn_AppendResult(cReportFileURL_Grid_Filtered, strR1_ColumnsToAveragePercent, strR1_FilterByColumn, strR1_FilterByValue, strWorkbookName, ",", iRows)
' Calculate average numbers
Call ReadExcelFile_CalculateFilteredAverageNumbersByColumn_AppendResult(cReportFileURL_Grid_Filtered, strR1_ColumnsToAverageNumber, strR1_FilterByColumn, strR1_FilterByValue, strWorkbookName, ",", iRows)
' Calculate average numbers
Call ReadExcelFile_CalculateFilteredAverage_TIME_H_M_S_ByColumn_AppendResult(cReportFileURL_Grid_Filtered, strR1_ColumnsToTotalTime_HMS, strR1_FilterByColumn, strR1_FilterByValue, strWorkbookName, ",", iRows)
' Calculate total HH:MM:SS
Call ReadExcelFile_CalculateFilteredTotal_TIME_H_M_S_ByColumn_AppendResult(cReportFileURL_Grid_Filtered, strR1_ColumnsToTotalTime_HMS, strR1_FilterByColumn, strR1_FilterByValue, strWorkbookName, ",", iRows)
Else
' Calculate only number of rows
Call ReadExcelFile_CalculateFilteredNumberOfRows_AppendResult(cReportFileURL_Grid_Filtered, strR1_TotalNumberOfRows, strR1_FilterByColumn, strR1_FilterByValue, strWorkbookName, ",", iRows)
End If
End If

' Apply filters to SQL report
cReportFileURL_SQL = cReports & "\" &strReport_Name_2 & MS_Report_Suffix & ".xlsx"
cReportFileURL_SQL_Filtered = cReports & "\" &strReport_Name_2 & strMS_Report_Suffix & ".xlsx"
'Call ReadExcelFile_FilterByColumnsValues(cReportFileURL_SQL, strR2_AutoFilter, cReportFileURL_SQL_Filtered)
'Call ReadExcelFile_ClearFilter(cReportFileURL_SQL)
Call ReadExcelFile_CopyFile(cReportFileURL_SQL, cReportFileURL_SQL_Filtered)
Call ReadExcelFile_InsertLastColumn(cReportFileURL_SQL_Filtered)
Call ReadExcelFile_RemoveRowsByFilterData(strR2_Filter1, strR2_Filter2, strR2_Filter3, strR2_Filter4, strR2_Filter5, strR2_Filter6, strR2_Filter7, cReportFileURL_SQL_Filtered)
 ' get original number of rows
iRows = ReadExcelFile_GetNumberOfRowsInExcel (cReportFileURL_SQL_Filtered, strWorkbookName)
' Calculate totals for columns with numbers
If strR2_TotalNumberOfRows = "" Then
Call ReadExcelFile_CalculateFilteredTotalByColumn_AppendResult(cReportFileURL_SQL_Filtered, strR2_ColumnsToTotalNumbers, strR2_FilterByColumn, strR2_FilterByValue, strWorkbookName, ",", iRows)
' Calculate average percentage
Call ReadExcelFile_CalculateFilteredAveragePercentByColumn_AppendResult(cReportFileURL_SQL_Filtered, strR2_ColumnsToAveragePercent, strR2_FilterByColumn, strR2_FilterByValue, strWorkbookName, ",", iRows)
' Calculate average numbers
Call ReadExcelFile_CalculateFilteredAverageNumbersByColumn_AppendResult(cReportFileURL_SQL_Filtered, strR2_ColumnsToAverageNumber, strR2_FilterByColumn, strR2_FilterByValue, strWorkbookName, ",", iRows)
' Calculate average numbers
Call ReadExcelFile_CalculateFilteredAverage_TIME_H_M_S_ByColumn_AppendResult(cReportFileURL_SQL_Filtered, strR2_ColumnsToTotalTime_HMS, strR2_FilterByColumn, strR2_FilterByValue, strWorkbookName, ",", iRows)
' Calculate total HH:MM:SS
Call ReadExcelFile_CalculateFilteredTotal_TIME_H_M_S_ByColumn_AppendResult(cReportFileURL_SQL_Filtered, strR2_ColumnsToTotalTime_HMS, strR2_FilterByColumn, strR2_FilterByValue, strWorkbookName, ",", iRows)
Else
' Calculate only number of rows
Call ReadExcelFile_CalculateFilteredNumberOfRows_AppendResult(cReportFileURL_SQL_Filtered, strR2_TotalNumberOfRows, strR2_FilterByColumn, strR2_FilterByValue, strWorkbookName, ",", iRows)
End If


' Compare and validate cross reference columns
Call ReadExcelFile_CrossRefererenceReportsCompare_StandardReports_Full(cReportFileURL_Grid_Filtered, cReportFileURL_SQL_Filtered, strCrossreference_ColumnsCompare, strWorkbookName)

Case "Dossier"

'Call WaitUntillPageFinishLoading_SmallIcon()
'Call Wait_UntillDownloadLoaderDisappeared()
'Call Dossier_Wait_UntillDossietTitleAppeared()

' Export report
Call Dossier_ShowData_ExportToExcel(strR3_DossierReportTitle)
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)

' Report location.
strReportName_Dossier = cReports & "\" & strReportLink_Substring & "_Dossier.xlsx"
cReportFileURL = ReportLocation( cReports, strReportLink_Substring)

' copy file from download directory to report directory.
Call ReadExcelFile_CopyFile(cReportFileURL, strReportName_Dossier)
' Delete original report
Call ReadExcelFile_DeleteFile (cReportFileURL)
' Delete informational rows above the header row
Call ReadExcelFile_DeleteEmptyRowsAboveColumnsRow(strReportName_Dossier, strCompare_ValidateColumnName, 1)

' Apply filters to Dosier report
cReportFileURL_Dossier_Filtered = cReports & "\" &strReport_Name_3 & strMS_Report_Suffix & ".xlsx"
Call ReadExcelFile_CopyFile(strReportName_Dossier, cReportFileURL_Dossier_Filtered)
' Insert new column
Call ReadExcelFile_InsertLastColumn(cReportFileURL_Dossier_Filtered)
' Apply filter
Call ReadExcelFile_RemoveRowsByFilterData(strR3_Filter1, strR3_Filter2, strR3_Filter3, strR3_Filter4, strR3_Filter5, strR3_Filter6, strR3_Filter7, cReportFileURL_Dossier_Filtered)
 ' get original number of rows
iRows = ReadExcelFile_GetNumberOfRowsInExcel (cReportFileURL_Dossier_Filtered, strWorkbookName)

If strR3_TotalNumberOfRows = "" Then
' Calculate totals for columns with numbers
Call ReadExcelFile_CalculateFilteredTotalByColumn_AppendResult(cReportFileURL_Dossier_Filtered, strR3_ColumnsToTotalNumbers, strR3_FilterByColumn, strR3_FilterByValue, strWorkbookName, ",", iRows)
Else
' Calculate only number of rows
Call ReadExcelFile_CalculateFilteredNumberOfRows_AppendResult(cReportFileURL_Dossier_Filtered, strR3_TotalNumberOfRows, strR3_FilterByColumn, strR3_FilterByValue, strWorkbookName, ",", iRows)
End If












Case Else
Reporter.ReportEvent micFail, "Select Option", ("Incorrect report type: " & strReportType & " sent to scrit")

End Select

Next

Services.EndTransaction "MicroStrategy - Performance"



'cDataFileURL = strDataDriver_Location & "\" & strDataDriver_FileName & ".xls"
strTempFileURL = "C:\Temp\tempFile.xlsx"
strColName = "Data Driver"
iIndex = 2
strDataDriver_FileName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strColName = "Data Driver Location"
strDataDriver_Location = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strColName = "SQL Location"
strSQLLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strColName = "Test Name"
strTestName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Create folder (strTestName) under C:Maximus/Reports
cReports = "C:\Maximus\Reports" & "\" & strTestName
Call CreateFolderSingleIfNotExists(cReports)

Services.StartTransaction "MicroStrategy - Performance"

strOneDrivePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%") & "\OneDrive - Maximus, Inc"
cDataFileURL = strDataDriver_Location & "\" & strDataDriver_FileName & ".xls"

'cDataFileURL = "C:\UFT\Project\Contact Center\Data\CC_DataDriver_Ad Hoc - AgentEfficiency (1.0 AgentPerformavce VS 2.0 Agent Level).xls"


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
strCompare_ColumnsToTotal = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCompare_ColumnsToTotal, iIndex)
strCompare_ValidateColumnName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCompare_ValidateColumnName, iIndex)
strCompare_ValidateByColumnValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCompare_ValidateByColumnValue, iIndex)
strLookUp_FileName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLookUp_FileName, iIndex)
strLookUp_WorkbookName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLookUp_WorkbookName, iIndex)
strGrid_ColumnList = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_ColumnList, iIndex)
strGrid_Time_RowsExcludedFromRun = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_Time_RowsExcludedFromRun, iIndex)
strGrid_Persentage_RowsExcludedFromRun = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_Persentage_RowsExcludedFromRun, iIndex)
strGrid_WebList_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_1, iIndex)
strGrid_WebList_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_2, iIndex)
strGrid_WebList_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_3, iIndex)
strGrid_WebList_4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_4, iIndex)
strGrid_WebList_5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_5, iIndex)
strGrid_WebList_6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_6, iIndex)
strGrid_WebList_7 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_7, iIndex)


strBitMapLocation = OptionSelectionScreenshotLocation(cReports, strReportName, strReportType)
strURL =  GetEnvironmentURL (strEnv, cEnvPath_PROD_New, cEnvPath_PROD_Old, cEnvPath_UAT_1, cEnvPath_UAT_2)

If strReportType <> "Export_SQL" Then ' Skip UI if  Report generated from SQL

' Close all IE browsers
Call GEN_CloseAll_Browsers(strBrowser)

' Log into Micro Starategy
Call MicroStarategy_LogIn(strBrowser, strURL, strUser, strPass, strLoginAuthentication)

' Select folders
If strLink_1 <> "" Then
Call MicroStarategy_LoopThroughPage_SelectLink (strLink_1)
End If

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

' Select report
strReportType_Temp = strReportName
Call MicroStarategy_DirectAccess_SelectReportLink_3 (strReportLink, strReportType_Temp, strContainerType)


strError = TerminateScript (TestResultLocation)
If strError = true Then
Exit For	
End If

' Select options configuration
Select Case strSelectOption

   Case "Available-Selected"
' Validate option's values
strSearchIndex = 0 ' index for option's search box
strAddIndex = 0 ' index for option  objects
Call MicroStarategy_Available_Selected_VerifyOptionsList (strValidate_UI_AvailableSelected_Options_Included, stsValidate_UI_AvailableSelected_Options_Excluded, strSearchIndex)   

If strTypeValue_1 <> "Default"Then ' Do not select any options if Default value is passed.
' Select options
'Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_1, strAddIndex, strAddIndex) ' Choose options in loop
Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_1, strAddIndex)
End If

' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton ()
Wait(2)' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports) ' Download file
End  If

   Case "Save As"
' Download Report: Save As
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

   Case "Graphs"
' ???? Graphs
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button

   Case "SingleDropdown"
  ' Validate dropdown options
Call MicroStarategy_SingleDropdownSelection_VerifyDropdownList(strSingleDropdownList_IncludedValues, strSingleDropdownList_ExcludedValues)
' Select option 
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.
Call MicroStarategy_SingleDropdownSelection (strTypeValue_1)
End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
Call MicroStarategy_CalendarAndOtherSelections_TwoSingleEntries (strTypeValue_1, strIndex_D1, strIndex_D2, strIndexCal_1, strIndexCal_2) '- Calendar (two single date entries)
strSearchIndex = 2 ' index for option's search box
strAddIndex = 0 ' index for option  objects
' Select options
Call MicroStarategy_Available_Selected_SelectOptions (strTypeValue_2, strSearchIndex, strAddIndex) ' Choose options in loop
'Call MicroStarategy_Available_Selected_SelectOptions_2 (strTypeValue_2, strAddIndex)
End  If
' Save options screenshot
Call CaptureBitmap_Desktop (strBitMapLocation)
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Wait(1)
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Wait(1)
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
End  If

  Case Else
Reporter.ReportEvent micFail, "Select Option", ("Incorrect option type: " & strSelectOption & " sent to scrit")

End Select

End If ' Report generated from SQL


' ------------------------------------ Validate report data ---------------------------------------------------------------------

Select Case strReportType

Case "1.0 Agent Performance Ad-Hoc Template"

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
Call ReadExcelFile_ReadGrid_ValidateColumns(strGrid_ColumnList)

' Create Excel report from Grid
Wait(1)
Call Wait_UntillDownloadLoaderDisappeared()
Call CaptureBitmap_Desktop (strBitMapLocation)
' Export excel report from grid
Call GUIReport_ExportGridReport()
Call MicroStarategy_ExportOptions_SelectExportButtonONLY()
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
' Report location
cReportFileURL = ReportLocation( cReports, strReportLink_Substring)
Call ReadExcelFile_DeleteEmptyRowsAboveColumnsRow(cReportFileURL, strCompare_ValidateColumnName, 1)

End If 

Case "2.0 Agent Level Availability and Occupancy Summary Data"

Call WaitUntillPageFinishLoading_SmallIcon()
Call Wait_UntillDownloadLoaderDisappeared()
Call Wait_UntillDownloadLoaderDisappeared_Grid()

Call CaptureBitmap_Desktop (strBitMapLocation) ' GUI report screenshot

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
'Call ReadExcelFile_ReadGrid_ValidateColumns(strGrid_ColumnList)

' Grid calculations
Call Wait_UntillDownloadLoaderDisappeared()
Call ReadExcelFile_ReadGrid_Horizontal_sum_TIME_H_M_S_rows_ValidateTotal(strGrid_Time_RowsExcludedFromRun)
Call ReadExcelFile_ReadGrid_Horizontal_Average_Percentage_rows_ValidateTotal(strGrid_Persentage_RowsExcludedFromRun)


' Create Excel report from Grid
Wait(1)
Call Wait_UntillDownloadLoaderDisappeared()
Call CaptureBitmap_Desktop (strBitMapLocation)
' Export excel report from grid
Call GUIReport_ExportGridReport()
Call MicroStarategy_ExportOptions_SelectExportButtonONLY()
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)
cReportFileURL = ReportLocation( cReports, strReportLink_Substring)
Call ReadExcelFile_DeleteEmptyRowsAboveColumnsRow(cReportFileURL, strCompare_ValidateColumnName, 1)

End  If

Case Else
Reporter.ReportEvent micFail, "Select Option", ("Incorrect report type: " & strReportType & " sent to scrit")

End Select

Next

Services.EndTransaction "MicroStrategy - Performance"

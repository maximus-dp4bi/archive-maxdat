Services.StartTransaction "MicroStrategy - Performance"

' Clean up
Call KillAllChromeProcesses()
Call KillAllExcelProcesses()

'======================================== Run from GLOBAl data driver ==================================================

strTempFileURL = "C:\Temp\tempFile.xlsx" ' Copy of Global data driver with only one record.
iIndexTemp = 2
strColName = "Data Driver"
strDataDriver_FileName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndexTemp)
strColName = "Data Driver Location"
strDataDriver_Location = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndexTemp)
'strColName = "SQL Location"
'strSQLLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)

' Get last folder name which will be MAIN folder for ALL Reports
strColName = "Script Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndexTemp)
strColName = "Test Name"
strTestname = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndexTemp)
strBaseFolderName = ReadExcelFile_GetLastFolderName(strBasicLocation)
cReports = "C:\Maximus\Reports" & "\" & strBaseFolderName & "\" & strTestname
' Data Driver Path
strOneDrivePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%") & "\OneDrive - Maximus, Inc"
cDataFileURL = strDataDriver_Location & "\" & strDataDriver_FileName & ".xls"

' Exit script if Alert = FAILED
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndexTemp)
strFilePathINI = strBasicLocation & "\" & "Global_INI.ini"
strAlert = ReadIni( strFilePathINI, "Alert", "value" )
If strAlert = "FAILED" Then

' ============================Append record to ReportSummary.xlsx =========================================
' Get Summary Report location
iIndexTemp = 2
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndexTemp)
strFilePathINI = strBasicLocation & "\" & "Global_INI.ini" ' get Summary Report full path from INI file
strSummaryReportPath = ReadIni( strFilePathINI, "SummaryReportPath", "value" )

' Get data from data driver
strScriptName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, "Test Name", iIndexTemp)
strReport_1 = strGenesysReportName
strReport_2 = strReportName
strRunStartTime = now()
strRunStatus = "FAILED"
strNotes = "Please contact: " & strEmail_To & " for details"
Call ReadExcelFile_SummaryReport_AppendRow (strSummaryReportPath, strScriptName, strReport_1, strReport_2, strRunStartTime, strRunStatus, strNotes)

' Exit test
ExitTest	
End If

' ================================================================================================================================

' =========================================== Manual run. Uncoment if you want to ran individual script in debug mode ================

'strSQLLocation = "C:\Automation_Root\States\NC\Genesys\NCUI\SQL"
'cDataFileURL = "C:\Automation_Root\States\NC\Genesys\NCUI\Project\Data\DataDriver_AgentStatusQACheck_GenNCUIAgentStatusSummaryDailydataset.xls"
'strFolderName = ConvertDateToName
'strTestName = Environment("TestName")
'cReports = "C:\Maximus\Reports" & "\" & strTestName & "-" & strFolderName
'Call CreateFolderSingleIfNotExists(cReports) 


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
strBrowser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBrowser, iIndex)
strReportType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportType, iIndex)

' Close all browsers
Call GEN_CloseAll_Browsers(strBrowser)



' Select options configuration
Select Case strReportType

Case "Genesys"
   
strURL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cURL, iIndex)  
strUser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGen_User, iIndex)
strPass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGen_Pass, iIndex)
strMainOption = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGen_MainOption, iIndex)
strGen_SecondOption = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGen_SecondOption, iIndex)
strGen_Tab = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGen_Tab, iIndex)
strGen_SavedView = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGen_SavedView, iIndex)

' Log in
Call Genesys_LogIn (strBrowser, strURL, strUser, strPass)
' Select Collaboration link
Call Genesys_SelectCollaborateLink()
' Select option
Call Genesys_Select_Performance_Option(strMainOption, strGen_SecondOption)
' Select Tab
Call Genesys_Select_Tab (strGen_SecondOption, strGen_Tab)
' Select Saved Views icon
Call Genesys_Select_SaveViewsIcon(strGen_SecondOption)
' Select View
Call Genesys_SelectView(strGen_SecondOption, strGen_SavedView)
' Select Export icon
Call Genesys_Select_ExportIcon (strGen_SecondOption)
' Update report name and then update Data Driver with Genesys report name.
strColumnIndex = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cGen_ReportName, 1)
strRowIndex = iIndex
strGenesysReportName = Genesys_UpdateReportName (strGen_SecondOption, cDataFileURL, strRowIndex, strColumnIndex)
' Click on Export button
Call Genesys_Select_ExportButton (strGen_SecondOption)
' Select Inbox icon
Call SelectInboxIcon()
' Download report
strReportName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGen_ReportName, iIndex)
Call Genesys_DownloadReport(strReportName)
' Copy report from download folder into report folder
Call CopyFile_FromDownloads_ToLocalFolder_GENESYS (strReportName, cReports)


Case "RunReport_Grid"

strUser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_User, iIndex)
strPass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_Pass, iIndex) 
strEnv = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEnvironment, iIndex)
strURL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cURL, iIndex)
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
strGrid_WebList_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_1, iIndex)
strGrid_WebList_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_2, iIndex)
strGrid_WebList_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_3, iIndex)
strGrid_WebList_4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_4, iIndex)
strGrid_WebList_5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_5, iIndex)
strGrid_WebList_6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_6, iIndex)
strGrid_WebList_7 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_7, iIndex)
strCompare_ValidateColumnName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCompare_ValidateColumnName, iIndex)


' Log into Micro Starategy
Call MicroStarategy_LogIn(strBrowser, strURL, strUser, strPass, strLoginAuthentication)

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

' Select report (Export option)
If strReportLink <> "" Then
strReportType_Temp = strReportType
Call MicroStarategy_DirectAccess_SelectReportLink_4 (strReportLink, strReportType_Temp, strContainerType)
End If


' Select options configuration
Select Case strSelectOption

   Case "Available-Selected"
' Validate option's values
strSearchIndex = 0 ' index for option's search box
strAddIndex = 0 ' index for option  objects
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
' Call GUIReport_WaitUntill_HomeReport_icon_Appeared()
Call GUIReport_WaitUntill_HomeReport_SaveIcon_Appeared()
Call Wait_UntillDownloadLoaderDisappeared_Grid()
'Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
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
If strTypeValue_1 <> "Default" Then ' Do not select any options if Default value is passed.
strIndex_D1 = 0
strIndex_D2 = 2
strIndexCal_1 = 0
strIndexCal_2 = 1
Call MicroStarategy_CalendarAndOtherSelections_TwoSingleEntries (strTypeValue_1, strIndex_D1, strIndex_D2, strIndexCal_1, strIndexCal_2) '- Calendar (two single date entries)
strSearchIndex = 4 ' index for option's search box
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

'===========================================
' Submit report

Call WaitUntillPageFinishLoading_SmallIcon()
Call Wait_UntillDownloadLoaderDisappeared()
Call Wait_UntillDownloadLoaderDisappeared_Grid()

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

' Create Excel report from Grid
Wait(1)
Call Wait_UntillDownloadLoaderDisappeared()
Call CaptureBitmap_Desktop (strBitMapLocation)
' Export excel report from grid
Call GUIReport_ExportGridReport_2()
Call MicroStarategy_ExportOptions_SelectExportButtonONLY()
Wait(10)
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)

' Report location.
strReportName_Grid = cReports & "\" & strReportName & "_Grid.xlsx"
cReportFileURL = ReportLocation( cReports, strReportName)

Call ReadExcelFile_CopyFile(cReportFileURL, strReportName_Grid)
' Delete original report
Call ReadExcelFile_DeleteFile (cReportFileURL)
' Delete informational rows above the header row
Call ReadExcelFile_DeleteEmptyRowsAboveColumnsRow(strReportName_Grid, strCompare_ValidateColumnName, 1)


Case "Filter-Calculate-Compare"

strR1_Col1_Filter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Col1_Filter, iIndex)
strR1_Col1_Filter_Value = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Col1_Filter_Value, iIndex)
strR1_Col2_Filter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Col2_Filter, iIndex)
strR1_Col2_Filter_Value = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Col2_Filter_Value, iIndex)
strR1_ColumnsToSum_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToSum_1, iIndex)
strR1_ColumnsToSum_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToSum_2, iIndex)
strR1_ColumnsToSum_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_ColumnsToSum_3, iIndex)

strR2_Col1_Filter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col1_Filter, iIndex)
strR2_Col1_Filter_Value = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col1_Filter_Value, iIndex)
strR2_Col2_Filter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col2_Filter, iIndex)
strR2_Col2_Filter_Value = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col2_Filter_Value, iIndex)
strR2_ColumnsToSum_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToSum_1, iIndex)
strR2_ColumnsToSum_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToSum_2, iIndex)
strR2_ColumnsToSum_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_ColumnsToSum_3, iIndex)

strEmail_To = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_To, iIndex)
strEmail_CC = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_CC, iIndex)
strEmail_Subject = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_Subject, iIndex)
strEmail_Body = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_Body, iIndex)


'============= Genesys
' Update Data Driver with Genasys report name
strColumnIndex = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cReport_Name_1, 1)
strReportUpdatedName_Genesys = ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, strColumnIndex, strGenesysReportName)
' Get number of rows from Genesys report
strReportPath_Genesys = cReports & "\" & strGenesysReportName & ".xlsx"
' Calculate total number of rows by specified column and append totals
strNumberOfRows_Genesys = ReadExcelFile_CalculateNumberOfRowsByColumn_AppendResult(strReportPath_Genesys, strR1_FilterByColumn)

'================== Grid =====================
' Update Data Driver with Grid report name
strColumnIndex = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cReport_Name_2, 1)
strGridReport = strReportName & "_Grid"
strGridReport_FullPath = cReports & "\" & strGridReport & ".xlsx"
Call ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, strColumnIndex, strGridReport)

' Delete Genesys CSV file.
strReportPath_Genesys_CSV = cReports & "\" & strGenesysReportName & ".csv"
Call ReadExcelFile_DeleteFile (strReportPath_Genesys_CSV)

'=============== Update genysys driver with agent name ========================
' Find first agent which contains any value in Genesys report and upload this value into Data Driver
strAgentName = ReadExcelFile_GetFirstNoneBlankValue(strReportPath_Genesys, strR1_Col1_Filter, strR1_ColumnsToSum_1)

' Update Data Draver with agent name (genesys section)
strColumnIndex_Gen = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cR1_Col1_Filter_Value, 1)
Call ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, strColumnIndex_Gen, strAgentName)

' Update Data Draver with agent name (grid section)
strColumnIndex_Gen = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cR2_Col1_Filter_Value, 1)
Call ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, strColumnIndex_Gen, strAgentName)

' Get new (updated) Agent names
strR1_Col1_Filter_Value = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_Col1_Filter_Value, iIndex)
strR2_Col1_Filter_Value = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col1_Filter_Value, iIndex)

' ====================== Compare ==========================
' Compare genesys total number of rows with Grid total value for specified date
strResult = ReadExcelFile_CrossRef_AgentStatusQACheck_GenNCUIAgentStatusSummaryDailydataset(strReportPath_Genesys, strGridReport_FullPath, strR1_Col1_Filter, strR1_Col1_Filter_Value, strR1_Col2_Filter, strR1_Col2_Filter_Value, strR1_ColumnsToSum_1, strR1_ColumnsToSum_2, strR1_ColumnsToSum_3, strR2_Col1_Filter, strR2_Col1_Filter_Value, strR2_Col2_Filter, strR2_Col2_Filter_Value, strR2_ColumnsToSum_1, strR2_ColumnsToSum_2, strR2_ColumnsToSum_3)
strValidate = InStr(strResult, "FAILED")
If strValidate <> 0  Then
strPassed_Failed = "FAILED"	
Else
strPassed_Failed = "PASSED"
End If

'============== Run from GLOBAl data driver. Please comment it out if you would like to run script individually in debug mode ===========
' ============================Append record to ReportSummary.xlsx =========================================
' Get Summary Report location
iIndexTemp = 2
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndexTemp)
strFilePathINI = strBasicLocation & "\" & "Global_INI.ini"
strSummaryReportPath = ReadIni( strFilePathINI, "SummaryReportPath", "value" )

' Get data from data driver
strScriptName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, "Test Name", iIndexTemp)
strReport_1 = strGenesysReportName
strReport_2 = strReportName
strRunStartTime = now()
strRunStatus = strPassed_Failed
strNotes = "Please contact: " & strEmail_To & " for details"
Call ReadExcelFile_SummaryReport_AppendRow (strSummaryReportPath, strScriptName, strReport_1, strReport_2, strRunStartTime, strRunStatus, strNotes)

  Case Else
Reporter.ReportEvent micFail, "Select Option", ("Incorrect option type: " & strSelectOption & " sent to scrit")

End Select


Next

' ========================== Send email =================================================
strEmail_Subject = strEmail_Subject & " " & strGenesysReportName & " and " & strGridReport & " comparison: " & strPassed_Failed
strAttach_1 = strReportPath_Genesys
strAttach_2 = strGridReport_FullPath
'strAttach_1 = ""
'strAttach_2 = ""
strEmail_Body = strResult & "   " & strEmail_Body
Call SendEmailFromOutlook(strEmail_To, strEmail_CC, strEmail_Subject, strEmail_Body, strAttach_1, strAttach_2, strAttach_3)

Services.EndTransaction "MicroStrategy - Performance"

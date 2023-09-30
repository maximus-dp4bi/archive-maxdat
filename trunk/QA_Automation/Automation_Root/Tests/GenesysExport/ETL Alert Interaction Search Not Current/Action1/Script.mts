
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


' ================================================================================================================================

' =========================================== Manual run. Uncoment if you want to ran individual script in debug mode ================

'strSQLLocation = "C:\Automation_Root\States\NC\Genesys\NCUI\SQL"
'cDataFileURL = "C:\Automation_Root\States\NC\Genesys\NCUI\Project\Data\DataDriver_ETL Alert Interaction Search Not Current.xls"
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

Case "Export"

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
Call MicroStarategy_DirectAccess_SelectReportLink_Export (strReportLink, strReportType_Temp, strContainerType)
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
Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button
If strReportType = "Export" Then
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports) ' Download file
End  If

   Case "Save As"
' Download Report: Save As
'Call MicroStarategy_ExportOptions_SelectExportButton () ' Select Export button

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

' Export excel report
Call MicroStarategy_ExportOptions_SelectExportButtonONLY()
Call CopyFile_FromDownloads_ToLocalFolder (strReportLink_Substring, cReports)

' Report location.
strReportName_Export = cReports & "\" & strReportName & "_Export.xlsx"
cReportFileURL = ReportLocation( cReports, strReportName)

Call ReadExcelFile_CopyFile(cReportFileURL, strReportName_Export)
' Delete original report
Call ReadExcelFile_DeleteFile (cReportFileURL)
' Delete informational rows above the header row
Call ReadExcelFile_DeleteEmptyRowsAboveColumnsRow(strReportName_Export, strCompare_ValidateColumnName, 1)


Case "Filter-Calculate-Compare"

strR1_FilterByColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_FilterByColumn, iIndex)
strR2_Col1_Filter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col1_Filter, iIndex)
strR2_Col2_Filter = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col2_Filter, iIndex)
strR2_Col2_Filter_Value = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_Col2_Filter_Value, iIndex)
strR2_TargetColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_TargetColumn, iIndex)

strEmail_To = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_To, iIndex)
strEmail_CC = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_CC, iIndex)
strEmail_Subject = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_Subject, iIndex)
strEmail_Body = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_Body, iIndex)

'================== Grid =====================
' Update Data Driver with Grid report name
strColumnIndex = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cReport_Name_2, 1)
strExportReport = strReportName & "_Export"
strExportReport_FullPath = cReports & "\" & strExportReport & ".xlsx"
Call ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, strColumnIndex, strExportReport)

' ====================== Compare ==========================
' Compare values in two columns
strResult =  ReadExcelFile_CompareTwoColumns(strExportReport_FullPath, strR2_Col1_Filter, strR2_Col2_Filter)
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
strReport_1 = " "
strReport_2 = strReportName
strRunStartTime = now()
strRunStatus = strPassed_Failed
strNotes = "Please contact: " & strEmail_To & " for details"
Call ReadExcelFile_SummaryReport_AppendRow (strSummaryReportPath, strScriptName, strReport_1, strReport_2, strRunStartTime, strRunStatus, strNotes)

' Update Alert section of INI file with report status. If this report FAILED, do not run other reports
Call WriteINI (strFilePathINI, "Alert", "value", strPassed_Failed) ' Update INI file with Summary Report file full path

Case Else
Reporter.ReportEvent micFail, "Select Option", ("Incorrect option type: " & strSelectOption & " sent to scrit")

End Select


Next

'========================= Send Email ================================================

' Send email 
strEmail_Subject = "ETL Alert Interaction Search Not Current validation is: " & strPassed_Failed
strAttach_1 = ""
strAttach_2 = strGridReport_FullPath
'strAttach_2 = ""
'strAttach_3 = ""
strEmail_Body = strResult
Call SendEmailFromOutlook(strEmail_To, strEmail_CC, strEmail_Subject, strEmail_Body, strAttach_1, strAttach_2, strAttach_3)

Services.EndTransaction "MicroStrategy - Performance"

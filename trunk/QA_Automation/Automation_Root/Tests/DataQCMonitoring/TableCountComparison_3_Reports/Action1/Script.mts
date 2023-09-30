
'strScriptLocation = "C:\Automation_Root\Tests\DataQCMonitoring"
'strBaseFolderName = ReadExcelFile_GetLastFolderName(strScriptLocation)

Services.StartTransaction "MicroStrategy - Performance"

' Clean up
Call KillAllChromeProcesses()
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
' Data Driver Path
strOneDrivePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%") & "\OneDrive - Maximus, Inc"
cDataFileURL = strDataDriver_Location & "\" & strDataDriver_FileName & ".xls"

' Exit script if Alert = FAILED
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strFilePathINI = strBasicLocation & "\" & "Global_INI.ini"
strAlert = ReadIni( strFilePathINI, "Alert", "value" )
If strAlert = "FAILED" Then
ExitTest	
End If

' ================================================================================================================================

' =========================================== Manual run. Uncoment if you want to ran individual script in debug mode ================
'strSQLLocation = "C:\Automation_Root\States\NJ\DataQCMonitoring\NJSBE\SQL"
'strFilePathINI = "C:\Automation_Root\States\NJ\DataQCMonitoring\NJSBE\Global_INI.ini"
'cDataFileURL = "C:\Automation_Root\States\NJ\DataQCMonitoring\NJSBE\Project\Data\DataDriver_TableCountComparison.xls"
'strTestName = Environment("TestName")
'cReports = "C:\Maximus\Reports" & "\" & strTestName
'
'' Rename Folder if exists
'Call ReadExcelFile_RenameFolder(cReports)
'' Create new folder
'Call CreateFolderSingleIfNotExists(cReports) 
'========================================================================================================================================


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

Case "RunReport_Grid"

strUser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_User, iIndex)
strPass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_Pass, iIndex) 
strEnv = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEnvironment, iIndex)
strURL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cURL, iIndex)
strLoginAuthentication = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLoginAuthentication, iIndex)
strTime_Substract_From_Current = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTime_Substract_From_Current, iIndex)
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
'Reporter.ReportEvent micFail, "Select Option", ("Incorrect option type: " & strSelectOption & " sent to scrit")

End Select

'===========================================
' Submit report

Call WaitUntillPageFinishLoading_SmallIcon()
Call Wait_UntillDownloadLoaderDisappeared()
Call Wait_UntillDownloadLoaderDisappeared_Grid()

' ============================== Report # 1 =======================================================
If iIndex = 2 Then
strTime_Current = TableCountCpmparison_GetCurrentTimeStamp()

' Get first report time stamp
If strTime_Substract_From_Current = 0 Then
strReport_1_timestamp =  strTime_Current	
Else
strReport_1_timestamp = DateAdd("h",strTime_Substract_From_Current, strTime_Current)
End If
 
' Write to ini
Call WriteINI (strFilePathINI, "Report_1_Time", "value", strReport_1_timestamp)

' Constract report suffix
strReport_1_Suffix = replace(strReport_1_timestamp, "/", ".")
strReport_1_Suffix = replace(strReport_1_Suffix, ":", "")

' Constract Report Name
strReportNm = strReportName & "_" & strReport_1_Suffix

' Write report path to ini
CurrentPath = cReports & "\" & strReportName & "_" & strReport_1_Suffix
Call WriteINI (strFilePathINI, "Report_1_Location", "value", CurrentPath)

' Select grid options
strReport_1_timestamp = Replace(strReport_1_timestamp, "#", "")
' Select dropdown Lists options
strTitle = "Selection #1"
Call ReadGrid_SelectDropdownList(strReport_1_timestamp, strTitle, 0)
strTitle = "Selection #2"
Call ReadGrid_SelectDropdownList(strGrid_WebList_2, strTitle, 1)

End If

' ============================== Report # 2 =======================================================

If iIndex = 3 Then
strTime_Current = TableCountCpmparison_GetCurrentTimeStamp()

' Get first report time stamp
If strTime_Substract_From_Current = 0 Then
strReport_2_timestamp =  strTime_Current	
Else
strReport_2_timestamp = DateAdd("h",strTime_Substract_From_Current, strTime_Current)
End If
 
' Write to ini
Call WriteINI (strFilePathINI, "Report_2_Time", "value", strReport_2_timestamp)

' Constract report suffix
strReport_2_Suffix = replace(strReport_2_timestamp, "/", ".")
strReport_2_Suffix = replace(strReport_2_Suffix, ":", "")

' Constract Report Name
strReportNm = strReportName & "_" & strReport_2_Suffix

' Write report path to ini
CurrentPath = cReports & "\" & strReportName & "_" & strReport_2_Suffix
Call WriteINI (strFilePathINI, "Report_2_Location", "value", CurrentPath)

' Select grid options
strReport_2_timestamp = Replace(strReport_2_timestamp, "#", "")
' Select dropdown Lists options
strTitle = "Selection #1"
Call ReadGrid_SelectDropdownList(strReport_2_timestamp, strTitle, 0)
strTitle = "Selection #2"
Call ReadGrid_SelectDropdownList(strGrid_WebList_2, strTitle, 1)

End If

' ============================== Report # 3 =======================================================

If iIndex = 4 Then
strTime_Current = TableCountCpmparison_GetCurrentTimeStamp()

' Get first report time stamp
If strTime_Substract_From_Current = 0 Then
strReport_3_timestamp =  strTime_Current	
Else
strReport_3_timestamp = DateAdd("h",strTime_Substract_From_Current, strTime_Current)
End If
 
' Write to ini
Call WriteINI (strFilePathINI, "Report_3_Time", "value", strReport_3_timestamp)

' Constract report suffix
strReport_3_Suffix = replace(strReport_3_timestamp, "/", ".")
strReport_3_Suffix = replace(strReport_3_Suffix, ":", "")

' Constract Report Name
strReportNm = strReportName & "_" & strReport_3_Suffix

' Write report path to ini
CurrentPath = cReports & "\" & strReportName & "_" & strReport_3_Suffix
Call WriteINI (strFilePathINI, "Report_3_Location", "value", CurrentPath)

' Select grid options
strReport_3_timestamp = Replace(strReport_3_timestamp, "#", "")
' Select dropdown Lists options
strTitle = "Selection #1"
Call ReadGrid_SelectDropdownList(strReport_3_timestamp, strTitle, 0)
strTitle = "Selection #2"
Call ReadGrid_SelectDropdownList(strGrid_WebList_3, strTitle, 1)

End If


' Create Excel report from Grid
Wait(1)
Call Wait_UntillDownloadLoaderDisappeared()
' Export excel report from grid
Call GUIReport_ExportGridReport_2()
Call MicroStarategy_ExportOptions_SelectExportButtonONLY()
'Call CopyFile_FromDownloads_ToLocalFolder (strReportLink, cReports)
Call CopyFile_FromDownloads_ToLocalFolder (strReportName, cReports)

' Report location.
If iIndex = 2 Then
' Full path of new file
strReportSuffix = ReadIni(strFilePathINI, "Report_1_Location", "value" )
strReportFullPath = strReportSuffix  & ".xlsx"
' Full path of downloaded file
cReportFileURL = cReports & "\" & strReportName & ".xlsx"
Call ReadExcelFile_CopyFile(cReportFileURL, strReportFullPath)
End If

' Report location.
If iIndex = 3 Then
' Full path of new file
strReportSuffix = ReadIni( strFilePathINI, "Report_2_Location", "value" )
strReportFullPath = strReportSuffix  & ".xlsx"
' Full path of downloaded file
cReportFileURL = cReports & "\" & strReportName & ".xlsx"
Call ReadExcelFile_CopyFile(cReportFileURL, strReportFullPath)
End If

' Report location.
If iIndex = 4 Then
' Full path of new file
strReportSuffix = ReadIni( strFilePathINI, "Report_3_Location", "value" )
strReportFullPath = strReportSuffix  & ".xlsx"
' Full path of downloaded file
cReportFileURL = cReports & "\" & strReportName & ".xlsx"
Call ReadExcelFile_CopyFile(cReportFileURL, strReportFullPath)
End If


' Delete original report
Call ReadExcelFile_DeleteFile (cReportFileURL)
' Delete informational rows above the header row
Call ReadExcelFile_DeleteEmptyRowsAboveColumnsRow(strReportFullPath, strCompare_ValidateColumnName, 1)

Case "Filter-Calculate-Compare"

strR1_FilterByColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_FilterByColumn, iIndex)
strR1_FilterByValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR1_FilterByValue, iIndex)
strR2_FilterByColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_FilterByColumn, iIndex)
strR2_FilterByValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR2_FilterByValue, iIndex)
strR3_FilterByColumn = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_FilterByColumn, iIndex)
strR3_FilterByValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cR3_FilterByValue, iIndex)


strEmail_To = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_To, iIndex)
strEmail_CC = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_CC, iIndex)
strEmail_Subject = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_Subject, iIndex)
strEmail_Body = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEmail_Body, iIndex)

' Get files path
' Full path of file 1
strFile_1_Path = ReadIni(strFilePathINI, "Report_1_Location", "value")
strFile_1_Path = strFile_1_Path & ".xlsx"
' Full path of file 2
strFile_2_Path = ReadIni(strFilePathINI, "Report_2_Location", "value")
strFile_2_Path = strFile_2_Path & ".xlsx"

' Full path of file 3
strFile_3_Path = ReadIni(strFilePathINI, "Report_3_Location", "value")
strFile_3_Path = strFile_3_Path & ".xlsx"

' Compare files
strResult =  ReadExcelFile_CrossRef_DataQCMonitoring(strFile_1_Path, strFile_2_Path, strFile_3_Path, strR1_FilterByColumn, strR1_FilterByValue, strR2_FilterByColumn, strR2_FilterByValue, strR3_FilterByColumn, strR3_FilterByValue)
If strResult = false  Then
strPassed_Failed = "FAILED"	
Else
strPassed_Failed = "PASSED"
End If

' Write STATUS to ini
Call WriteINI (strFilePathINI, "Status", "value", strPassed_Failed)

' ============================Append record to ReportSummary.xlsx =========================================
' Get Summary Report location
iIndex = 2
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strFilePathINI = strBasicLocation & "\" & "Global_INI.ini" ' get Summary Report full path from INI file
strSummaryReportPath = ReadIni( strFilePathINI, "SummaryReportPath", "value" )

' Get data from data driver
strScriptName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, "Test Name", iIndex)
strReport_1 = strGenesysReportName
strReport_2 = strReportName
strRunStartTime = now()
strRunStatus = strPassed_Failed
strNotes = "Please contact: " & strEmail_To & " for details"
Call ReadExcelFile_SummaryReport_AppendRow (strSummaryReportPath, strScriptName, strReport_1, strReport_2, strRunStartTime, strRunStatus, strNotes)

' ========================== Send email =================================================
strEmail_Subject = strEmail_Subject & " " & strFile_2_Path & " and " & strFile_2_Path & " comparison: " & strPassed_Failed
strAttach_1 = strFile_1_Path
strAttach_2 = strFile_2_Path
strAttach_3 = strFile_3_Path
strEmail_Body = strResult & "   " & strEmail_Body
Call SendEmailFromOutlook(strEmail_To, strEmail_CC, strEmail_Subject, strEmail_Body, strAttach_1, strAttach_2, strAttach_3)


  Case Else
Reporter.ReportEvent micFail, "Select Option", ("Incorrect option type: " & strSelectOption & " sent to scrit")

End Select


Next



Services.EndTransaction "MicroStrategy - Performance"


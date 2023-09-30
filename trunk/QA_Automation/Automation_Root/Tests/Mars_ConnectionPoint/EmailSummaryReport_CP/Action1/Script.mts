﻿
' Clean up
Call KillAllChromeProcesses()
Call KillAllExcelProcesses()

' ========================== This script used only during scheduled unattended run ======================================

' Get temp data driver location
strTempFileURL = "C:\Temp\tempFile.xlsx"
iIndex = 2
' Get Basic location
strColName = "Basic Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Get ini file name
strColName = "Data Driver"
strIniFileName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Construct ini file path
strFilePathINI = strBasicLocation & "\" & strIniFileName
' Get Report Summary file path
strSummaryReportPath = ReadIni( strFilePathINI, "SummaryReportPath", "value")


MsgBox "Wait to broadcast email"

' Email subject
strSubject = ReadExcelFile_CalculatePassedFailedRecords(strSummaryReportPath, "Run Status")
strEmail_Subject = "Data QC Monitoring Summary Report.  " & strSubject
' Attachment
strAttach_1 = strSummaryReportPath
strAttach_2 = ""
strAttach_3 = ""
' Email info
strColName = "Email To"
strEmailTo = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Email CC
strColName = "Email CC"
strEmailCC = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Email Body
strEmailBody = "Please contact:  " & "leonidklebanov@maximus.com" &  " for more details"

' Submit email to automation developer
Call SendEmailFromOutlook(strEmailTo, strEmailCC, strEmail_Subject, strEmailBody, strAttach_1, strAttach_2, strAttach_3)




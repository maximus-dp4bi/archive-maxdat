
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
' Get Current Report file path
strCurrentReportPath = ReadIni( strFilePathINI, "Report_1_Location", "value")
strCurrentReportPath = strCurrentReportPath & ".xlsx"


'MsgBox "Wait to broadcast email"

' Email subject
'strSubject = ReadExcelFile_CalculatePassedFailedRecords(strCurrentReportPath, "Run Status")
strEmail_Subject = "Pleas find Data QC Monitoring Report results attached.  " 
' Attachment
strAttach_1 = strCurrentReportPath
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




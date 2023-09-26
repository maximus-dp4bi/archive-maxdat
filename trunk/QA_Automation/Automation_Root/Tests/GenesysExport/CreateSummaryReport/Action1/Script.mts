
'============== Run from GLOBAl data driver. Please comment it out if you would like to run script individually in debug mode ===========
' Clean up
Call KillAllChromeProcesses()
Call KillAllExcelProcesses()

strTempFileURL = "C:\Temp\tempFile.xlsx"
iIndex = 2
strColName = "Basic Location"
strDataDriver_Location = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex) ' Get basic location path
strPathIni = strDataDriver_Location & "\" & "Global_INI.ini" ' Construct INI file location

' Get last folder name which will be MAIN folder for ALL Reports
strColName = "Script Location"
strBasicLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
strBaseFolderName = ReadExcelFile_GetLastFolderName(strBasicLocation)
cReports = "C:\Maximus\Reports" & "\" & strBaseFolderName

' Rename previous Main folder to add folder's creation date
Call ReadExcelFile_RenameFolder(cReports)
Call CreateFolderSingleIfNotExists(cReports)
' Create Summary Report file
strDate = ConvertDate_from_MMslashDDslashYYYY_to_YYYYdashMMdashDD(now)
strExcelPath = cReports & "\" & "SummaryReport_" & strDate & ".xlsx"
Call ReadExcelFile_CreateStatusSummaryReport(strExcelPath) ' Create Summary Report file (populate header)
Call WriteINI (strPathIni, "SummaryReportPath", "value", strExcelPath) ' Update INI file with Summary Report file full path

Reporter.ReportEvent micWarning, "Create Summary Report", ("Report: " & strExcelPath & " created successfully")		

' Email subject : Script is started
strEmail_Subject = "Genesys NC UI QA Automation Check started."
' Attachment
strAttach_1 = ""
strAttach_2 = ""
strAttach_3 = ""
' Email info
strColName = "Email To"
strEmailTo = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Email CC
strColName = "Email CC"
strEmailCC = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strTempFileURL, strColName, iIndex)
' Email Body
strEmailBody = "FYI"

' Submit email to automation developer
Call SendEmailFromOutlook(strEmailTo, strEmailCC, strEmail_Subject, strEmailBody, strAttach_1, strAttach_2, strAttach_3)










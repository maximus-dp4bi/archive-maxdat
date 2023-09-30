
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

Call ReadExcelFile_RenameFolder(cReports)
Call CreateFolderSingleIfNotExists(cReports)
' Create Summary Report folder
strDate = ConvertDate_from_MMslashDDslashYYYY_to_YYYYdashMMdashDD(now)
strExcelPath = cReports & "\" & "SummaryReport_" & strDate & ".xlsx"
Call ReadExcelFile_CreateStatusSummaryReport(strExcelPath) ' Create Summary Report folder (populate header)
Call WriteINI (strPathIni, "SummaryReportPath", "value", strExcelPath) ' Update INI file with Summary Report file full path

Reporter.ReportEvent micWarning, "Create Summary Report", ("Report: " & strExcelPath & " created successfully")	










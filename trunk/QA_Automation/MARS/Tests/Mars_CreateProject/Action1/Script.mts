
cDataFileURL = "C:\UFT\MARS\Project\Data\Mars.xls"
Call KillAllExcelProcesses()


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
strEnvironment = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEnvironment, iIndex)
strMars_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMars_User, iIndex)
strMars_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMars_Pass, iIndex)
strDB_SF_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_User, iIndex)
strDB_SF_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_Pass, iIndex)

Call Crear_Cach_2(strBrowser, cYouTube)
Call GEN_CloseAll_Browsers(strBrowser)
'Call OpenChrome_ClearCach_CloseChrome(strBrowser, cMarsLogInURL)
Systemutil.Run  "chrome.exe", " -incognito " & cMarsLogInURL
Call GEN_CloseAll_Browsers(strBrowser)

Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)



Wait(1)


 @@ hightlight id_;_462416_;_script infofile_;_ZIP::ssf4.xml_;_
 @@ hightlight id_;_65894_;_script infofile_;_ZIP::ssf5.xml_;_
 @@ hightlight id_;_593256_;_script infofile_;_ZIP::ssf7.xml_;_
 @@ hightlight id_;_65894_;_script infofile_;_ZIP::ssf1.xml_;_





Next

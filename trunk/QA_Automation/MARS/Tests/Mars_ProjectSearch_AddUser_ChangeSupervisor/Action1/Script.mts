
Browser("Tenant Manager").Page("Tenant Manager").WebButton("Open").Click
setting.webpackage("ReplayType") = 2
wait(1)
Browser("Tenant Manager").Page("Tenant Manager").WebList("User Name").FireEvent "onmouseover"
wait(1)
Browser("Tenant Manager").Page("Tenant Manager").WebList("User Name").FireEvent "onfocus"
Wait(1)
Browser("Tenant Manager").Page("Tenant Manager").WebList("User Name").FireEvent "ondblclick"
setting.webpackage("ReplayType") = 1
'
 @@ script infofile_;_ZIP::ssf69.xml_;_
 @@ script infofile_;_ZIP::ssf65.xml_;_

 
'






cDataFileURL = "C:\UFT\MARS\Project\Data\Mars_ProjectSearch_AddUser_ChangeSupervisor.xls"
Call KillAllExcelProcesses()

' Generate Unique number
strUniqueNumber_Create = GenerateUniqueNumber()



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
strDB_SF_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_User, iIndex)
strMars_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMars_Pass, iIndex)
strDB_SF_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_Pass, iIndex)
strCP_BaseProject = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseProject, iIndex)
strCP_ProjectSearch_Agency = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ProjectSearch_Agency, iIndex)
strCP_ProjectSearc_State = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ProjectSearc_State, iIndex)
strCP_ProjectSearc_Program = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ProjectSearc_Program, iIndex)
strScenario_Type = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cScenario_Type, iIndex)
strTeam_Name = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_Name, iIndex)
strUser_Name = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_Name, iIndex)






Select Case strScenario_Type

Case "UserAdd"
strEvent = "UserAdd"
'============

Call GEN_CloseAll_Browsers(strBrowser)
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)

' Serch for Project Name
Call Mars_ProjectSearch(strCP_BaseProject, strCP_ProjectSearc_State, strCP_ProjectSearc_Program, strCP_ProjectSearch_Agency)
Wait(1)
' Select Team
Call Mars_Team_Select(strTeam_Name)

Call Mars_AddUser_To_Team(strUser_Name)

Case Else

'None

End  Select

Wait(1)
Next
Wait(1)

























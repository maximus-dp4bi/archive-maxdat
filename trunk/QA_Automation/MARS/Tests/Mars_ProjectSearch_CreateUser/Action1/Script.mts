

cDataFileURL = "C:\UFT\MARS\Project\Data\Mars_ProjectSearch_CreateUser.xls"
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


strUser_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_FN, iIndex)
strUser_MN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_MN, iIndex)
strUser_LN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_LN, iIndex)
strUser_Email = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_Email, iIndex)
strUser_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_StartDate, iIndex)
strUser_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_StartDate_Expected, iIndex)
strUser_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_EndDate, iIndex)
strUser_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_EndDate_Expected, iIndex)
strUser_AccountType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AccountType, iIndex)
strUser_AccountAuthor = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AccountAuthor, iIndex)
strUser_AuthorizationDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AuthorizationDate, iIndex)
strUser_PHI_Permission = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PHI_Permission, iIndex)
strUser_PII_Permission = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PII_Permission, iIndex)
strUser_OverrideAuth = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_OverrideAuth, iIndex)
strUser_Role = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_Role, iIndex)
strUser_RoleDesc = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleDesc, iIndex)
strUser_RoleStartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleStartDate, iIndex)
strUser_RoleStartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleStartDate_Expected, iIndex)
strUser_RoleEndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleEndDate, iIndex)
strUser_RoleEndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleEndDate_Expected, iIndex)





Select Case strScenario_Type

Case "UserCreate"
strEvent = "UserCreate"
'============

Call GEN_CloseAll_Browsers(strBrowser)
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)

' Serch for Project Name
Call Mars_ProjectSearch(strCP_BaseProject, strCP_ProjectSearc_State, strCP_ProjectSearc_Program, strCP_ProjectSearch_Agency)
Wait(1)

' Create user
Call Mars_CreateUser(strCP_BaseProject, strUser_FN, strUser_MN, strUser_LN, strUser_Email, strUser_StartDate, strUser_EndDate, strUser_AccountType, strUser_AccountAuthor, strUser_AuthorizationDate, strUser_PHI_Permission, strUser_PII_Permission, strUser_OverrideAuth, strUser_Role, strUser_RoleDesc, strUser_RoleStartDate, strUser_RoleEndDate)

End  Select

Next

























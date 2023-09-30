

cDataFileURL = "C:\UFT\MARS\Project\Data\Mars.xls"
Call KillAllExcelProcesses()

' Generate Unique number
strUniqueNumber_Create = GenerateUniqueNumber()
strUniqueNumber_Update = GenerateUniqueNumber()
strUniqueNumberBU_Create = GenerateUniqueNumber()
strUniqueNumberBU_Update = GenerateUniqueNumber()
strUniqueNumberRole_Create = GenerateUniqueNumber()

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
strCP_State = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_State, iIndex)
strCP_BaseProgramName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseProgramName, iIndex)
strCP_BaseContactID = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseContactID, iIndex)
strCP_BaseAgencyName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseAgencyName, iIndex)
strCP_ContractStartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ContractStartDate, iIndex)
strCP_ContractStartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ContractStartDate_Expected, iIndex)
strCP_ContractEndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ContractEndDate, iIndex)
strCP_ContractEndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ContractEndDate_Expected, iIndex)
strCP_GoLiveDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_GoLiveDate, iIndex)
strCP_ProvStatus = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_ProvStatus, iIndex)
strCP_TimeZone = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_TimeZone, iIndex)
strCP_TimeZone_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_TimeZone_Expected, iIndex)
strCP_TenantManager_ProjectFile_JSON = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_TenantManager_ProjectFile_JSON, iIndex)
strScenario_Type = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cScenario_Type, iIndex)

strBU_BusinessUnitName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_BusinessUnitName, iIndex)
strBU_Description = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_Description, iIndex)
strBU_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_StartDate, iIndex)
strBU_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_StartDate_Expected, iIndex)
strBU_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_EndDate, iIndex)
strBU_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_EndDate_Expected, iIndex)

strRole_Name = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_Name, iIndex)
strRole_Description = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_Description, iIndex)
strRole_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_StartDate, iIndex)
strRole_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_StartDate_Expected, iIndex)
strRole_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_EndDate, iIndex)
strRole_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_EndDate_Expected, iIndex)

Select Case strScenario_Type

Case "ProjectCreate"
strEvent = "ProjectCreate"
'============

Call GEN_CloseAll_Browsers(strBrowser)
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)

strCP_ProjectName = strCP_BaseProject & strUniqueNumber_Create
Call Mars_CreateProject(strCP_ProjectName, strCP_State, strCP_BaseProgramName, strCP_BaseContactID, strCP_BaseAgencyName, strCP_ContractStartDate, strCP_ContractEndDate, strCP_GoLiveDate, strCP_ProvStatus, strCP_TimeZone, strUniqueNumber_Create)

Wait(1)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project'and DATA:action = 'Create' and DATA:dataObject:projectName = " & "'" & strCP_ProjectName & "'" & ";" '& ""
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 
wait(2)
' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"

' contractStartDate"
XMLTag = "contractStartDate"
strExpectedValue = strCP_ContractStartDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' contractEndDate"
XMLTag = "contractEndDate"
strExpectedValue = strCP_ContractEndDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' stateAgencyName"
XMLTag = "stateAgencyName"
strExpectedValue = strCP_BaseAgencyName & strUniqueNumber_Create
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' goLiveDate
XMLTag = "goLiveDate"
strExpectedValue = ConvertDate_from_MMslashDDslashYYYY_to_YYYYdashMMdashDD(strCP_GoLiveDate)
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)	

' programName
XMLTag = "programName"
strExpectedValue = strCP_BaseProgramName & strUniqueNumber_Create
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' Created By
strExpectedValue = Get_CreatedByID()
XMLTag = "createdBy"
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


' provisioningStatus
strExpectedValue = strCP_ProvStatus
XMLTag = "provisioningStatus"
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' ProjectID
'Get it from UI
strProjectID_ProvisioningStatus = Get_ProjectID_ProvisioningStatus()
XMLTag = "projectId"
strValue = XML_GetValue_byTag_NoValidation(XMLFileName, XMLTag)
' Compare value from XML with value on screen
Call Validate_InString(strProjectID_ProvisioningStatus, strValue, XMLTag)

' timeZone
XMLTag = "timeZone"
strExpectedValue = strCP_TimeZone_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' state
XMLTag = "state"
strExpectedValue = strCP_State
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "ProjectUpdate"
'============
strCP_ProjectName = strCP_BaseProject & strUniqueNumber_Create
strEvent = "ProjectUpdate"
strUpdated = Mars_UpdateProject(strCP_ProjectName, strCP_State, strCP_BaseProgramName, strCP_BaseContactID, strCP_BaseAgencyName, strCP_ContractStartDate, strCP_ContractEndDate, strCP_GoLiveDate, strCP_ProvStatus, strCP_TimeZone, strUniqueNumber_Update)

Wait(1)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project'and DATA:action = 'Update' and DATA:dataObject:projectName = " & "'" & strCP_ProjectName & "'" & ";" '& ""
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"

' contractStartDate"
XMLTag = "contractStartDate"
strExpectedValue = strCP_ContractStartDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' contractEndDate"
XMLTag = "contractEndDate"
strExpectedValue = strCP_ContractEndDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' stateAgencyName"
XMLTag = "stateAgencyName"
strExpectedValue = strCP_BaseAgencyName & strUniqueNumber_Update
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' goLiveDate
XMLTag = "goLiveDate"
strExpectedValue = ConvertDate_from_MMslashDDslashYYYY_to_YYYYdashMMdashDD(strCP_GoLiveDate)
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' programName
XMLTag = "programName"
strExpectedValue = strCP_BaseProgramName & strUniqueNumber_Update
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' Created By
strExpectedValue = Get_CreatedByID()
XMLTag = "createdBy"
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


' provisioningStatus
strExpectedValue = strCP_ProvStatus
XMLTag = "provisioningStatus"
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

'' ProjectID
''Get it from UI
'strProjectID_ProvisioningStatus = Get_ProjectID_ProvisioningStatus()
'XMLTag = "projectId"
'strValue = XML_GetValue_byTag_NoValidation(XMLFileName, XMLTag)
'' Compare value from XML with value on screen
'Call Validate_InString(strProjectID_ProvisioningStatus, strValue, XMLTag)

' timeZone
XMLTag = "timeZone"
strExpectedValue = strCP_TimeZone_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' state
XMLTag = "state"
strExpectedValue = strCP_State
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "BU_Create"
strEvent = "BU_Create"
'===============
strCP_ProjectName = strCP_BaseProject & strUniqueNumber_Create
strBU_BusinessUnitName = strBU_BusinessUnitName & strUniqueNumberBU_Create
strBU_StartDate = ConvertTodaysDate_To_MMslashDDslashYYYY() ' convert today's date to mm/dd/yyyy with leading zeros
'str_EndDate = DateAdd("m",2,strBU_StartDate) ' add two month to today's date
'strBU_EndDate = ConvertDate_To_MMslashDDslashYYYY(strBU_EndDate) ' add leading zeros
strBU_Description = strBU_Description & strUniqueNumberBU_Create
Call Mars_BusinessUnit_Create(strBU_BusinessUnitName, strBU_StartDate, strBU_EndDate, strBU_Description)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Business Unit'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:businessUnitName = " & "'" & strBU_BusinessUnitName & "'" & ";" '& ""
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)

' contractStartDate"
XMLTag = "businessUnitName"
strExpectedValue = strBU_BusinessUnitName
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' description"
XMLTag = "description"
strExpectedValue = strBU_Description
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


' effectiveEndDate"
XMLTag = "effectiveEndDate"
strExpectedValue = strBU_EndDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "BU_Update"
strEvent = "BU_Update"
'===============
strCP_ProjectName = strCP_BaseProject & strUniqueNumber_Create
strBU_BusinessUnitName = strBU_BusinessUnitName & strUniqueNumberBU_Create
strBU_Description = strBU_Description & strUniqueNumberBU_Update
Call Mars_BusinessUnit_Update(strBU_BusinessUnitName, strBU_EndDate, strBU_Description)

' Read DB and create JSON file

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Business Unit'and DATA:action = 'Update' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:businessUnitName = " & "'" & strBU_BusinessUnitName & "'" & ";" 
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 
Wait(1)

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)


' contractStartDate"
XMLTag = "businessUnitName"
strExpectedValue = strBU_BusinessUnitName
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' description"
XMLTag = "description"
strExpectedValue = strBU_Description
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' effectiveEndDate"
XMLTag = "effectiveEndDate"
strExpectedValue = strBU_EndDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "Role_Create"
strEvent = "Role_Create"
'===============
strCP_ProjectName = strCP_BaseProject & strUniqueNumber_Create
strRole_Name = strRole_Name & strUniqueNumberRole_Create
strRole_Description = strRole_Description & strUniqueNumberRole_Create
Call Mars_Role_Create(strRole_Name, strRole_StartDate, strRole_EndDate, strRole_Description)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project Role'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:roleName = " & "'" & strRole_Name & "'" & ";"
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)

' contractStartDate"
XMLTag = "roleName"
strExpectedValue = strRole_Name
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' description"
XMLTag = "roleDesc"
strExpectedValue = strRole_Description
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "startDate"
strExpectedValue = strRole_StartDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "endDate"
strExpectedValue = strRole_EndDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)










Case Else

'None

End  Select

Wait(1)
Next
Wait(1)

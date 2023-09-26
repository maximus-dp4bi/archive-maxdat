
'cReports = "C:\Maximus\Reports" & "\" & "Mars_ConnectionPoint"
'strFilePathINI = "C:\Automation_Root\States\NJ\Mars_ConnectionPoint\NJSBE\Global_INI.ini"
'
'' Delete all JSON files
'Call ReadExcelFile_DeleteAllFilesUnderFolder_SpecificExtention(cReports, "json")
'' Rename XMLs files with event's name
'Call WriteINI (strFilePathINI, "CONTACT_RECORD_UPDATE_EVENT", "count", "0")
'Call ReadExcelFile_RenameXMLFilesInLoop_WithEventsName(cReports, strFilePathINI)


''
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


'sn = 5.385105E+7
'dSciNotn = CDbl(sn)
'd = Round(sn, 8)

'cDataFileURL = "C:\Automation_Root\States\CA\Mars_ConnectionPoint\Project\Data\Mars_AllEvents_CP.xls"
'Call KillAllExcelProcesses()

' Generate Unique number

iRowValues = ReadExcelFile_LoadStringWithRowsContainsYesValue(cDataFileURL) ' Get list of reports marked as "Y".

ArrayOfValues = Split(iRowValues, ",")

For i = 0 To UBound(ArrayOfValues)

' Performance verification: Start

 iIndex = ArrayOfValues(i)
 
 ' Clear dowload folder.
 Call KillAllExcelProcesses()
 Call ClearCurrentDownloadFolder()
 
 ' Get current date time and convert it to special date
strCurrentDateTime = now()
strConvertedDateTime = Convert_CurrentDateTime_To_SpecialDateTime_AddHours(strCurrentDateTime, 5)
 
' Get variables from external Data file
strBrowser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBrowser, iIndex)
strEnvironment = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEnvironment, iIndex)
strMars_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMars_User, iIndex)
strDB_SF_User = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_User, iIndex)
strMars_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMars_Pass, iIndex)
strDB_SF_Pass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cDB_SF_Pass, iIndex)
strCP_BaseProject = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_BaseProject, iIndex)
strCP_TenantManager_ProjectFile_JSON = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCP_TenantManager_ProjectFile_JSON, iIndex)
strScenario_Type = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cScenario_Type, iIndex)

Select Case strScenario_Type

Case "ProjectCreate"
strEvent = "ProjectCreate"
'============
strUniqueNumber_Create = GenerateUniqueNumber()
strCons_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_FN, iIndex)
strCons_MN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_MN, iIndex)
strCons_LN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_LN, iIndex)
strCons_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_FN, iIndex)
strCont_ContactReason = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_ContactReason, iIndex)
strCont_ContactAction = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_ContactAction, iIndex)
strCont_Comment1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Comment1, iIndex)
strCont_Comment2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Comment2, iIndex)
strCont_Type = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Type, iIndex)
strCont_Queue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Queue, iIndex)
strCont_Channel = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Channel, iIndex)
strCont_ChannelValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_ChannelValue, iIndex)
strCont_Program = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Programm, iIndex)
strCont_Disposition = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Disposition, iIndex)



' Close all browsers
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Connection Point
Call Mars_LogIn_CP(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass, strCP_BaseProject)
Wait(1)

' Select Initiate Contact button
Call MarsCP_InitiateContact_Button()
' Make Add Consumer button appeared
'Call MarsCP_AddConsumerButton_MakeItAppeared()
' Select Add Consumer button
'Call MarsCP_AddConsumerButton_Select()

' Create random alphabetic string
strRandomString = GenerateRandomString("12")
strRandomString = RemoveNumbersFromString(strRandomString)

' Search for Consumer
strConsumerFound =  MarsCP_SearchForConsumer(strCons_FN, strCons_LN)
' Open CONSUMER AUTHENTICATION
' Select Consumer
Call MarsCP_ConsumerAuthentication_ExpandAndSelectConsumer()
' Fill up reasons
Call MarsCP_Reasons(strCont_ContactReason, strCont_ContactAction, strCont_Comment1, strCont_Comment2)
' Fill up Contact Details
Call MarsCP_ContactDetails(strCont_Type, strCont_Queue, strCont_Channel, strCont_ChannelValue, strCont_Program)
' End Contact
Call MarsCP_EndContact()
' Wrap-Up and Close
Call MarsCP_WrapUp_AndClose(strCont_Disposition)



' Read DB and create JSON files for all previously generated events
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where (DATA:dataObject:createdBy = '480' or DATA:dataObject:externalLinkPayload:createdBy = '480')  and DATA:eventCreatedOn >=  '2020-11-12T14:57:00.000000+00:00' order by DATA:eventCreatedOn;"
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where (DATA:dataObject:createdBy = '480' or DATA:dataObject:externalLinkPayload:createdBy = '480')  and DATA:eventCreatedOn >=  " & "'" & strConvertedDateTime & "'" & " order by DATA:eventCreatedOn;"
'strUser = "SVC_UFT_DEV_USER"
'strPassword = "^N4]8TmUnL?%7e}]"
'strListOfActions = "CONTACT_RECORD_SAVE_EVENT,CONTACT_RECORD_REASON_SAVE_EVENT,CONSUMER_AUTHENTICATION_SAVE_EVENT,CONTACT_RECORD_UPDATE_EVENT,LINK_EVENT_CASE_CONTACT_RECORD,LINK_EVENT_CONTACT_RECORD_CASE,LINK_EVENT_CONTACT_RECORD_CONSUMER,LINK_EVENT_CONSUMER_CONTACT_RECORD"
strFileBaseName = "CP"
' Read DB and create JSON file
Call Wait_SQLToStart()
Call Snowflake_ReadDB_CP_2(cReports, strFileBaseName, strDB_SF_User, strDB_SF_Pass, SQLquery)
Wait(1)

' Convert JSONs to XMLs
'strJsonFolderName = "Desktop;This PC;OSDisk (C:);Maximus;Reports;CP_Test"
strJsonFolderName = "Desktop;This PC;OSDisk (C:);Maximus;Reports;" & strBaseFolderName
Call Convert_JSON_to_XML_All(strJsonFolderName, cReports)

' Delete all JSON files
Call ReadExcelFile_DeleteAllFilesUnderFolder_SpecificExtention(cReports, "json")
'======================= Delete CP_8 file (TEMP solution) ===============================================
strFile_8_Path = cReports &"\"& "CP_8.xml"
Call ReadExcelFile_DeleteFile(strFile_8_Path)
'==========================================================================================================

' Rename XMLs files with event's name
Call WriteINI (strFilePathINI, "CONTACT_RECORD_UPDATE_EVENT", "count", "0")
Call ReadExcelFile_RenameXMLFilesInLoop_WithEventsName(cReports, strFilePathINI)







' Create unique project ID
strCP_ProjectName = strCP_BaseProject & strUniqueNumber_Create
' Update INI file with unique Project ID
Call INI_WriteValue (cIniPath, "PROJECT", "ID", strCP_ProjectName)

Call Mars_CreateProject(strCP_ProjectName, strCP_State, strCP_BaseProgramName, strCP_BaseContactID, strCP_BaseAgencyName, strCP_ContractStartDate, strCP_ContractEndDate, strCP_GoLiveDate, strCP_ProvStatus, strCP_TimeZone, strUniqueNumber_Create)

Wait(1)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project'and DATA:action = 'Create' and DATA:dataObject:projectName = " & "'" & strCP_ProjectName & "'" & ";"
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
strEvent = "ProjectUpdate"
'============
strUniqueNumber_Update = GenerateUniqueNumber()
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

' Convert Start Date
strCP_ContractStartDate = ConvertDate_ToShortDate_MMDDYYYY(strCP_ContractStartDate)
' Calculate and convert End Date
strCP_ContractEndDate = Date_AddNumberOfMonth(strCP_ContractStartDate, strCP_ContractEndDate)
' Convert strUser_AuthorizationDate
strCP_GoLiveDate = Date_AddNumberOfMonth(strCP_ContractStartDate, strCP_GoLiveDate)
' Agency Name
strCP_BaseAgencyName_Update = strCP_BaseAgencyName & strUniqueNumber_Update
' Program Name
strCP_BaseProgramName_Update = strCP_BaseProgramName & strUniqueNumber_Update

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

strEvent = "ProjectUpdate"
strUpdated = Mars_UpdateProject(strCP_ProjectName, strCP_State, strCP_BaseProgramName_Update, strCP_BaseContactID, strCP_BaseAgencyName_Update, strCP_ContractStartDate, strCP_ContractEndDate, strCP_GoLiveDate, strCP_ProvStatus, strCP_TimeZone, strUniqueNumber_Update)

Wait(1)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project'and DATA:action = 'Update' and DATA:dataObject:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:programName = " & "'" & strCP_BaseProgramName_Update& "'" & ";"
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
strExpectedValue = strCP_BaseAgencyName_Update
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' goLiveDate
XMLTag = "goLiveDate"
strExpectedValue = strCP_GoLiveDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' programName
XMLTag = "programName"
strExpectedValue = strCP_BaseProgramName_Update
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

Case "ProjectContactDetail_Create"
strEvent = "ProjectContactDetail_Create"
'===============

strProjectContact_Role1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cProjectContact_Role1, iIndex)
strProjectContact_Role2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cProjectContact_Role2, iIndex)
strProjectContact_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cProjectContact_FN, iIndex)
strProjectContact_MN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cProjectContact_MN, iIndex)
strProjectContact_LN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cProjectContact_LN, iIndex)
strProjectContact_Phone = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cProjectContact_Phone, iIndex)
strProjectContact_Email = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cProjectContact_Email, iIndex)

Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
' Get BU ID
strBU_BusinessUnitName = INI_GetValue (cIniPath, "BU", "NAME")
' Get Team Name
strTeam_Name = INI_GetValue (cIniPath, "TeamName", "NAME")
' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

' Create Approval Account
'=========================
' Create random alphabetic string
strRandomString = GenerateRandomString("12")
strRandomString = RemoveNumbersFromString(strRandomString)
' Create First, Last name and email
strProjectContact_FN1 = strProjectContact_FN & strRandomString
strProjectContact_LN1 = strProjectContact_LN & strRandomString
strProjectContact_Email1 = strRandomString & "@" & strProjectContact_Email

' Select Project's role
Call Mars_ProjectContactDetail_Add(strProjectContact_Role1, strProjectContact_FN1, strProjectContact_MN, strProjectContact_LN1, strProjectContact_Phone, strProjectContact_Email1)
Wait(1)

' Update INI file with unique Account Approver First Name
Call INI_WriteValue (cIniPath, "AccountApproverFN", "NAME", strProjectContact_FN1)

' Create Manager Account
'=========================
' Create random alphabetic string
strRandomString = GenerateRandomString("12")
strRandomString = RemoveNumbersFromString(strRandomString)
' Create First, Last name and email
strProjectContact_FN2 = strProjectContact_FN & strRandomString
strProjectContact_LN2 = strProjectContact_LN & strRandomString
strProjectContact_Email2 = strRandomString & "@" & strProjectContact_Email

' Select Project's role
Call Mars_ProjectContactDetail_Add(strProjectContact_Role2, strProjectContact_FN2, strProjectContact_MN, strProjectContact_LN2, strProjectContact_Phone, strProjectContact_Email2)
Wait(1)

' Update INI file with unique Account Approver First Name
Call INI_WriteValue (cIniPath, "AccountManagerFN", "NAME", strProjectContact_FN2)


Case "BU_Create"
strEvent = "BU_Create"
'===============
strUniqueNumberBU_Create = GenerateUniqueNumber()
strBU_BusinessUnitName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_BusinessUnitName, iIndex)
strBU_Description = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_Description, iIndex)
strBU_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_StartDate, iIndex)
strBU_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_StartDate_Expected, iIndex)
strBU_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_EndDate, iIndex)
strBU_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_EndDate_Expected, iIndex)

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

' Convert Start Date
strBU_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strBU_StartDate)
' Calculate and convert End Date
strBU_EndDate = Date_AddNumberOfMonth(strBU_StartDate, strBU_EndDate)
strBU_BusinessUnitName = strBU_BusinessUnitName & strUniqueNumberBU_Create
strBU_Description = strBU_Description & strUniqueNumberBU_Create
Call Mars_BusinessUnit_Create(strBU_BusinessUnitName, strBU_StartDate, strBU_EndDate, strBU_Description)

' Update INI file with unique BU name
Call INI_WriteValue (cIniPath, "BU", "NAME", strBU_BusinessUnitName)

' Read DB and create JSON file
Call Wait_SQLToStart()
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Business Unit'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:businessUnitName = " & "'" & strBU_BusinessUnitName & "'" & ";"
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Business Unit'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:businessUnitName = " & "'" & strBU_BusinessUnitName & "'" & " and DATA:dataObject:description = " & "'" & strBU_Description & "'" & ";"
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

' effectiveStartDate"
XMLTag = "effectiveStartDate"
strExpectedValue = strBU_StartDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


' effectiveEndDate"
XMLTag = "effectiveEndDate"
strExpectedValue = strBU_EndDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "BU_Update"
strEvent = "BU_Update"
'===============
strUniqueNumberBU_Update = GenerateUniqueNumber()
strBU_BusinessUnitName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_BusinessUnitName, iIndex)
strBU_Description = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_Description, iIndex)
strBU_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_StartDate, iIndex)
strBU_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_StartDate_Expected, iIndex)
strBU_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_EndDate, iIndex)
strBU_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_EndDate_Expected, iIndex)

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
strBU_BusinessUnitName = INI_GetValue (cIniPath, "BU", "NAME")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

' Convert Start Date
strBU_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strBU_StartDate)
' Calculate and convert End Date
strBU_EndDate = Date_AddNumberOfMonth(strBU_StartDate, strBU_EndDate)
strBU_Description = strBU_Description & strUniqueNumberBU_Update
Call Mars_BusinessUnit_Update(strBU_BusinessUnitName, strBU_EndDate, strBU_Description)

' Read DB and create JSON file

' Read DB and create JSON file
Call Wait_SQLToStart()
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Business Unit'and DATA:action = 'Update' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:businessUnitName = " & "'" & strBU_BusinessUnitName & "'" & ";" 
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Business Unit'and DATA:action = 'Update' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:businessUnitName = " & "'" & strBU_BusinessUnitName & "'" & " and DATA:dataObject:description = " & "'" & strBU_Description & "'" & ";"
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
strExpectedValue = strBU_EndDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "Role_Create"
strEvent = "Role_Create"
'===============
strUniqueNumberRole_Create = GenerateUniqueNumber()
strRole_Name = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_Name, iIndex)
strRole_Description = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_Description, iIndex)
strRole_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_StartDate, iIndex)
strRole_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_StartDate_Expected, iIndex)
strRole_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_EndDate, iIndex)
strRole_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_EndDate_Expected, iIndex)

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
Wait(1)

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

' Convert Start Date
strRole_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strRole_StartDate)
' Calculate and convert End Date
strRole_EndDate = Date_AddNumberOfMonth(strRole_StartDate, strRole_EndDate)
strRole_Name = strRole_Name & strUniqueNumberRole_Create
strRole_Description = strRole_Description & strUniqueNumberRole_Create
Call Mars_Role_Create(strRole_Name, strRole_StartDate, strRole_EndDate, strRole_Description)

' Update INI file with unique Role name
Call INI_WriteValue (cIniPath, "RoleName", "NAME", strRole_Name)

' Read DB and create JSON file
Call Wait_SQLToStart()
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project Role'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:roleName = " & "'" & strRole_Name & "'" & ";"
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project Role'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:roleName = " & "'" & strRole_Name & "'" & " and DATA:dataObject:roleDesc = " & "'" & strRole_Description & "'" & ";"
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
wait(1)

Case "Role_Update"
strEvent = "Role_Update"
'===============
strUniqueNumberRole_Update = GenerateUniqueNumber()
strRole_Name = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_Name, iIndex)
strRole_Description = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_Description, iIndex)
strRole_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_StartDate, iIndex)
strRole_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_StartDate_Expected, iIndex)
strRole_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_EndDate, iIndex)
strRole_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cRole_EndDate_Expected, iIndex)

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
' Get project ID
strRole_Name = INI_GetValue (cIniPath, "RoleName", "NAME")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

' Convert Start Date
strRole_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strRole_StartDate)
' Calculate and convert End Date
strRole_EndDate = Date_AddNumberOfMonth(strRole_StartDate, strRole_EndDate)
strRole_Description = strRole_Description & strUniqueNumberRole_Update
Call Mars_Role_Update(strRole_Name, strRole_StartDate, strRole_EndDate, strRole_Description)

' Read DB and create JSON file
Call Wait_SQLToStart()
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project Role'and DATA:action = 'Update' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:roleName = " & "'" & strRole_Name & "'" & ";"
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project Role'and DATA:action = 'Update' and DATA:projectName = " & "'" & strCP_ProjectName & "'" & " and DATA:dataObject:roleName = " & "'" & strRole_Name & "'" & " and DATA:dataObject:roleDesc = " & "'" & strRole_Description & "'" & ";"
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)

' Role name
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


Case "Team_Create"
strEvent = "Team_Create"
'===============
strUniqueNumberTeam_Create = GenerateUniqueNumber()
strTeam_Name = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_Name, iIndex)
strTeam_Desc = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_Desc, iIndex)
strTeam_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_StartDate, iIndex)
strTeam_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_StartDate_Expected, iIndex)
strTeam_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_EndDate, iIndex)
strTeam_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_EndDate_Expected, iIndex)
strBU_BusinessUnitName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBU_BusinessUnitName, iIndex)

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
' Get project ID
strBU_BusinessUnitName = INI_GetValue (cIniPath, "BU", "NAME")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

' Convert Start Date
strTeam_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strTeam_StartDate)
' Calculate and convert End Date
strTeam_EndDate = Date_AddNumberOfMonth(strTeam_StartDate, strTeam_EndDate)
strTeam_Name = strTeam_Name & strUniqueNumberTeam_Create
strTeam_Desc = strTeam_Desc & strUniqueNumberTeam_Create
Call Mars_Team_Create(strTeam_Name, strBU_BusinessUnitName, strTeam_StartDate, strTeam_EndDate, strTeam_Desc)

' Update INI file with unique Role name
Call INI_WriteValue (cIniPath, "TeamName", "NAME", strTeam_Name)

' Read DB and create JSON file
Call Wait_SQLToStart()
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Team'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" &" ;"
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Team'and DATA:action = 'Create' and DATA:projectName = " & "'" & strCP_ProjectName & "'" &" and DATA:dataObject:teamName = " & "'" & strTeam_Name & "'" & ";"
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)

' Team Name"
XMLTag = "teamName"
strExpectedValue = strTeam_Name
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' description"
XMLTag = "description"
strExpectedValue = strTeam_Desc
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "effectiveStartDate"
strExpectedValue = strTeam_StartDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "effectiveEndDate"
strExpectedValue = strTeam_EndDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "Team_Update"
strEvent = "Team_Update"
'===============
strUniqueNumberTeam_Update = GenerateUniqueNumber()
strTeam_Name = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_Name, iIndex)
strTeam_Desc = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_Desc, iIndex)
strTeam_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_StartDate, iIndex)
strTeam_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_StartDate_Expected, iIndex)
strTeam_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_EndDate, iIndex)
strTeam_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTeam_EndDate_Expected, iIndex)

Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)
' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
' Get BU ID
strBU_BusinessUnitName = INI_GetValue (cIniPath, "BU", "NAME")
' Get Team Name
strTeam_Name_Old = INI_GetValue (cIniPath, "TeamName", "NAME")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

' Convert Start Date
strTeam_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strTeam_StartDate)
' Calculate and convert End Date
strTeam_EndDate = Date_AddNumberOfMonth(strTeam_StartDate, strTeam_EndDate)
strTeam_Name_New= strTeam_Name & strUniqueNumberTeam_Update
strTeam_Desc = strTeam_Desc & strUniqueNumberTeam_Update
Call Mars_Team_Update(strTeam_Name_Old, strTeam_Name_New, strBU_BusinessUnitName, strTeam_StartDate, strTeam_EndDate, strTeam_Desc)


' Update INI file with unique Role name
Call INI_WriteValue (cIniPath, "TeamName", "NAME", strTeam_Name_New)

' Read DB and create JSON file
Call Wait_SQLToStart()
'SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Team'and DATA:action = 'Update' and DATA:projectName = " & "'" & strCP_ProjectName & "'" &" ; "
SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Team'and DATA:action = 'Update' and DATA:projectName = " & "'" & strCP_ProjectName & "'" &" and DATA:dataObject:teamName = " & "'" & strTeam_Name_New & "'" & ";"
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)

' Team Name"
XMLTag = "teamName"
strExpectedValue = strTeam_Name
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' description"
XMLTag = "description"
strExpectedValue = strTeam_Desc
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "effectiveStartDate"
strExpectedValue = strTeam_StartDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "effectiveEndDate"
strExpectedValue = strTeam_EndDate_Expected
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)


Case "User_Create"
strEvent = "User_Create"
'===============
strUniqueNumberUser_Create = GenerateUniqueNumber()
strUser_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_FN, iIndex)
strUser_MN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_MN, iIndex)
strUser_LN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_LN, iIndex)
strUser_Email = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_Email, iIndex)
strUser_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_StartDate, iIndex)
strUser_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_StartDate_Expected, iIndex)
strUser_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_EndDate, iIndex)
strUser_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_EndDate_Expected, iIndex)
strUser_AccountType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AccountType, iIndex)
strUser_AuthorizationDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AuthorizationDate, iIndex)
strUser_AuthorizationDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AuthorizationDate_Expected, iIndex)
strUser_PHI_Switch = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PHI_Switch, iIndex)
strUser_PII_Switch = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PII_Switch, iIndex)
strUser_PHI_Permission = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PHI_Permission, iIndex)
strUser_PII_Permission = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PII_Permission, iIndex)
strUser_OverrideAuth = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_OverrideAuth, iIndex)
strcUser_OverrideAuth_Switch = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_OverrideAuth_Switch, iIndex)
strUser_RoleStartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleStartDate, iIndex)
strUser_RoleStartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleStartDate_Expected, iIndex)
strUser_RoleEndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleEndDate, iIndex)
strUser_RoleEndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleEndDate_Expected, iIndex)

strRandomString = GenerateRandomString("12")
strRandomString = RemoveNumbersFromString(strRandomString)
strUser_FN1 = strUser_FN & strRandomString
strUser_LN1 = strUser_LN & strRandomString
strUser_Email1 = strRandomString & "@" & strUser_Email

' Convert Start Date
strUser_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strUser_StartDate)
' Calculate and convert End Date
strUser_EndDate = Date_AddNumberOfMonth(strUser_StartDate, strUser_EndDate)
' Convert strUser_AuthorizationDate
strUser_AuthorizationDate = ConvertDate_ToShortDate_MMDDYYYY(strUser_AuthorizationDate)
' Convert User Role Start Date
strUser_RoleStartDate = ConvertDate_ToShortDate_MMDDYYYY(strUser_RoleStartDate)
' Calculate and convert User Role End Date
strUser_RoleEndDate = Date_AddNumberOfMonth(strUser_RoleStartDate, strUser_RoleEndDate)

' Update INI file with unique Role name
Call INI_WriteValue (cIniPath, "User_Name", "NAME", strUser_FN1)

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)

' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
' Gt User Author First Name
strUser_AccountAuthor = INI_GetValue (cIniPath, "AccountApproverFN", "NAME")
' Gt User Author First Name
strUser_Role = INI_GetValue (cIniPath, "RoleName", "NAME")
' Account Approver
strUser_AccountAuthor = INI_GetValue (cIniPath, "AccountApproverFN", "NAME")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

Call Mars_CreateUser(strCP_ProjectName, strUser_FN1, strUser_MN, strUser_LN1, strUser_Email1, strUser_StartDate, strUser_EndDate, strUser_AccountType, strUser_AccountAuthor, strUser_AuthorizationDate, strUser_PHI_Switch, strUser_PII_Switch, strUser_PHI_Permission, strUser_PII_Permission, strUser_OverrideAuth, strcUser_OverrideAuth_Switch, strUser_Role, strUser_RoleDesc, strUser_RoleStartDate, strUser_RoleEndDate)

' Update INI file with unique user name
Call INI_WriteValue (cIniPath, "User_Name", "NAME", strUser_FN1)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery= "select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Staff' and DATA:action = 'Create' and DATA:dataObject:firstName = " & "'" & strUser_FN1 & "'" & " and DATA:projectName = " & "'" & strCP_ProjectName & "'" &" ;"
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)

' Email"
XMLTag = "email"
strExpectedValue = strUser_Email1
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' endDate"
XMLTag = "endDate"
strExpectedValue = strUser_EndDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "startDate"
strExpectedValue = strUser_StartDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' firstName"
XMLTag = "firstName"
strExpectedValue = strUser_FN1
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' lastName"
XMLTag = "lastName"
strExpectedValue = strUser_LN1
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' middleName"
XMLTag = "middleName"
strExpectedValue = strUser_MN
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' accountType"
XMLTag = "accountType"
strExpectedValue = strUser_AccountType
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' accountAuthorization"
XMLTag = "accountAuthorization"
strExpectedValue = strUser_AccountAuthor
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' accountAuthorizationdate"
XMLTag = "accountAuthorizationdate"
strExpectedValue = strUser_AuthorizationDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' overrideAuthorization"
XMLTag = "overrideAuthorization"
strExpectedValue = strcUser_OverrideAuth_Switch
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' overrideAuthorizationReason"
XMLTag = "overrideAuthorizationReason"
strExpectedValue = strUser_OverrideAuth
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' requirePHIAccess"
XMLTag = "requirePHIAccess"
strExpectedValue = strUser_PHI_Switch
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' reasonPHIAccess"
XMLTag = "reasonPHIAccess"
strExpectedValue = strUser_PHI_Permission
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' requirePIIAccess"
XMLTag = "requirePHIAccess"
strExpectedValue = strUser_PHI_Switch
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' reasonPIIAccess"
XMLTag = "reasonPHIAccess"
strExpectedValue = strUser_PHI_Permission
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' projectName"
XMLTag = "projectName"
strExpectedValue = strCP_ProjectName
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)



Case "User_Update"
strEvent = "User_Update"
'===============
strUniqueNumberUser_Update = GenerateUniqueNumber()
strUser_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_FN, iIndex)
strUser_MN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_MN, iIndex)
strUser_LN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_LN, iIndex)
strUser_Email = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_Email, iIndex)
strUser_StartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_StartDate, iIndex)
strUser_StartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_StartDate_Expected, iIndex)
strUser_EndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_EndDate, iIndex)
strUser_EndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_EndDate_Expected, iIndex)
strUser_AccountType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AccountType, iIndex)
strUser_AuthorizationDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AuthorizationDate, iIndex)
strUser_AuthorizationDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_AuthorizationDate_Expected, iIndex)
strUser_PHI_Switch = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PHI_Switch, iIndex)
strUser_PII_Switch = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PII_Switch, iIndex)
strUser_PHI_Permission = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PHI_Permission, iIndex)
strUser_PII_Permission = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_PII_Permission, iIndex)
strUser_OverrideAuth = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_OverrideAuth, iIndex)
strUser_OverrideAuth_Switch = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_OverrideAuth_Switch, iIndex)
strUser_RoleStartDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleStartDate, iIndex)
strUser_RoleStartDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleStartDate_Expected, iIndex)
strUser_RoleEndDate = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleEndDate, iIndex)
strUser_RoleEndDate_Expected = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cUser_RoleEndDate_Expected, iIndex)

strRandomString = GenerateRandomString("12")
strRandomString = RemoveNumbersFromString(strRandomString)
strUser_FN2 = strUser_FN & strRandomString
strUser_LN2 = strUser_LN & strRandomString
strUser_Email1 = strRandomString & "@" & strUser_Email

' Convert Start Date
strUser_StartDate = ConvertDate_ToShortDate_MMDDYYYY(strUser_StartDate)
' Calculate and convert End Date
strUser_EndDate = Date_AddNumberOfMonth(strUser_StartDate, strUser_EndDate)
' Convert strUser_AuthorizationDate
strUser_AuthorizationDate = ConvertDate_ToShortDate_MMDDYYYY(strUser_AuthorizationDate)

' Close browser
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Mars
Call Mars_LogIn(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass)
Wait(1)

' Get project ID
strCP_ProjectName = INI_GetValue (cIniPath, "PROJECT", "ID")
' Gt User Author First Name
strUser_AccountAuthor = INI_GetValue (cIniPath, "AccountApproverFN", "NAME")
' Gt User Author First Name
strUser_Role = INI_GetValue (cIniPath, "RoleName", "NAME")

' Serch for Project Name
Call Mars_ProjectSearch(strCP_ProjectName, "", "", "")
Wait(1)

Call Mars_UpdateUser(strCP_ProjectName, strUser_FN2, strUser_MN, strUser_LN2, strUser_Email1, strUser_StartDate, strUser_EndDate, strUser_AccountType, strUser_AccountAuthor, strUser_AuthorizationDate, strUser_PHI_Switch, strUser_PII_Switch, strUser_PHI_Permission, strUser_PII_Permission, strUser_OverrideAuth, strUser_OverrideAuth_Switch)

' Update INI file with unique First name
Call INI_WriteValue (cIniPath, "User_Name", "NAME", strUser_FN2)

' Read DB and create JSON file
Call Wait_SQLToStart()
SQLquery= "select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Staff' and DATA:action = 'Update' and DATA:dataObject:firstName = " & "'" & strUser_FN2 & "'" & " and DATA:projectName = " & "'" & strCP_ProjectName & "'" &" ;"
Call Snowflake_ReadDB(strCP_ProjectName, strCP_TenantManager_ProjectFile_JSON, strDB_SF_User, strDB_SF_Pass, SQLquery) 

' Convert JSON to XML
Call Convert_JSON_to_XML(strCP_TenantManager_ProjectFile_JSON)
' Navigate to XML file
XMLFileName = cReports & "\" & strCP_TenantManager_ProjectFile_JSON & ".xml"
Wait(1)


' Email"
XMLTag = "email"
strExpectedValue = strUser_Email1
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' endDate"
XMLTag = "endDate"
strExpectedValue = strUser_EndDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' startDate"
XMLTag = "startDate"
strExpectedValue = strUser_StartDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' firstName"
XMLTag = "firstName"
strExpectedValue = strUser_FN2
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' lastName"
XMLTag = "lastName"
strExpectedValue = strUser_LN2
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' middleName"
XMLTag = "middleName"
strExpectedValue = strUser_MN
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' accountType"
XMLTag = "accountType"
strExpectedValue = strUser_AccountType
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' accountAuthorization"
XMLTag = "accountAuthorization"
strExpectedValue = strUser_AccountAuthor
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' accountAuthorizationdate"
XMLTag = "accountAuthorizationdate"
strExpectedValue = strUser_AuthorizationDate
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' overrideAuthorization"
XMLTag = "overrideAuthorization"
strExpectedValue = strcUser_OverrideAuth_Switch
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' overrideAuthorizationReason"
XMLTag = "overrideAuthorizationReason"
strExpectedValue = strUser_OverrideAuth
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' requirePHIAccess"
XMLTag = "requirePHIAccess"
strExpectedValue = strUser_PHI_Switch
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' reasonPHIAccess"
XMLTag = "reasonPHIAccess"
strExpectedValue = strUser_PHI_Permission
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' requirePIIAccess"
XMLTag = "requirePHIAccess"
strExpectedValue = strUser_PHI_Switch
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' reasonPIIAccess"
XMLTag = "reasonPHIAccess"
strExpectedValue = strUser_PHI_Permission
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)

' projectName"
XMLTag = "projectName"
strExpectedValue = strCP_ProjectName
Call XML_GetValue_byTag(XMLFileName, XMLTag, strExpectedValue, strEvent)





Case Else

'None

End  Select



Wait(1)
Next
Wait(1)

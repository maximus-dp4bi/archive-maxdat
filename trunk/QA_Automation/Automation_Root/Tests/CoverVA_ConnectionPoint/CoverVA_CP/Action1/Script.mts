
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
'strOneDrivePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%") & "\OneDrive - Maximus, Inc"
'cDataFileURL = strDataDriver_Location & "\" & strDataDriver_FileName & ".xls"

' Copy dataDriver file from original location to Report folder and then use it as normal datadriver.
cDataFileURL = CopyFile_From_To(strDataDriver_Location, cReports, strDataDriver_FileName)

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
 
  ' Get Snowflake environment
 strSnowflake_ENV = ReadIni( strFilePathINI, "ENV", "value")
 
 select case strSnowflake_ENV
   case "UAT"
      'strSF_Connection = cSnowflakeConnection_UAT1 & cSnowflakeConnection_UAT2
      strSF_Connection = ReadIni( strFilePathINI, "ENV_UAT", "value")
   case "DEV"
      'strSF_Connection = cSnowflakeConnection_DEV1 & cSnowflakeConnection_DEV2
      strSF_Connection = ReadIni( strFilePathINI, "ENV_DEV", "value")
   case "PRD"
      'strSF_Connection = cSnowflakeConnection_PROD1 & cSnowflakeConnection_PROD2
      strSF_Connection = ReadIni( strFilePathINI, "ENV_PRD", "value")
   case else
     'None
end select
 
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


'============
strUniqueNumber_Create = GenerateUniqueNumber()
strCons_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_FN, iIndex)
strCons_MN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_MN, iIndex)
strCons_LN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_LN, iIndex)
strSearchResult_TableName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cSearchResult_TableName, iIndex)

'strCons_FN = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCons_FN, iIndex)
strCont_ContactReason = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_ContactReason, iIndex)
strCont_ContactAction = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_ContactAction, iIndex)
strCont_Comment1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Comment1, iIndex)
strCont_Comment2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Comment2, iIndex)
strCont_Type = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Type, iIndex)
strCont_Queue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Queue, iIndex)
strCont_Channel = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Channel, iIndex)
strCont_ChannelValue = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_ChannelValue, iIndex)
strCont_Program = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Programm, iIndex)
strCont_TranslationService = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_TranslationService, iIndex)
strCont_Disposition = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCont_Disposition, iIndex)

strTaskOption = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTaskOption, iIndex)
strTaskPriority = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTaskPriority, iIndex)
strTaskStatus = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTaskStatus, iIndex)
strTaskAssignee = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTaskAssignee, iIndex)
strTaskInfo = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTaskInfo, iIndex)

' Close all browsers
Call GEN_CloseAll_Browsers(strBrowser)
' Log in to Connection Point
Call Mars_LogIn_CP(strBrowser, cMarsLogInURL, strMars_User, strMars_Pass, strCP_BaseProject)
Wait(1)

' Fold Call management popup
Call MarsCP_CallManagementPopUp_Fold()

                          '========= Start of INITIATE CONTACT process ==========

'====================================== Select Initiate Contact button ===========================================
Call MarsCP_InitiateContact_Button()
' Make Add Consumer button appeared
'Call MarsCP_AddConsumerButton_MakeItAppeared()
' Select Add Consumer button
'Call MarsCP_AddConsumerButton_Select()

' Create random alphabetic string
strRandomString = GenerateRandomString("12")
strRandomString = RemoveNumbersFromString(strRandomString)

' ================================= Search for Consumer ==========================================================
strConsumerFound =  MarsCP_SearchForConsumer(strCons_FN, strCons_LN, strSearchResult_TableName)
' Open CONSUMER AUTHENTICATION
' =================================== Select Consumer ============================================================
Call CP_ConsumerAuthentication_ExpandAndSelectConsumer(strSearchResult_TableName)

'================================================= Start: Create Task ===============================================

Select Case strScenario_Type

Case "InitiateContact_ReviewComplaints"

strTas_ReviewComplaint_ExternalCaseID = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewComplaint_ExternalCaseID, iIndex)
strTask_ReviewComplaint_ExternalConsumerID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewComplaint_ExternalConsumerID , iIndex)
strTask_ReviewComplaint_ComplaintType  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewComplaint_ComplaintType , iIndex)
' Create Task
Call CP_Task_ReviewComplaint_Create(strTaskOption, strTaskPriority, strTaskStatus, strTaskAssignee, strTaskInfo, strTas_ReviewComplaint_ExternalCaseID, strTask_ReviewComplaint_ExternalConsumerID , strTask_ReviewComplaint_ComplaintType)
wait(2)
strTaskID = CP_GetTaskID()


Case "InitiateContact_ReviewAppeal"

' Create random alphabetic string
strRandomANString = GenerateRandomString("8")
strRandomAString = RemoveNumbersFromString(strRandomANString)
strTask_ReviewAppeal_ExternalApplicationId = strRandomAString
' Update Data Draver with agent name (grid section)
indexColumnIndex_TaskID = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cTask_ReviewAppeal_ExternalApplicationId, 1)
Call ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, indexColumnIndex_TaskID, strTask_ReviewAppeal_ExternalApplicationId)

nLow = 1
nHigh = 10000
Randomize
strRandomNString = Int((nHigh - nLow + 1) * Rnd + nLow)
strTask_ReviewAppeal_ExternalCaseId = strRandomNString
indexTask_ReviewAppeal_ExternalCaseId = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cTask_ReviewAppeal_ExternalCaseId, 1)
Call ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, indexTask_ReviewAppeal_ExternalCaseId, strTask_ReviewAppeal_ExternalCaseId)

strTask_ReviewAppeal_Expedited  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_Expedited , iIndex)
strTask_ReviewAppeal_DmasReceivedDate  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_DmasReceivedDate , iIndex)
strTask_ReviewAppeal_CovervaReceivedDate  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_CovervaReceivedDate , iIndex)
strTask_ReviewAppeal_ExternalApplicationId  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_ExternalApplicationId , iIndex)
strTask_ReviewAppeal_ExternalCaseId  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_ExternalCaseId , iIndex)
strTask_ReviewAppeal_CaseStatus  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_CaseStatus , iIndex)
strTask_ReviewAppeal_AppealReason  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_AppealReason , iIndex)
strTask_ReviewAppeal_BusinessUnit  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_BusinessUnit , iIndex)
strTask_ReviewAppeal_AppealsCaseSummaryDueDate  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_AppealsCaseSummaryDueDate , iIndex)
strTask_ReviewAppeal_AppealsCaseSummary_Hyperlink  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_AppealsCaseSummary_Hyperlink , iIndex)
strTask_ReviewAppeal_AppealsCaseSummaryStatus  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_AppealsCaseSummaryStatus , iIndex)
strTask_ReviewAppeal_ReviewOutcome  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_ReviewOutcome , iIndex)
strTask_ReviewAppeal_ActionTaken  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_ReviewAppeal_ActionTaken , iIndex)
' Create Task
Call CP_Task_ReviewAppeal_Create(strTaskOption, strTaskPriority, strTaskStatus, strTaskAssignee, strTaskInfo, strTask_ReviewAppeal_Expedited, strTask_ReviewAppeal_DmasReceivedDate, strTask_ReviewAppeal_CovervaReceivedDate, strTask_ReviewAppeal_ExternalApplicationId, strTask_ReviewAppeal_ExternalCaseId, strTask_ReviewAppeal_CaseStatus, strTask_ReviewAppeal_AppealReason, strTask_ReviewAppeal_BusinessUnit, strTask_ReviewAppeal_AppealsCaseSummaryDueDate, strTask_ReviewAppeal_AppealsCaseSummary_Hyperlink, strTask_ReviewAppeal_AppealsCaseSummaryStatus, strTask_ReviewAppeal_ReviewOutcome, strTask_ReviewAppeal_ActionTaken)
wait(5)
strTaskID = CP_GetTaskID()
wait(1)

Case "InitiateContact_GeneralEscalation"

strTask_GeneralEscalation_ExternalCaseId  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_ExternalCaseId , iIndex)
strTask_GeneralEscalation_ExternalApplicationID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_ExternalApplicationID , iIndex)
strTask_GeneralEscalation_ConnectionPointContactRecordId  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_ConnectionPointContactRecordId , iIndex)
strTask_GeneralEscalation_ConnectionPointSRId  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_ConnectionPointSRId , iIndex)
strTask_GeneralEscalation_ConnectionPointTaskId  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_ConnectionPointTaskId , iIndex)
strTask_GeneralEscalation_ContactReason  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_ContactReason , iIndex)
strTask_GeneralEscalation_DueDate  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_DueDate , iIndex)
strTask_GeneralEscalation_ActionTaken  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_GeneralEscalation_ActionTaken , iIndex)
Call CP_Task_GenerateEscalation_Create(strTaskOption, strTaskPriority, strTaskStatus, strTaskAssignee, strTaskInfo, strTask_GeneralEscalation_ExternalCaseId, strTask_GeneralEscalation_ExternalApplicationID, strTask_GeneralEscalation_ConnectionPointContactRecordId, strTask_GeneralEscalation_ConnectionPointSRId, strTask_GeneralEscalation_ConnectionPointTaskId, strTask_GeneralEscalation_ContactReason, strTask_GeneralEscalation_DueDate, strTask_GeneralEscalation_ActionTaken)
wait(2)
strTaskID = CP_GetTaskID()

Case "InitiateContact_InboundDocument"

strTask_InboundDocument_ExternalCaseID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_InboundDocument_ExternalCaseID , iIndex)
strTask_InboundDocument_ExternalConsumerID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_InboundDocument_ExternalConsumerID , iIndex)
strTask_InboundDocument_ApplicationID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_InboundDocument_ApplicationID , iIndex)
strTask_InboundDocument_DocumentType  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_InboundDocument_DocumentType , iIndex)
strTask_InboundDocument_SelectProgram  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_InboundDocument_SelectProgram , iIndex)
strTask_InboundDocument_ActionTaken  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_InboundDocument_ActionTaken , iIndex)
Call CP_Task_InboundDocument_Create(strTaskOption, strTaskPriority, strTaskStatus, strTaskAssignee, strTaskInfo, strTask_InboundDocument_ExternalCaseID, strTask_InboundDocument_ExternalConsumerID, strTask_InboundDocument_ApplicationID, strTask_InboundDocument_DocumentType, strTask_InboundDocument_SelectProgram, strTask_InboundDocument_ActionTaken)
wait(2)
strTaskID = CP_GetTaskID()

Case "InitiateContact_TransferToLDSS"

strTask_TransferToLDSS_ExternalCaseID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_ExternalCaseID , iIndex)
strTask_TransferToLDSS_ExternalConsumerID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_ExternalConsumerID , iIndex)
strTask_TransferToLDSS_ApplicationID  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_ApplicationID , iIndex)
strTask_TransferToLDSS_TransferedDate  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_TransferedDate , iIndex)
strTask_TransferToLDSS_TransferReason  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_TransferReason , iIndex)
strTask_TransferToLDSS_Locality  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_Locality , iIndex)
strTask_TransferToLDSS_CaseWorker_FN  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_CaseWorker_FN , iIndex)
strTask_TransferToLDSS_CaseWorker_LN  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_CaseWorker_LN , iIndex)
strTask_TransferToLDSS_ActionTaken  = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cTask_TransferToLDSS_ActionTaken , iIndex)
Call CP_Task_TransferToLDSS_Create(strTaskOption, strTaskPriority, strTaskStatus, strTaskAssignee, strTaskInfo, strTask_TransferToLDSS_ExternalCaseID, strTask_TransferToLDSS_ApplicationID, strTask_TransferToLDSS_ApplicationID, strTask_TransferToLDSS_TransferedDate, strTask_TransferToLDSS_TransferReason, strTask_TransferToLDSS_Locality, strTask_TransferToLDSS_CaseWorker_FN, strTask_TransferToLDSS_CaseWorker_LN,  strTask_TransferToLDSS_ActionTaken)
wait(2)
strTaskID = CP_GetTaskID()

Case Else

'None

End  Select

'================================================= End: Create Task ===============================================

' Update Data Draver with task id
strColumnIndex_TaskID = ReadExcelFile_GetColumnIndexByColumnName(cDataFileURL, cTaskID, 1)
Call ReadExcelFile_UpdateCellValue(cDataFileURL, iIndex, strColumnIndex_TaskID, strTaskID)

' '========================================== Create Reasons ===================================================
Call MarsCP_Reasons(strCont_ContactReason, strCont_ContactAction, strCont_Comment1, strCont_Comment2)

' ========================================== Fill up Contact Details ===========================================
Call CP_ContactDetails(strCont_Type, strCont_Queue, strCont_Channel, strCont_ChannelValue, strCont_Program, strCont_TranslationService)

' =========================================== End Contact ======================================================
Call MarsCP_EndContact()
' ======================================= Wrap-Up and Close Initiate Contact ===================================
Call MarsCP_WrapUp_AndClose(strCont_Disposition)

wait(1)
                       '========= End of INITIATE CONTACT process ==========
                       

'============================================ DATA VALIDATION ====================================================
Select Case strScenario_Type

'=============================================== Review Complaints =========================================
Case "InitiateContact_ReviewComplaints"

' Search for task and open Task Detail read only view
Call CP_TaskSearch_OpenTaskDetailView(strTaskID)
Wait(1)

' Read basic data from Task Detail view and update excel (TaskOutput worksheet)
strWorkSheet = "TaskOutput"
Call CP_TaskDetail_CommonInfo_GetFromScreen_UpdateExcel(cDataFileURL, strWorkSheet, strTaskID)
' Read Review Complaint specific data from Task Detail view and update excel (TaskOutput worksheet)
Call CP_TaskDetail_ReviewComplaint_GetFromScreen_UpdateExcel(cDataFileURL, strWorkSheet)

' Wait for 5+ minutes
Call Wait_SQLToStart()
' Validate some  TASK_FIELD_IDs against Task_Detail view
Call CP_TaskDetail_Validate(cDataFileURL, strSF_Connection)
' Validate some entries in Review Complaint view
strMainIndex = iRowValues
Call CP_COMPLAINT_INSTANCE_Validate(cDataFileURL, strSF_Connection, strMainIndex)


'=============================================== Review Appeal =========================================
Case "InitiateContact_ReviewAppeal"

' Search for task and open Task Detail read only view
Call CP_TaskSearch_OpenTaskDetailView(strTaskID)
Wait(1)

' Read basic data from Task Detail view and update excel (TaskOutput worksheet)
strWorkSheet = "TaskOutput"
Call CP_TaskDetail_CommonInfo_GetFromScreen_UpdateExcel(cDataFileURL, strWorkSheet, strTaskID)
' Read Review Appeal specific data from Task Detail view and update excel (TaskOutput worksheet)
Call CP_TaskDetail_ReviewAppeal_GetFromScreen_UpdateExcel(cDataFileURL, strWorkSheet)

' Wait for 5+ minutes
Call Wait_SQLToStart()
' Validate some  TASK_FIELD_IDs against Task_Detail view
Call CP_TaskDetail_Validate(cDataFileURL, strSF_Connection)
wait(1)
' Validate Review Appeals view
Call CP_ReviewAppeal_Validate(cDataFileURL, strSF_Connection)

'=============================================== RGeneral Escalation =========================================
Case "InitiateContact_GeneralEscalation"

' Search for task and open Task Detail read only view
Call CP_TaskSearch_OpenTaskDetailView(strTaskID)
Wait(1)

'=============================================== Inbound Document =========================================
Case "InitiateContact_InboundDocument"

' Search for task and open Task Detail read only view
Call CP_TaskSearch_OpenTaskDetailView(strTaskID)
Wait(1)

'=============================================== Transfer to LDSS =========================================
Case "InitiateContact_TransferToLDSS"

' Search for task and open Task Detail read only view
Call CP_TaskSearch_OpenTaskDetailView(strTaskID)
Wait(1)

Case Else

'None

End  Select




Next
Wait(1)

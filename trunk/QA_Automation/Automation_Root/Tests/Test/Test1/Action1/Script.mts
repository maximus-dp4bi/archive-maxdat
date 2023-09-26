

 @@ hightlight id_;_3870302_;_script infofile_;_ZIP::ssf24.xml_;_




a=Split("JanuaryFabuaryMarch","month",-1,1)
for each x in a
    aa = (x)
next


Dim [val.val],[Date]
 [val.val] = "shekhar"
[Date]= "July 16,2015"
 msgbox [val.val]
msgbox [Date]




strSQLLocation = "C:\Automation_Root\States\NC\Genesys\NCUI\SQL"
cDataFileURL = "C:\Automation_Root\States\NC\Genesys\NCUI\Project\Data\DataDriver_AgentStatusQACheck_GenNCUIAgentStatusSummaryDailydataset.xls"
strFolderName = ConvertDateToName
strTestName = Environment("TestName")
cReports = "C:\Maximus\Reports" & "\" & strTestName & "-" & strFolderName
Call CreateFolderSingleIfNotExists(cReports) 


Call KillAllExcelProcesses()


' Performance verification: Start

 iIndex = 3
 
 ' Clear dowload folder.
 Call KillAllExcelProcesses()
 Call ClearCurrentDownloadFolder()

' Get variables from external Data file
strBrowser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cBrowser, iIndex)
strReportType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportType, iIndex)

' Close all browsers
Call GEN_CloseAll_Browsers(strBrowser)
iCount = 0

Do until iCount = 100
  
strUser = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_User, iIndex)
strPass = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_Pass, iIndex) 
strEnv = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cEnvironment, iIndex)
strURL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cURL, iIndex)
strLoginAuthentication = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLoginAuthentication, iIndex)
strLink_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_1, iIndex)
strLink_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_2, iIndex)
strLink_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_3, iIndex)
strLink_4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_4, iIndex)
strLink_5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_5, iIndex)
strLink_6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cLink_6, iIndex)
strReportName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportName, iIndex)
strReportLink = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportLink, iIndex)
strContainerType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportContainerType, iIndex)
strWorkbookName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cMS_WorkbookName, iIndex)
strReportLink_Substring = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportLink_Substring, iIndex)
strReportType = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cReportType, iIndex)
strSelectOption = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sSelectOption, iIndex)
strTypeValue_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sTypeValue_1, iIndex)
strTypeValue_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sTypeValue_2, iIndex)
strTypeValue_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, sTypeValue_3, iIndex)
strGrid_WebList_1 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_1, iIndex)
strGrid_WebList_2 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_2, iIndex)
strGrid_WebList_3 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_3, iIndex)
strGrid_WebList_4 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_4, iIndex)
strGrid_WebList_5 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_5, iIndex)
strGrid_WebList_6 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_6, iIndex)
strGrid_WebList_7 = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cGrid_WebList_7, iIndex)
strCompare_ValidateColumnName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(cDataFileURL, cCompare_ValidateColumnName, iIndex)

Wait(1)
iCount = iCount + 1

Loop

















































Set obj = Createobject("Scripting.FileSystemObject")
Set fol = obj.GetFolder("C:\Maximus\Reports\MIEBS - Contact Center\MIEBS_PROD_09.22.2020_ContactCenter_AdHocDatasetReports_1.0 Agent Performance Ad-Hoc Template") 'Folder Path
Set fis = fol.Files

For each fs in fis
    If latest = "" Then
        Set latest = fs
        ElseIf latest.Datecreated < fs.Datecreated Then
        Set latest = fs
    End If
Next

Msgbox latest.name





Function ShortingArrayValueInDcedingOrder_RemoveDuplicates() 

ReDim strValue(11)	

a = array(8,45,6,2,8,45,10,2,15,2,11)

Set obj = createobject("Scripting.Dictionary")
obj.CompareMode = vbtextcompare

For each val in a
    obj(val) = val
Next

a1 = obj.Items

For i = 0 To ubound(a1)
    For j = 0 To ubound(a1)
        If a1(i) > a1(j) Then
            t = a1(i)
            a1(i) = a1(j)
            a1(j) = t
        End If
    Next
Next

For k = 0 To ubound(a1)
    msgbox a1(k)
Next

End Function


Function ShortingArrayValueInAcendingOrder_RemoveDuplicates() 

 a = array(8,45,6,2,8,45,10,2,15,2,11)

Set obj = createobject("Scripting.Dictionary")
obj.CompareMode = vbtextcompare

For each val in a
    obj(val) = val
Next

a1 = obj.Items

For i = 0 To ubound(a1)
    For j = 0 To ubound(a1)
        If a1(i) < a1(j) Then
            t = a1(i)
            a1(i) = a1(j)
            a1(j) = t
        End If
    Next
Next

For k = 0 To ubound(a1)
    msgbox a1(k)
Next

End Function

Function GetHighestValueFromArray()
	
 a = array(54,4,2,5,4,58,5,8,7,9)

For i = 1 To ubound(a)
    If a(i) > a(0) Then
        a(0) =a(i)
    End If
Next

msgbox a(0) ' 58	
	
	
	
	
End Function

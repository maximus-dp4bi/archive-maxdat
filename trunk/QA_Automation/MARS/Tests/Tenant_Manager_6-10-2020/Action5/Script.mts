


Dim Project_Name
CT=Unique_ID_Num()

Project_Name = "UFTTest" 
State = "NY"
Program_Name="Auto" & CC
Contract_ID = "123456"
Agency_Name = "Agency"& CC
C_Start_Date = "05/29/2020"
C_End_Date = "05/29/2021"
Go_Live_Date = "01/29/2021"
Provi_Status = "Active"
Time_Zone = "Eastern"



Project_Name=Project_Name & CT
Print "Project Name - " & Project_Name


Set BrserProjList = Description.Create
Set PgeProjList = Description.Create
Set AddBtn = Description.Create
Set ProjNameWE = Description.Create
Set ProjStateBtn = Description.Create
Set ProjStateSE = Description.Create
Set PorgNameWE = Description.Create
Set ContactIDWE = Description.Create
Set AgencyNameWE = Description.Create
Set StartDate = Description.Create
Set EndDate = Description.Create
Set LiveDate = Description.Create
Set ProvStatus = Description.Create
Set TimeZone = Description.Create
Set SaveBtn = Description.Create
Set AcceptContinure = Description.Create
Set ImageLogo = Description.Create

BrserProjList("title").value = "Tenant Manager"

PgeProjList("title").value = "Tenant Manager"

ProjNameWE("name").value = "projectName"

ProjStateBtn("html id").value = "mui-component-select-state"

ProjStateSE("innertext").value = State

PorgNameWE("name").value = "programName"

ContactIDWE("name").value = "contractId"

AgencyNameWE("name").value = "stateAgencyName"

StartDate("name").value = ("WebEdit")
StartDate("kind").value = ("singleline")
StartDate("placeholder").value = ("MM/DD/YYYY")
StartDate("index").value = ("1")

'EndDate("index").value = ("2")


AddBtn("Name").value = "add"
AddBtn("value").value = "add"
AddBtn("type").value = "button"

AddBtn("class").value = "MuiButtonBase-root MuiFab-root mdl-js-button mdl-button--fab mdl-js-ripple-effect mx-btn-white-tm ml-2 mt-4"
'connection point loading image:
'Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//DIV[@id='root']/MAIN[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/H4[1]").WaitProperty "innertext", "USE OF THIS SYSTEM CONSTITUTES CONSENT TO THE FOLLOWING", 100000
	
'Starting Action:
'IF Error on page

'if option to agree with condition exists
If Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//DIV[@id='root']/MAIN[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/A[1]").Exist (120) Then
	If Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//DIV[2]/DIV[1]/DIV[@role='dialog'][1]/DIV[@role='document'][1]/DIV[1]/DIV[1]").Exist (10) Then 
		Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//DIV[2]/DIV[1]/DIV[@role='dialog'][1]/DIV[@role='document'][1]/DIV[1]/DIV[1]/P[1]/DIV[1]/BUTTON[1]").Click
	End If
	Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//DIV[@id='root']/MAIN[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/A[1]").Click
Else
Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//DIV[@id='root']/MAIN[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/A[1]").WaitProperty "outertext", "USE OF THIS SYSTEM CONSTITUTES CONSENT TO THE FOLLOWING", 10000
Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//DIV[@id='root']/MAIN[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/A[1]").Click
End If
'""""""""""""""""""""""""""""""""""""""""""
Browser(BrserProjList).Page(PgeProjList).WebButton(AddBtn).Click

Browser(BrserProjList).Page(PgeProjList).WebEdit(ProjNameWE).Set Project_Name 

Browser(BrserProjList).Page(PgeProjList).WebButton(ProjStateBtn).Click

Browser(BrserProjList).Page(PgeProjList).WebElement(ProjStateSE).Click

Browser(BrserProjList).Page(PgeProjList).WebEdit(PorgNameWE).Set Program_Name

Browser(BrserProjList).Page(PgeProjList).WebEdit(ContactIDWE).Set Contract_ID

Browser(BrserProjList).Page(PgeProjList).WebEdit(AgencyNameWE).Set Agency_Name

'xpath dates 
'Start
Browser(BrserProjList).Page(PgeProjList).WebEdit("xpath:=//*[normalize-space()='Contract Start Date']/DIV[1]/INPUT[1]").Set C_Start_Date
'End
Browser(BrserProjList).Page(PgeProjList).WebEdit("xpath:=//*[normalize-space()='Contract End Date']/DIV[1]/INPUT[1]").Set C_End_Date
'Golive
Browser(BrserProjList).Page(PgeProjList).WebEdit("xpath:=//*[normalize-space()='Go-Live Date']/DIV[1]/INPUT[1]").Set Go_Live_Date

'Xpath Provisioning Status
Browser(BrserProjList).Page(PgeProjList).WebButton("xpath:=//*[@id='mui-component-select-provStatus']").Click
'Active
Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//*[@role='option'][2]").Click


'Xpath Time Zone
Browser(BrserProjList).Page(PgeProjList).WebButton("xpath:=//*[@id='mui-component-select-timeZone']").Click
'Eastern
Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//*[@role='option'][7]").Click

'SAVE Project
Browser(BrserProjList).Page(PgeProjList).WebButton("xpath:=//*[normalize-space()='check Save']").Click
wait (2)
If Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//*[@id='client-snackbar']").Exist (5) Then 
	Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//*[@role='alert'][1]/DIV[2]/BUTTON[1]/SPAN[1]/svg").Click
End If


'Validate If Project Was Created (UI)

'Back Button
Browser(BrserProjList).Page(PgeProjList).WebButton("xpath:=//*//DIV[@id='root']/DIV[1]/DIV[2]/DIV[1]/BUTTON[1]").Click
If Browser(BrserProjList).Page(PgeProjList).WebElement("xpath:=//*[@role='dialog'][1]/DIV[@role='document'][1]/DIV[1]/DIV[1]").Exist (5) Then
	Browser(BrserProjList).Page(PgeProjList).WebButton("xpath:=//*[@role='document'][1]/DIV[1]/DIV[1]/P[1]/DIV[1]/BUTTON[1]").Click
End If

'Search Project Nmae
Browser(BrserProjList).Page(PgeProjList).WebEdit("xpath:=//*[@role='combobox']/DIV/DIV[normalize-space()='Project']/INPUT[1]").Set Project_Name
Browser(BrserProjList).Page(PgeProjList).WebButton("xpath:=//*[normalize-space()='search Search']").Click

Browser(BrserProjList).Page(PgeProjList).WebButton("xpath:=//*//DIV[@id='root']/DIV[1]/MAIN[1]/DIV[1]/DIV[1]/DIV[1]/DIV[4]/DIV[1]/DIV[1]/DIV[1]/BUTTON[1]").Click


'-----Validate project was created:
M=minute(Now)
x =  M Mod 5

W= 5-x
zzz=W*70

'msgbox w & " 7th min - x " & M & " wait time " & zzz
print zzz
Wait(zzz)


Dim conn, dbResult
Set conn = CreateObject("ADODB.Connection")
Set dbResult = CreateObject("ADODB.Recordset")
sconnect = "Provider=MSDASQL.1;DSN=MARS_SNOW;" & ";HDR=Yes';Password=^N4]8TmUnL?%7e}];Warehouse=QA_WH"  ' "Provider=MSDASQL.1;DSN=JMUFT;" & ";HDR=Yes';Password=Topwinter1;Warehouse=QA_WH"

conn.Open (sconnect)



SQLquery="select DATA::VARCHAR from MARS_DP4BI_DEV.SOLACE.EVENT_FULL_JSON_DATA where DATA:recordType = 'Project' and DATA:dataObject:projectName = " & "'" & Project_Name & "'" & ";" '& "" 

dbResult.open(SQLquery), conn



Set fso = CreateObject("Scripting.FileSystemObject")
Set UFT_Log = fso.CreateTextFile("C:\Mars_Logs\Snowflake_Res.txt")

UFT_Log.WriteLine Now

For intCount = 0 To dbResult.Fields.Count - 1
 If Not dbResult.BOF Then
 dbresult.MoveFirst
 End If

intRow = 1
Do Until dbResult.EOF

 strTest = dbResult.Fields(intCount).Value
 UFT_Log.write  strTest

 dbResult.MoveNext
 intRow =intCount+1
Loop
Next





'__________________Converting date to YYYY-MM-DD

C_End_Date_Output = DateFormat_SolidTime(C_End_Date)

Print C_End_Date_Output

Go_Live_Date_Output = DateFormat_SolidTime(Go_Live_Date)

Print Go_Live_Date_Output

C_Start_Date_Output = DateFormat_SolidTime(C_Start_Date)

Print C_Start_Date_Output

''''''''''''''''''''''''''''''''


json = fso.OpenTextFile("C:\Mars_Logs\Snowflake_Res.txt").ReadAll

Project_NameRes = instr(json, Project_Name)

StateRes = instr(json, State)
Program_NameRes = instr(json, Program_Name)
Contract_IDRes = instr(json, Contract_ID)
Agency_NameRes = instr(json, Agency_Name)
C_Start_DateRes = instr(json, C_Start_Date)
C_End_DateRes = instr(json, C_End_Date)
Go_Live_DateRes = instr(json, Go_Live_Date)
Provi_StatusRes = instr(json, Provi_Status)
Time_ZoneRes = instr(json, Time_Zone)
C_Start_Date_RES = instr(json, C_Start_Date_Output)
C_End_Date_RES = instr(json, C_End_Date_Output)
Go_Live_Date_RES = instr(json, Go_Live_Date_Output)

Set UFT_Result_Log = fso.CreateTextFile("C:\Mars_Logs\UFT_Result_Log.txt")

If Project_NameRes > 0 Then
	Reporter.ReportEvent micPass, "Project was successfully created",  "Project exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Project - " & Project_Name & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Project was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Project - " & Project_Name & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If

'''''''''''''''''''''''''''''''''''

If StateRes > 0 Then
	Reporter.ReportEvent micPass, "State was successfully recorded",  "State exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "State - Entered:  "& State & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "State was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: State - Entered: " & State & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If

'''''''''''''''''''''''''''''''''''

If Program_NameRes > 0 Then
	Reporter.ReportEvent micPass, "Program was successfully created",  "Program exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Program - Entered: " & Program_Name & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Program was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Program Entered: - " & Program_Name & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If

'''''''''''''''''''''''''''''''''''

If Contract_IDRes > 0 Then
	Reporter.ReportEvent micPass, "Contract ID was successfully created",  "Contract ID exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Contract ID - Entered: " & Contract_ID & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Contract ID was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Contract ID - Entered: " & Contract_ID & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If

'''''''''''''''''''''''''''''''''''

If Agency_NameRes > 0 Then
	Reporter.ReportEvent micPass, "Agency Name was successfully created",  "Agency Name  exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Agency Name  - Entered: " & Agency_Name & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Agency Name  was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Agency Name - Entered: " & Agency_Name & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If


'''''''''''''''''''''''''''''''''''

If Provi_StatusRes > 0 Then
	Reporter.ReportEvent micPass, "Provisioning Status was successfully created",  "Project exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Provisioning Status  - Entered: " & Provi_Status & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Project was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Project - " & Provi_Status & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If

'''''''''''''''''''''''''''''''''''

If TestDates1 > 0 Then
	Reporter.ReportEvent micPass, "Project was successfully created",  "Provisioning Status exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Provisioning Status - Entered: " & TestDate & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Provisioning Status was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Provisioning Status  - Entered: " & TestDate & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If

'''''''''''''''''''''''''''''''''''

If C_Start_Date_RES > 0 Then
	Reporter.ReportEvent micPass, "Contract Start Date was successfully created",  "Contract Start Date exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Contract Start Date - Entered: " & C_Start_Date & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Contract Start Date was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Contract Start Date - Entered: " & C_Start_Date & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If
'End date
If C_End_Date_RES > 0 Then
	Reporter.ReportEvent micPass, "Contract End Date was successfully created",  "Contract End Date exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Contract End Date - Entered: " & C_End_Date & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Contract End Date was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Contract End Date - Entered: " & C_End_Date & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If

'Go Live date

If Go_Live_Date_RES > 0 Then
	Reporter.ReportEvent micPass, "Go Live Date was successfully created",  "Go Live Date exists in Snowflake database and was verified"
	UFT_Result_Log.writeline "Go Live Date - Entered: " & Go_Live_Date & "  Was successfully created and verified.  Verification Date/Time - " & Now
Else
	Reporter.ReportEvent micFail, "Go Live  Date was NOT created",  "UFT was no able to verify existance of data in Snowflake dB"
	UFT_Result_Log.writeline "Error: Go Live Date - Entered: " & Go_Live_Date & "  Was NOT successfully verified. Verification Date/Time - " & Now
End If



Set fso = nothing





MsgBox XML_Read_Value_byTag ("C:\UFT\MARS\Reports\Snowflake_Res111.xml", "projectName")


Function XML_Read_Value_byTag(XMLFileName, XMLTag)
    Set oXMLFile = CreateObject("Msxml2.DOMDocument")
        oXMLFile.Load(XMLFileName)
    Set oXMLFileVariale = oXMLFile.getElementsByTagName(XMLTag)
        XML_Read_Value_byTag = oXMLFileVariale.Item(0).Text
End Function



MyDateTime= Now
'strSerial = DateSerial(MyDateTime)
curDate =  Month(Date) & "_" & Day(Date) & "_" & Year(Date) & "_" & Time

CurDate2  = Replace(CurDate,":","-")


GUID = CreateGuidPlainFormat()
GUID =  Replace(GUID,"-","")
strShort = CreateGuid()




Function CreateGuid()
    CreateGuid = Left(CreateObject("Scriptlet.TypeLib").Guid,10)
End Function
Function CreateGuidPlainFormat()
  Dim objTypeLib
  Set objTypeLib = CreateObject("Scriptlet.TypeLib")
  CreateGuidPlainFormat = Mid(objTypeLib.Guid, 2, 12)
End Function


	SystemUtil.Run "chrome.exe", "https://www.microfocus.com/en-us/home"
	'Set ObjBrowser = Browser("ConnectionPoint Sign In")
	Set ObjBrowser = Browser("Digital Transformation")
		Wait(1)
	ObjBrowser.Highlight
	Wait(1)
	Browser("Digital Transformation").Page("Digital Transformation").Image("Micro Focus").Click
	Set WshShell = CreateObject("WScript.Shell")
	WshShell.SendKeys "^+{DELETE}" 'Sending Ctrl, Shift and Delete Key together
	Wait(2)
	WshShell.SendKeys "{TAB 9}"
	Wait(2)
	WshShell.SendKeys "{ENTER}"
	Wait(1)
	Set WshShell = Nothing


 @@ script infofile_;_ZIP::ssf5.xml_;_
 @@ script infofile_;_ZIP::ssf6.xml_;_











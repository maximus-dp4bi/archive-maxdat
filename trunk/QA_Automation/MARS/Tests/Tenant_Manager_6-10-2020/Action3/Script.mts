'Setting discription
Set Brser = Description.Create
Set Pge = Description.Create
Set WebEl = Description.Create
Set ConnPoint = Description.Create
Set OTPCode = Description.Create
'Setting properties


Brser("name").value = "ConnectionPoint Sign In"
Brser("opentitle").value = "ConnectionPoint Sign In"

Pge("title").value = "ConnectionPoint Sign In"

Browser(Brser).Page(Pge).Highlight


'WebEl("class") = "app-cell-appname"
'WebEl("innertext") = "ConnectionPoint | Non-ProdEdit"
'WebEl("outertext") = "ConnectionPoint | Non-ProdEdit"

strBrowser = "chrome.exe"
strURL = "https://mars-tenant-manager-ui-uat.apps.non-prod.pcf-maximus.com/"



'Open Tenant Manager
SystemUtil.Run strBrowser, strURL





'Browser(Brser).Page(Pge).WebElement("xpath:=//*[@id='tile-13']/a/div").Highlight
'Browser(Brser).Page(Pge).WebElement("xpath:=//*[@id='tile-13']/a/div").Click

'Browser(Brser).Page(Pge).Exit


'Set Brser1 = Description.Create
'Set Pge1 = Description.Create
'Set link1 = Description.Create
'Set BoxOTP = Description.Create
'Set ConnPoint = Description.Create
'Set OTPCode = Description.Create
'Setting properties


'Brser1("title").value = "OneLogin"
'Brser1("openurl").value = "about:blank"
'Pge1("title").value = "OneLogin"
'Pge1("url").value = "https://maximusinc.onelogin.com/client/otp_prompt/414292175"

'link1("innertext").value = "Click here to enter OTP manually"
'link1("html id").value = "otp_auto_token_manual_msg"


'BoxOTP("html id").value = "otp_token_1"
'BoxOTP("name").value = "otp_token_1"

'MSGBOX "Please check OneLogin message on your phone, click Allow and click OK on this pop-up"

'If Browser(Brser1).Page(Pge1).Link(link1).Exist Then
'	Browser(Brser1).Page(Pge1).Link(link1).Click
'	Browser(Brser1).Page(Pge1).WebEdit(BoxOTP).Highlight
'	codeOTP=inputbox("Please Enter Your OTP Token Code")
'	Browser(Brser1).Page(Pge1).WebEdit(BoxOTP).Set codeOTP
'	Set WshShell=CreateObject("WScript.Sheel")
'	WshShell.SendKeys("Enter")
'	Set WshShell=nothing
'End If


RunAction "Tenant_Manager_Create_Project", oneIteration

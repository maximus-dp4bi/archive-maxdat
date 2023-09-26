Dim strBrowser, strURL

strBrowser = "chrome.exe"
strURL = "https://cp-sso.login.sys.non-prod.pcf-maximus.com/login"
'"/incognito https://mars-tenant-manager-ui-uat.apps.non-prod.pcf-maximus.com/"


'Open Tenant Manager
SystemUtil.Run strBrowser, strURL


'Setting discription
Set Brser = Description.Create
Set Pge = Description.Create
Set LoginDlg = Description.Create
Set PWD = Description.Create
Set LoginBtn = Description.Create
Set WWElementMain = Description.Create
'Setting properties


Brser("name").value = "ConnectionPoint Sign In"
Brser("opentitle").value = "ConnectionPoint Sign In"

Pge("title").value = "ConnectionPoint Sign In"

'WWElementMain("innertext") = "Welcome to ConnectionPoint Sign In!"

LoginDlg("Name").value = "username"
LoginDlg("placeholder").value = "Email"

PWD("Name").value = "password"
PWD("placeholder").value = "password"

LoginBtn("Name").value = "Sign in"
LoginBtn("type").value = "submit"



If Browser(Brser).Page(Pge).WebEdit(LoginDlg).Exist (10) Then
	Browser(Brser).Page(Pge).WebEdit(LoginDlg).Highlight
	'Login to Tenant Manager
    Browser(Brser).Page(Pge).WebEdit(LoginDlg).set "SVC_mars_user_5"
    Browser(Brser).Page(Pge).WebEdit(PWD).SetSecure "5ecfe2bf83e273a002427c58c37dc0ed99056022b491"
    Browser(Brser).Page(Pge).WebButton(LoginBtn).Click
    
    RunAction "Open_ConnectionPoint", oneIteration
Else
	RunAction "Open_ConnectionPoint", oneIteration
End If




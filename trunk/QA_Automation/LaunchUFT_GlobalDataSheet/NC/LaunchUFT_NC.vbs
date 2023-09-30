strFilePath = "C:\UFT\LaunchUFT_GlobalDataSheet\NC\GlobalDataSheet_NC_ContactCenter.xlsx"
strTempFilePath = "C:\Temp\tempFile.xlsx"
strListOfIndexes = ReadExcelFile_LoadStringWithRowsContainsYesValue (strFilePath)

Call ReadExcelFile_DeleteTempFile(strTempFilePath)

ArrayOfValues = Split(strListOfIndexes, ",")
For i = 0 To UBound(ArrayOfValues)
iIndex = ArrayOfValues(i)

' Get data from indexed row
strScriptLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strFilePath, "Script Location", iIndex)
strTestName = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strFilePath, "Test Name", iIndex)
strDataDriverLocation = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strFilePath, "Data Driver Location", iIndex)
strDataDriver = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strFilePath, "Data Driver", iIndex)
strSQL = ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strFilePath, "SQL Location", iIndex)

' Load temp file with information
Set ob = CreateObject("Excel.Application")

'ob.WorkBooks.Open (strTempFilePath)
ob.WorkBooks.Add()
Set sheet = ob.ActiveWorkbook.Worksheets(1)

sheet.Cells(1, 1).Value = "Script Location"
sheet.Cells(1, 2).Value = "Test Name"
sheet.Cells(1, 3).Value = "Data Driver Location"
sheet.Cells(1, 4).Value = "Data Driver"
sheet.Cells(1, 5).Value = "SQL Location"
sheet.Cells(2, 1).Value = strScriptLocation
sheet.Cells(2, 2).Value = strTestName
sheet.Cells(2, 3).Value = strDataDriverLocation
sheet.Cells(2, 4).Value = strDataDriver
sheet.Cells(2, 5).Value = strSQL

ob.ActiveWorkbook.SaveAs(strTempFilePath)
ob.Application.Quit

Set qtApp = CreateObject("QuickTest.Application")
If Not qtApp.Launched then
strScriptPath = strScriptLocation & "\" & strTestName
Call StartUFT(strScriptPath)
end if
set qtTest = qtApp.Test 
Set qtResultsOpt = CreateObject("QuickTest.RunResultsOptions")
'qtResultsOpt.ResultsLocation = "C:\Maximus\Results"
Call RunSettings()
qtTest.Run qtResultsOpt ' Run the test
'qtTest.Run


'MsgBox qtTest.LastRunResults.Status 
Call CloseUFT()
'qtApp.Test.Close
'qtApp.Quit
'Set qtApp = Nothing

Call ReadExcelFile_DeleteTempFile(strTempFilePath)

Next

' Read main driver "GlobalDataSheet" and return list of line numbers with YES (reports to run)
'=========================================================================
Function ReadExcelFile_LoadStringWithRowsContainsYesValue (strFilePath)

Dim value, iSum, iValue, iCount 
Dim lRow, rowcount
Dim fieldvalue
iCount = 0

'Open the spreadsheet document for read-only access.
Set objExcel = CreateObject("Excel.Application")
Set objWorkbook = objExcel.Workbooks.Open(strFilePath)

'Set ws = objWorkbook.Sheets("Items")
Set ws = objExcel.ActiveWorkbook.Worksheets(1)
rowcount = ws.usedrange.rows.count

for j = 1 to rowcount
StrFlagValue = ws.cells(j,1)
If StrFlagValue  = "Y" Then
    iValue = j 
    If iCount = 0 Then
    iSum = iValue
    iCount = iCount + 1
    Else
    iSum = iSum & "," & iValue
    End If
    
End If
next

  Call objExcel.ActiveWorkbook.Close(False)

  ' Quit Excel
  objExcel.Application.Quit
  
  ReadExcelFile_LoadStringWithRowsContainsYesValue = iSum
  
  End Function

' Get cell value by column name and row index
'===================================================================================================
Function ReadExcelFile_GetCellValueByColumnNameAndRowIndex(strFile, strSearchedColumn, iIndex)

  ' Local variable declarations
  Dim objExcel, objSheet, objCells, strColumn, strColumnFlag, strCellValue
  Dim nUsedRows, nUsedCols, nTop, nLeft, nRow, nCol
  Dim arrSheet()

  ' Default return value
  ReadExcelFile_GetCellValueByColumnNameAndRowIndex= Null

  ' Create the Excel object
  On Error Resume Next
  Set objExcel = CreateObject("Excel.Application")
  If (Err.Number <> 0) Then
    Exit Function
  End If

  ' Don't display any alert messages
  objExcel.DisplayAlerts = 0  

  ' Open the document as read-only
  On Error Resume Next
  Call objExcel.Workbooks.Open(strFile, False, True)
  If (Err.Number <> 0) Then
    Exit Function
  End If

  ' If you wanted to read all sheets, you could call
  ' objExcel.Worksheets.Count to get the number of sheets
  ' and the loop through each one. But in this example, we
  ' will just read the first sheet.
  Set objSheet = objExcel.ActiveWorkbook.Worksheets(1)  

  ' Get the number of used columns
  nUsedCols = objSheet.UsedRange.Columns.Count
'Loop through each column to get column index by column name
For nCol = 0 To (nUsedCols - 1)
'
strColumn = objSheet.Cells(1,nCol).value

If strColumn = strSearchedColumn Then
'MsgBox strColumn
Exit For
End If

Next
'

nRow = iIndex

' Get cell value on intersactopn of nRow and nCol
strCellValue = objSheet.Cells(nRow,nCol).value

' Close the workbook without saving
Call objExcel.ActiveWorkbook.Close(False)

' Quit Excel
objExcel.Application.Quit

' Return the sheet data to the caller
ReadExcelFile_GetCellValueByColumnNameAndRowIndex = strCellValue 

End Function

' Delete temp file
'=========================================================
Function ReadExcelFile_DeleteTempFile (strFilePath)
dim filesys
Set filesys = CreateObject("Scripting.FileSystemObject")
If filesys.FileExists(strFilePath) Then
filesys.DeleteFile strFilePath
End  If
End  Function

' Start UFT - load test
'==========================================================
Function StartUFT(strPath)
qtApp.Launch
qtApp.Visible = True
qtApp.Open strPath 'name of the start up script
qtApp.Options.Run.RunMode = "Fast"
qtApp.Options.Run.ViewResults = False
qtApp.WindowState = "Maximize"
 End Function

' Close UFT
'==========================================================
 Function CloseUFT()
qtTest.Close
qtApp.quit
 End Function

'===========================================================
' Run settings
Function RunSettings()
qtApp.Options.Run.ImageCaptureForTestResults = "OnWarning"
qtApp.Options.Run.RunMode = "Normal"
qtApp.Options.Run.ViewResults = False
End Function
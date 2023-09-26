Attribute VB_Name = "GenProjChargeCodeUpdStatements"
Sub GenUpdStatements()

    Dim thisRow As Long
    
    Dim sheet As Worksheet
        
    Set sheet = Sheets(1)
    
    For thisRow = 2 To 100000
    
        If Len(sheet.Cells(thisRow, 1)) <> 0 Then
                
            sheet.Cells(thisRow, 5).Value = "UPDATE D_PI_PROJECTS SET projectchargecode = '" & sheet.Cells(thisRow, 3).Value & "', projectchargecodename = '" & sheet.Cells(thisRow, 4).Value & "', update_timestamp = current_timestamp() where projectid = '" & sheet.Cells(thisRow, 1).Value & "';"
            sheet.Cells(thisRow, 6).Value = "UPDATE D_PI_PROJECTS_HOLD SET projectchargecode = '" & sheet.Cells(thisRow, 3).Value & "', projectchargecodename = '" & sheet.Cells(thisRow, 4).Value & "', update_timestamp = current_timestamp() where projectid = '" & sheet.Cells(thisRow, 1).Value & "';"
            
        Else
            Exit For
        End If
        
    Next thisRow

End Sub




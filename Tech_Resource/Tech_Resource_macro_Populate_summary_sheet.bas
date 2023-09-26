Attribute VB_Name = "Module1"
Sub PopulateSummarySheet()
   Dim I As Integer
   Dim Current As Worksheet
   Dim SText As String
   Dim Col As Integer
   Dim ProjText As String
   Dim SPerson As String
   Dim SDate As String
   Dim IRow As Integer
   Dim ISumCol As Integer
   Dim ISumRow As Integer
   Dim IMaxLen As Integer
   Dim STextLine As String
   Dim NameCol As New Collection
   Dim TextCol As New Collection
   Dim ColorCol As New Collection
   Dim ISheet As Integer
   Dim IPerson As Integer
   Dim SRange As String
   Dim IPersonSum As Integer
   Dim IColor As Integer
   Dim IPersonCount As Integer
   
   
   Application.ScreenUpdating = False
   ISumCol = 1
   ISheet = 0
   IPersonCount = 0
   For Each Current In Worksheets
    
      If Current.Name <> "Holiday PTO" And Current.Name <> "Summary" And Current.Name <> "Template" Then
         ISheet = ISheet + 1
         ' Start each sheet at Row 3
         IRow = 3
         Current.Activate
         'start with first row, column A (person)
         Current.Range("A" & IRow).Activate
         I = 1
         While (ActiveCell.Text <> "" Or (ActiveCell.Interior.ColorIndex = 1 And ActiveCell.Text = ""))
         ' build a collection of all names from all sheets in order
            If ISheet = 1 Then
               NameCol.Add ActiveCell.Text
               TextCol.Add ""
               ColorCol.Add ActiveCell.Interior.ColorIndex
            ElseIf Not ItemExists(NameCol, ActiveCell.Text) Then
              NameCol.Add ActiveCell.Text, After:=I - 1
              ColorCol.Add ActiveCell.Interior.ColorIndex, After:=I - 1
              ' add a condition for a new separator (black) row at the end of the existing resource list
            ElseIf (ActiveCell.Interior.ColorIndex = 1 And ActiveCell.Text = "") And IPersonCount <= I Then
              NameCol.Add ActiveCell.Text, After:=I - 1
              ColorCol.Add ActiveCell.Interior.ColorIndex, After:=I - 1
            End If
               
            I = I + 1
             
            IRow = IRow + 1
            'move to the next person
            Current.Range("A" & IRow).Activate
                        
         Wend ' all people on sheet
         'save the total count
         If I > IPersonCount Then
            IPersonCount = I
         End If
         
      End If ' sheet name check
      
   Next
      
   ' write the name list to the summary sheet
   ISumRow = 1
   For I = 1 To NameCol.Count
      'MsgBox (NameCol(I) & " " & I & " " & ColorCol(I))
      ISumRow = ISumRow + 1 'start at row 2 on the summary
      Worksheets("Summary").Cells(ISumRow, 1).Value = NameCol(I)
      Worksheets("Summary").Cells(ISumRow, 1).Interior.ColorIndex = ColorCol(I)
      SRange = "B" & ISumRow & ":AZ" & ISumRow
      If ColorCol(I) = 1 Then
         Worksheets("Summary").Range(SRange).Interior.ColorIndex = 15
      Else
          Worksheets("Summary").Range(SRange).Interior.ColorIndex = White
      End If
   Next
   
   ' now go back through the worksheets and build the project lists for each name
   ISumRow = 1
   ISumCol = 1
   
   For Each Current In Worksheets
    
      If Current.Name <> "Holiday PTO" And Current.Name <> "Summary" And Current.Name <> "Template" Then
         
         ' Start each sheet at Row 3
         IRow = 3
         Current.Activate
         'start with first row, column A (person)
         Current.Range("A" & IRow).Activate
         
         ' set the summary sheet row back to 1
         ISumRow = 1
         
         SDate = Current.Name
         ' set the date columns on the Summary sheets, starting with B2
         ISumCol = ISumCol + 1
         Worksheets("Summary").Cells(1, ISumCol).Value = SDate
         If ISumCol > 2 Then ' capture the formatting from the prior cell, assuming the first one was formatted and never cleared
            Worksheets("Summary").Cells(1, ISumCol - 1).Copy
            Worksheets("Summary").Cells(1, ISumCol).PasteSpecial Paste:=xlPasteFormats
         End If
        
         IMaxLen = 0
         Set TextCol = New Collection
         Set ColorCol = New Collection
         ' go through all names on this sheet
         ' check for not empty cell (end of column) or empty and black fill (dividers)
         While (ActiveCell.Text <> "" Or (ActiveCell.Interior.ColorIndex = 1 And ActiveCell.Text = ""))
           
            I = 1
           ' For j = 1 To NameCol.Count
             
            If ActiveCell.Text <> "" Then
               SPerson = ActiveCell.Text
               IPerson = GetIndex(NameCol, SPerson)
               Current.Range("C" & IRow).Activate
               SText = ""
               IPersonSum = 0
               
             
               
               Col = ActiveCell.Column
               ' check the project title row 1
               ProjText = Trim(Current.Cells(1, Col).Text)
               While ProjText <> ""
                  
                 ' If Not IsEmpty(ActiveCell) Then
                 If ActiveCell.Text <> "" Then
                 
                 
                     STextLine = Trim(ActiveCell.Text) & " " & ProjText
                     IPersonSum = IPersonSum + (100 * ActiveCell.Value)
                     
                     If Len(STextLine) > IMaxLen Then
                        IMaxLen = Len(STextLine)
                     End If
                     
                     If I = 1 Then
                        SText = STextLine
                     Else
                        SText = SText & vbLf & STextLine
                     End If
                     
                     
                  End If
                  I = I + 1
                  ' move to next column
                  ActiveCell.Offset(0, 1).Activate
                  Col = ActiveCell.Column
                  ProjText = Current.Cells(1, Col).Text
                  
               
               Wend ' all projects for this person
               ' assign the text to the text collection at the correct index
      
               If SText <> "" Then
                  TextCol.Add Item:=SText, key:=CStr(IPerson)
                  Select Case IPersonSum
                     Case Is < 100
                        IColor = 22
                     Case 100
                        IColor = 2
                     Case Else
                        IColor = 6
                  End Select
                  ColorCol.Add Item:=IColor, key:=CStr(IPerson)
               End If
               
            End If ' if the person cell was empty
                
            
            IRow = IRow + 1
            'move to the next person
            Current.Range("A" & IRow).Activate
            
         Wend ' all people loop
         
         
         For x = 1 To NameCol.Count
            
            If ItemExists2(TextCol, CStr(x)) Then
                Worksheets("Summary").Cells(x + 1, ISumCol).Value = Trim(TextCol.Item(CStr(x)))
                Worksheets("Summary").Cells(x + 1, ISumCol).Interior.ColorIndex = ColorCol.Item(CStr(x))
            Else
                Worksheets("Summary").Cells(x + 1, ISumCol).Value = ""
                  ' check if current row, column 1 is black (fill row)
                  ' and set to red otherwise (person has no projects for this week - blank cell)
                If Worksheets("Summary").Cells(x + 1, 1).Interior.ColorIndex <> 1 Then
                   Worksheets("Summary").Cells(x + 1, ISumCol).Interior.ColorIndex = 22
                Else
                   Worksheets("Summary").Cells(x + 1, ISumCol).Interior.ColorIndex = 1 ' black
                End If
            End If
            
         Next
         
        
      End If ' sheet name check
      
   Next ' worksheet
   
   Worksheets("Summary").Columns("A:AR").ColumnWidth = IMaxLen
   
  
   ' finally clear any columns and rows past the last used (if sheets were deleted)
   iLastColumn = Worksheets("Summary").Cells.Find("*", LookIn:=xlFormulas, Searchorder:=xlByColumns, SearchDirection:=xlPrevious).Column
   
   For s = ISumCol + 1 To iLastColumn
      Worksheets("Summary").Columns(s).ClearContents
      Worksheets("Summary").Columns(s).Interior.ColorIndex = 2 ' white
   Next
   
   iLastRow = Worksheets("Summary").Cells.Find("*", LookIn:=xlFormulas, Searchorder:=xlByRows, SearchDirection:=xlPrevious).Row
       
   For y = NameCol.Count + 2 To iLastRow
      Worksheets("Summary").Rows(y).ClearContents
      Worksheets("Summary").Rows(y).Interior.ColorIndex = 2 ' white
   Next
   ' get out of last copied cell
   Application.CutCopyMode = False
   ' locate on the Summary sheet
   With Sheets("Summary")
      .Activate
      .Cells(1, 1).Activate
   End With
   Application.ScreenUpdating = True
   End Sub
   
   Function ItemExists(inCol As Collection, testStr As String) As Boolean
     Dim j As Integer
     
     ItemExists = False
     
     For j = 1 To inCol.Count
        If inCol(j) = testStr Then
           ItemExists = True
        End If
     Next
   End Function
   Function GetIndex(inCol As Collection, testStr As String) As Integer
     Dim j As Integer
     
     GetIndex = 0
     For j = 1 To inCol.Count
        If inCol(j) = testStr Then
           GetIndex = j
        End If
     Next
   End Function
  Function ItemExists2(inCol As Collection, inkey As String) As Boolean
  
     Dim k As String
     
     On Error Resume Next
     k = inCol.Item(inkey)
   
     ItemExists2 = (Err.Number = 0)
     Err.Clear
     
   End Function



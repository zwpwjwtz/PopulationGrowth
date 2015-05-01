VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "family"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Const maxChildren As Integer = 6
Private person As Integer
Private father As Boolean
Private mother As Boolean
Private children() As Boolean
Private lastcome As Integer
Public Function showState()
 Debug.Print "Father:" & father & " Mother: " & mother & " Person: " & person
End Function
Public Function getNumber() As Integer
 getNumber = person
End Function
Public Function getPerson() As group
 Dim temp As New group
 If hasDimed(children) Then
  For i = 1 To children(UBound(children))
   If children(i) = True Then temp.inc True Else temp.inc False
  Next i
 End If
 If father Then temp.inc True
 If mother Then temp.inc False
 Set getPerson = temp
End Function
Public Function bear(isMale As Boolean)
 If Not (father And mother) Then bear = False: Exit Function
 If person >= maxChildren + 2 Then bear = False: Exit Function
 person = person + 1
 ReDim Preserve children(person)
 children(person) = isMale
End Function
Public Function comeout() As group
 If Not hasDimed(children) Then Exit Function
 If UBound(children) <= lastcome Then Exit Function
 Dim temp As New group, i As Integer
 For i = lastcome + 1 To UBound(children)
  If children(i) = True Then temp.inc True Else temp.inc False
 Next i
 lastcome = UBound(children)
 Set comeout = temp
End Function
Public Function dead(isMale As Boolean, isparent As Boolean)
 If isparent Then
  If isMale Then father = False Else mother = False
 Else
  If Not hasDimed(children) Then
   Exit Function
  Else
   person = person - 1
   ReDim Preserve children(person)
  End If
 End If
  dead = (person = 0) And Not father And Not mother
End Function
Private Sub Class_Initialize()
 person = 2
 lastcome = 0
 father = True
 mother = True
End Sub


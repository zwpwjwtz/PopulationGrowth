VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "group"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public male As Long
Public female As Long
Public Function getRatio()
 getRatio = male / female
End Function
Public Function inc(isMale As Boolean)
 If isMale Then male = male + 1 Else female = female + 1
End Function
Public Function dec(isMale As Boolean)
 If isMale Then male = male - 1 Else female = female - 1
End Function

Private Sub Class_Initialize()
 male = 0
 female = 0
End Sub


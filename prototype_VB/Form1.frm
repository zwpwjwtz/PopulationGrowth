VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "人口增长模拟"
   ClientHeight    =   3525
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6870
   LinkTopic       =   "Form1"
   ScaleHeight     =   3525
   ScaleWidth      =   6870
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton Command3 
      Caption         =   "清理结果"
      Height          =   375
      Left            =   3000
      TabIndex        =   19
      Top             =   3000
      Width           =   1335
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   6360
      Top             =   120
   End
   Begin VB.Frame Frame1 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   615
      Left            =   4920
      TabIndex        =   16
      Top             =   2760
      Width           =   1575
      Begin VB.OptionButton optionMustF 
         Caption         =   "有女"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   360
         Width           =   1335
      End
      Begin VB.OptionButton optionMustM 
         Caption         =   "有男"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   0
         Value           =   -1  'True
         Width           =   1335
      End
   End
   Begin VB.OptionButton optionSex 
      Caption         =   "性别要求"
      Height          =   255
      Left            =   4680
      TabIndex        =   15
      Top             =   2400
      Width           =   1575
   End
   Begin VB.TextBox textPressureF 
      Enabled         =   0   'False
      Height          =   270
      Left            =   5280
      TabIndex        =   14
      Text            =   "0"
      Top             =   2040
      Width           =   1095
   End
   Begin VB.TextBox textPressureM 
      Enabled         =   0   'False
      Height          =   270
      Left            =   5280
      TabIndex        =   13
      Text            =   "0"
      Top             =   1680
      Width           =   1095
   End
   Begin VB.OptionButton optionPressure 
      Caption         =   "选择压："
      Height          =   375
      Left            =   4680
      TabIndex        =   10
      Top             =   1200
      Width           =   1215
   End
   Begin VB.OptionButton optionNature 
      Caption         =   "完全自然"
      Height          =   375
      Left            =   4680
      TabIndex        =   9
      Top             =   720
      Value           =   -1  'True
      Width           =   1815
   End
   Begin VB.CommandButton Command2 
      Caption         =   "停止模拟"
      Height          =   375
      Left            =   1560
      TabIndex        =   5
      Top             =   3000
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "开始模拟"
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   3000
      Width           =   1335
   End
   Begin VB.TextBox textStart 
      Height          =   390
      Left            =   2280
      TabIndex        =   2
      Text            =   "100"
      Top             =   960
      Width           =   2055
   End
   Begin VB.TextBox textRatio 
      Height          =   375
      Left            =   2280
      TabIndex        =   1
      Text            =   "1"
      Top             =   480
      Width           =   2055
   End
   Begin VB.Label Label3 
      Caption         =   "家庭数："
      Height          =   255
      Left            =   360
      TabIndex        =   20
      Top             =   2400
      Width           =   3735
   End
   Begin VB.Label Label7 
      Caption         =   "女："
      Height          =   255
      Left            =   4800
      TabIndex        =   12
      Top             =   2040
      Width           =   615
   End
   Begin VB.Label Label6 
      Caption         =   "男："
      Height          =   255
      Left            =   4800
      TabIndex        =   11
      Top             =   1680
      Width           =   615
   End
   Begin VB.Label Label5 
      Caption         =   "选项："
      Height          =   255
      Left            =   4560
      TabIndex        =   8
      Top             =   240
      Width           =   1335
   End
   Begin VB.Line Line1 
      X1              =   4440
      X2              =   4440
      Y1              =   0
      Y2              =   3480
   End
   Begin VB.Label labelState 
      Caption         =   "实时人数："
      Height          =   255
      Left            =   360
      TabIndex        =   7
      Top             =   1680
      Width           =   3615
   End
   Begin VB.Label labelGeneration 
      Caption         =   "代数："
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   2040
      Width           =   3735
   End
   Begin VB.Label Label2 
      Caption         =   "起始人数："
      Height          =   255
      Left            =   1080
      TabIndex        =   3
      Top             =   1080
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "起始比例：（男：女）"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   1935
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private families() As family
Private freePerson As group
Private familyNum As Long
Const natureMarriage = 0.9 '一代中结婚的概率
Const natureBirth = 0.2 '一代中出生的概率
Const natureBirthPerson = 6 '一代中出生的最大人数
Const natureDeath = 0.7 '一代中死亡的概率
Const natureManDeath = 0.5 '一代中死亡的人为男性的概率
Const natureParentsDeath = 0.4 '一代中父母死亡的概率
Private break As Boolean
Private generation As Long
Private Sub Command1_Click()
 Set freePerson = New group
 freePerson.male = Int(Val(textStart) * Val(textRatio) / Val(textRatio + 1))
 freePerson.female = Int(Val(textStart) * 1 / Val(textRatio) / Val(textRatio + 1))
 break = False
 Timer1.Enabled = True
End Sub
Function nGrow()
 Static i As Long, j As Long, temp As group
 Randomize Timer
  
  If freePerson.male And freePerson.female Then
   For i = 1 To freePerson.male
    If Rnd > natureMarriage Then '有机会选择配偶
     If freePerson.female Then '找到配偶
      familyNum = familyNum + 1
      ReDim Preserve families(familyNum)
      Set families(familyNum) = New family
      freePerson.dec True
      freePerson.dec False
     End If
    End If
   Next i
  End If
   '成家
   
  For i = 1 To UBound(families)
   If Rnd < natureBirth Then
    For j = 1 To Int(Rnd * natureBirthPerson)
     If Rnd > 0.5 Then families(i).bear True Else families(i).bear False
    Next j
   End If
  Next i
  '出生
  
  For i = 1 To UBound(families)
   Set temp = families(i).comeout
   If Not temp Is Nothing Then
    freePerson.male = freePerson.male + temp.male
    freePerson.female = freePerson.female + temp.female
   End If
  Next i
  '长大
  
  For i = 1 To UBound(families)
   For j = 1 To Int(Rnd * families(i).getNumber + 1)
    If Rnd < natureDeath Then
     If families(i).dead(Rnd > natureManDeath, Rnd > natureParentsDeath) Then remove families, i
    End If
   Next j
  Next i
  '死亡
  
  generation = generation + 1
  refreshState
End Function
Function pGrow()

End Function
Function sGrow()

End Function
Sub refreshState()
 Dim i As Long, temp As group, male As Long, female As Long
 male = 0: female = 0
 For i = 1 To UBound(families)
  Set temp = families(i).getPerson
  If Not (temp Is Nothing) Then
   male = male + temp.male
   female = female + temp.female
  End If
 Next i
 labelState.Caption = "实时人数: 男：" & male & " 女：" & female
 labelGeneration.Caption = "代数：" & generation
 Label3.Caption = "家庭数：" & UBound(families)
 DoEvents
End Sub

Private Sub Command2_Click()
 break = True
End Sub

Private Sub Command3_Click()
 generation = 0
 familyNum = 0
 Set freePerson = Nothing
 Set families = Nothing
 labelState.Caption = ""
End Sub

Private Sub optionNature_Click()
 refreshSelect
End Sub

Private Sub optionPressure_Click()
 refreshSelect
End Sub

Private Sub optionSex_Click()
 refreshSelect
End Sub

Private Sub textRatio_Change()
 If Val(textRatio.Text) <= 0 Then showerr "性别比不能小于0！", textRatio
End Sub
Private Sub showerr(str As String, Optional obj As Object)
 MsgBox str, vbOKOnly, "错误"
 If Not (obj Is Nothing) Then obj.SetFocus
End Sub

Private Sub textStart_Change()
 If Val(textStart) < 2 Then showerr "起始人数不能小于2人！", textStart
End Sub
Private Sub refreshSelect()
 optionMustM.Enabled = optionSex.Value
 optionMustF.Enabled = optionSex.Value
 textPressureM.Enabled = optionPressure.Value
 textPressureF.Enabled = optionPressure.Value
End Sub

Private Sub Timer1_Timer()
 If optionNature Then
  nGrow
 ElseIf optionPressure Then
  pGrow
 Else
  sGrow
 End If
 If break Then Timer1.Enabled = False: break = False
End Sub

VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "�˿�����ģ��"
   ClientHeight    =   3525
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6870
   LinkTopic       =   "Form1"
   ScaleHeight     =   3525
   ScaleWidth      =   6870
   StartUpPosition =   3  '����ȱʡ
   Begin VB.CommandButton Command3 
      Caption         =   "������"
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
         Caption         =   "��Ů"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   360
         Width           =   1335
      End
      Begin VB.OptionButton optionMustM 
         Caption         =   "����"
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
      Caption         =   "�Ա�Ҫ��"
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
      Caption         =   "ѡ��ѹ��"
      Height          =   375
      Left            =   4680
      TabIndex        =   10
      Top             =   1200
      Width           =   1215
   End
   Begin VB.OptionButton optionNature 
      Caption         =   "��ȫ��Ȼ"
      Height          =   375
      Left            =   4680
      TabIndex        =   9
      Top             =   720
      Value           =   -1  'True
      Width           =   1815
   End
   Begin VB.CommandButton Command2 
      Caption         =   "ֹͣģ��"
      Height          =   375
      Left            =   1560
      TabIndex        =   5
      Top             =   3000
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "��ʼģ��"
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
      Caption         =   "��ͥ����"
      Height          =   255
      Left            =   360
      TabIndex        =   20
      Top             =   2400
      Width           =   3735
   End
   Begin VB.Label Label7 
      Caption         =   "Ů��"
      Height          =   255
      Left            =   4800
      TabIndex        =   12
      Top             =   2040
      Width           =   615
   End
   Begin VB.Label Label6 
      Caption         =   "�У�"
      Height          =   255
      Left            =   4800
      TabIndex        =   11
      Top             =   1680
      Width           =   615
   End
   Begin VB.Label Label5 
      Caption         =   "ѡ�"
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
      Caption         =   "ʵʱ������"
      Height          =   255
      Left            =   360
      TabIndex        =   7
      Top             =   1680
      Width           =   3615
   End
   Begin VB.Label labelGeneration 
      Caption         =   "������"
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   2040
      Width           =   3735
   End
   Begin VB.Label Label2 
      Caption         =   "��ʼ������"
      Height          =   255
      Left            =   1080
      TabIndex        =   3
      Top             =   1080
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "��ʼ���������У�Ů��"
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
Const natureMarriage = 0.9 'һ���н��ĸ���
Const natureBirth = 0.2 'һ���г����ĸ���
Const natureBirthPerson = 6 'һ���г������������
Const natureDeath = 0.7 'һ���������ĸ���
Const natureManDeath = 0.5 'һ������������Ϊ���Եĸ���
Const natureParentsDeath = 0.4 'һ���и�ĸ�����ĸ���
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
    If Rnd > natureMarriage Then '�л���ѡ����ż
     If freePerson.female Then '�ҵ���ż
      familyNum = familyNum + 1
      ReDim Preserve families(familyNum)
      Set families(familyNum) = New family
      freePerson.dec True
      freePerson.dec False
     End If
    End If
   Next i
  End If
   '�ɼ�
   
  For i = 1 To UBound(families)
   If Rnd < natureBirth Then
    For j = 1 To Int(Rnd * natureBirthPerson)
     If Rnd > 0.5 Then families(i).bear True Else families(i).bear False
    Next j
   End If
  Next i
  '����
  
  For i = 1 To UBound(families)
   Set temp = families(i).comeout
   If Not temp Is Nothing Then
    freePerson.male = freePerson.male + temp.male
    freePerson.female = freePerson.female + temp.female
   End If
  Next i
  '����
  
  For i = 1 To UBound(families)
   For j = 1 To Int(Rnd * families(i).getNumber + 1)
    If Rnd < natureDeath Then
     If families(i).dead(Rnd > natureManDeath, Rnd > natureParentsDeath) Then remove families, i
    End If
   Next j
  Next i
  '����
  
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
 labelState.Caption = "ʵʱ����: �У�" & male & " Ů��" & female
 labelGeneration.Caption = "������" & generation
 Label3.Caption = "��ͥ����" & UBound(families)
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
 If Val(textRatio.Text) <= 0 Then showerr "�Ա�Ȳ���С��0��", textRatio
End Sub
Private Sub showerr(str As String, Optional obj As Object)
 MsgBox str, vbOKOnly, "����"
 If Not (obj Is Nothing) Then obj.SetFocus
End Sub

Private Sub textStart_Change()
 If Val(textStart) < 2 Then showerr "��ʼ��������С��2�ˣ�", textStart
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

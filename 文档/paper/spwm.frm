VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text3 
      Height          =   615
      Left            =   2160
      TabIndex        =   3
      Text            =   " "
      Top             =   2160
      Width           =   2415
   End
   Begin VB.TextBox Text1 
      Height          =   615
      Left            =   720
      TabIndex        =   2
      Text            =   " "
      Top             =   1800
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   615
      Left            =   2400
      TabIndex        =   1
      Text            =   " "
      Top             =   1320
      Width           =   2175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   615
      Left            =   840
      TabIndex        =   0
      Top             =   720
      Width           =   1335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim m, n, a, c, f, g, h, j As Double
Dim b, d As Single
Open "d:\ddd\paper\spwmval.txt" For Output As #1
For m = 1.2 To 30 Step 2.4
n = (180 - 2.4) / 2 - 60 - m


a = (n / 180) * 3.1415926


b = Sin(a) * 0.04836586578028
c = ((60 - n) / 180) * 3.1415926
d = Sin(c) * 0.04836586578028

f = Int((113.3333 / 0.048364447) * (b + d) * 1000) / 1000
g = Int((113.3333 / 0.048364447) * b * 1000) / 1000
h = Int((113.3333 / 0.048364447) * d * 1000) / 1000

j = 133.3333333 - f
Write #1, f, g, h, j ' 写入以逗号隔开的数据。
Next m
Close #1

Text1.Text = "OK"
End Sub
 

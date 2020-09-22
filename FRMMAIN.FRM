VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "System Monitor 2k"
   ClientHeight    =   4665
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8190
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4665
   ScaleWidth      =   8190
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrRefresh 
      Interval        =   1000
      Left            =   5760
      Top             =   2940
   End
   Begin MSComctlLib.ListView lstItems 
      Height          =   3735
      Left            =   2100
      TabIndex        =   1
      Top             =   60
      Width           =   6015
      _ExtentX        =   10610
      _ExtentY        =   6588
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   3
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Name"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "Description"
         Object.Width           =   6526
      EndProperty
      BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   2
         Text            =   "Value"
         Object.Width           =   1411
      EndProperty
   End
   Begin VB.ListBox lstCategory 
      Height          =   3765
      Left            =   60
      TabIndex        =   0
      Top             =   60
      Width           =   1935
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "System Monitor 2k"
      BeginProperty Font 
         Name            =   "Arial Black"
         Size            =   27.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   2400
      TabIndex        =   2
      Top             =   3840
      Width           =   5685
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private SysMon As New SysMon

Private Sub Form_Load()
  'initialize the listbox
  Dim i As Long
  
  For i = 1 To SysMon.Categories.Count
    lstCategory.AddItem SysMon.Categories(i).CatName
  Next
  lstCategory.ListIndex = 0
End Sub

Private Sub CatChange()
  'refresh the list with the category selected in the listbox
  Dim Category As Category
  Dim i As Long
  lstItems.ListItems.Clear
  Set Category = SysMon.Categories(lstCategory.ListIndex + 1)
  For i = 1 To Category.Count
    With lstItems.ListItems.Add(, , Category(i).ItemName)
      .ListSubItems.Add , , Category(i).Description
      .ListSubItems.Add , , Category(i).Value
    End With
  Next i
End Sub

Private Sub lstCategory_Click()
  'change the listbox with the category you select
  CatChange
End Sub

Private Sub tmrRefresh_Timer()
  'refresh the list
  Dim Category As Category
  Dim i As Long
  Set Category = SysMon.Categories(lstCategory.ListIndex + 1)
  For i = 1 To Category.Count
    With lstItems.ListItems(i)
      .ListSubItems(2).Text = Category(i).Value
    End With
  Next
End Sub

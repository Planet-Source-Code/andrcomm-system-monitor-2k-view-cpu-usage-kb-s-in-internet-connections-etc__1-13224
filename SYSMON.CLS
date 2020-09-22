VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SysMon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"Categories"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
'local variable(s) to hold property value(s)
Private mvarCategories As New Categories  'local copy

Public Sub Refresh()
  Dim lCount As Long
  Dim sEnumCat() As String
  Dim sEnumItm() As String
  Dim sCateg As Variant
  Dim sCatName As String
  Dim sItem As Variant
  Dim sItemName As String
  Dim sItemDesc As String
  Dim bItemDif As Boolean
  Dim objCateg As Category
  
  mvarCategories.Clear

  With CReg
    .ClassKey = HKEY_LOCAL_MACHINE
    .SectionKey = PerfStats
    .EnumerateSections sEnumCat, lCount
    For Each sCateg In sEnumCat
      .SectionKey = PerfStats & "\" & sCateg
      .ValueKey = "Name"
      sCatName = .Value
      .EnumerateSections sEnumItm, lCount
      Set objCateg = mvarCategories.Add(sCatName, CStr(sCateg))
      For Each sItem In sEnumItm
        .SectionKey = PerfStats & "\" & sCateg & "\" & sItem
        .ValueKey = "Name"
        sItemName = .Value
        .ValueKey = "Description"
        sItemDesc = .Value
        .ValueKey = "Differentiate"
        bItemDif = CBool(.Value)
        objCateg.Add sItemName, bItemDif, sItemDesc, sCateg & "\" & sItem, CStr(sItem)
      Next
    Next
  End With
        
End Sub

Public Property Set Categories(ByVal vData As Categories)
'used when assigning an Object to the property, on the left side of a Set statement.
'Syntax: Set x.Categories = Form1
    Set mvarCategories = vData
End Property


Public Property Get Categories() As Categories
Attribute Categories.VB_UserMemId = 0
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Categories
    Set Categories = mvarCategories
End Property

Private Sub Class_Initialize()
  Refresh
End Sub

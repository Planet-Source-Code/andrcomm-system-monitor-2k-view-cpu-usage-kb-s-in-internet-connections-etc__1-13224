VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Item"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
'local variable(s) to hold property value(s)
Private mvarItemName As String 'local copy
Private mvarDifferentiate As Boolean 'local copy
Private mvarDescription As String 'local copy
Private mvarValue As Long 'local copy
Private mvarValueKey As String 'local copy

Private LastValue As Long
Private bLVInitialized As Boolean 'was LastValue initialized?

Friend Property Let ValueKey(ByVal vData As String)
  mvarValueKey = vData
End Property

Friend Property Get ValueKey() As String
  ValueKey = mvarValueKey
End Property


Friend Property Let Value(ByVal vData As Long)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Value = 5
    'not used
End Property


Public Property Get Value() As Long
Attribute Value.VB_UserMemId = 0
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Value
  Dim lValue As Long
  
  CReg.ClassKey = HKEY_DYN_DATA
  CReg.SectionKey = StatData
  CReg.ValueKey = ValueKey
  CReg.ValueType = REG_DWORD_LITTLE_ENDIAN
  CReg.ExplicitType = True
  
  lValue = CReg.Value
  If mvarDifferentiate = True Then
    If Not bLVInitialized Then LastValue = lValue: bLVInitialized = True
    Value = lValue - LastValue
    LastValue = lValue
  Else
    bLVInitialized = False
    Value = lValue
  End If
  
  CReg.ExplicitType = False
End Property



Friend Property Let Description(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Description = 5
    mvarDescription = vData
End Property


Public Property Get Description() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Description
    Description = mvarDescription
End Property



Public Property Let Differentiate(ByVal vData As Boolean)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Differentiate = 5
    mvarDifferentiate = vData
End Property


Public Property Get Differentiate() As Boolean
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Differentiate
    Differentiate = mvarDifferentiate
End Property



Friend Property Let ItemName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ItemName = 5
    mvarItemName = vData
End Property


Public Property Get ItemName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ItemName
    ItemName = mvarItemName
End Property




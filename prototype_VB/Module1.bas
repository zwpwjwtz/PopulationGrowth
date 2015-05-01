Attribute VB_Name = "Module1"
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function SafeArrayGetDim Lib "oleaut32.dll" (ByRef psa() As Any) As Long
Public Function hasDimed(ByRef arr() As Boolean) As Boolean
 'Static temp As String
 'temp = Join(arr, " ")
 'hasDimed = Len(temp) > 0
 hasDimed = SafeArrayGetDim(arr) <> 0
End Function
Public Function remove(ByRef arr() As family, id As Long)
 CopyMemory arr(id), VarPtr(arr(id + 1)), UBound(arr) - id
 ReDim Preserve arr(UBound(arr) - 1)
End Function


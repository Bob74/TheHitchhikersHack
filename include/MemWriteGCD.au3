
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Func _MemoryWriteGCD($iv_Address, $ah_Handle, $sv_Type, $subj)
	If Not IsArray($ah_Handle) Then
		SetError(1)
		Return 0
	EndIf
	Local $v_buffer = DllStructCreate($sv_Type)
	If @error Then
		SetError(@error + 1)
		Return 0
	EndIf
	DllStructSetData($v_buffer, 1, $subj)
	DllCall($ah_Handle[0], "int", "WriteProcessMemory", "int", $ah_Handle[1], "int", $iv_Address, "ptr", DllStructGetPtr($v_buffer), "int", DllStructGetSize($v_buffer), "int", "")
	If Not @error Then
		Return -1
	Else
		SetError(6)
		Return 0
	EndIf
EndFunc



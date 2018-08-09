

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;; FONCTIONS DE LA TELEPORT LIST ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;Fonction settpname(): Lit le nom de la Map et de la zone Minimap et les écrit dans le nom du Add TP
Func settpname()
$MapNamePath = _MEMORYREAD($MapName,$WowProcess, "char[30]")
$MapName1 = StringReplace($MapNamePath, "World\Maps\", "")
$MapName2 = StringReplace($MapName1, "Expansion01", "Outreterre")
$MapNameFinal = StringReplace($MapName2, "Northrend", "Norfendre")
$ZoneNameAdr = _MemoryRead($MiniMapName+0,$WowProcess, "ptr")
$ZoneName = _MemoryRead($ZoneNameAdr,$WowProcess, "char[30]")
$ZoneNameAccAi = StringReplace($ZoneName, "Ã©", "é")
$ZoneNameAccGr = StringReplace($ZoneNameAccAi, "Ã¨", "è")
$ZoneNameAccCi1 = StringReplace($ZoneNameAccGr, "ÃŽ", "Î")
$ZoneNameAccCi2 = StringReplace($ZoneNameAccCi1, "Ãª", "ê")
$ZoneNameAccCi3 = StringReplace($ZoneNameAccCi2, "Ã´", "ô")
$ZoneNameAccCi4 = StringReplace($ZoneNameAccCi3, "Ã¢", "â")
$ZoneNameAccAi2 = StringReplace($ZoneNameAccCi4, "Ã‰", "é")
$ZoneNameOe = StringReplace($ZoneNameAccAi2, "Å“", "oe")
$ZoneNameApp = StringReplace($ZoneNameOe, "â€™", "'")
$ZoneNameCed = StringReplace($ZoneNameApp, "Ã§", "ç")
GUICtrlSetData($AddTPNameInput,$MapNameFinal&": "&$ZoneNameCed)
EndFunc

;Fonction createlist(): Créé la liste de TP au lancement du programme
Func createlist()
$Number = 0
Global $Liste = @ScriptDir&"\thhh_TPlist.ini"
$line = 1
$CountLines = _FileCountLines($liste)
$CountLinesTotal = ($CountLines-6)
for $line = 1 to $CountLinesTotal Step 8
$Number = $Number+1
$file = FileReadLine($Liste,$line)
$delcaract1 = StringReplace($file, "[", "")
$delcaract2 = StringReplace($delcaract1, "]", "")
$Nom1 = FileReadLine($Liste,$line)
$delcaractN1 = StringReplace($Nom1, "[", "")
$Nom = StringReplace($delcaractN1, "]", "")
$Map = iniRead($Liste, $delcaract2, "MapID:", "")
$X = iniRead($Liste, $delcaract2, "XPos:", "")
$Y = iniRead($Liste, $delcaract2, "YPos:", "")
$Z = iniRead($Liste, $delcaract2, "ZPos:", "")
$Comment = iniRead($Liste, $delcaract2, "Comment:", "")
GUICtrlCreateListViewItem($Number&"|"&$Nom&"|"&$Map&"|"&$X&"|"&$Y&"|"&$Z&"|"&$Comment,$Previewlist)
Next
EndFunc

;Fonction getTP(): Cherche la destination correspondant à l'élément sélectionné puis Téléporte via goDesTP()
Func getTP()
$Selected = _GUICtrlListView_GetSelectedIndices(GUICtrlGetHandle($Previewlist))
$destination = ($Selected*8)+1
$filedes = FileReadLine($Liste,$destination)
$delcaractdes1 = StringReplace($filedes, "[", "")
$delcaractdes2 = StringReplace($delcaractdes1, "]", "")
Global $Mapdes = iniRead($Liste, $delcaractdes2, "MapID:", "")
Global $Xdes = iniRead($Liste, $delcaractdes2, "XPos:", "")
Global $Ydes = iniRead($Liste, $delcaractdes2, "YPos:", "")
Global $Zdes = iniRead($Liste, $delcaractdes2, "ZPos:", "")

If _MEMORYREAD($MapID,$WowProcess) = 4294967295 or _MEMORYREAD($MapID,$WowProcess) = $Mapdes Then
goDesTP()
ElseIf $Mapdes = 530 Then
	If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
		MsgBox(0,"","Vous devez être en Outreterre pour vous téléporter ici")
	Else
		MsgBox(0,"","You must be on Outland to teleport there")
	EndIf
ElseIf $Mapdes = 571 Then
	If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
		MsgBox(0,"","Vous devez être en Norfendre pour vous téléporter ici")
	Else
		MsgBox(0,"","You must be on Norfendre to teleport there")
	EndIf
ElseIf $Mapdes = 0 Then
	If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
		MsgBox(0,"","Vous devez être aux Royaumes de l'Est pour vous téléporter ici")
	Else
		MsgBox(0,"","You must be on Eastern Kingdom to teleport there")
	EndIf
ElseIf $Mapdes = 1 Then
	If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
		MsgBox(0,"","Vous devez être en Kalimdor pour vous téléporter ici")
	Else
		MsgBox(0,"","You must be on Kalimdor to teleport there")
	EndIf
ElseIf $Mapdes = 4294967295 Then
goDesTP()
ElseIf _MEMORYREAD($MapID,$WowProcess) not = $Mapdes Then
	If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
		$MsgboxTpMap = MsgBox(4,"","Vous n'êtes pas sur la bonne carte pour vous téléporter."&@CRLF&" "&@CRLF&"Téléporter quand même ?")
	Else
		$MsgboxTpMap = MsgBox(4,"","You are on the wrong Map."&@CRLF&" "&@CRLF&"Do you really want to teleport ?")
	EndIf
	If $MsgboxTpMap = 6 Then
		goDesTP()
	ElseIf $MsgboxTpMap = 7 Then
	EndIf
EndIf
EndFunc

func goDesTP()
If GUICtrlRead($WEHcheckbox)=$GUI_CHECKED Then ;;; Liste WEH ON
If $Xdes="" and $Ydes="" and $Zdes="" Then
Else
_MemoryWrite($PlayerBase+$PosX,$WowProcess,$Ydes,'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,$Xdes,'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,$Zdes,'float')
EndIf
ElseIf GUICtrlRead($WEHcheckbox)=$GUI_UNCHECKED Then ;;; Liste WEH OFF
If $Xdes="" and $Ydes="" and $Zdes="" Then
Else
_MemoryWrite($PlayerBase+$PosX,$WowProcess,$Xdes,'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,$Ydes,'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,$Zdes,'float')
EndIf
EndIf
EndFunc


;Fonction addtp(): Si le TP à un nom, il écrit une nouvelle destination dans l'INI et recharge la liste en supprimant ce qui est affiché et relançant createlist()
func addtp()
If GUICtrlRead($AddTPNameInput) = "" Then
	MsgBox(0,"Erreur", "Vous devez indiquer un nom pour votre TP")
Else
FileWriteLine ($liste, "["&GUICtrlRead($AddTPNameInput)&"]")
FileWriteLine ($liste, "Type:=")
FileWriteLine ($liste, "MapID:="&_MEMORYREAD($MapID,$WowProcess,"dword"))
FileWriteLine ($liste, "XPos:="&(Round(_MEMORYREAD($PlayerBase+$PosX,$WowProcess,"float"), 3)))
FileWriteLine ($liste, "YPos:="&(Round(_MEMORYREAD($PlayerBase+$PosY,$WowProcess,"float"), 3)))
FileWriteLine ($liste, "ZPos:="&(Round(_MEMORYREAD($PlayerBase+$PosZ,$WowProcess,"float"), 3)))
FileWriteLine ($liste, "Comment:=Destination ajoutée manuellement")
FileWriteLine ($liste, "")
GUICtrlSetData($AddTPNameInput,"")
_GUICtrlListView_DeleteAllItems($Previewlist)
createlist()
EndIf
EndFunc

func deltp()
$DelLine = 0
If GUICtrlRead($DelTPInput) = "" Then
	MsgBox(0,"Erreur", "Vous devez indiquer le n° du TP à supprimer (Colonne de gauche)")
Else
For $DelLine = 0 to ((GUICtrlRead($DelTPInput)*8)-8)
Next
GUICtrlSetData($DelTPInput,"")
_FileWriteToLine($liste,$DelLine,"",1)
_FileWriteToLine($liste,$DelLine,"",1)
_FileWriteToLine($liste,$DelLine,"",1)
_FileWriteToLine($liste,$DelLine,"",1)
_FileWriteToLine($liste,$DelLine,"",1)
_FileWriteToLine($liste,$DelLine,"",1)
_FileWriteToLine($liste,$DelLine,"",1)
_FileWriteToLine($liste,$DelLine,"",1)
_GUICtrlListView_DeleteAllItems($Previewlist)
createlist()
EndIf
EndFunc
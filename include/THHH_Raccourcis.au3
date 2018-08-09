
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; RACCOURCIS - SERVEUR OFFICIELS ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; ON ECRIT LE RACCOURCIS DANS L'EDIT CORRESPONDANT ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func SCsettings()
If ControlGetFocus("Raccourcis Officiel") = "Edit1" Then
refreshSCtext("Wallclimb", $SettingInputWallclimb)
ElseIf ControlGetFocus("Raccourcis Officiel") = "Edit2" Then
refreshSCtext("Supersaut", $SettingInputSupersaut)
ElseIf ControlGetFocus("Raccourcis Officiel") = "Edit3" Then
refreshSCtext("Noclipaction", $SettingInputNoclipAction)
EndIf
Global $SCIniEmpl="Raccourcis - Officiel"
writekeypress()
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; RACCOURCIS - SERVEUR PRIVES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; ON ECRIT LE RACCOURCIS DANS L'EDIT CORRESPONDANT ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func PriveSCsettings()
$EjectInput=0   ;Variable qui sert a faire dégager les inputs qui ne sont pas listés (ceux qui continnent les vitesses, etc et qui n'ont pas de raccourcis)
Global $SCIniEmpl="Raccourcis - Prive"
If ControlGetFocus("Raccourcis Privé") = "Edit1" Then
refreshSCtext("Flymod", $PriveSettingInputFlymod)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit2" Then
refreshSCtext("Speedglobale", $PriveSettingInputSpeedglobale)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit3" Then
refreshSCtext("Speed", $PriveSettingInputSpeed)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit4" Then
refreshSCtext("Wallclimb", $PriveSettingInputWallclimb)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit5" Then
refreshSCtext("Supersaut", $PriveSettingInputSupersaut)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit6" Then
refreshSCtext("Debloperso", $PriveSettingInputDebloperso)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit7" Then
refreshSCtext("Clicktp", $PriveSettingInputClicktp)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit8" Then
refreshSCtext("Gocorps", $PriveSettingInputGocorps)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit9" Then
refreshSCtext("Stopfall", $PriveSettingInputStopfall)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit10" Then
refreshSCtext("Tpcibledos", $PriveSettingInputTpcibledos)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit11" Then
refreshSCtext("Tpcibleundermap", $PriveSettingInputTpcibleundermap)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit12" Then
refreshSCtext("FreezeZ", $PriveSettingInputFreezeZ)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit13" Then
refreshSCtext("SpeedN", $PriveSettingInputSpeedN)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit14" Then
refreshSCtext("Speed100", $PriveSettingInputSpeed100)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit15" Then
refreshSCtext("Speedcustom", $PriveSettingInputSpeedcustom)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit17" Then
refreshSCtext("SpeedP", $PriveSettingInputSpeedP)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit18" Then
refreshSCtext("SpeedM", $PriveSettingInputSpeedM)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit20" Then
refreshSCtext("SpeedFlyN", $PriveSettingInputSpeedFlyN)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit21" Then
refreshSCtext("SpeedFly280", $PriveSettingInputSpeedFly280)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit22" Then
refreshSCtext("SpeedFlycustom", $PriveSettingInputSpeedFlycustom)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit24" Then
refreshSCtext("SpeedFlyP", $PriveSettingInputSpeedFlyP)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit25" Then
refreshSCtext("SpeedFlyM", $PriveSettingInputSpeedFlyM)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit27" Then
refreshSCtext("SupersautP", $PriveSettingInputSupersautP)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit28" Then
refreshSCtext("SupersautM", $PriveSettingInputSupersautM)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit30" Then
refreshSCtext("TimeSpeedP", $PriveSettingInputTimeSpeedP)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit31" Then
refreshSCtext("TimeSpeedM", $PriveSettingInputTimeSpeedM)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit33" Then
refreshSCtext("TailleP", $PriveSettingInputTailleP)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit34" Then
refreshSCtext("TailleM", $PriveSettingInputTailleM)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit36" Then
refreshSCtext("FlagA2", $PriveSettingInputGouletFlagA2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit37" Then
refreshSCtext("RegenA2", $PriveSettingInputGouletRegenA2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit38" Then
refreshSCtext("BersekerA2", $PriveSettingInputGouletBersekerA2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit39" Then
refreshSCtext("SprintA2", $PriveSettingInputGouletSprintA2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit40" Then
refreshSCtext("FlagH2", $PriveSettingInputGouletFlagH2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit41" Then
refreshSCtext("RegenH2", $PriveSettingInputGouletRegenH2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit42" Then
refreshSCtext("BersekerH2", $PriveSettingInputGouletBersekerH2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit43" Then
refreshSCtext("SprintH2", $PriveSettingInputGouletSprintH2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit44" Then
refreshSCtext("Ecurie", $PriveSettingInputArathiEcurie)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit45" Then
refreshSCtext("Ferme", $PriveSettingInputArathiFerme)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit46" Then
refreshSCtext("Mine", $PriveSettingInputArathiMine)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit47" Then
refreshSCtext("Forge", $PriveSettingInputArathiForge)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit48" Then
refreshSCtext("Scierie", $PriveSettingInputArathiScierie)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit49" Then
refreshSCtext("OeilDrapeau", $PriveSettingInputOeilDrapeau)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit50" Then
refreshSCtext("TourMages", $PriveSettingInputOeilTourMages)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit51" Then
refreshSCtext("RuinesDraenei", $PriveSettingInputOeilRuinesDraenei)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit52" Then
refreshSCtext("TourElfes", $PriveSettingInputOeilTourElfes)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit53" Then
refreshSCtext("RuinesSaccageur", $PriveSettingInputOeilRuinesSaccageur)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit54" Then
refreshSCtext("A2", $PriveSettingInputAlteracA2)
ElseIf ControlGetFocus("Raccourcis Privé") = "Edit55" Then
refreshSCtext("H2", $PriveSettingInputAlteracH2)
Else
$EjectInput=1
EndIf
If $EjectInput=1 Then
Else
writekeypress()
EndIf
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; RAJOUT DES COMBINAISONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func writekeypress()
If _IsPressed(10, $dll) Then ; Si on appuis sur SHIFT, on lance la detection de la 2eme touche avec GetKeyPressed()
							 ; et on enlève les touches qui ne supportent pas les combinaisons
getkeypressed()
	If $Keypressed = "+" or $Keypressed="F12" or $Keypressed="F11" or $Keypressed="F10" or $Keypressed="F9" or $Keypressed="F8" or $Keypressed="F7" or $Keypressed="F6" or $Keypressed="F5" or $Keypressed="F4" or $Keypressed="F3" or $Keypressed="F2" or $Keypressed="F1" Then
	ElseIf $Keypressed = "" Then
		IniWrite($Setting, $SCIniEmpl, $SCFonctionName,"")
	Else
		IniWrite($Setting, $SCIniEmpl, $SCFonctionName,'"+'&$Keypressed&'"')
	EndIf
ElseIf _IsPressed(11, $dll) Then
getkeypressed()
	If $Keypressed="^" or $Keypressed="F12" or $Keypressed="F11" or $Keypressed="F10" or $Keypressed="F9" or $Keypressed="F8" or $Keypressed="F7" or $Keypressed="F6" or $Keypressed="F5" or $Keypressed="F4" or $Keypressed="F3" or $Keypressed="F2" or $Keypressed="F1" Then
	ElseIf $Keypressed = "" Then
		IniWrite($Setting, $SCIniEmpl, $SCFonctionName,"")
	Else
		IniWrite($Setting, $SCIniEmpl, $SCFonctionName,'"^'&$Keypressed&'"')
	EndIf
ElseIf _IsPressed(12, $dll) Then
getkeypressed()
	If $Keypressed="!" or $Keypressed="F12" or $Keypressed="F11" or $Keypressed="F10" or $Keypressed="F9" or $Keypressed="F8" or $Keypressed="F7" or $Keypressed="F6" or $Keypressed="F5" or $Keypressed="F4" or $Keypressed="F3" or $Keypressed="F2" or $Keypressed="F1" Then
	ElseIf $Keypressed = "" Then
		IniWrite($Setting, $SCIniEmpl, $SCFonctionName,"")
	Else
		IniWrite($Setting, $SCIniEmpl, $SCFonctionName,'"!'&$Keypressed&'"')
	EndIf
Else
getkeypressed()
EndIf
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;; REFRESH DES RACCOURCIS AFFICHES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Func refreshSCtext($SCFonctionName2, $SettingInputFonction)
Global $SCFonctionName = $SCFonctionName2
$SettingInputFonctionBrut = iniRead($Setting, $SCIniEmpl, $SCFonctionName, "Erreur")
If StringMid($SettingInputFonctionBrut,1,1) = '{' Then
$SettingInputFonction1 = StringReplace($SettingInputFonctionBrut, "{", "")
$SettingInputFonctionINI = StringReplace($SettingInputFonction1, "}", "")
ElseIf StringMid($SettingInputFonctionBrut,1,1) = '+' Then
$SettingInputFonctionINI = StringReplace($SettingInputFonctionBrut, "+", "Maj + ")
ElseIf StringMid($SettingInputFonctionBrut,1,1) = '!' Then
$SettingInputFonctionINI = StringReplace($SettingInputFonctionBrut, "!", "Alt + ")
ElseIf StringMid($SettingInputFonctionBrut,1,1) = '^' Then
$SettingInputFonctionINI = StringReplace($SettingInputFonctionBrut, "^", "Ctrl + ")
Else
$SettingInputFonctionINI = "Aucun"
EndIf
GUICtrlSetData($SettingInputFonction,$SettingInputFonctionINI)
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; ASSIGNATION/DESASIGNATION DES RACCOURCIS ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func assignSC()
Global $SettingSCwallclimb = iniRead($Setting, "Raccourcis - Officiel", "Wallclimb", "Erreur")
Global $SettingSCsupersaut = iniRead($Setting, "Raccourcis - Officiel", "Supersaut", "Erreur")
Global $SettingSCnoclipaction = iniRead($Setting, "Raccourcis - Officiel", "Noclipaction", "Erreur")
HotKeySet($SettingSCwallclimb,"scpwallclimb")
HotKeySet($SettingSCsupersaut,"scpsupersaut")
HotKeySet($SettingSCnoclipaction,"sconoclipaction")
EndFunc

func assignSCprivate()
Global $PriveSettingSCflymod = iniRead($Setting, "Raccourcis - Prive", "Flymod", "Erreur")
Global $PriveSettingSCspeedglobale = iniRead($Setting, "Raccourcis - Prive", "Speedglobale", "Erreur")
Global $PriveSettingSCspeed = iniRead($Setting, "Raccourcis - Prive", "Speed", "Erreur")
Global $PriveSettingSCwallclimb = iniRead($Setting, "Raccourcis - Prive", "Wallclimb", "Erreur")
Global $PriveSettingSCsupersaut = iniRead($Setting, "Raccourcis - Prive", "Supersaut", "Erreur")
Global $PriveSettingSCdebloperso = iniRead($Setting, "Raccourcis - Prive", "Debloperso", "Erreur")
Global $PriveSettingSCclicktp = iniRead($Setting, "Raccourcis - Prive", "Clicktp", "Erreur")
Global $PriveSettingSCgocorps = iniRead($Setting, "Raccourcis - Prive", "Gocorps", "Erreur")
Global $PriveSettingSCstopfall = iniRead($Setting, "Raccourcis - Prive", "Stopfall", "Erreur")
Global $PriveSettingSCtpcibledos = iniRead($Setting, "Raccourcis - Prive", "Tpcibledos", "Erreur")
Global $PriveSettingSCtpcibleundermap = iniRead($Setting, "Raccourcis - Prive", "Tpcibleundermap", "Erreur")
Global $PriveSettingSCFreezeZ = iniRead($Setting, "Raccourcis - Prive", "FreezeZ", "Erreur")
Global $PriveSettingSCSpeedN = iniRead($Setting, "Raccourcis - Prive", "SpeedN", "Erreur")
Global $PriveSettingSCSpeed100 = iniRead($Setting, "Raccourcis - Prive", "Speed100", "Erreur")
Global $PriveSettingSCSpeedcustom = iniRead($Setting, "Raccourcis - Prive", "Speedcustom", "Erreur")
Global $PriveSettingSCSpeedP = iniRead($Setting, "Raccourcis - Prive", "SpeedP", "Erreur")
Global $PriveSettingSCSpeedM = iniRead($Setting, "Raccourcis - Prive", "SpeedM", "Erreur")
Global $PriveSettingSCSpeedFlyN = iniRead($Setting, "Raccourcis - Prive", "SpeedFlyN", "Erreur")
Global $PriveSettingSCSpeedFly280 = iniRead($Setting, "Raccourcis - Prive", "SpeedFly280", "Erreur")
Global $PriveSettingSCSpeedFlycustom = iniRead($Setting, "Raccourcis - Prive", "SpeedFlycustom", "Erreur")
Global $PriveSettingSCSpeedFlyP = iniRead($Setting, "Raccourcis - Prive", "SpeedFlyP", "Erreur")
Global $PriveSettingSCSpeedFlyM = iniRead($Setting, "Raccourcis - Prive", "SpeedFlyM", "Erreur")
Global $PriveSettingSCSupersautP = iniRead($Setting, "Raccourcis - Prive", "SupersautP", "Erreur")
Global $PriveSettingSCSupersautM = iniRead($Setting, "Raccourcis - Prive", "SupersautM", "Erreur")
Global $PriveSettingSCTimeSpeedP = iniRead($Setting, "Raccourcis - Prive", "TimeSpeedP", "Erreur")
Global $PriveSettingSCTimeSpeedM = iniRead($Setting, "Raccourcis - Prive", "TimeSpeedM", "Erreur")
Global $PriveSettingSCTailleP = iniRead($Setting, "Raccourcis - Prive", "TailleP", "Erreur")
Global $PriveSettingSCTailleM = iniRead($Setting, "Raccourcis - Prive", "TailleM", "Erreur")
Global $PriveSettingSCGouletFlagA2 = iniRead($Setting, "Raccourcis - Prive", "FlagA2", "Erreur")
Global $PriveSettingSCGouletRegenA2 = iniRead($Setting, "Raccourcis - Prive", "RegenA2", "Erreur")
Global $PriveSettingSCGouletBersekerA2 = iniRead($Setting, "Raccourcis - Prive", "BersekerA2", "Erreur")
Global $PriveSettingSCGouletSprintA2 = iniRead($Setting, "Raccourcis - Prive", "SprintA2", "Erreur")
Global $PriveSettingSCGouletFlagH2 = iniRead($Setting, "Raccourcis - Prive", "FlagH2", "Erreur")
Global $PriveSettingSCGouletRegenH2 = iniRead($Setting, "Raccourcis - Prive", "RegenH2", "Erreur")
Global $PriveSettingSCGouletBersekerH2 = iniRead($Setting, "Raccourcis - Prive", "BersekerH2", "Erreur")
Global $PriveSettingSCGouletSprintH2 = iniRead($Setting, "Raccourcis - Prive", "SprintH2", "Erreur")
Global $PriveSettingSCArathiEcurie = iniRead($Setting, "Raccourcis - Prive", "Ecurie", "Erreur")
Global $PriveSettingSCArathiFerme = iniRead($Setting, "Raccourcis - Prive", "Ferme", "Erreur")
Global $PriveSettingSCArathiMine = iniRead($Setting, "Raccourcis - Prive", "Mine", "Erreur")
Global $PriveSettingSCArathiForge = iniRead($Setting, "Raccourcis - Prive", "Forge", "Erreur")
Global $PriveSettingSCArathiScierie = iniRead($Setting, "Raccourcis - Prive", "Scierie", "Erreur")
Global $PriveSettingSCOeilDrapeau = iniRead($Setting, "Raccourcis - Prive", "OeilDrapeau", "Erreur")
Global $PriveSettingSCOeilRuinesDraenei = iniRead($Setting, "Raccourcis - Prive", "RuinesDraenei", "Erreur")
Global $PriveSettingSCOeilTourMages = iniRead($Setting, "Raccourcis - Prive", "TourMages", "Erreur")
Global $PriveSettingSCOeilRuinesSaccageur = iniRead($Setting, "Raccourcis - Prive", "RuinesSaccageur", "Erreur")
Global $PriveSettingSCOeilTourElfes = iniRead($Setting, "Raccourcis - Prive", "TourElfes", "Erreur")
Global $PriveSettingSCAlteracA2 = iniRead($Setting, "Raccourcis - Prive", "Forge", "Erreur")
Global $PriveSettingSCAlteracH2 = iniRead($Setting, "Raccourcis - Prive", "Scierie", "Erreur")
HotKeySet($PriveSettingSCflymod,"scpflymod")
HotKeySet($PriveSettingSCspeed,"scpspeedglobale")
HotKeySet($PriveSettingSCspeed,"scpspeed")
HotKeySet($PriveSettingSCwallclimb,"scpwallclimb")
HotKeySet($PriveSettingSCsupersaut,"scpsupersaut")
HotKeySet($PriveSettingSCdebloperso,"debloperso")
HotKeySet($PriveSettingSCclicktp,"scpclicktp")
Hotkeyset($PriveSettingSCgocorps,"gocorps")
Hotkeyset($PriveSettingSCstopfall,"privestopfall")
Hotkeyset($PriveSettingSCtpcibledos,"privetpcibledos")
Hotkeyset($PriveSettingSCtpcibleundermap,"privetpcibleundermap")
Hotkeyset($PriveSettingSCFreezeZ,"scpfreezez")
Hotkeyset($PriveSettingSCSpeedN,"scpspeedSpeedN")
Hotkeyset($PriveSettingSCSpeed100,"scpspeedSpeed100")
Hotkeyset($PriveSettingSCSpeedcustom,"scpspeedSpeedCustom")
Hotkeyset($PriveSettingSCSpeedP,"scpspeedSpeedP")
Hotkeyset($PriveSettingSCSpeedM,"scpspeedSpeedM")
Hotkeyset($PriveSettingSCSpeedFlyN,"scpspeedSpeedFlyN")
Hotkeyset($PriveSettingSCSpeedFly280,"scpspeedSpeedFly280")
Hotkeyset($PriveSettingSCSpeedFlycustom,"scpspeedSpeedFlyCustom")
Hotkeyset($PriveSettingSCSpeedFlyP,"scpspeedSpeedFlyP")
Hotkeyset($PriveSettingSCSpeedFlyM,"scpspeedSpeedFlyM")
Hotkeyset($PriveSettingSCSupersautP,"scpspeedSupersautP")
Hotkeyset($PriveSettingSCSupersautM,"scpspeedSupersautM")
Hotkeyset($PriveSettingSCTimeSpeedP,"scpspeedTimeSpeedP")
Hotkeyset($PriveSettingSCTimeSpeedM,"scpspeedTimeSpeedM")
Hotkeyset($PriveSettingSCTailleP,"scpspeedTailleP")
Hotkeyset($PriveSettingSCTailleM,"scpspeedTailleM")
Hotkeyset($PriveSettingSCGouletFlagA2,"scppvpgouletflaga2")
Hotkeyset($PriveSettingSCGouletRegenA2,"scppvpgouletregena2")
Hotkeyset($PriveSettingSCGouletBersekerA2,"scppvpgouletbersekera2")
Hotkeyset($PriveSettingSCGouletSprintA2,"scppvpgouletsprinta2")
Hotkeyset($PriveSettingSCGouletFlagH2,"scppvpgouletflagh2")
Hotkeyset($PriveSettingSCGouletRegenH2,"scppvpgouletregenh2")
Hotkeyset($PriveSettingSCGouletBersekerH2,"scppvpgouletbersekerh2")
Hotkeyset($PriveSettingSCGouletSprintH2,"scppvpgouletsprinth2")
Hotkeyset($PriveSettingSCArathiEcurie,"scppvparathiecurie")
Hotkeyset($PriveSettingSCArathiFerme,"scppvparathiferme")
Hotkeyset($PriveSettingSCArathiMine,"scppvparathimine")
Hotkeyset($PriveSettingSCArathiForge,"scppvparathiforge")
Hotkeyset($PriveSettingSCArathiScierie,"scppvparathiscierie")
Hotkeyset($PriveSettingSCOeilDrapeau,"scppvpoeildrapeau")
Hotkeyset($PriveSettingSCOeilRuinesDraenei,"scppvpoeilRuinesDraenei")
Hotkeyset($PriveSettingSCOeilTourMages,"scppvpoeilTourMages")
Hotkeyset($PriveSettingSCOeilRuinesSaccageur,"scppvpoeilRuinesSaccageur")
Hotkeyset($PriveSettingSCOeilTourElfes,"scppvpoeilTourElfes")
Hotkeyset($PriveSettingSCAlteracA2,"scppvpalteraca2")
Hotkeyset($PriveSettingSCAlteracH2,"scppvpalterach2")
EndFunc

func unassignSC()
HotKeySet($SettingSCwallclimb)
HotKeySet($SettingSCsupersaut)
HotKeySet($SettingSCnoclipaction)
EndFunc

func unassignSCprivate()
HotKeySet($PriveSettingSCflymod)
HotKeySet($PriveSettingSCspeedglobale)
HotKeySet($PriveSettingSCspeed)
HotKeySet($PriveSettingSCwallclimb)
HotKeySet($PriveSettingSCsupersaut)
HotKeySet($PriveSettingSCdebloperso)
HotKeySet($PriveSettingSCclicktp)
HotKeySet($PriveSettingSCgocorps)
HotKeySet($PriveSettingSCstopfall)
HotKeySet($PriveSettingSCtpcibledos)
HotKeySet($PriveSettingSCtpcibleundermap)
Hotkeyset($PriveSettingSCFreezeZ)
Hotkeyset($PriveSettingSCSpeedN)
Hotkeyset($PriveSettingSCSpeed100)
Hotkeyset($PriveSettingSCSpeedcustom)
Hotkeyset($PriveSettingSCSpeedP)
Hotkeyset($PriveSettingSCSpeedM)
Hotkeyset($PriveSettingSCSpeedFlyN)
Hotkeyset($PriveSettingSCSpeedFly280)
Hotkeyset($PriveSettingSCSpeedFlycustom)
Hotkeyset($PriveSettingSCSpeedFlyP)
Hotkeyset($PriveSettingSCSpeedFlyM)
Hotkeyset($PriveSettingSCSupersautP)
Hotkeyset($PriveSettingSCSupersautM)
Hotkeyset($PriveSettingSCTimeSpeedP)
Hotkeyset($PriveSettingSCTimeSpeedM)
Hotkeyset($PriveSettingSCTailleP)
Hotkeyset($PriveSettingSCTailleM)
Hotkeyset($PriveSettingSCGouletFlagA2)
Hotkeyset($PriveSettingSCGouletRegenA2)
Hotkeyset($PriveSettingSCGouletBersekerA2)
Hotkeyset($PriveSettingSCGouletSprintA2)
Hotkeyset($PriveSettingSCGouletFlagH2)
Hotkeyset($PriveSettingSCGouletRegenH2)
Hotkeyset($PriveSettingSCGouletBersekerH2)
Hotkeyset($PriveSettingSCGouletSprintH2)
Hotkeyset($PriveSettingSCArathiEcurie)
Hotkeyset($PriveSettingSCArathiFerme)
Hotkeyset($PriveSettingSCArathiMine)
Hotkeyset($PriveSettingSCArathiForge)
Hotkeyset($PriveSettingSCArathiScierie)
Hotkeyset($PriveSettingSCOeilDrapeau)
Hotkeyset($PriveSettingSCOeilRuinesDraenei)
Hotkeyset($PriveSettingSCOeilTourMages)
Hotkeyset($PriveSettingSCOeilRuinesSaccageur)
Hotkeyset($PriveSettingSCOeilTourElfes)
Hotkeyset($PriveSettingSCAlteracA2)
Hotkeyset($PriveSettingSCAlteracH2)
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FONCTIONS DES RACCOURCIS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func scpflymod()
$PriveFlySpeedInputed = GUICtrlRead($PriveFlySpeedInput)
If $SCPriveFlyModON = 0 Then
	$SCPriveFlyModON = 1
	GUICtrlSetState($PriveFlyModON, $GUI_CHECKED)
	_MEMORYWRITE($PlayerBase+$PlayerState,$WowProcess,129, "dword")
	_MEMORYWRITE($PlayerBase+$FlySpeed,$WowProcess,$PriveFlySpeedInputed, "float")
Else
	$SCPriveFlyModON = 0
	GUICtrlSetState($PriveFlyModON, $GUI_UNCHECKED)
	_MEMORYWRITE($PlayerBase+$PlayerState,$WowProcess,128, "dword")
	_MEMORYWRITE($PlayerBase+$FlySpeed,$WowProcess,7, "float")
 EndIf
 EndFunc
func scpfreezez()
If $SCPriveFreezeZON = 0 Then
	$SCPriveFreezeZON = 1
	GUICtrlSetState($PriveFreezeZON, $GUI_CHECKED)
	_MEMORYWRITE($PlayerBase+$PlayerState2,$WowProcess,0x80000400, "ptr")
Else
	$SCPriveFreezeZON = 0
	GUICtrlSetState($PriveFreezeZON, $GUI_UNCHECKED)
	_MEMORYWRITE($PlayerBase+$PlayerState2,$WowProcess,0x80000000, "ptr")
 EndIf
 EndFunc
func scpspeed()
$PriveSpeedInputed = GUICtrlRead($PriveSpeedInput)
If $SCPriveSpeedON = 0 Then
	$SCPriveSpeedON = 1
	GUICtrlSetState($PriveSpeedON, $GUI_CHECKED)
	_MEMORYWRITE($PlayerBase+$Speed,$WowProcess,$PriveSpeedInputed, "float")
	_MEMORYWRITE($PlayerBase+$SpeedSwim,$WowProcess,$PriveSpeedInputed, "float")
Else
	$SCPriveSpeedON = 0
	GUICtrlSetState($PriveSpeedON, $GUI_UNCHECKED)
	_MEMORYWRITE($PlayerBase+$Speed,$WowProcess,7, "float")
	_MEMORYWRITE($PlayerBase+$SpeedSwim,$WowProcess,4.7, "float")
EndIf
EndFunc
func scpspeedglobale()
If GUICtrlRead($PriveSpeedON)=$GUI_UNCHECKED Then
	GUICtrlSetState($PriveSpeedON, $GUI_CHECKED)
ElseIf GUICtrlRead($PriveSpeedON)=$GUI_CHECKED Then
	GUICtrlSetState($PriveSpeedON, $GUI_UNCHECKED)
EndIf
EndFunc
func scpwallclimb()
If $SCPriveWallClimbON = 0 Then
	$SCPriveWallClimbON = 1
	GUICtrlSetState($PriveWallClimbON, $GUI_CHECKED)
	GUICtrlSetState($WallClimbON, $GUI_CHECKED)
	_MEMORYWRITE($PlayerBase + $Wallclimb, $WowProcess,255, "float")
Else
	$SCPriveWallClimbON = 0
	GUICtrlSetState($PriveWallClimbON, $GUI_UNCHECKED)
	GUICtrlSetState($WallClimbON, $GUI_UNCHECKED)
	_MEMORYWRITE($PlayerBase + $Wallclimb, $WowProcess,1, "float")
EndIf
EndFunc
func scpclicktp()
If WinActive("World of Warcraft") Then
	If $SCPriveClickTPON = 0 Then
		$SCPriveClickTPON = 1
		GUICtrlSetState($PriveClickTP, $GUI_CHECKED)
			If _ispressed(02) and $SCPriveClickTPON = 0 Then
				$PlayerStateORG = _MemoryRead($PlayerBase+$PlayerState2,$WowProcess,"ptr")
				_MEMORYWRITE($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG+0x800), "ptr")
				sleep(245)
				_MemoryWrite($PlayerBase+$PosX,$WowProcess,_MemoryRead($ClickTpX,$WowProcess, 'float'), 'float')
				_MemoryWrite($PlayerBase+$PosY,$WowProcess,_MemoryRead($ClickTpY,$WowProcess, 'float'), 'float')
				_MemoryWrite($PlayerBase+$PosZ,$WowProcess,_MemoryRead($ClickTpZ,$WowProcess, 'float'), 'float')
				sleep(245)
				_MEMORYWRITE($PlayerBase+$PlayerState2,$WowProcess,$PlayerStateORG, "ptr")
				_MEMORYWRITE($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG+0x400), "ptr")
				_MEMORYWRITE($PlayerBase+$PlayerState2,$WowProcess,$PlayerStateORG, "ptr")
			EndIf
	Else
		$SCPriveClickTPON = 0
		GUICtrlSetState($PriveClickTP, $GUI_UNCHECKED)
	EndIf
EndIf
EndFunc
func scpsupersaut()
If $SCPriveSupersautON = 0 Then
	$SCPriveSupersautON = 1
	GUICtrlSetState($PriveSuperSautON, $GUI_CHECKED)
	GUICtrlSetState($SuperSautON, $GUI_CHECKED)
		If _IsPressed(20) Then
			$PriveSuperSautInputed=GUICtrlRead ($PriveSuperSautInput)*(-1)
			_MEMORYWRITE($PlayerBase + $HauteurSaut, $WowProcess,$PriveSuperSautInputed, "float")
		EndIf
Elseif $SCPriveSupersautON = 1 Then
	$SCPriveSupersautON = 0
	GUICtrlSetState($PriveSuperSautON, $GUI_UNCHECKED)
	GUICtrlSetState($SuperSautON, $GUI_UNCHECKED)
EndIf
EndFunc
;;; SPEED
func scpspeedSpeedN()
	GUICtrlSetData($PriveSpeedInput,7)
	GUICtrlSetData($PriveSpeedGlobaleInput,7)
	_MEMORYWRITE($PlayerBase+$Speed,$WowProcess,7, "float")
	_MEMORYWRITE($PlayerBase+$SpeedSwim,$WowProcess,4.7, "float")
EndFunc
func scpspeedSpeed100()
	GUICtrlSetData($PriveSpeedInput,14)
	GUICtrlSetData($PriveSpeedGlobaleInput,14)
EndFunc
func scpspeedSpeedCustom()
	$PriveSpeedCustomInputed = GUICtrlRead($PriveSettingInputSpeedcustomInput)
	GUICtrlSetData($PriveSpeedInput,$PriveSpeedCustomInputed)
	GUICtrlSetData($PriveSpeedGlobaleInput,$PriveSpeedCustomInputed)
EndFunc
func scpspeedSpeedP()
	$PriveSpeedInputed = GUICtrlRead($PriveSpeedInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputSpeedIncr)
	GUICtrlSetData($PriveSpeedInput,$PriveSpeedInputed+$PriveIncrement)
	GUICtrlSetData($PriveSpeedGlobaleInput,$PriveSpeedInputed+$PriveIncrement)
EndFunc
func scpspeedSpeedM()
	$PriveSpeedInputed = GUICtrlRead($PriveSpeedInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputSpeedIncr)
	GUICtrlSetData($PriveSpeedInput,$PriveSpeedInputed-$PriveIncrement)
	GUICtrlSetData($PriveSpeedGlobaleInput,$PriveSpeedInputed-$PriveIncrement)
EndFunc
func scpspeedSpeedFlyN()
	GUICtrlSetData($PriveFlySpeedInput,7)
EndFunc
func scpspeedSpeedFly280()
	GUICtrlSetData($PriveFlySpeedInput,26.6)
EndFunc
func scpspeedSpeedFlyCustom()
	$PriveSpeedFlyCustomInputed = GUICtrlRead($PriveSettingInputSpeedFlycustomInput)
	GUICtrlSetData($PriveFlySpeedInput,$PriveSpeedFlyCustomInputed)
EndFunc
func scpspeedSpeedFlyP()
	$PriveSpeedFlyInputed = GUICtrlRead($PriveFlySpeedInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputSpeedFlyIncr)
	GUICtrlSetData($PriveFlySpeedInput,$PriveSpeedFlyInputed+$PriveIncrement)
EndFunc
func scpspeedSpeedFlyM()
	$PriveSpeedFlyInputed = GUICtrlRead($PriveFlySpeedInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputSpeedFlyIncr)
	GUICtrlSetData($PriveFlySpeedInput,$PriveSpeedFlyInputed-$PriveIncrement)
EndFunc
;;;; DIVERS
func scpspeedSupersautP()
	$PriveSuperSautInputed = GUICtrlRead($PriveSuperSautInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputSupersautIncr)
	GUICtrlSetData($PriveSuperSautInput,$PriveSuperSautInputed+$PriveIncrement)
	GUICtrlSetData($SuperSautInput,$PriveSuperSautInputed+$PriveIncrement)
EndFunc
func scpspeedSupersautM()
	$PriveSuperSautInputed = GUICtrlRead($PriveSuperSautInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputSupersautIncr)
	GUICtrlSetData($PriveSuperSautInput,$PriveSuperSautInputed-$PriveIncrement)
	GUICtrlSetData($SuperSautInput,$PriveSuperSautInputed-$PriveIncrement)
EndFunc
func scpspeedTimeSpeedP()
	$VitesseTempsInputed = GUICtrlRead($VitesseTempsInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputTimeSpeedIncr)
	GUICtrlSetData($VitesseTempsInput,$VitesseTempsInputed+$PriveIncrement)
	settimespeed()
EndFunc
func scpspeedTimeSpeedM()
	$VitesseTempsInputed = GUICtrlRead($VitesseTempsInput)
	$PriveIncrement = GUICtrlRead($PriveSettingInputTimeSpeedIncr)
	GUICtrlSetData($VitesseTempsInput,$VitesseTempsInputed-$PriveIncrement)
	settimespeed()
EndFunc
func scpspeedTailleP()
	$PriveIncrement = GUICtrlRead($PriveSettingInputTailleIncr)
	$PlayerScaleVar=_MEMORYREAD($PlayerBase+$PlayerScale,$WowProcess,"float")
	$PlayerNewTaille=$PlayerScaleVar*$PriveIncrement
	_MEMORYWRITE(($PlayerBase + $PlayerScale), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerScaleInput,Round($PlayerNewTaille, 5))

	$PlayerHauteurVar=_MEMORYREAD($PlayerBase+$PlayerHauteur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerHauteurVar*$PriveIncrement
	_MEMORYWRITE(($PlayerBase + $PlayerHauteur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerHauteurInput,Round($PlayerNewTaille, 5))

	$PlayerLargeurVar=_MEMORYREAD($PlayerBase+$PlayerLargeur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerLargeurVar*$PriveIncrement
	_MEMORYWRITE(($PlayerBase + $PlayerLargeur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerLargeurInput,Round($PlayerNewTaille, 5))
EndFunc
func scpspeedTailleM()
	$PriveIncrement = GUICtrlRead($PriveSettingInputTailleIncr)
	$PlayerScaleVar=_MEMORYREAD($PlayerBase+$PlayerScale,$WowProcess,"float")
	$PlayerNewTaille=$PlayerScaleVar/$PriveIncrement
	_MEMORYWRITE(($PlayerBase + $PlayerScale), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerScaleInput,Round($PlayerNewTaille, 5))

	$PlayerHauteurVar=_MEMORYREAD($PlayerBase+$PlayerHauteur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerHauteurVar/$PriveIncrement
	_MEMORYWRITE(($PlayerBase + $PlayerHauteur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerHauteurInput,Round($PlayerNewTaille, 5))

	$PlayerLargeurVar=_MEMORYREAD($PlayerBase+$PlayerLargeur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerLargeurVar/$PriveIncrement
	_MEMORYWRITE(($PlayerBase + $PlayerLargeur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerLargeurInput,Round($PlayerNewTaille, 5))
EndFunc
;;;;;;;;;;;;;;;;;;;; PVP
;;;; GOULET ALLY
func scppvpgouletflaga2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","flagA2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","flagA2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","flagA2Z","Erreur"), 'float')
EndFunc
func scppvpgouletregena2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","regenA2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","regenA2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","regenA2Z","Erreur"), 'float')
EndFunc
func scppvpgouletbersekera2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","bersekerA2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","bersekerA2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","bersekerA2Z","Erreur"), 'float')
EndFunc
func scppvpgouletsprinta2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","sprintA2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","sprintA2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","sprintA2Z","Erreur"), 'float')
EndFunc
;;;; GOULET HORDE
func scppvpgouletflagh2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","flagH2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","flagH2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","flagH2Z","Erreur"), 'float')
EndFunc
func scppvpgouletregenh2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","regenH2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","regenH2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","regenH2Z","Erreur"), 'float')
EndFunc
func scppvpgouletbersekerh2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","bersekerH2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","bersekerH2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","bersekerH2Z","Erreur"), 'float')
EndFunc
func scppvpgouletsprinth2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Goulet","sprintH2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Goulet","sprintH2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Goulet","sprintH2Z","Erreur"), 'float')
EndFunc
;;;; ARATHI
func scppvparathiecurie()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Arathi","ecurieX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Arathi","ecurieY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Arathi","ecurieZ","Erreur"), 'float')
EndFunc
func scppvparathiferme()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Arathi","fermeX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Arathi","fermeY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Arathi","fermeZ","Erreur"), 'float')
EndFunc
func scppvparathimine()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Arathi","mineX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Arathi","mineY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Arathi","mineZ","Erreur"), 'float')
EndFunc
func scppvparathiforge()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Arathi","forgeX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Arathi","forgeY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Arathi","forgeZ","Erreur"), 'float')
EndFunc
func scppvparathiscierie()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Arathi","scierieX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Arathi","scierieY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Arathi","scierieZ","Erreur"), 'float')
EndFunc
;;;; OEIL DU CYCLONE
func scppvpoeildrapeau()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Oeil","eildrapeauX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Oeil","eildrapeauY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Oeil","eildrapeauZ","Erreur"), 'float')
EndFunc
func scppvpoeilRuinesDraenei()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Oeil","RuinesDraeneiX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Oeil","RuinesDraeneiY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Oeil","RuinesDraeneiZ","Erreur"), 'float')
EndFunc
func scppvpoeilTourMages()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Oeil","TourMagesX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Oeil","TourMagesY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Oeil","TourMagesZ","Erreur"), 'float')
EndFunc
func scppvpoeilRuinesSaccageur()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Oeil","RuinesSaccageurX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Oeil","RuinesSaccageurY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Oeil","RuinesSaccageurZ","Erreur"), 'float')
EndFunc
func scppvpoeilTourElfes()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Oeil","TourElfesX","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Oeil","TourElfesY","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Oeil","TourElfesZ","Erreur"), 'float')
EndFunc
;;;; ALTERAC
func scppvpalteraca2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Alterac","A2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Alterac","A2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Alterac","A2Z","Erreur"), 'float')
EndFunc
func scppvpalterach2()
_MemoryWrite($PlayerBase+$PosX,$WowProcess,IniRead($Setting,"Alterac","H2X","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosY,$WowProcess,IniRead($Setting,"Alterac","H2Y","Erreur"), 'float')
_MemoryWrite($PlayerBase+$PosZ,$WowProcess,IniRead($Setting,"Alterac","H2Z","Erreur"), 'float')
EndFunc
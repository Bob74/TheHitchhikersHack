#NoTrayIcon
#RequireAdmin
#include <THHH_Offsets_3.3.5.au3> ; THHH_Offsets_3.3.2.au3 / THHH_Offsets_3.3.3.au3
#include <THHH_Language_func.au3>
#include <THHH_Raccourcis.au3>
#include <THHH_GetKeyPressed.au3>
#include <THHH_TPList_func.au3>
#include <THHH_Reglages.au3>
#include <MemWriteGCD.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiComboBox.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <SliderConstants.au3>
#include <EditConstants.au3>
#include <Misc.au3>
#include <NomadMemory.au3>
#include <GuiListView.au3>
#include <file.au3>
#include <WinAPI.au3>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SetPrivilege("SeDebugPrivilege", 1)
$WowProcessList = ProcessList("wow.exe")
$Wowpid1 = ProcessExists("wow.exe")
$dll = DllOpen("user32.dll")
Global Const $pi = 3.14159265
Global Const $TimeSpeedORG = 0.0166666693985462
Global $Setting = @ScriptDir&"\thhh_settings\thhh_Settings.ini"
Global $TrackSaveR = 0
Global $TrackSaveH = 0
Global $Keypressed=""
$SCPriveFlyModON = 0
$SCPriveSpeedON = 0
$SCPriveWallClimbON = 0
$SCPriveSupersautON = 0
$SCPriveClickTPON = 0
$SCPriveFreezeZON = 0
$X = 0
$TrackValueR = 0
$TrackValueH = 0
#Region ### GUI ###
$THHHGUI = GUICreate("The Hitchhiker's Hack", 332, 655, -1, -1)
GUISetBkColor(0xefefef)
$OnTop = GUICtrlCreateCheckbox("Checkbox", 5, 5, 15, 15)
$PriveOnTop= GUICtrlCreateLabel("Premier plan", 25, 5, 60, 15,$WS_EX_TRANSPARENT)
$GUItrans = GUICtrlCreateCheckbox("Checkbox", 5, 25, 15, 15)
$TransparenceGeneral = GUICtrlCreateLabel("Transparence", 25, 25, 70, 15)
$Reset = GUICtrlCreateButton("Reset", 210, 3, 50, 50, $WS_GROUP)
$About = GUICtrlCreateButton("A propos..", 131, 3, 74, 30, $WS_GROUP)
$State = GUICtrlCreateLabel("", 10, 638, 312, 17)
GUICtrlSetFont(-1,9,600)
$Optionsbutton = GUICtrlCreateButton("Options", 131, 32, 74, 20, $WS_GROUP)
$WowProcesslistview = GUICtrlCreateListView("WoW|",266,1,65,73,$LVS_SINGLESEL)
;;; Création de la liste des processus
For $i = 1 to $WowProcessList[0][0]
GUICtrlCreateListViewItem($WowProcessList[$i][1], $WowProcesslistview)
next
_GUICtrlListView_SetColumnWidth($WowProcesslistview,0,40)
_GUICtrlListView_SetItemSelected($WowProcesslistview,0)
$SelectedPID = _GUICtrlListView_GetSelectedIndices(GUICtrlGetHandle($WowProcesslistview))
If $Wowpid1 = "" Then
MsgBox(0,"", "Wow n'est pas lancé")
Exit
Else
;;; On sauve le nombre de processus pour comparer ensuite avec le nombre de processus actuels
;;; (et ainsi savoir si un deuxième jeu a été lancé ou fermé)
$WowProcessListViewItemCountSave = _GUICtrlListView_GetItemCount($WowProcesslistview)
$SelectedPIDadd = ($SelectedPID+1)
$WowPid = $WowProcessList[$SelectedPIDadd][1]
$WowProcess = _MEMORYOPEN($WowPid)
EndIf
;;; On commence la lecture de mémoire et l'écriture !
$PB1 = _MemoryRead($StaticPlayer,$WowProcess,"Ptr")
$PB2 = _MemoryRead($PB1+$PbPointer1,$WowProcess,"Ptr")
$PlayerBase = _MemoryRead($PB2+$PbPointer2,$WowProcess,"Ptr")
$PlayerBase2 = _MemoryRead($PlayerBase+8,$WowProcess,"Ptr")
$PlayerScaleVar=_MemoryRead($PlayerBase+$PlayerScale,$WowProcess,"float")
$PlayerHauteurVar=_MemoryRead($PlayerBase+$PlayerHauteur,$WowProcess,"float")
$PlayerLargeurVar=_MemoryRead($PlayerBase+$PlayerLargeur,$WowProcess,"float")
$SautVar=_MemoryRead($PlayerBase+$HauteurSaut,$WowProcess,"float")
	 _MemoryWrite($PlayerBase2+$Hunt,$WowProcess,0) ;      Mise à 0 des pistages car le pistage marche par
	 _MemoryWrite($PlayerBase2+$Ressources,$WowProcess,0) ;addition de valeurs (on part du principe qu'on par de 0)
$PlayerHauteurRESET=$PlayerHauteurVar
$PlayerLargeurRESET=$PlayerLargeurVar
$PLAYERBASEAD2=_MemoryRead(($PlayerBase + $PLAYERBASE_AD2), $WowProcess, "ptr")
$OFS_PBSPECTATE=$PLAYERBASEAD2 + $PLAYERBASE_PBSPECTATE
$LVL1CAMERAPOINTER = _MemoryRead($CAM_CAMERASTATIC, $WowProcess, "ptr")
$LVL2CAMERAPOINTER = _MemoryRead(($LVL1CAMERAPOINTER + $CAM_CAMERAOFFSA), $WowProcess, "ptr")
$MEMORYCAM = $LVL2CAMERAPOINTER + $CAM_CAMERAOFFSB
$MEMORYCAMROTZ = $MEMORYCAM + $CAM_CAMERAROTZ
$MEMORYCAMROTX = $MEMORYCAM + $CAM_CAMERAROTX
$tab = GUICtrlCreateTab(0, 55, 332, 635)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PRIVE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$tab0 = GUICtrlCreateTabItem("Fonctions (Privé)")
If IniRead($Setting,"Reglages","Interface","Erreur") = 1 Then
GUICTRLCREATEPIC(@ScriptDir&"\thhh_settings\skin\top.jpg", 0, 0, 332, 55, BitOR($WS_GROUP,$WS_CLIPSIBLINGS))
GUICTRLCREATEPIC(@ScriptDir&"\thhh_settings\skin\mid_priv.jpg", 0, 76, 330, 560, $WS_GROUP)
$PriveTeleportationGRP = GUICtrlCreateLabel("Téléportation", 167, 80, 75, 17)
$PrivePVPGRP = GUICtrlCreateLabel("JcJ", 172, 310, 30, 17)
$PriveXYZGRP = GUICtrlCreateLabel("XYZ", 172, 235, 30, 17)
$PriveTrackingGRP = GUICtrlCreateLabel("Pistage", 30, 485, 50, 17)
Else
$PriveTeleportationGRP = GUICtrlCreateGroup("Téléportation", 157, 80, 170, 155)
$PrivePVPGRP = GUICtrlCreateGroup("JcJ", 162, 310, 115, 70)
$PriveXYZGRP = GUICtrlCreateGroup("XYZ", 162, 235, 125, 75)
$PriveTrackingGRP = GUICtrlCreateGroup("Pistage", 20, 485, 291, 115)
GUICtrlCreateGroup("",162,378,102,30)
GUICtrlCreateGroup("",162,410,155,75)
GUICtrlCreateGroup("", 25, 80, 125, 395)
GUICtrlCreateGroup("", 225, 600, 95, 30)
EndIf
GUICtrlCreateLabel("TP", 215, 102, 20, 17)
$LBLCooActuel = GUICtrlCreateLabel("Actuel", 267, 102, 35, 17)
GUICtrlCreateLabel("Map", 165, 117, 22, 17)
GUICtrlCreateLabel("X", 175, 137, 10, 17)
GUICtrlCreateLabel("Y", 175, 157, 10, 17)
GUICtrlCreateLabel("Z", 175, 177, 10, 17)
$PriveMAPInput = GUICtrlCreateInput(_MemoryRead($MapID,$WowProcess), 255, 115, 60, 18, $ES_READONLY)
$PriveXInput = GUICtrlCreateInput(Round((_MemoryRead($PlayerBase+$PosX,$WowProcess,"float")),3), 255, 135, 60, 18, $ES_READONLY)
$PriveYInput = GUICtrlCreateInput(Round((_MemoryRead($PlayerBase+$PosY,$WowProcess,"float")),3), 255, 155, 60, 18, $ES_READONLY)
$PriveZInput = GUICtrlCreateInput(Round((_MemoryRead($PlayerBase+$PosZ,$WowProcess,"float")),3), 255, 175, 60, 18, $ES_READONLY)
$PriveMAPInputTP = GUICtrlCreateInput(_MemoryRead($MapID,$WowProcess), 190, 115, 60, 18, $ES_READONLY)
$PriveXInputTP = GUICtrlCreateInput("", 190, 135, 60, 18)
$PriveYInputTP = GUICtrlCreateInput("", 190, 155, 60, 18)
$PriveZInputTP = GUICtrlCreateInput("", 190, 175, 60, 18)
$PriveCopyTP = GUICtrlCreateButton("*", 190, 98, 22, 15, $WS_GROUP)
$PriveGoTP = GUICtrlCreateButton("Téléporter", 195, 200, 55, 25, $WS_GROUP)
$PriveGoCorps = GUICtrlCreateButton("TP Corps", 251, 200, 68, 25, $WS_GROUP)
$ListOuvrir = GUICtrlCreateButton("Liste", 163, 200, 30, 25, $WS_GROUP)
$PriveXYZON = GUICtrlCreateCheckbox("Checkbox", 266, 260, 15, 15)
$LBLActiverXYZ = GUICtrlCreateLabel("Activer XYZ", 172, 260, 68, 17)
$PriveXYZSpeedInput = GUICtrlCreateInput(0.5, 241, 280, 35, 20)
$LBLVitesseXYZ = GUICtrlCreateLabel("Vitesse XYZ", 172, 282, 58, 17)
$PriveTPcibleDos = GUICtrlCreateButton("TP Cible (dos)", 167, 325, 104, 25, $WS_GROUP)
$PriveTPcibleUndermap = GUICtrlCreateButton("TP Cible (sous map)", 167, 350, 104, 25, $WS_GROUP)
$PriveClickTP = GUICtrlCreateCheckbox("Checkbox",242,387,17,17)
GUICtrlCreateLabel("Click to TP",167,388,58,17)
$PriveCollisionsM2 = GUICtrlCreateCheckbox("Checkbox",297,420,17,17)
$LBLPriveCollisionsM2 = GUICtrlCreateLabel("Désactiver collisions M2",167,421,120,17)
$PriveCollisionsWMO = GUICtrlCreateCheckbox("Checkbox",297,440,17,17)
$LBLPriveCollisionsWMO = GUICtrlCreateLabel("Désactiver collisions WMO",167,441,130,17)
$PriveCollisionsAll = GUICtrlCreateCheckbox("Checkbox",205,460,17,17)
GUICtrlCreateLabel("Noclip",167,461,130,17)
$PriveSpeedGlobaleON = GUICtrlCreateCheckbox("Checkbox", 132, 90, 15, 15)
$LBLSpeedGlobale = GUICtrlCreateLabel("Vitesse globale", 30, 91, 72, 17)
$PriveSpeedGlobaleInput = GUICtrlCreateInput(7, 102, 91, 25, 15)
$PriveSpeedON = GUICtrlCreateCheckbox("Checkbox", 132, 110, 15, 15)
$LBLSpeed = GUICtrlCreateLabel("Vitesse", 30, 111, 54, 17)
$PriveSpeedInput = GUICtrlCreateInput(7, 102, 111, 25, 15)
$LBLSpeedPourcent1 = GUICtrlCreateLabel("en pourcents:", 30, 131, 75, 17)
$LBLSpeedPourcent = GUICtrlCreateLabel("", 97, 131, 50, 17, $SS_RIGHT)
$PriveFlyModON = GUICtrlCreateCheckbox("Checkbox", 132, 150, 15, 15)
$LBLFlymod = GUICtrlCreateLabel("Voler", 30, 151, 54, 17)
$PriveFlySpeedInput = GUICtrlCreateInput(7, 102, 151, 25, 15)
$PriveFreezeZON = GUICtrlCreateCheckbox("Checkbox", 132, 170, 15, 15)
$LBLFreezez = GUICtrlCreateLabel("Bloquer Z", 30, 171, 80, 17)
$PriveNoClipON = GUICtrlCreateCheckbox("Checkbox", 132, 190, 15, 15)
$LBLNoclip = GUICtrlCreateLabel("Traverser tout", 30, 191, 80, 17)
$PriveWaterWalkON = GUICtrlCreateCheckbox("Checkbox", 132, 210, 15, 15)
$LBLWalkonwater = GUICtrlCreateLabel("Marche sur l'eau", 30, 211, 80, 17)
$PriveUnderwaterWalkON = GUICtrlCreateCheckbox("Checkbox", 132, 230, 15, 15)
$LBLUnderwaterWalk = GUICtrlCreateLabel("Marche sous l'eau", 30, 231, 90, 17)
$PriveMountON = GUICtrlCreateCheckbox("Checkbox", 132, 250, 15, 15)
$LBLMount = GUICtrlCreateLabel("Monture en intérieur", 30, 251, 97, 17)
$PriveWallClimbON = GUICtrlCreateCheckbox("Checkbox", 132, 270, 15, 15)
$LBLWallclimb = GUICtrlCreateLabel("Grimper partout", 30, 271, 75, 17)
$NoCooldownCheck = GUICtrlCreateCheckbox("Checkbox", 132, 290, 15, 15)
GUICtrlCreateLabel("NoCooldown",30,291,65,17)
$PriveWalljumpON = GUICtrlCreateCheckbox("Checkbox", 132, 310, 15, 15)
$PriveLBLWalljump = GUICtrlCreateLabel("Walljump", 30, 311, 80, 17)
$PriveInfiniteJumpON = GUICtrlCreateCheckbox("Checkbox", 132, 330, 15, 15)
$LBLInfiniteJump = GUICtrlCreateLabel("Multi-sauts", 30, 331, 70, 17)
$PriveSuperSautON = GUICtrlCreateCheckbox("Checkbox", 132, 350, 15, 15)
$LBLSupersaut = GUICtrlCreateLabel("Super-saut", 30, 351, 66, 17)
$PriveSuperSautInput = GUICtrlCreateInput(22, 30, 371, 115, 20)
$PriveFactionMENU = GUICtrlCreateCombo("Faction",30, 395,115, 25)
GUICtrlSetData(-1, "Créature|Alliance|Horde")
$PriveDebloPerso = GUICtrlCreateButton("Débloquer Perso", 30, 420, 116, 25, $WS_GROUP)
$StopchuteON = GUICtrlCreateButton("Stopper chute", 30, 445, 116, 25, $WS_GROUP)
$PriveTrackHerbes = GUICtrlCreateCheckbox("Herbes", 30, 500, 69, 15)
$PriveTrackFilons = GUICtrlCreateCheckbox("Filons", 30, 520, 69, 15)
$PriveTrackCoffres = GUICtrlCreateCheckbox("Coffres", 30, 540, 69, 15)
$PriveTrackPoissons = GUICtrlCreateCheckbox("Poissons", 30, 560, 69, 15)
$PriveTrackAllRes = GUICtrlCreateCheckbox("Tout", 30, 580, 68, 15)
$PriveTrackBetes = GUICtrlCreateCheckbox("Bêtes", 130, 500, 69, 15)
$PriveTrackDragons = GUICtrlCreateCheckbox("Dragons", 130, 520, 69, 15)
$PriveTrackDemons = GUICtrlCreateCheckbox("Démons", 130, 540, 69, 15)
$PriveTrackElementaires = GUICtrlCreateCheckbox("Elémentaires", 130, 560, 71, 15)
$PriveTrackGeants = GUICtrlCreateCheckbox("Géants", 210, 500, 69, 15)
$PriveTrackMortsVivants = GUICtrlCreateCheckbox("Morts-vivants", 210, 520, 85, 15)
$PriveTrackHumanoides = GUICtrlCreateCheckbox("Humanoïdes", 210, 540, 77, 15)
$PriveTrackBestioles = GUICtrlCreateCheckbox("Bestioles", 210, 560, 69, 15)
$PriveTrackAllBet = GUICtrlCreateCheckbox("Tout", 170, 580, 68, 15)
$PriveRaccourcis = GUICtrlCreateCheckbox("Checkbox", 300, 610, 15, 15)
$PriveSCsettings = GUICtrlCreateButton("Raccourcis", 227, 608, 70, 19, $WS_GROUP)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; OFFICIEL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$tab1 = GUICtrlCreateTabItem("Fonctions (Officiel)")
If IniRead($Setting,"Reglages","Interface","Erreur") = 1 Then
GUICTRLCREATEPIC(@ScriptDir&"\thhh_settings\skin\top.jpg", 0, 0, 332, 55, BitOR($WS_GROUP,$WS_CLIPSIBLINGS))
GUICTRLCREATEPIC(@ScriptDir&"\thhh_settings\skin\mid_offi.jpg", 0, 76, 330, 560, $WS_GROUP)
$TeleportationGRP = GUICtrlCreateLabel("XYZ", 182, 90, 30, 17)
$TrackingGRP = GUICtrlCreateLabel("Pistage", 30, 290, 45, 17)
Else
$TeleportationGRP = GUICtrlCreateGroup("XYZ", 171, 90, 125, 125)
$TrackingGRP = GUICtrlCreateGroup("Pistage", 20, 290, 291, 115)
GUICtrlCreateGroup("", 30, 90, 125, 170)
GUICtrlCreateGroup("",162,215,155,75) ;;; groupe collisions
GUICtrlCreateGroup("", 225, 600, 95, 30)
EndIf
$TpON = GUICtrlCreateCheckbox("Checkbox", 275, 115, 15, 15)
$LBLActiverXYZOf = GUICtrlCreateLabel("Activer XYZ", 181, 115, 68, 17)
$TPauto = GUICtrlCreateRadio("Automatique", 181, 160, 80, 17)
$TPmanu = GUICtrlCreateRadio("Manuel", 181, 140, 0, 0)
GUICtrlSetState(-1, $GUI_CHECKED)
$NoClipActionON = GUICtrlCreateCheckbox("Checkbox", 275, 190, 15, 15)
GUICtrlCreateLabel("No-Clip Action", 182, 191, 70, 17)
$WallClimbON = GUICtrlCreateCheckbox("Checkbox", 135, 105, 15, 15)
$LBLWallclimbOf = GUICtrlCreateLabel("Grimper partout", 35, 105, 75, 17)
$CollisionsM2 = GUICtrlCreateCheckbox("Checkbox",297,225,17,17)
$LBLCollisionsM2Of = GUICtrlCreateLabel("Désactiver collisions M2",167,226,120,17)
$CollisionsWMO = GUICtrlCreateCheckbox("Checkbox",297,245,17,17)
$LBLCollisionsWMOOf = GUICtrlCreateLabel("Désactiver collisions WMO",167,246,130,17)
$CollisionsAll = GUICtrlCreateCheckbox("Checkbox",205,265,17,17)
GUICtrlCreateLabel("Noclip",167,266,130,17)
$WalljumpON = GUICtrlCreateCheckbox("Checkbox", 135, 125, 15, 15)
$LBLWalljumpOf = GUICtrlCreateLabel("Walljump", 35, 125, 54, 17)
$WaterWalkON = GUICtrlCreateCheckbox("Checkbox", 135, 145, 15, 15)
;GUICtrlSetState($WaterWalkON,$GUI_DISABLE) ;pour version 3.3.2
$LBLWaterWalkOf = GUICtrlCreateLabel("Marche sur l'eau", 35, 145, 90, 17)
$UnderwaterWalkON = GUICtrlCreateCheckbox("Checkbox", 135, 165, 15, 15)
$LBLUnderwaterWalkOf = GUICtrlCreateLabel("Marche sous l'eau", 35, 165, 90, 17)
$SuperSautON = GUICtrlCreateCheckbox("Checkbox", 135, 185, 15, 15)
$LBLSupersautOf = GUICtrlCreateLabel("Super-saut", 35, 185, 54, 17)
$SuperSautInput = GUICtrlCreateInput(22, 35, 205, 115, 20)
$FactionMENU = GUICtrlCreateCombo("Faction",35, 230, 115, 25)
GUICtrlSetData(-1, "Créature|Alliance|Horde")
$TrackHerbes = GUICtrlCreateCheckbox("Herbes", 30, 305, 69, 15)
$TrackFilons = GUICtrlCreateCheckbox("Filons", 30, 325, 69, 15)
$TrackCoffres = GUICtrlCreateCheckbox("Coffres", 30, 345, 69, 15)
$TrackPoissons = GUICtrlCreateCheckbox("Poissons", 30, 365, 69, 15)
$TrackAllRes = GUICtrlCreateCheckbox("Tout", 30, 385, 68, 15)
$TrackBetes = GUICtrlCreateCheckbox("Bêtes", 130, 305, 69, 15)
$TrackDragons = GUICtrlCreateCheckbox("Dragons", 130, 325, 69, 15)
$TrackDemons = GUICtrlCreateCheckbox("Démons", 130, 345, 69, 15)
$TrackElementaires = GUICtrlCreateCheckbox("Elémentaires", 130, 365, 71, 15)
$TrackGeants = GUICtrlCreateCheckbox("Géants", 210, 305, 69, 15)
$TrackMortsVivants = GUICtrlCreateCheckbox("Morts-Vivants", 210, 325, 85, 15)
$TrackHumanoides = GUICtrlCreateCheckbox("Humanoïdes", 210, 345, 77, 15)
$TrackBestioles = GUICtrlCreateCheckbox("Bestioles", 210, 365, 69, 15)
$TrackAllBet = GUICtrlCreateCheckbox("Tout", 170, 385, 68, 15)
$Raccourcis = GUICtrlCreateCheckbox("Checkbox", 300, 610, 15, 15)
$SCsettings = GUICtrlCreateButton("Raccourcis", 227, 608, 70, 19, $WS_GROUP)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; AFFICHAGE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$tab2 = GUICtrlCreateTabItem("Joueur")
If IniRead($Setting,"Reglages","Interface","Erreur") = 1 Then
GUICTRLCREATEPIC(@ScriptDir&"\thhh_settings\skin\top.jpg", 0, 0, 332, 55, BitOR($WS_GROUP,$WS_CLIPSIBLINGS))
GUICTRLCREATEPIC(@ScriptDir&"\thhh_settings\skin\mid_jou.jpg", 0, 76, 330, 479, $WS_GROUP)
$PlayerTailleGRP = GUICtrlCreateLabel("Taille", 40, 90, 45, 17)
$PlayerShowGRP = GUICtrlCreateLabel("Affichage", 215, 220, 80, 17)
$CameraGRP = GUICtrlCreateLabel("Caméra", 40, 305, 45, 17)
$TempsGRP = GUICtrlCreateLabel("Temps", 205, 300, 45, 17)
Else
$PlayerTailleGRP = GUICtrlCreateGroup("Taille Joueur", 30, 90, 265, 125)
$PlayerShowGRP = GUICtrlCreateGroup("Affichage", 205, 220, 90, 70)
$CameraGRP = GUICtrlCreateGroup("Caméra", 30, 305, 160, 105)
$TempsGRP = GUICtrlCreateGroup("Temps", 195, 300, 100, 110)
GUICtrlCreateGroup("", 30, 220, 170, 75)
GUICtrlCreateGroup("", 30, 415, 195, 80)
EndIf
$PlayerTailleP = GUICtrlCreateButton("Taille +", 40, 110, 60, 30, $WS_GROUP)
$PlayerTailleM = GUICtrlCreateButton("Taille -", 40, 152, 60, 30, $WS_GROUP)
$PlayerScaleInput = GUICtrlCreateInput($PlayerScaleVar, 160, 110, 80, 20)
$LBLTaille = GUICtrlCreateLabel("Taille", 110, 112, 50, 17)
$PlayerHauteurInput = GUICtrlCreateInput(Round($PlayerHauteurVar, 5), 160, 135, 80, 20)
$LBLHauteur = GUICtrlCreateLabel("Hauteur", 110, 137, 40, 17)
$PlayerLargeurInput = GUICtrlCreateInput(Round($PlayerLargeurVar, 5), 160, 160, 80, 20)
$LBLLargeur = GUICtrlCreateLabel("Largeur", 110, 162, 40, 17)
$PlayerScaleInputOK = GUICtrlCreateButton("Ok", 245, 107, 40, 25, $WS_GROUP)
$PlayerHauteurInputOK = GUICtrlCreateButton("Ok", 245, 132, 40, 25, $WS_GROUP)
$PlayerLargeurInputOK = GUICtrlCreateButton("Ok", 245, 157, 40, 25, $WS_GROUP)
$PlayerInputRESET = GUICtrlCreateButton("Reset", 180, 185, 40, 25, $WS_GROUP)
$InebriationON = GUICtrlCreateCheckbox("Checkbox", 80, 271, 15, 15)
$LBLAlcool = GUICtrlCreateLabel("Alcool", 40, 273, 54, 17)
$VALEUR_SLIDER_Inebriation = GUICtrlCreateInput(0, 160, 270, 30, 17, $ES_READONLY)
$SLIDER_TRANSITION_Inebriation = GUICtrlCreateSlider(40, 235, 150, 35)
GUICtrlSetState($SLIDER_TRANSITION_Inebriation, $GUI_FOCUS)
$Slider_Inebriation = GUICtrlRead($SLIDER_TRANSITION_Inebriation)
GUICtrlSetLimit($SLIDER_TRANSITION_Inebriation, 100, 0)
GUICtrlSetData($SLIDER_TRANSITION_Inebriation, 0)
$PlayerFlags2Check1 =  GUICtrlCreateCheckbox("Checkbox", 265, 240, 15, 15)
$LBLMort = GUICtrlCreateLabel("Mort", 215, 240, 54, 17)
$PlayerFlags2Check2 =  GUICtrlCreateCheckbox("Checkbox", 265, 265, 15, 15)
$LBLInvisible = GUICtrlCreateLabel("Invisible", 215, 265, 54, 17)
$CameraSpectate =  GUICtrlCreateCheckbox("Checkbox", 170, 319, 15, 15)
$LBLSpectateur = GUICtrlCreateLabel("Mode Spectateur", 40, 320, 100, 17)
$CameraSpectateSpeedInput = GUICtrlCreateInput(40, 140, 320, 25, 15)
$CameraSpectateNoclip =  GUICtrlCreateCheckbox("Checkbox", 170, 340, 15, 15)
$LBLNoclipCamera = GUICtrlCreateLabel("Traverser tout", 40, 340, 100, 17)
$CameraFollow =  GUICtrlCreateCheckbox("Checkbox", 170, 360, 15, 15)
$LBLFollowTar = GUICtrlCreateLabel("Suivre la cible", 40, 360, 100, 17)
$PriveTeleportCamera = GUICtrlCreateButton("TP Caméra (Serv. privé)", 50, 380, 120)
$HeureInput = GUICtrlCreateInput(_MemoryRead($TimeHeure,$WowProcess,"dword"), 240, 315, 25, 20)
$LBLHeure = GUICtrlCreateLabel("Heures", 200, 316, 40, 17)
$HeureInputOK = GUICtrlCreateButton("Ok", 270, 315, 20, 20, $WS_GROUP)
$MinutesInput = GUICtrlCreateInput(_MemoryRead($TimeMinutes,$WowProcess,"dword"), 240, 340, 25, 20)
GUICtrlCreateLabel("Minutes", 200, 341, 40, 17)
$MinutesInputOK = GUICtrlCreateButton("Ok", 270, 340, 20, 20, $WS_GROUP)
$VitesseTempsInput = GUICtrlCreateInput(1, 240, 365, 50, 20)
$LBLVitesseTemps = GUICtrlCreateLabel("Vitesse", 200, 366, 40, 17)
$VitesseTempsInputOK = GUICtrlCreateButton("Ok", 270, 385, 20, 20, $WS_GROUP)
$MapSHOW = GUICtrlCreateButton("Dévoiler la carte", 200, 510, 90, 28, $WS_GROUP)
$TitreMENU = GUICtrlCreateCombo("0   Titre", 30, 515, 160, 25)
GUICtrlSetData(-1, "0   Aucun|1   Soldat|2   Caporal|3   Sergent|4   Sergent-Chef|5   Sergent-Major|6   Chevalier|7   Chevalier-Lieutenant|8   Chevalier-Capitaine|9   Chevalier-Champion|10   Lieutenant-Commandant|11   Commandant|12   Maréchal|13   Grand Maréchal|14   Connétable|15   Éclaireur|16   Grunt|17   Sergent|18   Sergent-Chef|19   Adjudant|20   Garde de pierre|21   Garde de sang|22   Légionnaire|23   Centurion|24   Champion|25   Lieutenant Général|26   Général|27   Seigneur de Guerre|28   Grand Seigneur de Guerre|29   Gladiateur/rice|30   Duelliste|31   Rival/e|32   Compétiteur/rice|33   Seigneur Scarabée|34   Conquérant/e|35   Justicier/ère|36   Champion/ne des Naarus|37   Gladiateur/rice impitoyable|38   du Soleil Brisé|39   Main d'A'dal|40   Gladiateur Vengeur/Vengeresse|41   Maître de Guerre|42   le Chercheur/se|43   Ancien/ne|44   Gardien/ne des flammes|45   Garde-Flammes|46   L'exalté/e|47   L'explorateur/rice|48   Le/La diplomate|49   Gladiateur Brutal/e|50   Maître d'arène|51   loup de mer|52   Chef|53   Le/la Suprême|54   des Dix Tempêtes|55   du Rêve d'émeraude|56   Gladiateur Fatal/Fatale|57   Prophète|58   Le/La Maléfique|59   Traqueur/euse|60   de la Lame d'Ebène|61   Archimage|62   Porteguerre|63   Assassin|66   Cordon Bleu|69   Docteur|70   Grand maître pêcheur|78   de Quel'Thalas|79   d'Argus|80   de Kaz Modan|81   de Gnomeregan|82   au coeur de lion|83   champion d'Elune|84   héros d'Orgrimmar|85   le coureur des plaines|86   des Sombrelances|87   le réprouvé|88   le cherche-magie|89   Vainqueur du crépuscule|90   conquérant de Naxxramas")
$LBLEmote = GUICtrlCreateLabel("Emote sur la cible:", 85, 425, 110, 17)
$EmoteMENU = GUICtrlCreateCombo("0   Emote", 40, 445, 175, 25)
GUICtrlSetData(-1, "0   Aucun|1   Parler|2   Saluer|3   Saluer (main)|4   Acclamer|5   Affirmation|6   Question|10   Danse|11   Rire|14   Geste grossier|15   Rugir|16   Agenouiller|17   Bise|18   Pleurer|19   Poulet|20   Mendier|21   Applaudir|22   Crier|23   Montrer muscles|24   Timide|25   Montrer|28   Travailler|33   Recevoir coup|34   Recevoir coup (critique)|35   Attaque (sans arme)|36   Attaque (1 main)|37   Attaque (2 mains)|38   Attaque (2 mains)2|39   Parrer (sans arme)|43   Parrer (Bouclier)|44   Prêt attaque (sans arme)|45   Prêt attaque (1 main)|48   Prêt attaque (arc)|54   Attaque spéciale (1 main)|60   Coup de pied|61   Attaque (lancer)|64   Assommé|66   Saluer (Garde à vous)|69   Utiliser objet|92   Boire|173   Travailler (avec arme)|213   Prêt attaque (fusil)|233   Travailler (Son minage)|234   Travailler (Son bûcheron)|273   Oui|274   Non|275   Train|375   Prêt attaque (2 mains)|379   Pêche|380   Pêche lancé|381   Loot|382   Tourbillon|383   Noyé (fin)|384   Viser (arc)|385   Viser (fusil)|386   Viser (lancé)|387   Noyé (début)|389   Attaque ratée|390   Attaque esquivée|395   Saut (fin)|398   Agenouiller (maintenue)|399   Saut (début)|400   Danse Speciale (Humains uniquement)|415   Assis")
$SetTargetEmote = GUICtrlCreateButton("Ok", 40, 470, 175, 20, $WS_GROUP)
GUISetState(@SW_SHOW, $THHHGUI)
#EndRegion ### END GUI ###
#Region ### SETTINGS ###
$GUISetting = GUICreate("Options", 345, 290, -1, -1, -1)
$LangueGRP = GUICtrlCreateGroup("Langage", 250, 10, 80, 40)
$Francais = GUICtrlCreatePic(@ScriptDir&"\thhh_settings\fr.jpg", 255, 30, 20, 13)
$English = GUICtrlCreatePic(@ScriptDir&"\thhh_settings\en.jpg", 280, 30, 20, 13)
$Espanol = GUICtrlCreatePic(@ScriptDir&"\thhh_settings\es.jpg", 305, 30, 20, 13)
$InterfaceOff = GUICtrlCreateCheckbox("Checkbox", 15, 50, 15, 15)
$LBLInterfaceOff = GUICtrlCreateLabel("Utiliser l'interface de base", 35, 50, 200, 50)
$ContinueOnExit = GUICtrlCreateCheckbox("Checkbox", 15, 80, 15, 15)
$LBLContinueOnExit = GUICtrlCreateLabel("Conserver les fonctions activées après fermeture du programme", 35, 80, 200, 50)
$SaveSettings = GUICtrlCreateCheckbox("Checkbox", 15, 120, 15, 15)
$LBLSaveSettings = GUICtrlCreateLabel("Conserver les paramètres suivants à chaque lancement:", 35, 122, 200, 50)
$LaunchPrivateGRP = GUICtrlCreateGroup("Privé", 15, 155, 200, 120)
$LaunchSpeed = GUICtrlCreateCheckbox("Checkbox", 20, 170, 15, 15)
$LBLLaunchSpeed = GUICtrlCreateLabel("Vitesse", 40, 172, 60, 17)
$LaunchFly = GUICtrlCreateCheckbox("Checkbox", 20, 190, 15, 15)
$LBLLaunchFly = GUICtrlCreateLabel("Voler", 40, 192, 60, 17)
$LaunchWallclimbPrivate = GUICtrlCreateCheckbox("Checkbox", 20, 210, 15, 15)
$LBLLaunchWallClimbPrivate = GUICtrlCreateLabel("Grimper partout", 40, 212, 80, 17)
$LaunchNoCD = GUICtrlCreateCheckbox("Checkbox", 20, 230, 15, 15)
$LBLLaunchNoCD = GUICtrlCreateLabel("NoCooldown", 40, 232, 65, 17)
$LaunchRaccourcisPrivate = GUICtrlCreateCheckbox("Checkbox", 20, 250, 15, 15)
$LBLLaunchRaccourcisPrivate = GUICtrlCreateLabel("Raccourcis", 40, 252, 65, 17)
$LaunchSuperSautPrivate = GUICtrlCreateCheckbox("Checkbox", 130, 170, 15, 15)
$LBLLaunchSupersautPrivate = GUICtrlCreateLabel("Super-saut", 150, 172, 60, 17)
$LaunchTrackPrivate = GUICtrlCreateCheckbox("Checkbox", 130, 190, 15, 15)
$LBLLaunchTrackPrivate = GUICtrlCreateLabel("Pistage", 150, 192, 60, 17)
$LaunchClicktoTP = GUICtrlCreateCheckbox("Checkbox", 130, 210, 15, 15)
$LBLLaunchClicktoTP = GUICtrlCreateLabel("Click to TP", 150, 212, 60, 17)
$LaunchXYZPrivate = GUICtrlCreateCheckbox("Checkbox", 130, 230, 15, 15)
$LBLLaunchXYZPrivate = GUICtrlCreateLabel("Activer XYZ", 150, 232, 63, 17)
$LaunchOfficielGRP = GUICtrlCreateGroup("Officiel", 220, 155, 110, 120)
$LaunchSuperSautOfficiel = GUICtrlCreateCheckbox("Checkbox", 225, 170, 15, 15)
$LBLLaunchSupersautOfficiel = GUICtrlCreateLabel("Super-saut", 245, 172, 60, 17)
$LaunchWallclimbOfficiel = GUICtrlCreateCheckbox("Checkbox", 225, 190, 15, 15)
$LBLLaunchWallclimbOfficiel = GUICtrlCreateLabel("Grimper partout", 245, 192, 80, 17)
$LaunchTrackOfficiel = GUICtrlCreateCheckbox("Checkbox", 225, 210, 15, 15)
$LBLLaunchTrackOfficiel = GUICtrlCreateLabel("Pistage", 245, 212, 60, 17)
$LaunchXYZOfficiel = GUICtrlCreateCheckbox("Checkbox", 225, 230, 15, 15)
$LBLLaunchXYZOfficiel = GUICtrlCreateLabel("Activer XYZ", 245, 232, 65, 17)
$LaunchRaccourcisOfficiel = GUICtrlCreateCheckbox("Checkbox", 225, 250, 15, 15)
$LBLLaunchRaccourcisOfficiel = GUICtrlCreateLabel("Raccourcis", 245, 252, 65, 17)
#EndRegion ### END SETTINGS ###
#Region ### DEBLOQUER PERSO ###
$DebloPerso = GUICreate("  Débloquer le perso", 290, 110, -1, -1, -1, $WS_EX_TOOLWINDOW)
WinSetOnTop($DebloPerso, "", 1)
GUISetBkColor(0xefefef)
$GUITRANSDeblo = GUICtrlCreateCheckbox("Checkbox", 5, 5, 15, 15)
$TransparenceDeblo = GUICtrlCreateLabel("Transparence", 25, 7, 80, 17)
$DebloPersobutton = GUICtrlCreateButton("Cliquez pour débloquer votre perso", 30, 25, 230, 70, $WS_GROUP)
GUISetState(@SW_HIDE, $DebloPerso)
#EndRegion ### END DEBLOQUER PERSO ###
#Region ### STOP CHUTE ###
$Stopchute = GUICreate("  Stop chute", 290, 110, -1, -1, -1, $WS_EX_TOOLWINDOW)
WinSetOnTop($Stopchute, "", 1)
GUISetBkColor(0xefefef)
$GUITRANSStop = GUICtrlCreateCheckbox("Checkbox", 5, 5, 15, 15)
$TransparenceStopChute = GUICtrlCreateLabel("Transparence", 25, 7, 80, 17)
$Stopchutebutton = GUICtrlCreateButton("Cliquez pour arrêter votre chute", 30, 25, 230, 70, $WS_GROUP)
GUISetState(@SW_HIDE, $Stopchute)
#EndRegion ### END STOP CHUTE ###
#Region ### LISTE TP ###
$TPLIST = GUICreate("Teleport List", 800, 610, -1, -1)
GUISetBkColor(0xefefef)
$OnTopT = GUICtrlCreateCheckbox("Checkbox", 5, 5, 15, 15)
$ListeOnTop = GUICtrlCreateLabel("Premier plan", 25, 7, 70, 17)
$GUItransT = GUICtrlCreateCheckbox("Checkbox", 5, 25, 15, 15)
$TransparenceTP = GUICtrlCreateLabel("Transparence", 25, 27, 80, 17)
Global $Liste = @ScriptDir&"\thhh_TPlist.ini"
$line = 1
$CountLines = _FileCountLines($liste)
$CountLinesTotal = ($CountLines-6)
$PreviewList = GUICtrlCreateListView("n°|Nom|Map|X|Y|Z|Commentaire",0,50,660,450)
_GUICtrlListView_SetColumnWidth($PreviewList,0,26)
_GUICtrlListView_SetColumnWidth($PreviewList,1,235)
_GUICtrlListView_SetColumnWidth($PreviewList,2,35)
_GUICtrlListView_SetColumnWidth($PreviewList,3,35)
_GUICtrlListView_SetColumnWidth($PreviewList,4,35)
_GUICtrlListView_SetColumnWidth($PreviewList,5,35)
_GUICtrlListView_SetColumnWidth($PreviewList,6,150)
$listTeleportGO = GUICtrlCreateButton("Téléporter !",320,510,180,40)
$WEHcheckbox = GUICtrlCreateCheckbox("Checkbox", 430, 555, 15, 15)
$LVLlisteweh = GUICtrlCreateLabel("Liste WEH", 370, 557, 54, 17)
$AddTPGRP = GUICtrlCreateGroup("Ajouter un TP", 670, 55, 120, 105)
$LBLNomTP = GUICtrlCreateLabel("Nom de votre TP", 690, 75, 90, 17)
$AddTPNameInput = GUICtrlCreateInput("", 675, 90, 110, 20)
$AddTP = GUICtrlCreateButton("Ajouter TP",680,115,100,35)
$DelTPGRP = GUICtrlCreateGroup("Supprimer un TP", 670, 180, 120, 105)
$LBLTPNumber = GUICtrlCreateLabel("n° du TP", 705, 200, 60, 17)
$DelTPInput = GUICtrlCreateInput("", 705, 215, 50, 20)
$DelTP = GUICtrlCreateButton("Supprimer TP",680,240,100,35)
$MapActuName = GUICtrlCreateInput("", 701, 295, 60, 20, $ES_READONLY)
$MapActu = GUICtrlCreateInput((_MemoryRead($MapID,$WowProcess)), 716, 320, 30, 20, $ES_READONLY)
$LBLMapActuelle = GUICtrlCreateLabel("Map Actuelle", 701, 345, 90, 17)
GUISetState(@SW_HIDE, $TPLIST)
createlist()
#EndRegion ### END LISTE TP ###
#Region ### RACCOURCIS OFFICIEL ###
$SCsettingsGUI = GUICreate("Raccourcis Officiel", 200, 350, -1, -1, -1)
GUISetBkColor(0xefefef)
$SettingInputWallclimb = GUICtrlCreateInput("", 110, 30, 80, 20, $ES_READONLY)
$LBLSCWallclimbOf = GUICtrlCreateLabel("Grimper partout", 10, 33, 75, 17)
$SettingInputSupersaut = GUICtrlCreateInput("", 110, 60, 80, 20, $ES_READONLY)
$LBLSCSupersautOf = GUICtrlCreateLabel("Super-Saut", 10, 63, 54, 17)
$SettingInputNoclipAction = GUICtrlCreateInput("", 110, 90, 80, 20, $ES_READONLY)
GUICtrlCreateLabel("No-Clip Action", 10, 93, 80, 17)
Global $SCIniEmpl="Raccourcis - Officiel"
refreshSCtext("Wallclimb", $SettingInputWallclimb)
refreshSCtext("Supersaut", $SettingInputSupersaut)
refreshSCtext("Noclipaction", $SettingInputNoclipAction)
GUISetState(@SW_HIDE, $SCsettingsGUI)
#EndRegion ### END RACCOURCIS OFFICIEL ###
#Region ### RACCOURCIS PRIVE ###
$PriveSCsettingsGUI = GUICreate("Raccourcis Privé", 545, 620, -1, -1, -1)
GUISetBkColor(0xefefef)
;;; FONCTIONS
$PriveSCsettingsGUIGRPFonction = GUICtrlCreateGroup("Fonctions", 15, 10, 170, 320)
$PriveSettingInputFlymod = GUICtrlCreateInput("", 125, 25, 50, 20, $ES_READONLY)
$LBLSCFlymod = GUICtrlCreateLabel("Voler", 25, 28, 54, 17)
$PriveSettingInputSpeedglobale = GUICtrlCreateInput("", 125, 50, 50, 20, $ES_READONLY)
$LBLSCSpeedglobale = GUICtrlCreateLabel("Vitesse globale", 25, 53, 85, 17)
$PriveSettingInputSpeed = GUICtrlCreateInput("", 125, 75, 50, 20, $ES_READONLY)
$LBLSCSpeed = GUICtrlCreateLabel("Vitesse", 25, 78, 54, 17)
$PriveSettingInputWallclimb = GUICtrlCreateInput("", 125, 100, 50, 20, $ES_READONLY)
$LBLSCWallclimb = GUICtrlCreateLabel("Grimper partout", 25, 103, 75, 17)
$PriveSettingInputSupersaut = GUICtrlCreateInput("", 125, 125, 50, 20, $ES_READONLY)
$LBLSCSupersaut = GUICtrlCreateLabel("Super-Saut", 25, 128, 54, 17)
$PriveSettingInputDebloperso = GUICtrlCreateInput("", 125, 150, 50, 20, $ES_READONLY)
$LBLSCDebloperso = GUICtrlCreateLabel("Débloquer Perso", 25, 153, 100, 17)
$PriveSettingInputClicktp = GUICtrlCreateInput("", 125, 175, 50, 20, $ES_READONLY)
GUICtrlCreateLabel("Click to TP", 25, 178, 100, 17)
$PriveSettingInputGocorps = GUICtrlCreateInput("", 125, 200, 50, 20, $ES_READONLY)
$LBLSCGocorps = GUICtrlCreateLabel("TP Corps", 25, 203, 100, 17)
$PriveSettingInputStopfall = GUICtrlCreateInput("", 125, 225, 50, 20, $ES_READONLY)
$LBLSCStopchute = GUICtrlCreateLabel("Stopper chute", 25, 228, 100, 17)
$PriveSettingInputTpcibledos = GUICtrlCreateInput("", 125, 250, 50, 20, $ES_READONLY)
$LBLSCTPcibledos = GUICtrlCreateLabel("TP Cible (dos)", 25, 253, 100, 17)
$PriveSettingInputTpcibleundermap = GUICtrlCreateInput("", 125, 275, 50, 20, $ES_READONLY)
$LBLSCTPcibleundermap = GUICtrlCreateLabel("TP Cible (sous map)", 25, 278, 100, 17)
$PriveSettingInputFreezeZ = GUICtrlCreateInput("", 125, 300, 50, 20, $ES_READONLY)
$LBLSCFreezeZ = GUICtrlCreateLabel("Bloquer Z", 25, 303, 100, 17)
$PriveSCsettingsGUIGRPSpeed = GUICtrlCreateGroup("Vitesse", 15, 335, 170, 270)
$PriveSettingInputSpeedN = GUICtrlCreateInput("", 125, 350, 50, 20, $ES_READONLY)
$LBLSCSpeedN = GUICtrlCreateLabel("Vitesse normale", 25, 353, 100, 17)
$PriveSettingInputSpeed100 = GUICtrlCreateInput("", 125, 375, 50, 20, $ES_READONLY)
$LBLSCSpeed100 = GUICtrlCreateLabel("Vitesse 100%", 25, 378, 100, 17)
$PriveSettingInputSpeedcustom = GUICtrlCreateInput("", 125, 400, 50, 20, $ES_READONLY)
$LBLSCSpeedcustom = GUICtrlCreateLabel("Vitesse =", 25, 403, 50, 17)
$PriveSettingInputSpeedcustomInput = GUICtrlCreateInput(iniRead($Setting, "Raccourcis - Prive", "SpeedcustomValue", "Erreur"), 90, 401, 30, 20)
$PriveSettingInputSpeedP = GUICtrlCreateInput("", 125, 425, 50, 20, $ES_READONLY)
$LBLSCSpeedP = GUICtrlCreateLabel("Vitesse +", 25, 428, 60, 17)
$PriveSettingInputSpeedM = GUICtrlCreateInput("", 125, 450, 50, 20, $ES_READONLY)
$LBLSCSpeedM = GUICtrlCreateLabel("Vitesse -", 25, 453, 60, 17)
$PriveSettingInputSpeedIncr = GUICtrlCreateInput(iniRead($Setting, "Raccourcis - Prive", "SpeedIncr", "Erreur"), 90, 440, 30, 20)
$PriveSettingInputSpeedFlyN = GUICtrlCreateInput("", 125, 475, 50, 20, $ES_READONLY)
$LBLSCSpeedFlyN = GUICtrlCreateLabel("Vitesse vol normale", 25, 478, 100, 17)
$PriveSettingInputSpeedFly280 = GUICtrlCreateInput("", 125, 500, 50, 20, $ES_READONLY)
$LBLSCSpeedFly280 = GUICtrlCreateLabel("Vitesse vol 280%", 25, 503, 100, 17)
$PriveSettingInputSpeedFlycustom = GUICtrlCreateInput("", 125, 525, 50, 20, $ES_READONLY)
$LBLSCSpeedFlycustom = GUICtrlCreateLabel("Vitesse vol =", 25, 528, 60, 17)
$PriveSettingInputSpeedFlyCustomInput = GUICtrlCreateInput(iniRead($Setting, "Raccourcis - Prive", "SpeedFlyCustomValue", "Erreur"), 90, 526, 30, 20)
$PriveSettingInputSpeedFlyP = GUICtrlCreateInput("", 125, 550, 50, 20, $ES_READONLY)
$LBLSCSpeedFlyP = GUICtrlCreateLabel("Vitesse vol +", 25, 558, 60, 17)
$PriveSettingInputSpeedFlyM = GUICtrlCreateInput("", 125, 575, 50, 20, $ES_READONLY)
$LBLSCSpeedFlyM = GUICtrlCreateLabel("Vitesse vol -", 25, 578, 60, 17)
$PriveSettingInputSpeedFlyIncr = GUICtrlCreateInput(iniRead($Setting, "Raccourcis - Prive", "SpeedFlyIncr", "Erreur"), 90, 563, 30, 20)
;;; DIVERS
$PriveSCsettingsGUIGRPDivers = GUICtrlCreateGroup("Divers", 192, 405, 335, 117)
$PriveSettingInputSupersautP = GUICtrlCreateInput("", 295, 420, 50, 20, $ES_READONLY)
$LBLSCSupersautP = GUICtrlCreateLabel("Super-saut +", 200, 423, 90, 17)
$PriveSettingInputSupersautM = GUICtrlCreateInput("", 295, 445, 50, 20, $ES_READONLY)
$LBLSCSupersautM = GUICtrlCreateLabel("Super-saut -", 200, 448, 90, 17)
$PriveSettingInputSupersautIncr = GUICtrlCreateInput(iniRead($Setting, "Raccourcis - Prive", "SupersautIncr", "Erreur"), 260, 432, 30, 20)
$PriveSettingInputTimeSpeedP = GUICtrlCreateInput("", 295, 470, 50, 20, $ES_READONLY)
$LBLSCTimeSpeedP = GUICtrlCreateLabel("Vitesse temps +", 200, 473, 90, 17)
$PriveSettingInputTimeSpeedM = GUICtrlCreateInput("", 295, 495, 50, 20, $ES_READONLY)
$LBLSCTimeSpeedM = GUICtrlCreateLabel("Vitesse temps -", 200, 498, 90, 17)
$PriveSettingInputTimeSpeedIncr = GUICtrlCreateInput(iniRead($Setting, "Raccourcis - Prive", "TimeSpeedIncr", "Erreur"), 260, 483, 30, 20)
$PriveSettingInputTailleP = GUICtrlCreateInput("", 450, 420, 50, 20, $ES_READONLY)
$LBLSCTailleP = GUICtrlCreateLabel("Taille +", 355, 423, 90, 17)
$PriveSettingInputTailleM = GUICtrlCreateInput("", 450, 445, 50, 20, $ES_READONLY)
$LBLSCTailleM = GUICtrlCreateLabel("Taille -", 355, 448, 90, 17)
$PriveSettingInputTailleIncr = GUICtrlCreateInput(iniRead($Setting, "Raccourcis - Prive", "TailleIncr", "Erreur"), 415, 431, 30, 20)
;;;; ClicktoTP
GUICtrlCreateGroup("Click to TP", 355, 474, 165, 40)
$PriveClickTPToucheSHIFT = GUICtrlCreateRadio("Maj", 365, 489, 50, 17)
$PriveClickTPToucheCTRL = GUICtrlCreateRadio("Ctrl", 425, 489, 50, 17)
$PriveClickTPToucheALT = GUICtrlCreateRadio("Alt", 485, 489, 30, 17)
If iniRead($Setting, "Raccourcis - Prive", "Clicktptouche", "Erreur") = 10 Then
GUICtrlSetState($PriveClickTPToucheSHIFT, $GUI_CHECKED)
ElseIf iniRead($Setting, "Raccourcis - Prive", "Clicktptouche", "Erreur") = 11 Then
GUICtrlSetState($PriveClickTPToucheCTRL, $GUI_CHECKED)
ElseIf iniRead($Setting, "Raccourcis - Prive", "Clicktptouche", "Erreur") = 12 Then
GUICtrlSetState($PriveClickTPToucheALT, $GUI_CHECKED)
EndIf
;;; PVP
$PriveSCsettingsGUIGRPPvP = GUICtrlCreateGroup("Jcj - Raccourcis de téléportation", 192, 10, 335, 390)
;;; GOULET
$PriveSCsettingsGUIGRPGoulet = GUICtrlCreateGroup("Goulet", 197, 25, 160, 220)
$PriveSettingInputGouletFlagA2 = GUICtrlCreateInput("", 300, 40, 50, 20, $ES_READONLY)
$LBLSCGouletFlagA2 = GUICtrlCreateLabel("Alliance Drapeau", 205, 43, 90, 17)
$PriveSettingInputGouletRegenA2 = GUICtrlCreateInput("", 300, 65, 50, 20, $ES_READONLY)
$LBLSCGouletRegenA2 = GUICtrlCreateLabel("Alliance Regen", 205, 68, 90, 17)
$PriveSettingInputGouletBersekerA2 = GUICtrlCreateInput("", 300, 90, 50, 20, $ES_READONLY)
$LBLSCGouletBersekerA2 = GUICtrlCreateLabel("Alliance Berseker", 205, 93, 90, 17)
$PriveSettingInputGouletSprintA2 = GUICtrlCreateInput("", 300, 115, 50, 20, $ES_READONLY)
$LBLSCGouletSprintA2 = GUICtrlCreateLabel("Alliance Sprint", 205, 118, 90, 17)
$PriveSettingInputGouletFlagH2 = GUICtrlCreateInput("", 300, 140, 50, 20, $ES_READONLY)
$LBLSCGouletFlagH2 = GUICtrlCreateLabel("Horde Drapeau", 205, 143, 90, 17)
$PriveSettingInputGouletRegenH2 = GUICtrlCreateInput("", 300, 165, 50, 20, $ES_READONLY)
$LBLSCGouletRegenH2 = GUICtrlCreateLabel("Horde Regen", 205, 168, 90, 17)
$PriveSettingInputGouletBersekerH2 = GUICtrlCreateInput("", 300, 190, 50, 20, $ES_READONLY)
$LBLSCGouletBersekerH2 = GUICtrlCreateLabel("Horde Berseker", 205, 193, 90, 17)
$PriveSettingInputGouletSprintH2 = GUICtrlCreateInput("", 300, 215, 50, 20, $ES_READONLY)
$LBLSCGouletSprintH2 = GUICtrlCreateLabel("Horde Sprint", 205, 218, 90, 17)
;;; ARATHI
$PriveSCsettingsGUIGRPArathi = GUICtrlCreateGroup("Arathi", 277, 250, 160, 145)
$PriveSettingInputArathiEcurie = GUICtrlCreateInput("", 380, 265, 50, 20, $ES_READONLY)
$LBLSCArathiEcurie = GUICtrlCreateLabel("Écurie", 285, 268, 90, 17)
$PriveSettingInputArathiFerme = GUICtrlCreateInput("", 380, 290, 50, 20, $ES_READONLY)
$LBLSCArathiFerme = GUICtrlCreateLabel("Ferme", 285, 293, 90, 17)
$PriveSettingInputArathiMine = GUICtrlCreateInput("", 380, 315, 50, 20, $ES_READONLY)
$LBLSCArathiMine = GUICtrlCreateLabel("Mine", 285, 318, 90, 17)
$PriveSettingInputArathiForge = GUICtrlCreateInput("", 380, 340, 50, 20, $ES_READONLY)
$LBLSCArathiForge = GUICtrlCreateLabel("Forge", 285, 343, 90, 17)
$PriveSettingInputArathiScierie = GUICtrlCreateInput("", 380, 365, 50, 20, $ES_READONLY)
$LBLSCArathiScierie = GUICtrlCreateLabel("Scierie", 285, 368, 90, 17)
;;; OEIL
$PriveSCsettingsGUIGRPOeil = GUICtrlCreateGroup("Oeil du cyclone", 362, 25, 160, 145)
$PriveSettingInputOeilDrapeau = GUICtrlCreateInput("", 465, 40, 50, 20, $ES_READONLY)
$LBLSCOeilDrapeau = GUICtrlCreateLabel("Drapeau", 370, 43, 90, 17)
$PriveSettingInputOeilTourMages = GUICtrlCreateInput("", 465, 65, 50, 20, $ES_READONLY)
$LBLSCOeilTourMages = GUICtrlCreateLabel("Tour Mages", 370, 68, 90, 17)
$PriveSettingInputOeilRuinesDraenei = GUICtrlCreateInput("", 465, 90, 50, 20, $ES_READONLY)
$LBLSCOeilRuinesDraenei = GUICtrlCreateLabel("Ruines Draenei", 370, 93, 90, 17)
$PriveSettingInputOeilTourElfes = GUICtrlCreateInput("", 465, 115, 50, 20, $ES_READONLY)
$LBLSCOeilTourElfes = GUICtrlCreateLabel("Tour Elfes", 370, 118, 90, 17)
$PriveSettingInputOeilRuinesSaccageur = GUICtrlCreateInput("", 465, 140, 50, 20, $ES_READONLY)
$LBLSCOeilRuinesSaccageur = GUICtrlCreateLabel("Ruines Saccageur", 370, 143, 90, 17)
;;; ALTERAC
$PriveSCsettingsGUIGRPAlterac = GUICtrlCreateGroup("Alterac", 362, 175, 160, 70)
$PriveSettingInputAlteracA2 = GUICtrlCreateInput("", 465, 190, 50, 20, $ES_READONLY)
$LBLSCAlteracA2 = GUICtrlCreateLabel("Coté Alliance", 370, 193, 90, 17)
$PriveSettingInputAlteracH2 = GUICtrlCreateInput("", 465, 215, 50, 20, $ES_READONLY)
$LBLSCAlteracH2 = GUICtrlCreateLabel("Coté Horde", 370, 218, 90, 17)
;;; Premier refresh pour pas avoir de cases vides (elles se refresh quand on clique dessus uniquement)
Global $SCIniEmpl="Raccourcis - Prive"
refreshSCtext("Flymod", $PriveSettingInputFlymod)
refreshSCtext("Speedglobale", $PriveSettingInputSpeedglobale)
refreshSCtext("Speed", $PriveSettingInputSpeed)
refreshSCtext("Wallclimb", $PriveSettingInputWallclimb)
refreshSCtext("Supersaut", $PriveSettingInputSupersaut)
refreshSCtext("Debloperso", $PriveSettingInputDebloperso)
refreshSCtext("Clicktp", $PriveSettingInputClicktp)
refreshSCtext("Gocorps", $PriveSettingInputGocorps)
refreshSCtext("Stopfall", $PriveSettingInputStopfall)
refreshSCtext("Tpcibledos", $PriveSettingInputTpcibledos)
refreshSCtext("Tpcibleundermap", $PriveSettingInputTpcibleundermap)
refreshSCtext("FreezeZ", $PriveSettingInputFreezeZ)
refreshSCtext("SpeedN", $PriveSettingInputSpeedN)
refreshSCtext("Speed100", $PriveSettingInputSpeed100)
refreshSCtext("Speedcustom", $PriveSettingInputSpeedcustom)
refreshSCtext("SpeedP", $PriveSettingInputSpeedP)
refreshSCtext("SpeedM", $PriveSettingInputSpeedM)
refreshSCtext("SpeedFlyN", $PriveSettingInputSpeedFlyN)
refreshSCtext("SpeedFly280", $PriveSettingInputSpeedFly280)
refreshSCtext("SpeedFlycustom", $PriveSettingInputSpeedFlycustom)
refreshSCtext("SpeedFlyP", $PriveSettingInputSpeedFlyP)
refreshSCtext("SpeedFlyM", $PriveSettingInputSpeedFlyM)
refreshSCtext("SupersautP", $PriveSettingInputSupersautP)
refreshSCtext("SupersautM", $PriveSettingInputSupersautM)
refreshSCtext("TimeSpeedP", $PriveSettingInputTimeSpeedP)
refreshSCtext("TimeSpeedM", $PriveSettingInputTimeSpeedM)
refreshSCtext("TailleP", $PriveSettingInputTailleP)
refreshSCtext("TailleM", $PriveSettingInputTailleM)
refreshSCtext("FlagA2", $PriveSettingInputGouletFlagA2)
refreshSCtext("RegenA2", $PriveSettingInputGouletRegenA2)
refreshSCtext("BersekerA2", $PriveSettingInputGouletBersekerA2)
refreshSCtext("SprintA2", $PriveSettingInputGouletSprintA2)
refreshSCtext("FlagH2", $PriveSettingInputGouletFlagH2)
refreshSCtext("RegenH2", $PriveSettingInputGouletRegenH2)
refreshSCtext("BersekerH2", $PriveSettingInputGouletBersekerH2)
refreshSCtext("SprintH2", $PriveSettingInputGouletSprintH2)
refreshSCtext("Ecurie", $PriveSettingInputArathiEcurie)
refreshSCtext("Ferme", $PriveSettingInputArathiFerme)
refreshSCtext("Mine", $PriveSettingInputArathiMine)
refreshSCtext("Forge", $PriveSettingInputArathiForge)
refreshSCtext("Scierie", $PriveSettingInputArathiScierie)
refreshSCtext("OeilDrapeau", $PriveSettingInputOeilDrapeau)
refreshSCtext("TourMages", $PriveSettingInputOeilTourMages)
refreshSCtext("RuinesDraenei", $PriveSettingInputOeilRuinesDraenei)
refreshSCtext("TourElfes", $PriveSettingInputOeilTourElfes)
refreshSCtext("RuinesSaccageur", $PriveSettingInputOeilRuinesSaccageur)
refreshSCtext("A2", $PriveSettingInputAlteracA2)
refreshSCtext("H2", $PriveSettingInputAlteracH2)
GUISetState(@SW_HIDE, $PriveSCsettingsGUI)
#EndRegion ### END RACCOURCIS PRIVE ###
adlibregister("globalf")
GUICtrlSetData($PriveSpeedGlobaleInput,Abs(IniRead($Setting,"Reglages","pspeedglobalevalue","Error")))
GUICtrlSetData($PriveSpeedInput,Abs(IniRead($Setting,"Reglages","pspeedvalue","Erreur")))
GUICtrlSetData($PriveFlySpeedInput,Abs(IniRead($Setting,"Reglages","pflymodspeedvalue","Erreur")))
GUICtrlSetData($PriveSuperSautInput,Abs(IniRead($Setting,"Reglages","psupersautvalue","Erreur")))
GUICtrlSetData($SuperSautInput,Abs(IniRead($Setting,"Reglages","osupersautvalue","Erreur")))
GUICtrlSetData($PriveXYZSpeedInput,Abs(IniRead($Setting,"Reglages","pXYZSpeed","Erreur")))
If IniRead($Setting,"Reglages","Reglages","Erreur") = 1 Then
	GUICtrlSetState($SaveSettings, $GUI_CHECKED)
	reglageslancement()
Else
	disablesettingchoice()
EndIf
If IniRead($Setting,"Reglages","Continue","Erreur") = 1 Then
	GUICtrlSetState($ContinueOnExit, $GUI_CHECKED)
EndIf
If IniRead($Setting,"Reglages","Interface","Erreur") = 0 Then
	GUICtrlSetState($InterfaceOff, $GUI_CHECKED)
EndIf
If FileExists(@ScriptDir&"\thhh_settings\thhh_settings.ini") = 0 then
MsgBox(0,"Erreur","Le fichier de configuration n'a pas été trouvé, vous ne pouvez donc pas utiliser de raccourcis."&@CRLF&"Assurez-vous d'avoir décompressé le fichier téléchargé avant de lancer The Hitchhiker's Hack."&@CRLF&" "&@CRLF&"Le fichier de configuration (thhh_settings.ini) doit se trouver dans le répertoire thhh_settings pour que le programme fonctionne pleinement."&@CRLF&" "&@CRLF&" "&@CRLF&"__________________________________________________________________"&@CRLF&"Configuration's file can't be found, you can't use shortcuts."&@CRLF&"Please make sure that you have extract the downloaded file before launching The Hitchhiker's Hack."&@CRLF&" "&@CRLF&"The configuration's (thhh_settings.ini) file must be in the folder thhh_settings to make the program work fine.")
EndIf
language()

Do
    Switch GUIGetMsg()
		Case $Reset
			reset()
		Case $About
			MsgBox(0,"About","Merci aux communautées de www.mmo-trick.com, wwww.cheat-w0w.com et www.cheat-gam3.com pour leur soutient !"&@CRLF&"-----------------------------------------------------------------------------------------------------------------------------------------------"&@CRLF&" "&@CRLF&"Programme créé par Bob_74 pour la version "&$Version&" de WoW"&@CRLF&" "&@CRLF&"Ce programme ne sera plus mis à jour désormais, le code source est disponible sur www.mmo-trick.com, wwww.cheat-w0w.com, www.cheat-gam3.com et www.elitepvpers.de")
	;;;;;;;;;;;; Si activé, pas de reset à la fermeture
		Case $ContinueOnExit
			If GUICtrlRead($ContinueOnExit) = $GUI_CHECKED Then
				IniWrite($Setting,"Reglages","Continue", 1)
			ElseIf GUICtrlRead($ContinueOnExit) = $GUI_UNCHECKED Then
				IniWrite($Setting,"Reglages","Continue", 0)
			EndIf
	;;;;;;;;;; CHOIX DE LA LANGUE
		Case $Francais
			IniWrite($Setting, "Langue", "Langue", "0")
				language()
		Case $English
			IniWrite($Setting, "Langue", "Langue", "1")
				language()
		Case $Espanol
			IniWrite($Setting, "Langue", "Langue", "2")
				language()
	;;;;;;;;;;; DESACTIVATION DE L'INTERFACE (ancienne interface)
		Case $InterfaceOff
			If GUICtrlRead($InterfaceOff) = $GUI_CHECKED Then
				IniWrite($Setting,"Reglages","Interface", 0)
			ElseIf GUICtrlRead($InterfaceOff) = $GUI_UNCHECKED Then
				IniWrite($Setting,"Reglages","Interface", 1)
			EndIf
			If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
				MsgBox(0,"","Vous devez redémarrer le programme pour que l'interface soit changée")
			Else
				MsgBox(0,"","The program need to be restarted to change the interface")
			EndIf
	;;;;;;;;;;; PERMETTRE OU NON DE SAUVEGARDER LES FONCTIONS ENCLENCHEES AU DEMARRAGE
		Case $SaveSettings
			If GUICtrlRead($SaveSettings) = $GUI_CHECKED Then
				IniWrite($Setting,"Reglages", "Reglages", 1)
				enablesettingchoice()
			ElseIf GUICtrlRead($SaveSettings) = $GUI_UNCHECKED Then
				IniWrite($Setting,"Reglages", "Reglages", 0)
				disablesettingchoice()
			EndIf
	;;;;;;;;;; REGLAGES ON-TOP ET TRANSPARENCE
		Case $OnTop
			If GUICtrlRead($OnTop) = $GUI_CHECKED Then
				WinSetOnTop($THHHGUI, "", 1)
			ElseIf GUICtrlRead($OnTop) = $GUI_UNCHECKED Then
				WinSetOnTop($THHHGUI, "", 0)
			EndIf
		Case $OnTopT
			If GUICtrlRead($OnTopT) = $GUI_CHECKED Then
				WinSetOnTop($TPLIST, "", 1)
			ElseIf GUICtrlRead($OnTopT) = $GUI_UNCHECKED Then
				WinSetOnTop($TPLIST, "", 0)
			EndIf
		Case $GUITRANS
			If GUICtrlRead($GUITRANS) = 1 Then
				WinSetTrans($THHHGUI, -1, 150)
			Else
				WinSetTrans($THHHGUI, -1, 255)
			EndIf
		Case $GUITRANST
			If GUICtrlRead($GUITRANST) = 1 Then
				WinSetTrans($TPLIST, -1, 150)
			Else
				WinSetTrans($TPLIST, -1, 255)
			EndIf
		Case $GUITRANSStop
			If GUICtrlRead($GUITRANSStop) = 1 Then
				WinSetTrans($Stopchute, -1, 150)
			Else
				WinSetTrans($Stopchute, -1, 255)
			EndIf
		Case $GUITRANSDeblo
			If GUICtrlRead($GUITRANSDeblo) = 1 Then
				WinSetTrans($DebloPerso, -1, 150)
			Else
				WinSetTrans($DebloPerso, -1, 255)
			EndIf
	;;;;;;;;;;;;;;;;;;;;; OUVERTURE DES FENETRES
		Case $ListOuvrir
			settpname()
			GUISetState(@SW_SHOW, $TPLIST)
		Case $PriveDebloPerso
			GUISetState(@SW_SHOW, $DebloPerso)
		Case $StopchuteON
			GUISetState(@SW_SHOW, $Stopchute)
		Case $Optionsbutton
			GUISetState(@SW_SHOW, $GUISetting)
		Case $SCsettings
			GUISetState(@SW_SHOW, $SCsettingsGUI)
		Case $PriveSCsettings
			GUISetState(@SW_SHOW, $PriveSCsettingsGUI)
	;;;;;;;;;;;;;;;;;;;;; FERMETURE DES FENETRES
		Case $GUI_EVENT_CLOSE
			If WinActive("Teleport List") Then
				GUISetState(@SW_HIDE, $TPLIST)
			ElseIf WinActive("  Débloquer le perso") Then
				GUISetState(@SW_HIDE, $DebloPerso)
			ElseIf WinActive("  Stop chute") Then
				GUISetState(@SW_HIDE, $Stopchute)
			ElseIf WinActive("Options") Then
				GUISetState(@SW_HIDE, $GUISetting)
			ElseIf WinActive("Raccourcis Privé") Then
				If GUICtrlRead($PriveRaccourcis) = $GUI_CHECKED Then
					assignSCprivate() ;;;;; Si on ferme la fenêtre de raccourcis, on en profite pour assigner les raccourcis si Raccourcis est coché
				EndIf
					If GUICtrlRead($PriveClickTPToucheSHIFT) = $GUI_CHECKED Then
						$ClickTpTouche = 10
						IniWrite($Setting, "Raccourcis - Prive", "Clicktptouche", 10)
					ElseIf GUICtrlRead($PriveClickTPToucheCTRL) = $GUI_CHECKED Then
						$ClickTpTouche = 11
						IniWrite($Setting, "Raccourcis - Prive", "Clicktptouche", 11)
					ElseIf GUICtrlRead($PriveClickTPToucheALT) = $GUI_CHECKED Then
						$ClickTpTouche = 12
						IniWrite($Setting, "Raccourcis - Prive", "Clicktptouche", 12)
					EndIf
						$SpeedIncrWriteINI = GUICtrlRead($PriveSettingInputSpeedIncr)
						IniWrite($Setting,"Raccourcis - Prive", "SpeedIncr", $SpeedIncrWriteINI)
						$SpeedFlyIncrWriteINI = GUICtrlRead($PriveSettingInputSpeedFlyIncr)
						IniWrite($Setting,"Raccourcis - Prive", "SpeedFlyIncr", $SpeedFlyIncrWriteINI)
						$SupersautIncrWriteINI = GUICtrlRead($PriveSettingInputSupersautIncr)
						IniWrite($Setting,"Raccourcis - Prive", "SupersautIncr", $SupersautIncrWriteINI)
						$TimeSpeedIncrWriteINI = GUICtrlRead($PriveSettingInputTimeSpeedIncr)
						IniWrite($Setting,"Raccourcis - Prive", "TimeSpeedIncr", $TimeSpeedIncrWriteINI)
						$TailleIncrWriteINI = GUICtrlRead($PriveSettingInputTailleIncr)
						IniWrite($Setting,"Raccourcis - Prive", "TailleIncr", $TailleIncrWriteINI)
						IniWrite($Setting,"Raccourcis - Prive","SpeedCustomValue",GUICtrlRead($PriveSettingInputSpeedCustomInput))
						IniWrite($Setting,"Raccourcis - Prive","SpeedFlyCustomValue",GUICtrlRead($PriveSettingInputSpeedFlyCustomInput))
					GUISetState(@SW_HIDE, $PriveSCsettingsGUI)
			ElseIf WinActive("Raccourcis Officiel") Then
				If GUICtrlRead($Raccourcis) = $GUI_CHECKED Then
					assignSC() ;;;;; Si on ferme la fenêtre de raccourcis, on en profite pour assigner les raccourcis si Raccourcis est coché
				EndIf
					GUISetState(@SW_HIDE, $SCsettingsGUI)
			ElseIf WinActive("The Hitchhiker's Hack") Then
				IniWrite($Setting,"Reglages","pspeedvalue",GUICtrlRead($PriveSpeedInput)) ;;;;; Sauvegarde des valeurs principales
				IniWrite($Setting,"Reglages","pspeedglobalevalue",GUICtrlRead($PriveSpeedGlobaleInput))
				IniWrite($Setting,"Reglages","pflymodspeedvalue",GUICtrlRead($PriveFlySpeedInput))
				IniWrite($Setting,"Reglages","psupersautvalue",GUICtrlRead($PriveSuperSautInput))
				IniWrite($Setting,"Reglages","osupersautvalue",GUICtrlRead($SuperSautInput))
				IniWrite($Setting,"Reglages","pXYZSpeed",GUICtrlRead($PriveXYZSpeedInput))
					If IniRead($Setting,"Reglages","Reglages","Erreur") = 1 Then
						savevalues()													  ;;;;; Sauvegarde des "valeurs" choisies (options enclenchées, etc)
					EndIf
						If IniRead($Setting,"Reglages","Continue","Erreur") = 1 Then
						Else
							reset()
						EndIf
					_MemoryClose($WowProcess)
				Exit
			EndIf
	;;;;;;;;;;;;;;;;;;;;;;;;;; PRIVE
 		Case $PriveGoTP
			gotp()
		Case $PriveCopyTP
			copytp()
		Case $PriveGoCorps
			gocorps()
		Case $PriveSpeedON
			speed()
		Case $PriveFlyModON
			flymod()
		Case $PriveWaterWalkON
			privewaterwalk()
		Case $PriveUnderwaterWalkON
			underwaterwalk()
		Case $PriveWalljumpON
			walljump()
		Case $PriveMountON
			Global $Mount1Value=_MemoryRead($Mount1, $WowProcess, "ptr")
			Global $Mount2Value=_MemoryRead($Mount2, $WowProcess, "ptr")
			privemount()
		Case $PriveInfiniteJumpON
			privemultijump()
		Case $PriveWallClimbON
			WallClimbFunc()
		Case $PriveTrackHerbes
			privetrackherbes()
		Case $PriveTrackFilons
			privetrackfilons()
		Case $PriveTrackCoffres
			privetrackcoffres()
		Case $PriveTrackPoissons
			privetrackpoissons()
		Case $PriveTrackAllRes
			privetrackallres()
		Case $PriveTrackAllBet
			privetrackallbet()
		Case $PriveTrackBetes
			Privetrackbetes()
		Case $PriveTrackDragons
			privetrackdragons()
		Case $PriveTrackDemons
			privetrackdemons()
		Case $PriveTrackElementaires
			privetrackelementaires()
		Case $PriveTrackGeants
			privetrackgeants()
		Case $PriveTrackMortsVivants
			privetrackmortsvivants()
		Case $PriveTrackHumanoides
			privetrackhumanoides()
		Case $PriveTrackBestioles
			privetrackbestioles()
		Case $PriveFreezeZON
			privefreezez()
		Case $PriveNoClipON
			privenoclip()
		Case $PriveCollisionsM2
			collisionM2()
		Case $PriveCollisionsWMO
			collisionWMO()
		Case $PriveCollisionsAll
			collisionAll()
		Case $PriveTPcibleDos
			privetpcibledos()
		Case $PriveTPcibleUndermap
			privetpcibleundermap()
		Case $DebloPersobutton
			debloperso()
		Case $Stopchutebutton
			privestopfall()
	;;;;;;;;;;;;;;;;;;;;;;;;; LISTE TP
		Case $ListTeleportGO
			getTP()
		Case $AddTP
			addtp()
		Case $DelTP
			deltp()
	;;;;;;;;;;;;;;;;;;;;;;;;;; OFFICIEL
		Case $UnderwaterWalkON
			underwaterwalk()
		Case $WaterWalkON
			waterwalk()
		Case $WalljumpON
			walljump()
		Case $WallClimbON
			WallClimbFunc()
		Case $CollisionsM2
			collisionM2()
		Case $CollisionsWMO
			collisionWMO()
		Case $CollisionsAll
			collisionAll()
		Case $TrackHerbes
			trackherbes()
		Case $TrackFilons
			trackfilons()
		Case $TrackCoffres
			trackcoffres()
		Case $TrackPoissons
			trackpoissons()
		Case $TrackAllRes
			trackallres()
		Case $TrackAllBet
			trackallbet()
		Case $TrackBetes
			trackbetes()
		Case $TrackDragons
			trackdragons()
		Case $TrackDemons
			trackdemons()
		Case $TrackElementaires
			trackelementaires()
		Case $TrackGeants
			trackgeants()
		Case $TrackMortsVivants
			trackmortsvivants()
		Case $TrackHumanoides
			trackhumanoides()
		Case $TrackBestioles
			trackbestioles()
	;;;;;;;;;;;;;;;;;;;;;;;;;; JOUEUR
		Case $SetTargetEmote
			settargetemote()
		Case $TitreMENU
			settargettitre()
		Case $CameraSpectate
			cameraspectate()
		Case $CameraSpectateNoclip
			cameranoclip()
		Case $CameraFollow
			camerafollow()
		Case $PriveTeleportCamera
			priveteleportcamera()
 		Case $PlayerTailleP
			TailleP()
 		Case $PlayerTailleM
			TailleM()
 		Case $PlayerScaleInputOK
			PlayerScaleInputFunc()
 		Case $PlayerHauteurInputOK
			PlayerHauteurInputFunc()
 		Case $PlayerLargeurInputOK
			PlayerLargeurInputFunc()
		Case $PlayerInputRESET
			PlayerInputResetFunc()
 		Case $MapSHOW
			showmap()
		Case $HeureInputOK
			setheure()
		Case $MinutesInputOK
			setminutes()
		Case $VitesseTempsInputOK
			settimespeed()
		Case $PlayerFlags2Check1
			playershow1()
		Case $PlayerFlags2Check2
			playershow2()
	;;;;;;;;;;;;;;;;;;;;;;;;;;; RACCOURCIS
		Case $Raccourcis
			If GUICtrlRead($Raccourcis) = $GUI_CHECKED Then
				assignSC()
			Else
				unassignSC()
			EndIf
		Case $PriveRaccourcis
			If GUICtrlRead($PriveRaccourcis) = $GUI_CHECKED Then
				assignSCprivate()
			Elseif GUICtrlRead($PriveRaccourcis) = $GUI_UNCHECKED Then
				unassignSCprivate()
			EndIf
	EndSwitch
	;;;;;;;;;;;;;;;;;;;;;;;;;;; REFRESH RACCOURCIS
If WinGetState("Raccourcis Privé")=15 Then
	PriveSCsettings()
ElseIf WinGetState("Raccourcis Officiel")=15 Then
	SCsettings()
Else
EndIf
	;;;;;;;;;;;;;;;;;;;;;;;;;;; FREEZED FUNCTIONS
If GUICtrlRead($TpON)=$GUI_CHECKED Then
	Tp()
EndIf
If GUICtrlRead($SuperSautON)=$GUI_CHECKED Then
	SuperSaut()
EndIf
If GUICtrlRead($PriveSuperSautON)=$GUI_CHECKED Then
	PriveSuperSaut()
EndIf
If GUICtrlRead($PriveXYZON)=$GUI_CHECKED Then
	privexyz()
EndIf
If GUICtrlRead($PriveClickTP)=$GUI_CHECKED Then
	clicktp()
EndIf
If GUICtrlRead($NoCooldownCheck)=$GUI_CHECKED Then
	NoCooldown()
EndIf
	Inebriation()
Until $GUI_EVENT_CLOSE=1

func globalf()
$WowProcessListViewItemCount = ProcessList("Wow.exe")
If $WowProcessListViewItemCount[0][0] = 0 Then
_GUICtrlListView_DeleteAllItems($WowProcesslistview)
$WowProcessListViewItemCountSave = 0
ElseIf $WowProcessListViewItemCount[0][0] = $WowProcessListViewItemCountSave Then
_MemoryClose($WowProcess)
$SelectedPID = _GUICtrlListView_GetSelectedIndices(GUICtrlGetHandle($WowProcesslistview))
$SelectedPIDadd = ($SelectedPID+1)
Global $WowPid = $WowProcessList[$SelectedPIDadd][1]
Global $WowProcess = _MEMORYOPEN($WowPid)
$PB1 = _MemoryRead($StaticPlayer,$WowProcess,"Ptr")
$PB2 = _MemoryRead($PB1+$PbPointer1,$WowProcess,"Ptr")
$PlayerBase = _MemoryRead($PB2+$PbPointer2,$WowProcess,"Ptr")
$PlayerBase2 = _MemoryRead($PlayerBase+8,$WowProcess,"Ptr")
If _MemoryRead($BuildAddr,$WowProcess,"char[31]")=$Build Then
If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
GUICtrlSetData($State,"Programme activé")
GUICtrlSetColor($State,0x33AA00)
ElseIf IniRead($Setting,"Langue","Langue","Erreur") = 1 Then
GUICtrlSetData($State,"Program activated")
GUICtrlSetColor($State,0x33AA00)
Else
GUICtrlSetData($State,"Program activated")
GUICtrlSetColor($State,0x33AA00)
EndIf
Else
If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
GUICtrlSetData($State,"Version incompatible avec votre jeu !")
GUICtrlSetColor($State,0xFF0000)
Else
GUICtrlSetData($State,"Unsupported game version !")
GUICtrlSetColor($State,0xFF0000)
EndIf
EndIf
$PLAYERBASEAD2=_MemoryRead(($PlayerBase + $PLAYERBASE_AD2), $WowProcess, "ptr")
$LVL1CAMERAPOINTER = _MemoryRead($CAM_CAMERASTATIC, $WowProcess, "ptr")
$LVL2CAMERAPOINTER = _MemoryRead(($LVL1CAMERAPOINTER + $CAM_CAMERAOFFSA), $WowProcess, "ptr")
$OFS_PBSPECTATE=$PLAYERBASEAD2 + $PLAYERBASE_PBSPECTATE
$MEMORYCAM = $LVL2CAMERAPOINTER + $CAM_CAMERAOFFSB
$MEMORYCAMROTZ = $MEMORYCAM + $CAM_CAMERAROTZ
$MEMORYCAMROTX = $MEMORYCAM + $CAM_CAMERAROTX
GUICtrlSetData($PriveMAPInput,_MemoryRead($MapID,$WowProcess))
GUICtrlSetData($PriveMAPInputTP,_MemoryRead($MapID,$WowProcess))
If _MemoryRead($MapID,$WowProcess) = 4294967295 Then
GUICtrlSetData($MapActu,"")
Else
GUICtrlSetData($MapActu,_MemoryRead($MapID,$WowProcess))
EndIf
$MapNamePath = _MemoryRead($MapName,$WowProcess, "char[30]")
$MapName1 = StringReplace($MapNamePath, "World\Maps\", "")
$MapName2 = StringReplace($MapName1, "Expansion01", "Outreterre")
$MapNameFinal = StringReplace($MapName2, "Northrend", "Norfendre")
GUICtrlSetData($MapActuName,$MapNameFinal)
GUICtrlSetData($PriveXInput,Round(_MemoryRead($PlayerBase+$PosX,$WowProcess,"float"), 3))
GUICtrlSetData($PriveYInput,Round(_MemoryRead($PlayerBase+$PosY,$WowProcess,"float"), 3))
GUICtrlSetData($PriveZInput,Round(_MemoryRead($PlayerBase+$PosZ,$WowProcess,"float"), 3))


;;;;;;;;;; PRIVE GOBALF

If GUICtrlRead($PriveSpeedGlobaleON)=$GUI_CHECKED Then
	$PriveSpeedInputed = GUICtrlRead($PriveSpeedGlobaleInput)
	Global $PriveSpeedInputedPourcent = Round((($PriveSpeedInputed-7)*100)/7,0)
Else
	$PriveSpeedInputed = GUICtrlRead($PriveSpeedInput)
	Global $PriveSpeedInputedPourcent = Round((($PriveSpeedInputed-7)*100)/7,0)
EndIf
If $PriveSpeedInputedPourcent > 0 Then
	GUICtrlSetData($LBLSpeedPourcent,"+"&$PriveSpeedInputedPourcent&"%")
Else
	GUICtrlSetData($LBLSpeedPourcent,$PriveSpeedInputedPourcent&"%")
EndIf

If GUICtrlRead($PriveSpeedGlobaleON)=$GUI_CHECKED Then
	GUICtrlSetState($PriveSpeedON,$GUI_DISABLE)
	GUICtrlSetState($PriveSpeedInput,$GUI_DISABLE)
	GUICtrlSetState($PriveFlySpeedInput,$GUI_DISABLE)
	$PriveSpeedGlobaleInputed = GUICtrlRead($PriveSpeedGlobaleInput)
	_MemoryWrite($PlayerBase+$SpeedGlobale,$WowProcess,$PriveSpeedGlobaleInputed, "float")
Else
	GUICtrlSetState($PriveSpeedON,$GUI_ENABLE)
	GUICtrlSetState($PriveSpeedInput,$GUI_ENABLE)
	GUICtrlSetState($PriveFlySpeedInput,$GUI_ENABLE)
EndIf

If GUICtrlRead($PriveSpeedON)=$GUI_CHECKED Then
	GUICtrlSetState($PriveSpeedGlobaleON,$GUI_DISABLE)
	GUICtrlSetState($PriveSpeedGlobaleInput,$GUI_DISABLE)
	$PriveSpeedInputed = GUICtrlRead($PriveSpeedInput)
	 _MemoryWrite($PlayerBase+$Speed,$WowProcess,$PriveSpeedInputed, "float")
	 _MemoryWrite($PlayerBase+$SpeedSwim,$WowProcess,$PriveSpeedInputed, "float")
EndIf

If GUICtrlRead($PriveFlyModON)=$GUI_CHECKED Then
	$PriveFlySpeedInputed = GUICtrlRead($PriveFlySpeedInput)
	_MemoryWrite($PlayerBase+$FlySpeed,$WowProcess,$PriveFlySpeedInputed, "float")
	If _MemoryRead($PlayerBase+$PlayerState,$WowProcess,"dword")=4278190208 then
		_MemoryWrite($PlayerBase+$PlayerState,$WowProcess,129, "dword")
	EndIf
EndIf

If GUICtrlRead($PriveFreezeZON)=$GUI_CHECKED Then
	If _MemoryRead($PlayerBase+$PlayerState2,$WowProcess,"ptr")=0x80000000 Then
		_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,0x80000400, "ptr")
	EndIf
EndIf

If GUICtrlRead($PriveWaterWalkON)=$GUI_CHECKED Then
	 _MemoryWrite($PlayerBase+$PlayerState,$WowProcess,144, "dword")
EndIf

If GUICtrlRead($PriveMountON)=$GUI_CHECKED Then
	_MemoryWrite($Mount1, $WowProcess,$Mount1Value+0x00000077, "Ptr")
	_MemoryWrite($Mount2, $WowProcess,$Mount2Value+0x00000077, "Ptr")
EndIf

If GUICtrlRead($PriveInfiniteJumpON)=$GUI_CHECKED Then
	_MemoryWrite($InfiniteJumpPatch, $WowProcess,0xB70F0075, "Ptr")
EndIf

If GUICtrlRead($PriveCollisionsM2)=$GUI_CHECKED or GUICtrlRead($CollisionsM2)=$GUI_CHECKED Then
	_MemoryWrite($CollisionM2S, $WOWPROCESS, 0x458B17EB, "Ptr")
	_MemoryWrite($CollisionM2C, $WOWPROCESS, 0x0162054A, "Ptr")
EndIf

If GUICtrlRead($PriveCollisionsWMO)=$GUI_CHECKED or GUICtrlRead($CollisionsWMO)=$GUI_CHECKED Then
	_MemoryWrite($CollisionWMO, $WOWPROCESS, 0xC0329090, "Ptr")
EndIf

If GUICtrlRead($PriveCollisionsAll)=$GUI_CHECKED or GUICtrlRead($CollisionsAll)=$GUI_CHECKED Then
	GUICtrlSetState($PriveCollisionsWMO,$GUI_DISABLE)
	GUICtrlSetState($PriveCollisionsWMO,$GUI_CHECKED)
	GUICtrlSetState($PriveCollisionsM2,$GUI_DISABLE)
	GUICtrlSetState($PriveCollisionsM2,$GUI_CHECKED)
	GUICtrlSetState($CollisionsWMO,$GUI_DISABLE)
	GUICtrlSetState($CollisionsWMO,$GUI_CHECKED)
	GUICtrlSetState($CollisionsM2,$GUI_DISABLE)
	GUICtrlSetState($CollisionsM2,$GUI_CHECKED)
	_MemoryWrite($CollisionM2S, $WOWPROCESS, 0x458B17EB, "Ptr")
	_MemoryWrite($CollisionM2C, $WOWPROCESS, 0x0162054A, "Ptr")
	_MemoryWrite($CollisionWMO, $WOWPROCESS, 0xC0329090, "Ptr")
EndIf

If GUICtrlRead($WallClimbON)=$GUI_CHECKED or GUICtrlRead($PriveWallClimbON)=$GUI_CHECKED Then
	 _MemoryWrite($PlayerBase + $Wallclimb, $WowProcess, 255, "float")
EndIf

If GUICtrlRead($WaterWalkON) = $GUI_CHECKED Then
	_MemoryWrite($WaterWalkPatch, $WowProcess, 0xCF819090, "Ptr")
EndIf

If (GUICtrlRead($UnderwaterWalkON) = $GUI_CHECKED or GUICtrlRead($PriveUnderwaterWalkON) = $GUI_CHECKED) And (GUICtrlRead($WalljumpON)=$GUI_CHECKED or GUICtrlRead($PriveWalljumpON)=$GUI_CHECKED) Then
	_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess, 4, "dword")
ElseIf GUICtrlRead($UnderwaterWalkON) = $GUI_CHECKED or GUICtrlRead($PriveUnderwaterWalkON) = $GUI_CHECKED Then
	_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess, 6, "dword")
ElseIf GUICtrlRead($WalljumpON)=$GUI_CHECKED or GUICtrlRead($PriveWalljumpON)=$GUI_CHECKED Then
	_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess, 12, "dword")
EndIf

If GUICtrlRead($PlayerFlags2Check1)=$GUI_CHECKED Then
$PlayerFlags2Value = _MemoryRead($PlayerBase2+$PlayerFlags2, $WowProcess, "dword")
	 _MemoryWrite($PlayerBase2+$PlayerFlags2,$WowProcess,$PlayerFlags2Value, "dword")
EndIf

If GUICtrlRead($CameraSpectate)=$GUI_CHECKED Then
$CameraSpectateSpeedInputed = GUICtrlRead($CameraSpectateSpeedInput)
	_MemoryWrite($POSXCAMERA + 56, $WowProcess, $CameraSpectateSpeedInputed, "float")
EndIf

If _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword") not = 0 Then
Global $TrackSaveR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
EndIf
If _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword") = 0 Then
	If GUICtrlRead($PriveTrackHerbes)=$GUI_CHECKED or GUICtrlRead($PriveTrackFilons)=$GUI_CHECKED or GUICtrlRead($PriveTrackCoffres)=$GUI_CHECKED or GUICtrlRead($PriveTrackPoissons)=$GUI_CHECKED or GUICtrlRead($TrackHerbes)=$GUI_CHECKED or GUICtrlRead($TrackFilons)=$GUI_CHECKED or GUICtrlRead($TrackCoffres)=$GUI_CHECKED or GUICtrlRead($TrackPoissons)=$GUI_CHECKED Then
	_MemoryWrite($PlayerBase2+$Ressources,$WowProcess,$TrackSaveR, "dword")
	EndIf
EndIf

If _MemoryRead($PlayerBase2+$Hunt, $WowProcess, "dword") not = 0 Then
Global $TrackSaveH = _MemoryRead($PlayerBase2+$Hunt, $WowProcess, "dword")
EndIf
If _MemoryRead($PlayerBase2+$Hunt, $WowProcess, "dword") = 0 Then
	If GUICtrlRead($PriveTrackBetes)=$GUI_CHECKED or GUICtrlRead($PriveTrackDragons)=$GUI_CHECKED or GUICtrlRead($PriveTrackDemons)=$GUI_CHECKED or GUICtrlRead($PriveTrackElementaires)=$GUI_CHECKED or GUICtrlRead($PriveTrackGeants)=$GUI_CHECKED or GUICtrlRead($PriveTrackMortsVivants)=$GUI_CHECKED or GUICtrlRead($PriveTrackHumanoides)=$GUI_CHECKED or GUICtrlRead($PriveTrackBestioles)=$GUI_CHECKED or GUICtrlRead($TrackBetes)=$GUI_CHECKED or GUICtrlRead($TrackDragons)=$GUI_CHECKED or GUICtrlRead($TrackDemons)=$GUI_CHECKED or GUICtrlRead($TrackElementaires)=$GUI_CHECKED or GUICtrlRead($TrackGeants)=$GUI_CHECKED or GUICtrlRead($TrackMortsVivants)=$GUI_CHECKED or GUICtrlRead($TrackHumanoides)=$GUI_CHECKED or GUICtrlRead($TrackBestioles)=$GUI_CHECKED Then
	_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,$TrackSaveH, "dword")
	EndIf
EndIf

If _GUICtrlComboBox_GetCurSel($PriveFactionMENU) = 1 or _GUICtrlComboBox_GetCurSel($FactionMENU) = 1 Then
			_MemoryWrite(($PlayerBase2 + $Faction), $WOWPROCESS, 0, "dword")
ElseIf _GUICtrlComboBox_GetCurSel($PriveFactionMENU) = 2 or _GUICtrlComboBox_GetCurSel($FactionMENU) = 2 Then
			_MemoryWrite(($PlayerBase2 + $Faction), $WOWPROCESS, 1, "dword")
ElseIf _GUICtrlComboBox_GetCurSel($PriveFactionMENU) = 3 or _GUICtrlComboBox_GetCurSel($FactionMENU) = 3 Then
			_MemoryWrite(($PlayerBase2 + $Faction), $WOWPROCESS, 2, "dword")
EndIf

Else
refreshpid()
EndIf
endfunc



func refreshpid()
$WowProcessList = ProcessList("wow.exe")
$Wowpid1 = ProcessExists("wow.exe")
$SelectedItemListView = _GUICtrlListView_GetSelectedIndices($WowProcesslistview)
_GUICtrlListView_DeleteAllItems($WowProcesslistview)
for $i = 1 to $WowProcessList[0][0]
GUICtrlCreateListViewItem($WowProcessList[$i][1], $WowProcesslistview)
next
_GUICtrlListView_SetColumnWidth($WowProcesslistview,0,40)
_GUICtrlListView_SetItemSelected($WowProcesslistview,$SelectedItemListView)
$SelectedPID = _GUICtrlListView_GetSelectedIndices(GUICtrlGetHandle($WowProcesslistview))
$WowProcessListViewItemCountSave = _GUICtrlListView_GetItemCount($WowProcesslistview)
$SelectedPIDadd = ($SelectedPID+1)
_MemoryClose($WowProcess)
$WowPid = $WowProcessList[$SelectedPIDadd][1]
$WowProcess = _MEMORYOPEN($WowPid)
$PB1 = _MemoryRead($StaticPlayer,$WowProcess,"Ptr")
$PB2 = _MemoryRead($PB1+$PbPointer1,$WowProcess,"Ptr")
$PlayerBase = _MemoryRead($PB2+$PbPointer2,$WowProcess,"Ptr")
$PlayerBase2 = _MemoryRead($PlayerBase+8,$WowProcess,"Ptr")
$PlayerScaleVar=_MemoryRead($PlayerBase+$PlayerScale,$WowProcess,"float")
$PlayerHauteurVar=_MemoryRead($PlayerBase+$PlayerHauteur,$WowProcess,"float")
$PlayerLargeurVar=_MemoryRead($PlayerBase+$PlayerLargeur,$WowProcess,"float")
$SautVar=_MemoryRead($PlayerBase+$HauteurSaut,$WowProcess,"float")
	 _MemoryWrite($PlayerBase2+$Hunt,$WowProcess,0)
	 _MemoryWrite($PlayerBase2+$Ressources,$WowProcess,0)
$PlayerHauteurRESET=$PlayerHauteurVar
$PlayerLargeurRESET=$PlayerLargeurVar
$PLAYERBASEAD2=_MemoryRead(($PlayerBase + $PLAYERBASE_AD2), $WowProcess, "ptr")
$OFS_PBSPECTATE=$PLAYERBASEAD2 + $PLAYERBASE_PBSPECTATE
$LVL1CAMERAPOINTER = _MemoryRead($CAM_CAMERASTATIC, $WowProcess, "ptr")
$LVL2CAMERAPOINTER = _MemoryRead(($LVL1CAMERAPOINTER + $CAM_CAMERAOFFSA), $WowProcess, "ptr")
$MEMORYCAM = $LVL2CAMERAPOINTER + $CAM_CAMERAOFFSB
$MEMORYCAMROTZ = $MEMORYCAM + $CAM_CAMERAROTZ
$MEMORYCAMROTX = $MEMORYCAM + $CAM_CAMERAROTX
endfunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FONCTIONS OFFICIEL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func SuperSaut()
	 If _IsPressed(20) Then
		$SuperSautInputedBRUT = GUICtrlRead($SuperSautInput)
		$SuperSautInputed=Abs($SuperSautInputedBRUT)*(-1)
	 _MemoryWrite($PlayerBase + $HauteurSaut, $WowProcess,$SuperSautInputed, "float")
	 EndIf
EndFunc

func WallClimbFunc()
If GUICtrlRead($WallClimbON)=$GUI_UNCHECKED or GUICtrlRead($PriveWallClimbON)=$GUI_UNCHECKED Then
	 _MemoryWrite($PlayerBase + $Wallclimb, $WowProcess,1, "float")
 EndIf
 EndFunc

Func underwaterwalk()
	If (GUICtrlRead($UnderwaterWalkON) = $GUI_UNCHECKED or GUICtrlRead($PriveUnderwaterWalkON) = $GUI_UNCHECKED) And (GUICtrlRead($WalljumpON)=$GUI_UNCHECKED or GUICtrlRead($PriveWalljumpON)=$GUI_UNCHECKED) Then
		_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess, 8, "dword")
	ElseIf GUICtrlRead($WalljumpON) = $GUI_CHECKED or GUICtrlRead($PriveWalljumpON) = $GUI_CHECKED Then
		_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess, 12, "dword")
	EndIf
EndFunc

func walljump()
	If (GUICtrlRead($UnderwaterWalkON) = $GUI_UNCHECKED or GUICtrlRead($PriveUnderwaterWalkON) = $GUI_UNCHECKED) And (GUICtrlRead($WalljumpON)=$GUI_UNCHECKED or GUICtrlRead($PriveWalljumpON)=$GUI_UNCHECKED) Then
		_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess, 8, "dword")
	ElseIf GUICtrlRead($UnderwaterWalkON) = $GUI_CHECKED or GUICtrlRead($PriveUnderwaterWalkON) = $GUI_CHECKED Then
		_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess, 6, "dword")
	EndIf
endfunc

Func waterwalk()
	If GUICtrlRead($WaterWalkON) = $GUI_UNCHECKED Then
		_MemoryWrite($WaterWalkPatch, $WowProcess, 0xCF811474 , "Ptr")
	EndIf
EndFunc

func Tp()
If WinActive("World of Warcraft") Then
	If GUICtrlRead($TPmanu)=$GUI_CHECKED and GUICtrlRead($TPauto)=$GUI_UNCHECKED Then
		;;;;;;;;;;;; TP MANUEL
		If _IsPressed(68, $dll) Then
			For $X=0 To 10
				$Position = _MemoryRead($PlayerBase+$PosX, $WowProcess, "float")
				$NewPosition = $Position + 0.13
				_MemoryWrite($PlayerBase + $PosX, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
				$X=$X+1
			Next
		EndIf
		If _IsPressed(65, $dll) Then
			For $X=0 To 10
				$Position = _MemoryRead($PlayerBase+$PosX, $WowProcess, "float")
				$NewPosition = $Position - 0.13
				_MemoryWrite($PlayerBase + $PosX, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
				$X=$X+1
			Next
		EndIf
		If _IsPressed(64, $dll) Then
			For $X=0 To 10
				$Position = _MemoryRead($PlayerBase+$PosY, $WowProcess, "float")
				$NewPosition = $Position + 0.13
				_MemoryWrite($PlayerBase + $PosY, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
			$X=$X+1
			Next
		EndIf
		If _IsPressed(66, $dll) Then
			For $X=0 To 10
				$Position = _MemoryRead($PlayerBase+$PosY, $WowProcess, "float")
				$NewPosition = $Position - 0.13
				_MemoryWrite($PlayerBase + $PosY, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
				$X=$X+1
			Next
		EndIf
		If _IsPressed(67, $dll) Then
			For $X=0 To 10
				$Position = _MemoryRead($PlayerBase+$PosZ, $WowProcess, "float")
				$NewPosition = $Position + 0.13
				_MemoryWrite($PlayerBase + $PosZ, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
				$X=$X+1
			Next
		EndIf
		If _IsPressed(69, $dll) Then
			For $X=0 To 10
				$Position = _MemoryRead($PlayerBase+$PosZ, $WowProcess, "float")
				$NewPosition = $Position - 0.13
				_MemoryWrite($PlayerBase + $PosZ, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
				$X=$X+1
			Next
		EndIf
	EndIf
	;;;;;;;;;;;; TP AUTO
	If GUICtrlRead($TPmanu)=$GUI_UNCHECKED and GUICtrlRead($TPauto)=$GUI_CHECKED Then
		If _IsPressed(68, $dll) Then
			Do
				$Position = _MemoryRead($PlayerBase+$PosX, $WowProcess, "float")
				$NewPosition = $Position + 0.13
				_MemoryWrite($PlayerBase + $PosX, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
			Until _IsPressed(61, $dll)
		EndIf
		If _IsPressed(65, $dll) Then
			Do
				$Position = _MemoryRead($PlayerBase+$PosX, $WowProcess, "float")
				$NewPosition = $Position - 0.13
				_MemoryWrite($PlayerBase + $PosX, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
			Until _IsPressed(61, $dll)
		EndIf
		If _IsPressed(64, $dll) Then
			Do
				$Position = _MemoryRead($PlayerBase+$PosY, $WowProcess, "float")
				$NewPosition = $Position + 0.13
				_MemoryWrite($PlayerBase + $PosY, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
			Until _IsPressed(61, $dll)
		EndIf
		If _IsPressed(66, $dll) Then
			Do
				$Position = _MemoryRead($PlayerBase+$PosY, $WowProcess, "float")
				$NewPosition = $Position - 0.13
				_MemoryWrite($PlayerBase + $PosY, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
			Until _IsPressed(61, $dll)
		EndIf
		If _IsPressed(67, $dll) Then
			Do
				$Position = _MemoryRead($PlayerBase+$PosZ, $WowProcess, "float")
				$NewPosition = $Position + 0.13
				_MemoryWrite($PlayerBase + $PosZ, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
			Until _IsPressed(61, $dll)
		EndIf
		If _IsPressed(69, $dll) Then
			Do
				$Position = _MemoryRead($PlayerBase+$PosZ, $WowProcess, "float")
				$NewPosition = $Position - 0.13
				_MemoryWrite($PlayerBase + $PosZ, $WowProcess,$NewPosition, "float")
				send("{left}{left}{right}{right}")
				sleep(60)
			Until _IsPressed(61, $dll)
		EndIf
	EndIf
EndIf
EndFunc

func sconoclipaction()
If WinActive("World of Warcraft") Then
	If GUICtrlRead($NoClipActionON)=$GUI_CHECKED Then
			$locationX = _MemoryRead($PlayerBase+$PosX , $WowProcess, 'float')
			$locationY = _MemoryRead($PlayerBase+$PosY , $WowProcess, 'float')
			$locationR = _MemoryRead($PlayerBase+$PosR , $WowProcess, 'float')
			$newlocationX = $locationX + 0.13 * cos($locationR)
			$newlocationY = $locationY + 0.13 * sin($locationR)
			_MemoryWrite($PlayerBase+$PosX , $WowProcess,$newlocationX, 'float')
			_MemoryWrite($PlayerBase+$PosY , $WowProcess,$newlocationY, 'float')
			send("{left}{left}{right}{right}")
		$X=$X+1
	EndIf
EndIf
EndFunc

func trackherbes()
	If GUICtrlRead($TrackHerbes)=$GUI_CHECKED Then
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue+2), "dword")
	Else
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue-2), "dword")
	EndIf
 EndFunc

func trackfilons()
	If GUICtrlRead($TrackFilons)=$GUI_CHECKED Then
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue+4), "dword")
	Else
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue-4), "dword")
	EndIf
 EndFunc

func trackcoffres()
	If GUICtrlRead($TrackCoffres)=$GUI_CHECKED Then
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR+32), "dword")
	Else
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR-32), "dword")
	EndIf
 EndFunc

func trackpoissons()
	If GUICtrlRead($TrackPoissons)=$GUI_CHECKED Then
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR+262144), "dword")
	Else
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR-262144), "dword")
	EndIf
 EndFunc

 func trackallres()
 	If GUICtrlRead($TrackAllRes)=$GUI_CHECKED Then
		GUICtrlSetState($TrackHerbes, $GUI_CHECKED)
		GUICtrlSetState($TrackFilons, $GUI_CHECKED)
		GUICtrlSetState($TrackCoffres, $GUI_CHECKED)
		GUICtrlSetState($TrackPoissons, $GUI_CHECKED)
		_MemoryWrite($PlayerBase2+$Ressources,$WowProcess,-1, "dword")
 Else
		GUICtrlSetState($TrackHerbes, $GUI_UNCHECKED)
		GUICtrlSetState($TrackFilons, $GUI_UNCHECKED)
		GUICtrlSetState($TrackCoffres, $GUI_UNCHECKED)
		GUICtrlSetState($TrackPoissons, $GUI_UNCHECKED)
		_MemoryWrite($PlayerBase2+$Ressources,$WowProcess,0, "dword")
 EndIf
 EndFunc

func trackbetes()
	If GUICtrlRead($TrackBetes)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+1), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-1), "dword")
	EndIf
EndFunc

func trackdragons()
	If GUICtrlRead($TrackDragons)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+2), "dword")
	 Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-2), "dword")
	 EndIf
EndFunc

func trackdemons()
	If GUICtrlRead($TrackDemons)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+4), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-4), "dword")
	EndIf
EndFunc

func trackelementaires()
	If GUICtrlRead($TrackElementaires)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+8), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-8), "dword")
	EndIf
EndFunc

func trackgeants()
	If GUICtrlRead($TrackGeants)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+16), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-16), "dword")
	EndIf
EndFunc

func trackmortsvivants()
	If GUICtrlRead($TrackMortsVivants)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+32), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-32), "dword")
	EndIf
EndFunc

func trackhumanoides()
	If GUICtrlRead($TrackHumanoides)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+64), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-64), "dword")
	EndIf
EndFunc

func trackbestioles()
	If GUICtrlRead($TrackBestioles)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+128), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-128), "dword")
	EndIf
EndFunc

func trackallbet()
 	If GUICtrlRead($TrackAllBet)=$GUI_CHECKED Then
		GUICtrlSetState($TrackBetes, $GUI_CHECKED)
		GUICtrlSetState($TrackDragons, $GUI_CHECKED)
		GUICtrlSetState($TrackDemons, $GUI_CHECKED)
		GUICtrlSetState($TrackElementaires, $GUI_CHECKED)
		GUICtrlSetState($TrackGeants, $GUI_CHECKED)
		GUICtrlSetState($TrackMortsVivants, $GUI_CHECKED)
		GUICtrlSetState($TrackHumanoides, $GUI_CHECKED)
		GUICtrlSetState($TrackBestioles, $GUI_CHECKED)
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,-1, "dword")
 Else
		GUICtrlSetState($TrackBetes, $GUI_UNCHECKED)
		GUICtrlSetState($TrackDragons, $GUI_UNCHECKED)
		GUICtrlSetState($TrackDemons, $GUI_UNCHECKED)
		GUICtrlSetState($TrackElementaires, $GUI_UNCHECKED)
		GUICtrlSetState($TrackGeants, $GUI_UNCHECKED)
		GUICtrlSetState($TrackMortsVivants, $GUI_UNCHECKED)
		GUICtrlSetState($TrackHumanoides, $GUI_UNCHECKED)
		GUICtrlSetState($TrackBestioles, $GUI_UNCHECKED)
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,0, "dword")
 EndIf
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FONCTIONS PRIVE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func privexyz()
If WinActive("World of Warcraft") Then
	If _IsPressed(68, $dll) Then
		$PriveXYZSpeed=GUICtrlRead (Abs($PriveXYZSpeedInput))
		$locationX = _MemoryRead($PlayerBase+$PosX , $WowProcess, 'float')
		$locationY = _MemoryRead($PlayerBase+$PosY , $WowProcess, 'float')
		$locationR = _MemoryRead($PlayerBase+$PosR , $WowProcess, 'float')
		$newlocationX = $locationX + $PriveXYZSpeed * cos($locationR)
		$newlocationY = $locationY + $PriveXYZSpeed * sin($locationR)
		_MemoryWrite($PlayerBase+$PosX , $WowProcess,$newlocationX, 'float')
		_MemoryWrite($PlayerBase+$PosY , $WowProcess,$newlocationY, 'float')
	EndIf
	If _IsPressed(65, $dll) Then
		$PriveXYZSpeed=GUICtrlRead (Abs($PriveXYZSpeedInput))
		$locationX = _MemoryRead($PlayerBase+$PosX , $WowProcess, 'float')
		$locationY = _MemoryRead($PlayerBase+$PosY , $WowProcess, 'float')
		$locationR = _MemoryRead($PlayerBase+$PosR , $WowProcess, 'float')
		$newlocationX = $locationX - $PriveXYZSpeed * cos($locationR)
		$newlocationY = $locationY - $PriveXYZSpeed * sin($locationR)
		_MemoryWrite($PlayerBase+$PosX , $WowProcess,$newlocationX, 'float')
		_MemoryWrite($PlayerBase+$PosY , $WowProcess,$newlocationY, 'float')
	EndIf
	If _IsPressed(66, $dll) Then
		$PriveXYZSpeed=GUICtrlRead (Abs($PriveXYZSpeedInput))
		$locationX = _MemoryRead($PlayerBase+$PosX , $WowProcess, 'float')
		$locationY = _MemoryRead($PlayerBase+$PosY , $WowProcess, 'float')
		$locationR = _MemoryRead($PlayerBase+$PosR , $WowProcess, 'float')
		$newlocationX = $locationX - $PriveXYZSpeed * cos($locationR + ($pi/2))
		$newlocationY = $locationY - $PriveXYZSpeed * sin($locationR + ($pi/2))
		_MemoryWrite($PlayerBase+$PosX , $WowProcess,$newlocationX, 'float')
		_MemoryWrite($PlayerBase+$PosY , $WowProcess,$newlocationY, 'float')
	EndIf
	If _IsPressed(64, $dll) Then
		$PriveXYZSpeed=GUICtrlRead (Abs($PriveXYZSpeedInput))
		$locationX = _MemoryRead($PlayerBase+$PosX , $WowProcess, 'float')
		$locationY = _MemoryRead($PlayerBase+$PosY , $WowProcess, 'float')
		$locationR = _MemoryRead($PlayerBase+$PosR , $WowProcess, 'float')
		$newlocationX = $locationX - $PriveXYZSpeed * cos($locationR - ($pi/2))
		$newlocationY = $locationY - $PriveXYZSpeed * sin($locationR - ($pi/2))
		_MemoryWrite($PlayerBase+$PosX , $WowProcess,$newlocationX, 'float')
		_MemoryWrite($PlayerBase+$PosY , $WowProcess,$newlocationY, 'float')
	EndIf
	If _IsPressed(67, $dll) Then
		$PriveXYZSpeed=GUICtrlRead (Abs($PriveXYZSpeedInput))
		$Position = _MemoryRead($PlayerBase+$PosZ, $WowProcess, "float")
		$NewPosition = $Position + $PriveXYZSpeed
		_MemoryWrite($PlayerBase + $PosZ, $WowProcess,$NewPosition, "float")
	EndIf
	If _IsPressed(69, $dll) Then
		$PriveXYZSpeed=GUICtrlRead (Abs($PriveXYZSpeedInput))
		$Position = _MemoryRead($PlayerBase+$PosZ, $WowProcess, "float")
		$NewPosition = $Position - $PriveXYZSpeed
		_MemoryWrite($PlayerBase + $PosZ, $WowProcess,$NewPosition, "float")
	EndIf
EndIf
EndFunc

func priveteleportcamera()
	If _MemoryRead($POSXCAMERA,$WowProcess,"float") <> 0 Then
		If IniRead($Setting,"Reglages","Msgbox","Erreur")=1 Then
			If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
				$MsgboxTpCamera = MsgBox(4, "Attention", "Cette fonction ne fontionne que pour serveur privés."&@CRLF&" "&@CRLF&"Si vous êtes sur serveur officiel, cliquez sur Non."&@CRLF&"Si vous êtes sur serveur privé, vous pouvez cliquer sur Oui pour continuer.")
			Else
				$MsgboxTpCamera = MsgBox(4, "Warning", "This function si for Private server only."&@CRLF&" "&@CRLF&"If you are playing on live server, click on No."&@CRLF&"If you are playing on private server, you can click Yes to continue.")
			EndIf
				If $MsgboxTpCamera = 6 Then
				IniWrite($Setting,"Reglages","Msgbox",0)
					If IniRead($Setting,"Langue","Langue","Erreur") = 0 Then
					MsgBox(0, "Avertissement","Ces messages n'apparaîtront plus désormais.")
					Else
					MsgBox(0, "Warning","These messages won't be displayed anymore.")
					EndIf
					$CamPosX=_MemoryRead($POSXCAMERA, $WowProcess, "Float")
					$CamPosY=_MemoryRead($POSXCAMERA+4, $WowProcess, "Float")
					$CamPosZ=_MemoryRead($POSXCAMERA+8, $WowProcess, "Float")
					_MemoryWrite($PlayerBase+$POSX, $WowProcess, $CamPosX, "Float")
					_MemoryWrite($PlayerBase+$POSY, $WowProcess, $CamPosY, "Float")
					_MemoryWrite($PlayerBase+$POSZ, $WowProcess, $CamPosZ, "Float")
				ElseIf $MsgboxTpCamera = 7 Then
				EndIf
		Else
			$CamPosX=_MemoryRead($POSXCAMERA, $WowProcess, "Float")
			$CamPosY=_MemoryRead($POSXCAMERA+4, $WowProcess, "Float")
			$CamPosZ=_MemoryRead($POSXCAMERA+8, $WowProcess, "Float")
			_MemoryWrite($PlayerBase+$POSX, $WowProcess, $CamPosX, "Float")
			_MemoryWrite($PlayerBase+$POSY, $WowProcess, $CamPosY, "Float")
			_MemoryWrite($PlayerBase+$POSZ, $WowProcess, $CamPosZ, "Float")
		EndIf
	EndIf
EndFunc

func copytp()
	GUICtrlSetData($PriveXInputTP,Round((_MemoryRead($PlayerBase+$PosX,$WowProcess,"float")),3))
	GUICtrlSetData($PriveYInputTP,Round((_MemoryRead($PlayerBase+$PosY,$WowProcess,"float")),3))
	GUICtrlSetData($PriveZInputTP,Round((_MemoryRead($PlayerBase+$PosZ,$WowProcess,"float")),3))
EndFunc

func gotp()
	 _MemoryWrite($PlayerBase + $PosX, $WowProcess,GUICtrlRead($PriveXInputTP), "float")
	 _MemoryWrite($PlayerBase + $PosY, $WowProcess,GUICtrlRead($PriveYInputTP), "float")
	 _MemoryWrite($PlayerBase + $PosZ, $WowProcess,GUICtrlRead($PriveZInputTP), "float")
endfunc

func gocorps()
	If _MemoryRead($Corps, $WowProcess,"float") <> 0 Then
		$CorpsX=_MemoryRead($Corps,$WowProcess,"float")
		$CorpsY=_MemoryRead($Corps+4,$WowProcess,"float")
		$CorpsZ=_MemoryRead($Corps+8,$WowProcess,"float")
		_MemoryWrite($PlayerBase + $PosX, $WowProcess,$CorpsX, "float")
		_MemoryWrite($PlayerBase + $PosY, $WowProcess,$CorpsY, "float")
		_MemoryWrite($PlayerBase + $PosZ, $WowProcess,$CorpsZ, "float")
	EndIf
endfunc

func clicktp()
	If WinActive("World of Warcraft") Then
		If _ispressed(iniRead($Setting, "Raccourcis - Prive", "Clicktptouche", "Erreur"),$dll) and _ispressed(02,$dll) Then
			$PlayerStateORG = _MemoryRead($PlayerBase+$PlayerState2,$WowProcess,"ptr")
			_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG+0x800), "ptr")
			sleep(245)
				If _MemoryRead($ClickTpX,$WowProcess, 'float') = 0 Then
					_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,$PlayerStateORG, "ptr")
					send("{DOWN}")
				Else
					_MemoryWrite($PlayerBase+$PosX,$WowProcess,_MemoryRead($ClickTpX,$WowProcess, 'float'), 'float')
					_MemoryWrite($PlayerBase+$PosY,$WowProcess,_MemoryRead($ClickTpY,$WowProcess, 'float'), 'float')
					_MemoryWrite($PlayerBase+$PosZ,$WowProcess,_MemoryRead($ClickTpZ,$WowProcess, 'float'), 'float')
					sleep(245)
					_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,$PlayerStateORG, "ptr")
					_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG+0x400), "ptr")
					_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,$PlayerStateORG, "ptr")
					Sleep(500)
				EndIf
		EndIf
	EndIf
EndFunc

Func NoCooldown()
	Cooldowns(0,300)
EndFunc

Func Cooldowns($Spell, $SpellCD)
	$CD = $BaseCD
	$NR = 0
	$NextCD = _MemoryRead($CD + 8, $WowProcess, "ptr")
	While ($NEXTCD <> 0) And (BitAND($NextCD, 1) = 0)
		$NR = $NR + 1
		$CD = $NextCD
		$NextCD = _MemoryRead($CD + 4, $WowProcess, "ptr")
		$ECD = _MemoryRead($CD + 4, $WowProcess, "int")
		$ID = _MemoryRead($CD + 8, $WowProcess, "int")
		$StartTime = _MemoryRead($CD + 16, $WowProcess, "uint")
		Local $PF = DllStructCreate("ulong")
		DllCall("kernel32.dll", "none", "QueryPerformanceFrequency", "ptr", DllStructGetPtr($PF))
		Local $PC = DllStructCreate("int64")
		DllCall("kernel32.dll", "none", "QueryPerformanceCounter", "ptr", DllStructGetPtr($PC))
		$TS = (DllStructGetData($PC, 1) / DllStructGetData($PF, 1)) * 1000
		$MYCD = _MemoryRead($CD + 16, $WowProcess, "int")
		If ($TS - $StartTime < $SpellCD) Then
			_MemoryWriteGCD($CD + 16, $WowProcess, "uint", $StartTime - 1500)
			Return 1
		Endif
	WEnd
	Return 0
EndFunc

Func privetpcibledos()
$TargetGUID=_MemoryRead($TargetGUIDstatic,$WowProcess,"uint64")
	If $TargetGUID=0 then Return
	$Adr=GetGuid($TargetGUID)
	$TargetX=_MemoryRead($Adr+$PosX,$WowProcess,"float")
	$TargetY=_MemoryRead($Adr+$PosY,$WowProcess,"float")
	$TargetZ=_MemoryRead($Adr+$PosZ,$WowProcess,"float")
	$TargetR=_MemoryRead($Adr+$PosR,$WowProcess,"float")
	_MemoryWrite($PlayerBase+$PosX,$WowProcess,$TargetX-(3*cos($TargetR)),"float")
	_MemoryWrite($PlayerBase+$PosY,$WowProcess,$TargetY-(3*Sin($TargetR)),"float")
	_MemoryWrite($PlayerBase+$PosZ,$WowProcess,$TargetZ+1.5,"float")
	_MemoryWrite($PlayerBase+$PosR,$WowProcess,$TargetR,"float")
	sleep(150)
	ControlSend("World of Warcraft","","","{S}")
EndFunc

Func privetpcibleundermap()
$TargetGUID=_MemoryRead($TargetGUIDstatic,$WowProcess,"uint64")
	If $TargetGUID=0 then Return
	$Adr=GetGuid($TargetGUID)
	$TargetX=_MemoryRead($Adr+$PosX,$WowProcess,"float")
	$TargetY=_MemoryRead($Adr+$PosY,$WowProcess,"float")
	$TargetZ=_MemoryRead($Adr+$PosZ,$WowProcess,"float")
	$TargetR=_MemoryRead($Adr+$PosR,$WowProcess,"float")
	_MemoryWrite($PlayerBase+$PosX,$WowProcess,$TargetX-(8*cos($TargetR)),"float")
	_MemoryWrite($PlayerBase+$PosY,$WowProcess,$TargetY-(8*Sin($TargetR)),"float")
	_MemoryWrite($PlayerBase+$PosZ,$WowProcess,$TargetZ-5,"float")
	_MemoryWrite($PlayerBase+$PosR,$WowProcess,$TargetR,"float")
	sleep(150)
	ControlSend("World of Warcraft","","","{Q}{D}")
EndFunc

Func GetGuid($CurrentTargetGUID)
	$ClientConnection=_MemoryRead($StaticClientConnection,$WowProcess,"dword")
	$CurListMgr=_MemoryRead($ClientConnection+$MgrOffset,$WowProcess,"dword")
	$FirstObject=_MemoryRead($CurListMgr+$OFS_FIRST_OBJ,$WowProcess,"dword")
	$CurObject=$FirstObject
	$Type=_MemoryRead($CurObject+$OFS_OBJ_TYPE,$WowProcess,"dword")
		While $Type < 8 And $Type > 0
				$Guidobj=_MemoryRead($CurObject+$OFS_OBJ_GUID,$WowProcess,"int64")
					If $Guidobj=$CurrentTargetGUID Then
						$CurrentTargetGUIDadr=$CurObject
						Return $CurrentTargetGUIDadr
						ExitLoop
					EndIf
			$CurObject=_MemoryRead($CurObject+$OFS_NEXT_OBJ,$WowProcess,"dword")
			$Type=_MemoryRead($CurObject+$OFS_OBJ_TYPE,$WowProcess,"dword")
		WEnd
	$CurrentTargetGUID=""
EndFunc

func speed()
	If GUICtrlRead($PriveSpeedON)=$GUI_UNCHECKED Then
		GUICtrlSetState($PriveSpeedGlobaleON,$GUI_ENABLE)
		GUICtrlSetState($PriveSpeedGlobaleInput,$GUI_ENABLE)
		_MemoryWrite($PlayerBase+$Speed,$WowProcess,7, "float")
		_MemoryWrite($PlayerBase+$SpeedSwim,$WowProcess,4.7, "float")
	EndIf
 EndFunc

func collisionM2()
	If GUICtrlRead($PriveCollisionsM2)=$GUI_UNCHECKED or GUICtrlRead($CollisionsM2)=$GUI_UNCHECKED Then
		_MemoryWrite($CollisionM2S, $WOWPROCESS, 0x458B1774, "Ptr")
		_MemoryWrite($CollisionM2C, $WOWPROCESS, 0x0162840F, "Ptr")
	EndIf
EndFunc

func collisionWMO()
	If GUICtrlRead($PriveCollisionsWMO)=$GUI_UNCHECKED or GUICtrlRead($CollisionsWMO)=$GUI_UNCHECKED Then
		_MemoryWrite($CollisionWMO, $WOWPROCESS, 0xC0320675, "Ptr")
	EndIf
EndFunc

func collisionAll()
	If GUICtrlRead($PriveCollisionsAll)=$GUI_UNCHECKED or GUICtrlRead($CollisionsAll)=$GUI_UNCHECKED Then
		GUICtrlSetState($PriveCollisionsWMO,$GUI_ENABLE)
		GUICtrlSetState($PriveCollisionsWMO,$GUI_UNCHECKED)
		GUICtrlSetState($PriveCollisionsM2,$GUI_ENABLE)
		GUICtrlSetState($PriveCollisionsM2,$GUI_UNCHECKED)
		GUICtrlSetState($CollisionsWMO,$GUI_ENABLE)
		GUICtrlSetState($CollisionsWMO,$GUI_UNCHECKED)
		GUICtrlSetState($CollisionsM2,$GUI_ENABLE)
		GUICtrlSetState($CollisionsM2,$GUI_UNCHECKED)
		_MemoryWrite($CollisionM2S, $WOWPROCESS, 0x458B1774, "Ptr")
		_MemoryWrite($CollisionM2C, $WOWPROCESS, 0x0162840F, "Ptr")
		_MemoryWrite($CollisionWMO, $WOWPROCESS, 0xC0320675, "Ptr")
	EndIf
EndFunc

func flymod()
	If GUICtrlRead($PriveFlyModON)=$GUI_UNCHECKED Then
		_MemoryWrite($PlayerBase+$PlayerState,$WowProcess,128, "dword")
	EndIf
 EndFunc

func privefreezez()
	If GUICtrlRead($PriveFreezeZON)=$GUI_UNCHECKED Then
		_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,0x80000000, "ptr")
	EndIf
 EndFunc

func privewaterwalk()
	If GUICtrlRead($PriveWaterWalkON)=$GUI_UNCHECKED Then
		_MemoryWrite($PlayerBase+$PlayerState,$WowProcess,128, "dword")
	EndIf
 EndFunc

func privemount()
	If GUICtrlRead($PriveMountON)=$GUI_UNCHECKED Then
		$Mount1Value=_MemoryRead($Mount1, $WowProcess, "ptr")
		$Mount2Value=_MemoryRead($Mount2, $WowProcess, "ptr")
		_MemoryWrite($Mount1, $WowProcess,$Mount1Value-0x00000077, "Ptr")
		_MemoryWrite($Mount2, $WowProcess,$Mount2Value-0x00000077, "Ptr")
	EndIf
endfunc

func privemultijump()
	If GUICtrlRead($PriveInfiniteJumpON)=$GUI_UNCHECKED Then
		_MemoryWrite($InfiniteJumpPatch, $WowProcess,0xB70F4475, "Ptr")
	EndIf
endfunc

func privenoclip1()
	If GUICtrlRead($PriveNoClip1ON)=$GUI_UNCHECKED or GUICtrlRead($NoClip1ON)=$GUI_UNCHECKED Then
		_MemoryWrite($CollisionM2S, $WOWPROCESS, 0x458B1774, "Ptr")
		_MemoryWrite($CollisionM2C, $WOWPROCESS, 0x0162840F, "Ptr")
		_MemoryWrite($CollisionWMO, $WOWPROCESS, 0xC0320675, "Ptr")
	EndIf
 EndFunc

func privenoclip()
	If GUICtrlRead($PriveNoClipON)=$GUI_CHECKED Then
		_MemoryWrite(($PlayerBase + $PlayerLargeur), $WOWPROCESS, 0, "float")
	Else
		_MemoryWrite(($PlayerBase + $PlayerLargeur), $WOWPROCESS, $PlayerLargeurRESET, "float")
	EndIf
 EndFunc

func debloperso()
$PlayerStateORG = _MemoryRead($PlayerBase+$PlayerState2,$WowProcess,"ptr")
If $PlayerStateORG = 0x80000800 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x80000C00 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x81000800 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x90000800 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x90000C00 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x91000800 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x00000800 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x00000C00 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
ElseIf $PlayerStateORG = 0x01000800 Then
	_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,($PlayerStateORG-0x800), "ptr")
Else
 EndIf
 EndFunc

func privestopfall()
_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,0x80000400, "ptr")
_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,0x80000000, "ptr")
Send("{Space}")
Sleep(25)
_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,0x80000400, "ptr")
_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,0x80000000, "ptr")
EndFunc

func PriveSuperSaut()
	 If _IsPressed(20) Then
		$PriveSuperSautInputedBRUT = GUICtrlRead($PriveSuperSautInput)
		$PriveSuperSautInputed=Abs($PriveSuperSautInputedBRUT)*(-1)
		_MemoryWrite($PlayerBase+$HauteurSaut, $WowProcess,$PriveSuperSautInputed, "float")
	 EndIf
EndFunc

func Privetrackherbes()
	If GUICtrlRead($PriveTrackHerbes)=$GUI_CHECKED Then
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue+2), "dword")
	Else
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue-2), "dword")
	EndIf
 EndFunc

func Privetrackfilons()
	If GUICtrlRead($PriveTrackFilons)=$GUI_CHECKED Then
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue+4), "dword")
	Else
		$TrackValue = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($Trackvalue-4), "dword")
	EndIf
 EndFunc

func Privetrackcoffres()
	If GUICtrlRead($PriveTrackCoffres)=$GUI_CHECKED Then
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR+32), "dword")
	Else
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR-32), "dword")
	EndIf
 EndFunc

func Privetrackpoissons()
	If GUICtrlRead($PriveTrackPoissons)=$GUI_CHECKED Then
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR+262144), "dword")
	Else
		$TrackValueR = _MemoryRead($PlayerBase2+$Ressources, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2 + $Ressources, $WowProcess,($TrackvalueR-262144), "dword")
	EndIf
 EndFunc

func privetrackallres()
	If GUICtrlRead($PriveTrackAllRes)=$GUI_CHECKED Then
		GUICtrlSetState($PriveTrackHerbes, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackFilons, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackCoffres, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackPoissons, $GUI_CHECKED)
		_MemoryWrite($PlayerBase2+$Ressources,$WowProcess,-1, "dword")
	Else
		GUICtrlSetState($PriveTrackHerbes, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackFilons, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackCoffres, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackPoissons, $GUI_UNCHECKED)
		_MemoryWrite($PlayerBase2+$Ressources,$WowProcess,0, "dword")
	EndIf
EndFunc

func Privetrackbetes()
	If GUICtrlRead($PriveTrackBetes)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+1), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-1), "dword")
	EndIf
EndFunc

func Privetrackdragons()
	If GUICtrlRead($PriveTrackDragons)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+2), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-2), "dword")
	EndIf
EndFunc

func Privetrackdemons()
	If GUICtrlRead($PriveTrackDemons)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+4), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-4), "dword")
	EndIf
EndFunc

func Privetrackelementaires()
	If GUICtrlRead($PriveTrackElementaires)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+8), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-8), "dword")
	EndIf
EndFunc

func Privetrackgeants()
	If GUICtrlRead($PriveTrackGeants)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+16), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-16), "dword")
	EndIf
EndFunc

func Privetrackmortsvivants()
	If GUICtrlRead($PriveTrackMortsVivants)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+32), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-32), "dword")
	EndIf
EndFunc

func Privetrackhumanoides()
	If GUICtrlRead($PriveTrackHumanoides)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+64), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-64), "dword")
	EndIf
EndFunc

func Privetrackbestioles()
	If GUICtrlRead($PriveTrackBestioles)=$GUI_CHECKED Then
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH+128), "dword")
	Else
		$TrackValueH = _MemoryRead($PlayerBase2+$Hunt,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,($TrackvalueH-128), "dword")
	EndIf
EndFunc

func privetrackallbet()
	If GUICtrlRead($PriveTrackAllBet)=$GUI_CHECKED Then
		GUICtrlSetState($PriveTrackBetes, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackDragons, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackDemons, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackElementaires, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackGeants, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackMortsVivants, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackHumanoides, $GUI_CHECKED)
		GUICtrlSetState($PriveTrackBestioles, $GUI_CHECKED)
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,-1, "dword")
	Else
		GUICtrlSetState($PriveTrackBetes, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackDragons, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackDemons, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackElementaires, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackGeants, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackMortsVivants, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackHumanoides, $GUI_UNCHECKED)
		GUICtrlSetState($PriveTrackBestioles, $GUI_UNCHECKED)
		_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,0, "dword")
	EndIf
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; JOUEUR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func showmap()
	For $MapMask = 0x1044 to 0x1234
		_MemoryWrite(($PlayerBase2 + (0x&$MapMask)), $WOWPROCESS, -1, "Int64")
	Next
EndFunc

Func settargetemote()
$EmoteSelec = GUICtrlRead($EmoteMENU)
$EmoteSelecID1 = StringMid($EmoteSelec,1,4)
$EmoteSelecID = StringStripWS($EmoteSelecID1,8)
$TargetGUID=_MemoryRead($TargetGUIDstatic,$WowProcess,"uint64")
If $TargetGUID=0 then
	_MemoryWrite($PlayerBase2+$Emote,$WowProcess,$EmoteSelecID,"dword")
	sleep(150)
Else
	$Adr=GetGuid($TargetGUID)
	$Adr2 = _MemoryRead($Adr+8,$WowProcess,"ptr")
	_MemoryWrite($Adr2+$Emote,$WowProcess,$EmoteSelecID,"dword")
	sleep(150)
EndIf
EndFunc

func settargettitre()
$TitreSelec = GUICtrlRead($TitreMENU)
$TitreSelecID1 = StringMid($TitreSelec,1,4)
$TitreSelecID = StringStripWS($TitreSelecID1,8)
	_MemoryWrite($PlayerBase2+$Titre,$WowProcess,$TitreSelecID,"dword")
endfunc

func TailleP()
	$PlayerScaleVar=_MemoryRead($PlayerBase+$PlayerScale,$WowProcess,"float")
	$PlayerNewTaille=$PlayerScaleVar*1.5
	_MemoryWrite(($PlayerBase + $PlayerScale), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerScaleInput,Round($PlayerNewTaille, 5))

	$PlayerHauteurVar=_MemoryRead($PlayerBase+$PlayerHauteur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerHauteurVar*1.5
	_MemoryWrite(($PlayerBase + $PlayerHauteur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerHauteurInput,Round($PlayerNewTaille, 5))

	$PlayerLargeurVar=_MemoryRead($PlayerBase+$PlayerLargeur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerLargeurVar*1.5
	_MemoryWrite(($PlayerBase + $PlayerLargeur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerLargeurInput,Round($PlayerNewTaille, 5))
EndFunc
func TailleM()
	$PlayerScaleVar=_MemoryRead($PlayerBase+$PlayerScale,$WowProcess,"float")
	$PlayerNewTaille=$PlayerScaleVar/1.5
	_MemoryWrite(($PlayerBase + $PlayerScale), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerScaleInput,Round($PlayerNewTaille, 5))

	$PlayerHauteurVar=_MemoryRead($PlayerBase+$PlayerHauteur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerHauteurVar/1.5
	_MemoryWrite(($PlayerBase + $PlayerHauteur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerHauteurInput,Round($PlayerNewTaille, 5))

	$PlayerLargeurVar=_MemoryRead($PlayerBase+$PlayerLargeur,$WowProcess,"float")
	$PlayerNewTaille=$PlayerLargeurVar/1.5
	_MemoryWrite(($PlayerBase + $PlayerLargeur), $WOWPROCESS, $PlayerNewTaille, "float")
	GUICtrlSetData($PlayerLargeurInput,Round($PlayerNewTaille, 5))
EndFunc
func PlayerScaleInputFunc()
    $PlayerScaleInputed=GUICtrlRead ($PlayerScaleInput)
	_MemoryWrite(($PlayerBase + $PlayerScale), $WOWPROCESS, $PlayerScaleInputed, "float")
EndFunc
func PlayerHauteurInputFunc()
    $PlayerHauteurInputed=GUICtrlRead ($PlayerHauteurInput)
	_MemoryWrite(($PlayerBase + $PlayerHauteur), $WOWPROCESS, $PlayerHauteurInputed, "float")
EndFunc
func PlayerLargeurInputFunc()
    $PlayerLargeurInputed=GUICtrlRead ($PlayerLargeurInput)
	_MemoryWrite(($PlayerBase + $PlayerLargeur), $WOWPROCESS, $PlayerLargeurInputed, "float")
EndFunc
Func PlayerInputResetFunc()
	_MemoryWrite(($PlayerBase+$PlayerScale), $WOWPROCESS, 1, "float")
If $PlayerHauteurReset = 0 Then
	_MemoryWrite(($PlayerBase+$PlayerHauteur), $WOWPROCESS, 2.01, "float")
	$PlayerHauteurVar=2.01
	GUICtrlSetData($PlayerHauteurInput,Round($PlayerHauteurVar, 5))
Else
	_MemoryWrite(($PlayerBase+$PlayerHauteur), $WOWPROCESS, $PlayerHauteurReset, "float")
	GUICtrlSetData($PlayerHauteurInput,Round($PlayerHauteurReset, 5))
EndIf

If $PlayerLargeurReset = 0 Then
	_MemoryWrite(($PlayerBase+$PlayerLargeur), $WOWPROCESS, 0.31, "float")
	$PlayerLargeurVar=0.31
	GUICtrlSetData($PlayerLargeurInput,Round($PlayerLargeurVar, 5))
Else
	_MemoryWrite(($PlayerBase+$PlayerLargeur), $WOWPROCESS, $PlayerLargeurReset, "float")
	GUICtrlSetData($PlayerLargeurInput,Round($PlayerLargeurReset, 5))
EndIf
		GUICtrlSetData($PlayerScaleInput,1)
EndFunc

Func Inebriation()
If GUICtrlRead($InebriationON)=$GUI_CHECKED Then
	$val_Majslider_Inebriation = GUICtrlRead($SLIDER_TRANSITION_Inebriation)
    $Slider_Inebriation = $val_Majslider_Inebriation
    GUICtrlSetData($VALEUR_SLIDER_Inebriation,$Slider_Inebriation)
	_MemoryWrite(($PlayerBase2+$Inebriation),$WOWPROCESS,$Slider_Inebriation, "dword")
Else
	$val_Majslider_Inebriation = GUICtrlRead($SLIDER_TRANSITION_Inebriation)
    $Slider_Inebriation = $val_Majslider_Inebriation
    GUICtrlSetData($VALEUR_SLIDER_Inebriation,$Slider_Inebriation)
	_MemoryWrite(($PlayerBase2+$Inebriation),$WOWPROCESS,0, "dword")
EndIf
EndFunc

func playershow1()
	If GUICtrlRead($PlayerFlags2Check1)=$GUI_CHECKED Then
		$PlayerFlags2Value = _MemoryRead($PlayerBase2+$PlayerFlags2,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$PlayerFlags2,$WowProcess,($PlayerFlags2Value+1), "dword")
	Else
		$PlayerFlags2Value = _MemoryRead($PlayerBase2+$PlayerFlags2, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$PlayerFlags2,$WowProcess,($PlayerFlags2Value-1), "dword")
	EndIf
 EndFunc

func playershow2()
	If GUICtrlRead($PlayerFlags2Check2)=$GUI_CHECKED Then
		$PlayerFlags2Value = _MemoryRead($PlayerBase2+$PlayerFlags2,$WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$PlayerFlags2,$WowProcess,($PlayerFlags2Value+2), "dword")
	Else
		$PlayerFlags2Value = _MemoryRead($PlayerBase2+$PlayerFlags2, $WowProcess, "dword")
		_MemoryWrite($PlayerBase2+$PlayerFlags2,$WowProcess,($PlayerFlags2Value-2), "dword")
	EndIf
 EndFunc

func cameraspectate()
	If GUICtrlRead($CameraSpectate)=$GUI_CHECKED Then
		$POSX2=_MemoryRead($PlayerBase+$POSX, $WowProcess, "Float")
		$POSY2=_MemoryRead($PlayerBase+$POSY, $WowProcess, "Float")
		$POSZ2=_MemoryRead($PlayerBase+$POSZ, $WowProcess, "Float")
		$POSR2=_MemoryRead($PlayerBase+$POSR, $WowProcess, "Float")
		_MemoryWrite($POSXCAMERA, $WowProcess, $POSX2, "Float")
		_MemoryWrite($POSXCAMERA+4, $WowProcess, $POSY2, "Float")
		_MemoryWrite($POSXCAMERA+8, $WowProcess, $POSZ2+3, "Float")
		_MemoryWrite($OFS_PBSPECTATE, $WowProcess, 255, "Float")
		_MemoryWrite($MEMORYCAMROTZ, $WowProcess, 0.36, "Float")
		_MemoryWrite($MEMORYCAMROTX, $WowProcess, $POSR2, "Float")
		sleep(500)
	ElseIf GUICtrlRead($CameraSpectate)=$GUI_UNCHECKED Then
		_MemoryWrite($OFS_PBSPECTATE, $WowProcess, 0, "float")
		sleep(500)
	EndIf
EndFunc

func cameranoclip()
	If GUICtrlRead($CameraSpectateNoclip)=$GUI_CHECKED Then
		_MemoryWrite($POSXCAMERA + 60, $WowProcess, 0, "int")
	ElseIf GUICtrlRead($CameraSpectateNoclip)=$GUI_UNCHECKED Then
		_MemoryWrite($POSXCAMERA + 60, $WowProcess, 1, "int")
	EndIf
EndFunc

func camerafollow()
	If GUICtrlRead($CameraFollow)=$GUI_CHECKED Then
		$ClientConnection=_MemoryRead($StaticClientConnection,$WowProcess,"dword")
		$CurListMgr=_MemoryRead($ClientConnection+$MgrOffset,$WowProcess,"dword")
		$CurrentTargetGUID=_MemoryRead($TargetGUIDStatic,$WowProcess,"uint64")
		coor($CurrentTargetGUID)
	ElseIf GUICtrlRead($CameraFollow)=$GUI_UNCHECKED Then
	EndIf
EndFunc

func dummy()
EndFunc

func coor($arg)
	If $arg=0 then Return
	$Adr=GetGuid($arg)
	$R=_MemoryRead($Adr+$PosR,$WowProcess,"float")
	$RXvar=$R
	$RZvar=0.30
	$SpecZoom=1.5
		If GUICtrlRead($CameraFollow)=$GUI_CHECKED Then
			Do
				If _IsPressed(27) Then
					$RXvar=$RXvar+0.002
				ElseIf _IsPressed(25) Then
					$RXvar=$RXvar-0.002
				ElseIf _IsPressed(26) Then
					$SpecZoom=$SpecZoom-0.001
				ElseIf _IsPressed(28) Then
					$SpecZoom=$SpecZoom+0.001
				EndIf
			HotKeySet("{left}","dummy")
			HotKeySet("{right}","dummy")
			HotKeySet("{up}","dummy")
			HotKeySet("{down}","dummy")
			$X=_MemoryRead($Adr+$PosX,$WowProcess,"float")
			$Y=_MemoryRead($Adr+$PosY,$WowProcess,"float")
			$Z=_MemoryRead($Adr+$PosZ,$WowProcess,"float")
			$R=_MemoryRead($Adr+$PosR,$WowProcess,"float")
			_MemoryWrite($POSXCAMERA, $WowProcess, $X-(8*cos($RXvar)), "Float")
			_MemoryWrite($POSXCAMERA+4, $WowProcess, $Y-(8*Sin($RXvar)), "Float")
			_MemoryWrite($POSXCAMERA+8, $WowProcess, $Z+4, "Float")
			_MemoryWrite($POSXCAMERA+52, $WowProcess, $SpecZoom, "Float")
			_MemoryWrite($MEMORYCAMROTZ, $WowProcess, $RZvar, "float")
			_MemoryWrite($MEMORYCAMROTX, $WowProcess, $RXvar, "float")
			_MemoryWrite($OFS_PBSPECTATE, $WowProcess, 255, "Float");caméra spectateur activée
			_MemoryWrite($POSXCAMERA+56, $WowProcess, 0, "float");vitesse
			Until GUICtrlRead($CameraFollow)=$GUI_UNCHECKED
		EndIf
	If GUICtrlRead($CameraFollow)=$GUI_UNCHECKED Then
		$SpecZoom=1.5
		HotKeySet("{left}")
		HotKeySet("{right}")
		HotKeySet("{up}")
		HotKeySet("{down}")
		$POSX2=_MemoryRead($PlayerBase+$POSX, $WowProcess, "Float")
		$POSY2=_MemoryRead($PlayerBase+$POSY, $WowProcess, "Float")
		$POSZ2=_MemoryRead($PlayerBase+$POSZ, $WowProcess, "Float")
		$POSR2=_MemoryRead($PlayerBase+$POSR, $WowProcess, "Float")
		_MemoryWrite($POSXCAMERA, $WowProcess, $POSX2, "Float")
		_MemoryWrite($POSXCAMERA+4, $WowProcess, $POSY2, "Float")
		_MemoryWrite($POSXCAMERA+8, $WowProcess, $POSZ2+4, "Float")
		_MemoryWrite($POSXCAMERA+52, $WowProcess, $SpecZoom, "Float")
		_MemoryWrite($OFS_PBSPECTATE, $WowProcess, 0, "float");caméra spectateur désactivée
	EndIf
EndFunc

func setheure()
$TimeMinutesValue = GUICtrlRead($HeureInput)
_MemoryWrite($TimeHeure,$WowProcess,Abs($TimeMinutesValue),"dword")
endfunc
func setminutes()
$TimeMinutesValue = GUICtrlRead($MinutesInput)
_MemoryWrite($TimeMinutes,$WowProcess,Abs($TimeMinutesValue),"dword")
endfunc
func settimespeed()
$TimeSpeedValue = $TimeSpeedORG*GUICtrlRead($VitesseTempsInput)
_MemoryWrite($TimeSpeed,$WowProcess,Abs($TimeSpeedValue),"float")
endfunc

func Reset()
_MemoryClose ($WowPid)
Global $WowPid = ProcessExists("wow.exe")
Global $WowProcess = _MEMORYOPEN ($WowPid)
$PB1 = _MemoryRead($StaticPlayer,$WowProcess,"Ptr")
$PB2 = _MemoryRead($PB1+$PbPointer1,$WowProcess,"Ptr")
$PlayerBase = _MemoryRead($PB2+$PbPointer2,$WowProcess,"Ptr")
$PlayerBase2 = _MemoryRead($PlayerBase+8,$WowProcess,"Ptr")
GUICtrlSetData($PriveSpeedGlobaleInput,IniRead($Setting,"Reglages","pspeedglobalevalue","Error"))
GUICtrlSetData($PriveSpeedInput,IniRead($Setting,"Reglages","pspeedvalue","Error"))
GUICtrlSetData($PriveFlySpeedInput,IniRead($Setting,"Reglages","pflymodspeedvalue","Error"))
GUICtrlSetData($PriveSuperSautInput,IniRead($Setting,"Reglages","psupersautvalue","Error"))
GUICtrlSetData($SuperSautInput,IniRead($Setting,"Reglages","osupersautvalue","Error"))
GUICtrlSetData($PriveXYZSpeedInput,IniRead($Setting,"Reglages","pXYZSpeed","Error"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; OFFICIEL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GUICtrlSetState($WalljumpON, $GUI_UNCHECKED)
GUICtrlSetState($UnderwaterWalkON, $GUI_UNCHECKED)
GUICtrlSetState($SuperSautON, $GUI_UNCHECKED)
GUICtrlSetState($WallClimbON, $GUI_UNCHECKED)
_MemoryWrite($PlayerBase+$Wallclimb, $WowProcess,1, "float")
GUICtrlSetState($TpON, $GUI_UNCHECKED)
GUICtrlSetState($NoClipActionON, $GUI_UNCHECKED)
_MemoryWrite($PlayerBase2+$Ressources, $WowProcess,0, "dword")
_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,0, "dword")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PRIVE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
If GUICtrlRead($PriveMountON)=$GUI_CHECKED Then
GUICtrlSetState($PriveMountON, $GUI_UNCHECKED)
$Mount1Value=_MemoryRead($Mount1, $WowProcess, "ptr")
$Mount2Value=_MemoryRead($Mount2, $WowProcess, "ptr")
_MemoryWrite($Mount1, $WowProcess,$Mount1Value-0x00000077, "Ptr")
_MemoryWrite($Mount2, $WowProcess,$Mount2Value-0x00000077, "Ptr")
EndIf
GUICtrlSetState($PriveWalljumpON, $GUI_UNCHECKED)
GUICtrlSetState($PriveCollisionsM2, $GUI_UNCHECKED)
GUICtrlSetState($PriveCollisionsWMO, $GUI_UNCHECKED)
GUICtrlSetState($PriveCollisionsAll, $GUI_UNCHECKED)
GUICtrlSetState($PriveCollisionsM2, $GUI_ENABLE)
GUICtrlSetState($PriveCollisionsWMO, $GUI_ENABLE)
GUICtrlSetState($PriveCollisionsAll, $GUI_ENABLE)
GUICtrlSetState($CollisionsM2, $GUI_UNCHECKED)
GUICtrlSetState($CollisionsWMO, $GUI_UNCHECKED)
GUICtrlSetState($CollisionsAll, $GUI_UNCHECKED)
GUICtrlSetState($CollisionsM2, $GUI_ENABLE)
GUICtrlSetState($CollisionsWMO, $GUI_ENABLE)
GUICtrlSetState($CollisionsAll, $GUI_ENABLE)
_MemoryWrite($CollisionM2S, $WOWPROCESS, 0x458B1774, "Ptr")
_MemoryWrite($CollisionM2C, $WOWPROCESS, 0x0162840F, "Ptr")
_MemoryWrite($CollisionWMO, $WOWPROCESS, 0xC0320675, "Ptr")
GUICtrlSetState($WaterWalkON, $GUI_UNCHECKED)
_MemoryWrite($WaterWalkPatch, $WOWPROCESS, 0xCF811474, "Ptr")
GUICtrlSetState($PriveInfiniteJumpON, $GUI_UNCHECKED)
_MemoryWrite($InfiniteJumpPatch, $WowProcess,0xB70F4475, "Ptr")
GUICtrlSetState($PriveUnderwaterWalkON, $GUI_UNCHECKED)
GUICtrlSetState($PriveSpeedGlobaleON, $GUI_UNCHECKED)
_MemoryWrite($PlayerBase2+$PlayerFlags, $WowProcess,8, "dword")
GUICtrlSetState($PriveSuperSautON, $GUI_UNCHECKED)
GUICtrlSetState($PriveWallClimbON, $GUI_UNCHECKED)
_MemoryWrite($PlayerBase+$Wallclimb, $WowProcess,1, "float")
_MemoryWrite($PlayerBase2+$Ressources, $WowProcess,0, "dword")
_MemoryWrite($PlayerBase2+$Hunt,$WowProcess,0, "dword")
GUICtrlSetState($PriveXYZON,$GUI_UNCHECKED)
GUICtrlSetState($PriveClickTP,$GUI_UNCHECKED)
GUICtrlSetState($PriveFlyModON,$GUI_UNCHECKED)
GUICtrlSetState($PriveWaterWalkON,$GUI_UNCHECKED)
_MemoryWrite($PlayerBase+$PlayerState,$WowProcess,128, "dword")
_MemoryWrite($PlayerBase+$PlayerState2,$WowProcess,0x80000000, "ptr")
GUICtrlSetState($PriveFreezeZON,$GUI_UNCHECKED)
GUICtrlSetState($PriveNoClipON,$GUI_UNCHECKED)
_MemoryWrite($PlayerBase+$FlySpeed,$WowProcess,7, "float")
GUICtrlSetState($PriveSpeedON,$GUI_UNCHECKED)
GUICtrlSetState($PriveSpeedGlobaleON,$GUI_ENABLE)
GUICtrlSetState($PriveSpeedGlobaleInput,$GUI_ENABLE)
_MemoryWrite($PlayerBase+$Speed,$WowProcess,7, "float")
_MemoryWrite($PlayerBase+$SpeedSwim,$WowProcess,4.7, "float")
GUICtrlSetData($PriveXInput,Round(_MemoryRead($PlayerBase+$PosX,$WowProcess,"float"), 3))
GUICtrlSetData($PriveYInput,Round(_MemoryRead($PlayerBase+$PosY,$WowProcess,"float"), 3))
GUICtrlSetData($PriveZInput,Round(_MemoryRead($PlayerBase+$PosZ,$WowProcess,"float"), 3))
$SCPriveFlyModON = 0
$SCPriveSpeedON = 0
$SCPriveWallClimbON = 0
$SCPriveClickTPON = 0
$SCPriveSupersautON = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; AFFICHAGE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$PlayerHauteurVar=_MemoryRead($PlayerBase+$PlayerHauteur,$WowProcess,"float")
$PlayerLargeurVar=_MemoryRead($PlayerBase+$PlayerLargeur,$WowProcess,"float")
PlayerInputResetFunc()
GUICtrlSetData($VALEUR_SLIDER_Inebriation,0)
GUICtrlSetData($SLIDER_TRANSITION_Inebriation,0)
GUICtrlSetState($InebriationON,$GUI_UNCHECKED)
_MemoryWrite(($PlayerBase2+$Inebriation),$WOWPROCESS,0, "dword")
GUICtrlSetState($PlayerFlags2Check1,$GUI_UNCHECKED)
GUICtrlSetState($PlayerFlags2Check2,$GUI_UNCHECKED)
_MemoryWrite($PlayerBase2+$PlayerFlags2,$WowProcess,2048, "dword")
_MemoryWrite($OFS_PBSPECTATE, $WowProcess, 0, "float")
GUICtrlSetState($CameraSpectate,$GUI_UNCHECKED)
_MemoryWrite($OFS_PBSPECTATE, $WowProcess, 0, "float")
GUICtrlSetState($CameraSpectateNoclip,$GUI_UNCHECKED)
_MemoryWrite($POSXCAMERA + 60, $WowProcess, 1, "int")
GUICtrlSetState($PriveTrackAllBet,$GUI_UNCHECKED)
GUICtrlSetState($PriveTrackAllRes,$GUI_UNCHECKED)
GUICtrlSetState($TrackAllBet,$GUI_UNCHECKED)
GUICtrlSetState($TrackAllRes,$GUI_UNCHECKED)
GUICtrlSetState($NoCooldownCheck,$GUI_UNCHECKED)
GUICtrlSetState($CameraFollow,$GUI_UNCHECKED)
GUICtrlSetState($TrackHerbes, $GUI_UNCHECKED)
GUICtrlSetState($TrackHerbes, $GUI_ENABLE)
GUICtrlSetState($TrackFilons, $GUI_UNCHECKED)
GUICtrlSetState($TrackFilons, $GUI_ENABLE)
GUICtrlSetState($TrackCoffres, $GUI_UNCHECKED)
GUICtrlSetState($TrackCoffres, $GUI_ENABLE)
GUICtrlSetState($TrackPoissons, $GUI_UNCHECKED)
GUICtrlSetState($TrackPoissons, $GUI_ENABLE)
GUICtrlSetState($TrackBetes, $GUI_UNCHECKED)
GUICtrlSetState($TrackBetes, $GUI_ENABLE)
GUICtrlSetState($TrackDragons, $GUI_UNCHECKED)
GUICtrlSetState($TrackDragons, $GUI_ENABLE)
GUICtrlSetState($TrackDemons, $GUI_UNCHECKED)
GUICtrlSetState($TrackDemons, $GUI_ENABLE)
GUICtrlSetState($TrackElementaires, $GUI_UNCHECKED)
GUICtrlSetState($TrackElementaires, $GUI_ENABLE)
GUICtrlSetState($TrackGeants, $GUI_UNCHECKED)
GUICtrlSetState($TrackGeants, $GUI_ENABLE)
GUICtrlSetState($TrackMortsVivants, $GUI_UNCHECKED)
GUICtrlSetState($TrackMortsVivants, $GUI_ENABLE)
GUICtrlSetState($TrackHumanoides, $GUI_UNCHECKED)
GUICtrlSetState($TrackHumanoides, $GUI_ENABLE)
GUICtrlSetState($TrackBestioles, $GUI_UNCHECKED)
GUICtrlSetState($TrackBestioles, $GUI_ENABLE)
GUICtrlSetState($PriveTrackHerbes, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackHerbes, $GUI_ENABLE)
GUICtrlSetState($PriveTrackFilons, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackFilons, $GUI_ENABLE)
GUICtrlSetState($PriveTrackCoffres, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackCoffres, $GUI_ENABLE)
GUICtrlSetState($PriveTrackPoissons, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackPoissons, $GUI_ENABLE)
GUICtrlSetState($PriveTrackBetes, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackBetes, $GUI_ENABLE)
GUICtrlSetState($PriveTrackDragons, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackDragons, $GUI_ENABLE)
GUICtrlSetState($PriveTrackDemons, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackDemons, $GUI_ENABLE)
GUICtrlSetState($PriveTrackElementaires, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackElementaires, $GUI_ENABLE)
GUICtrlSetState($PriveTrackGeants, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackGeants, $GUI_ENABLE)
GUICtrlSetState($PriveTrackMortsVivants, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackMortsVivants, $GUI_ENABLE)
GUICtrlSetState($PriveTrackHumanoides, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackHumanoides, $GUI_ENABLE)
GUICtrlSetState($PriveTrackBestioles, $GUI_UNCHECKED)
GUICtrlSetState($PriveTrackBestioles, $GUI_ENABLE)
GUICtrlSetData($HeureInput,_MemoryRead($TimeHeure,$WowProcess,"dword"))
GUICtrlSetData($MinutesInput,_MemoryRead($TimeMinutes,$WowProcess,"dword"))
GUICtrlSetData($VitesseTempsInput,1)
_MemoryWrite($TimeSpeed,$WowProcess,$TimeSpeedORG,"float")
 EndFunc


; So Long and Thanks for All the fish !

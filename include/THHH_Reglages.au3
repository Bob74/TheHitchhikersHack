

Func reglageslancement()
If IniRead($Setting,"Reglages","pspeed","Erreur") = 1 Then
	GUICtrlSetState($LaunchSpeed, $GUI_CHECKED)
	GUICtrlSetState($PriveSpeedON,$GUI_CHECKED)
	speed()
EndIf
If IniRead($Setting,"Reglages","pflymod","Erreur") = 1 Then
	GUICtrlSetState($LaunchFly, $GUI_CHECKED)
	GUICtrlSetState($PriveFlyModON,$GUI_CHECKED)
	flymod()
EndIf
If IniRead($Setting,"Reglages","pSupersaut","Erreur") = 1 Then
	GUICtrlSetState($LaunchSuperSautPrivate, $GUI_CHECKED)
	GUICtrlSetState($PriveSuperSautON,$GUI_CHECKED)
EndIf
If IniRead($Setting,"Reglages","oSupersaut","Erreur") = 1 Then
	GUICtrlSetState($LaunchSuperSautOfficiel, $GUI_CHECKED)
	GUICtrlSetState($SuperSautON,$GUI_CHECKED)
EndIf
If IniRead($Setting,"Reglages","pXYZActivate","Erreur") = 1 Then
	GUICtrlSetState($LaunchXYZPrivate, $GUI_CHECKED)
	GUICtrlSetState($PriveXYZON,$GUI_CHECKED)
EndIf
If IniRead($Setting,"Reglages","pWallclimb","Erreur") = 1 Then
	GUICtrlSetState($LaunchWallclimbPrivate, $GUI_CHECKED)
	GUICtrlSetState($PriveWallClimbON,$GUI_CHECKED)
	PriveWallClimbFunc()
EndIf
If IniRead($Setting,"Reglages","oWallclimb","Erreur") = 1 Then
	GUICtrlSetState($LaunchWallclimbOfficiel, $GUI_CHECKED)
	GUICtrlSetState($WallClimbON, $GUI_CHECKED)
	WallClimbFunc()
EndIf
If IniRead($Setting,"Reglages","pNocooldown","Erreur") = 1 Then
	GUICtrlSetState($LaunchNoCD, $GUI_CHECKED)
	GUICtrlSetState($NoCooldownCheck,$GUI_CHECKED)
	NoCooldown()
EndIf
If IniRead($Setting,"Reglages","pRaccourcis","Erreur") = 1 Then
	GUICtrlSetState($LaunchRaccourcisPrivate, $GUI_CHECKED)
	GUICtrlSetState($PriveRaccourcis,$GUI_CHECKED)
	assignSCprivate()
EndIf
If IniRead($Setting,"Reglages","pclicktotp","Erreur") = 1 Then
	GUICtrlSetState($LaunchClicktoTP, $GUI_CHECKED)
	GUICtrlSetState($PriveClickTP,$GUI_CHECKED)
EndIf
If IniRead($Setting,"Reglages","oXYZActivate","Erreur") = 1 Then
	GUICtrlSetState($LaunchXYZOfficiel, $GUI_CHECKED)
	GUICtrlSetState($TpON,$GUI_CHECKED)
EndIf
If IniRead($Setting,"Reglages","oXYZActivate","Erreur") = 1 Then
	GUICtrlSetState($LaunchXYZOfficiel, $GUI_CHECKED)
	GUICtrlSetState($TpON,$GUI_CHECKED)
EndIf
If IniRead($Setting,"Reglages","oRaccourcis","Erreur") = 1 Then
	GUICtrlSetState($LaunchRaccourcisOfficiel, $GUI_CHECKED)
	GUICtrlSetState($Raccourcis,$GUI_CHECKED)
	assignSC()
EndIf
If IniRead($Setting,"Reglages","ptrack","Erreur") = 1 Then
GUICtrlSetState($LaunchTrackPrivate, $GUI_CHECKED)
	If IniRead($Setting,"Reglages","pRTout","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackAllRes, $GUI_CHECKED)
		privetrackallres()
	Else
	If IniRead($Setting,"Reglages","pHerbes","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackHerbes, $GUI_CHECKED)
		privetrackherbes()
	Endif
	If IniRead($Setting,"Reglages","pFilons","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackFilons, $GUI_CHECKED)
		privetrackfilons()
	Endif
	If IniRead($Setting,"Reglages","pCoffres","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackCoffres, $GUI_CHECKED)
		privetrackcoffres()
	Endif
	If IniRead($Setting,"Reglages","pPoissons","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackPoissons, $GUI_CHECKED)
		privetrackpoissons()
	EndIf
	EndIf
	If IniRead($Setting,"Reglages","pHTout","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackAllBet, $GUI_CHECKED)
		privetrackallbet()
	Else
	If IniRead($Setting,"Reglages","pBetes","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackBetes, $GUI_CHECKED)
		Privetrackbetes()
	Endif
	If IniRead($Setting,"Reglages","pDragons","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackDragons, $GUI_CHECKED)
		privetrackdragons()
	Endif
	If IniRead($Setting,"Reglages","pDemons","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackDemons, $GUI_CHECKED)
		privetrackdemons()
	Endif
	If IniRead($Setting,"Reglages","pElementaires","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackElementaires, $GUI_CHECKED)
		privetrackelementaires()
	Endif
	If IniRead($Setting,"Reglages","pGeants","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackGeants, $GUI_CHECKED)
		privetrackgeants()
	Endif
	If IniRead($Setting,"Reglages","pMorts-vivants","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackMortsVivants, $GUI_CHECKED)
		privetrackmortsvivants()
	Endif
	If IniRead($Setting,"Reglages","pHumanoides","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackHumanoides, $GUI_CHECKED)
		privetrackhumanoides()
	Endif
	If IniRead($Setting,"Reglages","pBestioles","Erreur") = 1 Then
		GUICtrlSetState($PriveTrackBestioles, $GUI_CHECKED)
		privetrackbestioles()
	EndIf
	EndIf
EndIf
If IniRead($Setting,"Reglages","otrack","Erreur") = 1 Then
GUICtrlSetState($LaunchTrackPrivate, $GUI_CHECKED)
	If IniRead($Setting,"Reglages","oRTout","Erreur") = 1 Then
		GUICtrlSetState($TrackAllRes, $GUI_CHECKED)
		trackallres()
	Else
	If IniRead($Setting,"Reglages","oHerbes","Erreur") = 1 Then
		GUICtrlSetState($TrackHerbes, $GUI_CHECKED)
		trackherbes()
	Endif
	If IniRead($Setting,"Reglages","oFilons","Erreur") = 1 Then
		GUICtrlSetState($TrackFilons, $GUI_CHECKED)
		trackfilons()
	Endif
	If IniRead($Setting,"Reglages","oCoffres","Erreur") = 1 Then
		GUICtrlSetState($TrackCoffres, $GUI_CHECKED)
		trackcoffres()
	Endif
	If IniRead($Setting,"Reglages","oPoissons","Erreur") = 1 Then
		GUICtrlSetState($TrackPoissons, $GUI_CHECKED)
		trackpoissons()
	EndIf
	EndIf
	If IniRead($Setting,"Reglages","oHTout","Erreur") = 1 Then
		GUICtrlSetState($TrackAllBet, $GUI_CHECKED)
		trackallbet()
	Else
	If IniRead($Setting,"Reglages","oBetes","Erreur") = 1 Then
		GUICtrlSetState($TrackBetes, $GUI_CHECKED)
		trackbetes()
	Endif
	If IniRead($Setting,"Reglages","oDragons","Erreur") = 1 Then
		GUICtrlSetState($TrackDragons, $GUI_CHECKED)
		trackdragons()
	Endif
	If IniRead($Setting,"Reglages","oDemons","Erreur") = 1 Then
		GUICtrlSetState($TrackDemons, $GUI_CHECKED)
		trackdemons()
	Endif
	If IniRead($Setting,"Reglages","oElementaires","Erreur") = 1 Then
		GUICtrlSetState($TrackElementaires, $GUI_CHECKED)
		trackelementaires()
	Endif
	If IniRead($Setting,"Reglages","oGeants","Erreur") = 1 Then
		GUICtrlSetState($TrackGeants, $GUI_CHECKED)
		trackgeants()
	Endif
	If IniRead($Setting,"Reglages","oMorts-vivants","Erreur") = 1 Then
		GUICtrlSetState($TrackMortsVivants, $GUI_CHECKED)
		trackmortsvivants()
	Endif
	If IniRead($Setting,"Reglages","oHumanoides","Erreur") = 1 Then
		GUICtrlSetState($TrackHumanoides, $GUI_CHECKED)
		trackhumanoides()
	Endif
	If IniRead($Setting,"Reglages","oBestioles","Erreur") = 1 Then
		GUICtrlSetState($TrackBestioles, $GUI_CHECKED)
		trackbestioles()
	EndIf
	EndIf
EndIf
EndFunc

func enablesettingchoice()
GUICtrlSetState($LaunchSpeed, $GUI_ENABLE)
GUICtrlSetState($LaunchFly, $GUI_ENABLE)
GUICtrlSetState($LaunchWallclimbPrivate, $GUI_ENABLE)
GUICtrlSetState($LaunchNoCD, $GUI_ENABLE)
GUICtrlSetState($LaunchRaccourcisPrivate, $GUI_ENABLE)
GUICtrlSetState($LaunchSuperSautPrivate, $GUI_ENABLE)
GUICtrlSetState($LaunchTrackPrivate, $GUI_ENABLE)
GUICtrlSetState($LaunchClicktoTP, $GUI_ENABLE)
GUICtrlSetState($LaunchXYZPrivate, $GUI_ENABLE)
GUICtrlSetState($LaunchSuperSautOfficiel, $GUI_ENABLE)
GUICtrlSetState($LaunchWallclimbOfficiel, $GUI_ENABLE)
GUICtrlSetState($LaunchTrackOfficiel, $GUI_ENABLE)
GUICtrlSetState($LaunchXYZOfficiel, $GUI_ENABLE)
GUICtrlSetState($LaunchRaccourcisOfficiel, $GUI_ENABLE)
EndFunc

func disablesettingchoice()
GUICtrlSetState($LaunchSpeed, $GUI_DISABLE)
GUICtrlSetState($LaunchFly, $GUI_DISABLE)
GUICtrlSetState($LaunchWallclimbPrivate, $GUI_DISABLE)
GUICtrlSetState($LaunchNoCD, $GUI_DISABLE)
GUICtrlSetState($LaunchRaccourcisPrivate, $GUI_DISABLE)
GUICtrlSetState($LaunchSuperSautPrivate, $GUI_DISABLE)
GUICtrlSetState($LaunchTrackPrivate, $GUI_DISABLE)
GUICtrlSetState($LaunchClicktoTP, $GUI_DISABLE)
GUICtrlSetState($LaunchXYZPrivate, $GUI_DISABLE)
GUICtrlSetState($LaunchSuperSautOfficiel, $GUI_DISABLE)
GUICtrlSetState($LaunchWallclimbOfficiel, $GUI_DISABLE)
GUICtrlSetState($LaunchTrackOfficiel, $GUI_DISABLE)
GUICtrlSetState($LaunchXYZOfficiel, $GUI_DISABLE)
GUICtrlSetState($LaunchRaccourcisOfficiel, $GUI_DISABLE)
EndFunc

func savevalues()
IniWrite($Setting,"Reglages","pspeed",GUICtrlRead($LaunchSpeed))
IniWrite($Setting,"Reglages","pflymod",GUICtrlRead($LaunchFly))
IniWrite($Setting,"Reglages","pWallclimb",GUICtrlRead($LaunchWallclimbPrivate))
IniWrite($Setting,"Reglages","pNocooldown",GUICtrlRead($LaunchNoCD))
IniWrite($Setting,"Reglages","pRaccourcis",GUICtrlRead($LaunchRaccourcisPrivate))
IniWrite($Setting,"Reglages","pSupersaut",GUICtrlRead($LaunchSuperSautPrivate))
IniWrite($Setting,"Reglages","ptrack",GUICtrlRead($LaunchTrackPrivate))
IniWrite($Setting,"Reglages","pclicktotp",GUICtrlRead($LaunchClicktoTP))
IniWrite($Setting,"Reglages","pXYZActivate",GUICtrlRead($LaunchXYZPrivate))
IniWrite($Setting,"Reglages","oSupersaut",GUICtrlRead($LaunchSuperSautOfficiel))
IniWrite($Setting,"Reglages","oWallclimb",GUICtrlRead($LaunchWallclimbOfficiel))
IniWrite($Setting,"Reglages","otrack",GUICtrlRead($LaunchTrackOfficiel))
IniWrite($Setting,"Reglages","oXYZActivate",GUICtrlRead($LaunchXYZOfficiel))
IniWrite($Setting,"Reglages","oRaccourcis",GUICtrlRead($LaunchRaccourcisOfficiel))
IniWrite($Setting,"Reglages","pHerbes",GUICtrlRead($PriveTrackHerbes))
IniWrite($Setting,"Reglages","pFilons",GUICtrlRead($PriveTrackFilons))
IniWrite($Setting,"Reglages","pCoffres",GUICtrlRead($PriveTrackCoffres))
IniWrite($Setting,"Reglages","pPoissons",GUICtrlRead($PriveTrackPoissons))
IniWrite($Setting,"Reglages","pRTout",GUICtrlRead($PriveTrackAllRes))
IniWrite($Setting,"Reglages","pBetes",GUICtrlRead($PriveTrackBetes))
IniWrite($Setting,"Reglages","pDragons",GUICtrlRead($PriveTrackDragons))
IniWrite($Setting,"Reglages","pDemons",GUICtrlRead($PriveTrackDemons))
IniWrite($Setting,"Reglages","pElementaires",GUICtrlRead($PriveTrackElementaires))
IniWrite($Setting,"Reglages","pGeants",GUICtrlRead($PriveTrackGeants))
IniWrite($Setting,"Reglages","pMorts-vivants",GUICtrlRead($PriveTrackMortsVivants))
IniWrite($Setting,"Reglages","pHumanoides",GUICtrlRead($PriveTrackHumanoides))
IniWrite($Setting,"Reglages","pBestioles",GUICtrlRead($PriveTrackBestioles))
IniWrite($Setting,"Reglages","pHTout",GUICtrlRead($PriveTrackAllBet))
IniWrite($Setting,"Reglages","oHerbes",GUICtrlRead($TrackHerbes))
IniWrite($Setting,"Reglages","oFilons",GUICtrlRead($TrackFilons))
IniWrite($Setting,"Reglages","oCoffres",GUICtrlRead($TrackCoffres))
IniWrite($Setting,"Reglages","oPoissons",GUICtrlRead($TrackPoissons))
IniWrite($Setting,"Reglages","oRTout",GUICtrlRead($TrackAllRes))
IniWrite($Setting,"Reglages","oBetes",GUICtrlRead($TrackBetes))
IniWrite($Setting,"Reglages","oDragons",GUICtrlRead($TrackDragons))
IniWrite($Setting,"Reglages","oDemons",GUICtrlRead($TrackDemons))
IniWrite($Setting,"Reglages","oElementaires",GUICtrlRead($TrackElementaires))
IniWrite($Setting,"Reglages","oGeants",GUICtrlRead($TrackGeants))
IniWrite($Setting,"Reglages","oMorts-vivants",GUICtrlRead($TrackMortsVivants))
IniWrite($Setting,"Reglages","oHumanoides",GUICtrlRead($TrackHumanoides))
IniWrite($Setting,"Reglages","oBestioles",GUICtrlRead($TrackBestioles))
IniWrite($Setting,"Reglages","oHTout",GUICtrlRead($TrackAllBet))
EndFunc
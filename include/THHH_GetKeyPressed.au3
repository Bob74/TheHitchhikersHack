


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;; ECRITURE DE LA TOUCHE DANS L'INI ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

func getkeypressed()
			If _IsPressed(41 ,$dll) Then
				$Keypressed = "a"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'a'&'}'&'"')
			Elseif _IsPressed(42 ,$dll) Then
				$Keypressed = "b"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'b'&'}'&'"')
			Elseif _IsPressed(43 ,$dll) Then
				$Keypressed = "c"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'c'&'}'&'"')
			Elseif _IsPressed(44 ,$dll) Then
				$Keypressed = "d"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'d'&'}'&'"')
			Elseif _IsPressed(45 ,$dll) Then
				$Keypressed = "e"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'e'&'}'&'"')
			Elseif _IsPressed(46 ,$dll) Then
				$Keypressed = "f"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'f'&'}'&'"')
			Elseif _IsPressed(47 ,$dll) Then
				$Keypressed = "g"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'g'&'}'&'"')
			Elseif _IsPressed(48 ,$dll) Then
				$Keypressed = "h"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'h'&'}'&'"')
			Elseif _IsPressed(49 ,$dll) Then
				$Keypressed = "i"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'i'&'}'&'"')
			Elseif _IsPressed("4A" ,$dll) Then
				$Keypressed = "j"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'j'&'}'&'"')
			Elseif _IsPressed("4B" ,$dll) Then
				$Keypressed = "k"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'k'&'}'&'"')
			Elseif _IsPressed("4C" ,$dll) Then
				$Keypressed = "l"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'l'&'}'&'"')
			Elseif _IsPressed("4D" ,$dll) Then
				$Keypressed = "m"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'m'&'}'&'"')
			Elseif _IsPressed("4E" ,$dll) Then
				$Keypressed = "n"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'n'&'}'&'"')
			Elseif _IsPressed("4F" ,$dll) Then
				$Keypressed = "o"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'o'&'}'&'"')
			Elseif _IsPressed(50 ,$dll) Then
				$Keypressed = "p"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'p'&'}'&'"')
			Elseif _IsPressed(51 ,$dll) Then
				$Keypressed = "q"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'q'&'}'&'"')
			Elseif _IsPressed(52 ,$dll) Then
				$Keypressed = "r"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'r'&'}'&'"')
			Elseif _IsPressed(53 ,$dll) Then
				$Keypressed = "s"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'s'&'}'&'"')
			Elseif _IsPressed(54 ,$dll) Then
				$Keypressed = "t"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'t'&'}'&'"')
			Elseif _IsPressed(55 ,$dll) Then
				$Keypressed = "u"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'u'&'}'&'"')
			Elseif _IsPressed(56 ,$dll) Then
				$Keypressed = "v"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'v'&'}'&'"')
			Elseif _IsPressed(57 ,$dll) Then
				$Keypressed = "w"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'w'&'}'&'"')
			Elseif _IsPressed(58 ,$dll) Then
				$Keypressed = "x"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'x'&'}'&'"')
			Elseif _IsPressed(59 ,$dll) Then
				$Keypressed = "y"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'y'&'}'&'"')
			Elseif _IsPressed("5A" ,$dll) Then
				$Keypressed = "z"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'z'&'}'&'"')
			Elseif _IsPressed(70 ,$dll) Then
				$Keypressed = "F1"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F1'&'}'&'"')
			Elseif _IsPressed(71 ,$dll) Then
				$Keypressed = "F2"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F2'&'}'&'"')
			Elseif _IsPressed(72 ,$dll) Then
				$Keypressed = "F3"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F3'&'}'&'"')
			Elseif _IsPressed(73 ,$dll) Then
				$Keypressed = "F4"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F4'&'}'&'"')
			Elseif _IsPressed(74 ,$dll) Then
				$Keypressed = "F5"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F5'&'}'&'"')
			Elseif _IsPressed(75 ,$dll) Then
				$Keypressed = "F6"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F6'&'}'&'"')
			Elseif _IsPressed(76 ,$dll) Then
				$Keypressed = "F7"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F7'&'}'&'"')
			Elseif _IsPressed(77 ,$dll) Then
				$Keypressed = "F8"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F8'&'}'&'"')
			Elseif _IsPressed(78 ,$dll) Then
				$Keypressed = "F9"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F9'&'}'&'"')
			Elseif _IsPressed(79 ,$dll) Then
				$Keypressed = "F10"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F10'&'}'&'"')
			Elseif _IsPressed("7A" ,$dll) Then
				$Keypressed = "F11"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F11'&'}'&'"')
			Elseif _IsPressed("7B" ,$dll) Then
				$Keypressed = "F12"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'F12'&'}'&'"')
			Elseif _IsPressed(31 ,$dll) Then
				$Keypressed = "&"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'&'&'}'&'"')
			Elseif _IsPressed(32 ,$dll) Then
				$Keypressed = "é"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'é'&'}'&'"')
;			Elseif _IsPressed(33 ,$dll) Then											; Touche 3 (3"#) => Pose des soucis et reste tout le temps active
;				$Keypressed = '"'
;				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'"'&'}'&'"')
			Elseif _IsPressed(34 ,$dll) Then
				$Keypressed = "'"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&"'"&'}'&'"')
			Elseif _IsPressed(35 ,$dll) Then
				$Keypressed = "("
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'('&'}'&'"')
			Elseif _IsPressed(36 ,$dll) Then
				$Keypressed = "-"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'-'&'}'&'"')
			Elseif _IsPressed(37 ,$dll) Then
				$Keypressed = "è"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'è'&'}'&'"')
			Elseif _IsPressed(38 ,$dll) Then
				$Keypressed = "_"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'_'&'}'&'"')
			Elseif _IsPressed(39 ,$dll) Then
				$Keypressed = "ç"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'ç'&'}'&'"')
			Elseif _IsPressed(30 ,$dll) Then
				$Keypressed = "à"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'à'&'}'&'"')
			Elseif _IsPressed("BA" ,$dll) Then
				$Keypressed = "$"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'$'&'}'&'"')
			Elseif _IsPressed("BB" ,$dll) Then
				$Keypressed = "="
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'='&'}'&'"')
			Elseif _IsPressed("BC" ,$dll) Then
				$Keypressed = ","
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&','&'}'&'"')
			Elseif _IsPressed("BE" ,$dll) Then
				$Keypressed = ";"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&';'&'}'&'"')
			Elseif _IsPressed("BF" ,$dll) Then
				$Keypressed = ":"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&':'&'}'&'"')
			Elseif _IsPressed("C0" ,$dll) Then
				$Keypressed = "ù"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'ù'&'}'&'"')
			Elseif _IsPressed("DB" ,$dll) Then
				$Keypressed = ")"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&')'&'}'&'"')
			Elseif _IsPressed("DC" ,$dll) Then
				$Keypressed = "*"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'*'&'}'&'"')
			Elseif _IsPressed("DD" ,$dll) Then
				$Keypressed = "^"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'^'&'}'&'"')
			Elseif _IsPressed("DE" ,$dll) Then
				$Keypressed = "²"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'²'&'}'&'"')
			Elseif _IsPressed("DF" ,$dll) Then
				$Keypressed = "!"
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, '"'&'{'&'!'&'}'&'"')
			Elseif _IsPressed(08 ,$dll) Then
				$SettingSCBRUT = iniRead($Setting, "Raccourcis - Prive", $SCFonctionName, "Erreur")
				HotKeySet($SettingSCBRUT)
				$Keypressed = ""
				IniWrite($Setting, $SCIniEmpl, $SCFonctionName, "")
			EndIf
EndFunc
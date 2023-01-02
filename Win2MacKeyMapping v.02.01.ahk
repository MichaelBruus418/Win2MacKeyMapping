; ***********************************************************************************************
; This script maps a Danish Windows keyboard to Mac via AutoHotkey (for use with NoMachine).
; General mappings (e.g. cut/copy/paste) should work with any keyboard.
; Special characters probably only works correctly for win DK to mac DK keyboard.
; Key mappings are only active when NoMachine Mac Window is active.
; This script will not be maintained.

; KeyMappings are divided into three sections:
; Function mappings (cut/copy/paste etc.)
; Character mappings (single characters)
; X-Code shortcuts remapped (spepcific for X-code editor)

; You may want to remove/outcomment X-code shortcuts remapped.

; Michael Bruus, 2023.

; --- Modifier keys ---
; - PC -		- Mac -
; Win key		Command
; Alt			Option
; Ctrl			Ctrl	 

; ***********************************************************************************************
; --- Notes ---
; {Blind} = Any modifier keys already down, will remain down during send.
; This method is necessary for Hotkeys with AltGr in MacLab. 
; https://eastmanreference.com/complete-list-of-applescript-key-codes
; https://altcodesguru.com/mac-alt-key-codes.html
; https://www.w3schools.com/charsets/ref_html_ascii.asp
; hex := Format("{:X}", dec) ; Dec2Hex

; --- Mac Key Codes ---
; VK = Virtual Key
; Name		VK (hex)	decimal	
; Ctrl 		11			17
; Option	12			18
; Cmd 		5D			93

; --- PC Key Codes ---
; VK = Virtual Key, SC = Scan code
; Name				VK (hex)	SC (hex)	Description
; Acute Accent		DB			00D			Deadkey (pipe)
; Diaeresis			BA			01B			Deadkey (caret)
; NumpaddAdd		6B			04E
; NumpaddSub		6D			04A
; Plus sign			BB			00C
; Minus sign		BD			035
; ***********************************************************************************************
; --- Config ---
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; 
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, RegEx ; Activate regular expressions for WinTitle in WinActive directive.
; ***********************************************************************************************
; --- IMPORTANT: NoMachine Window Regex ---
; To limit this script to remap keystrokes in NoMachine Mac window only, 
; we check the name of the active window.
; As of NoMachine v. 7.10.2, the following applies (but may not in the future).
; - Conditions -
; Respond only if active window have title "NoMachine" AND
; have any WinText filename AND
; is started by nxplayer.bin 
#IfWinActive NoMachine - .* ahk_exe nxplayer.bin  

; ***********************************************************************************************
; --- Function Mappings ---
; Map Windows Ctrl to Mac Command
; DESTROYS ALL KEY MAPPINGS USING CTRL.
; DON'T DO IT!
;Ctrl::vk5D

; Map Windows logo key to Mac Command key.
LWin::vk5D
RWin::vk5D

; Remap Win+d to toggle windows desktop
LWin & d::
RWin & d::
	WinActivate, ahk_exe Explorer.EXE
	Send, {Lwin down}d{LWin up}
return 

; Home
Home::Send, {vk5D down}{Left}{vk5D up} ; Home::Cmd+Left

; End
End::Send, {vk5D down}{Right}{vk5D up} ; End::Cmd+Right

; Select All
^a::Send, {vk5D down}a{vk5D up} ; Ctrl+a::Cmd+a

; Undo
^z::Send, {vk5D down}z{vk5D up} ;  Ctrl+z::Cmd+z

; Redo
^+z::Send, {vk5D down}{Shift down}z{Shift up}{vk5D up} ;  Ctrl+Shift+z::Cmd+Shift+z

; Cut
^x::Send, {vk5D down}x{vk5D up} 

; Copy
^c::Send, {vk5D down}c{vk5D up} 

; Paste
^v::Send, {vk5D down}v{vk5D up} 

; New
^n::Send, {vk5D down}n{vk5D up} 

; Open
^o::Send, {vk5D down}o{vk5D up} 

; Close tab
^w::Send, {vk5D down}w{vk5D up} 

; ***********************************************************************************************
; --- Character Mappings (sorted by unicode) ---
; Dollar sign	$	
^!4::Send, < ; Ctrl+Alt+4, <
<^>!4::Send, < ; AltGr+4, <

; Less-than		<	
<::Send, ½

; Greater-than	>
>::Send, §

; At-sign		@	
^!2::Send, !' ; Ctrl+Alt+2, Option+'
<^>!2::Send, {Blind}' ; AltGr+2, Option+'

; Left square bracket	[
^!8::Send, !8
<^>!8::Send, {Blind}8

; Backslash		\	
^!<::Send, !+7 ; Ctrl+Alt+<, Option+Shift+7
<^>!<::	Send, {Blind}+7 ; AltGr+7, Option+Shift+7

; Right square bracket	]
^!9::Send, !9 ; Ctrl+Alt+9, Option+9
<^>!9::Send, {Blind}9 ; AltGr+9, Option+9

; Circumflex Accent		^ (caret)
; NOT NECCESARY. PC > MAC: Shift+Diaeresis

; Grave Accent			` (back-tick)
; NOT NECESSARY: PC > MAC: Shift+Acute Accent

; Left curly bracket	{	
^!7::Send, !+8 ; Ctrl+Alt+7, Option+Shift+8
<^>!7::Send, {Blind}+8 ; AltGr+7, Option+Shift+8	

; Vertical Line	(Pipe)	|
^!SC00D::Send, {Blind}{vk11 up}i ; Ctrl+Alt+Acute Accent, Option+i 
<^>!SC00D::Send, {Blind}i ; AltGr+Acute Accent, Option+i

; Right curly bracket	}	
^!0::Send, !+9 ; Ctrl+Alt+0, Option+Shift+9
<^>!0::Send, {Blind}+9 ; AltGr+0, Option+Shift+9	

; Tilde			~ (U007E)	
^!SC01B:: ; Ctrl+Alt+Diaeresis 
<^>!SC01B:: ; AltGr+Diaeresis 
	Input, keyVar, L1 M ; Wait for 1 key press (L = length). Store key in keyVar.
	Send, {vk12 down}¨{vk12 up}%keyVar% ; Send mac tilde character followed by pressed key.
return
 
; Pound sign	£ (U00A3)	
^!3::Send, !4 ; Ctrl+Alt+3, Option+4
<^>!3::Send, {Blind}4 ; AltGr+3, Option+4

; Section sign	§ (U00A7)	
+½::Send, !3 ; Shift+½, Shift+3

; Euro sign		€ (U20AC)
^!e::Send, +4 ; Ctrl+Alt+e, Shift+4
<^>!e::Send, +4 ; AltGr+e, Shift+4

; Acute Accent	´ (U00B4)
; NOT NECESSARY: PC > MAC: Acute Accent

; ***********************************************************************************************
; --- Xcode shortcuts remapped ---

; Run
^r::Send, {vk5D down}r{vk5D up} ; Ctrl+R, Cmd+R

; Toggle Comment
; Until Xcode v. 14
; ^'::Send, {vk5D down}+7{vk5D up} ; Ctrl+'::Cmd+Shift+7´
; From Xcode v.14+
^'::Send, {vk5D down}{vkDB}{vk5D up} ; Ctrl+'::Cmd+Acute Accent

; Font size increase (Ctrl++)
^SC04E:: ; Ctrl + NumpadAdd
^SC00C:: ; Ctrl + +
	Send, {vk11 up}{vk5D down}{+}{vk5D up} ; Cmd++
return

; Font size decrease (Ctrl+-)
^SC04A:: ; Ctrl + NumpadSub
^SC035:: ; Ctrl + -
	Send, {vk11 up}{vk5D down}{-}{vk5D up} ; Cmd+-
return

; Font size reset
^0:: ; Ctrl+0
^#0:: ; Ctrl+Win+0
^Numpad0:: ; Ctrl + Numpad0
^#Numpad0:: ; Ctrl + Win + Numpad0
	Send, {Blind}{vk5D down}0{vk5D up} ; Ctrl+Cmd+0
return 

; TODO: Multiple cursors up
;<^>!up::Send, {vk11 down}{Shift down}{Up}{Shift up}{vk11 up}

; TODO: Multiple cursors down
;<^>!down::Send, {vk11 down}{Shift down}{Down}{Shift up}{vk11 up}

; Select Next Occurrence (multiple cursors)
^d::Send, {vk11 up}{vk5D down}{vk12 down}e{vk12 up}{vk5D up} ; Ctrl+d::Cmd+Option+e

; Macro: Duplicate current line (Ctrl+Shift+d)
^+d::
	Send, {vk5D down}{Left}{vk5D up} ; Cmd+Left (Go to start of line)
	Send, {vk5D down}{Shift down}{Right}{Shift up}{vk5D up} ; Cmd+Shift+Right (Select line)
	Send, {vk5D down}c{vk5D up} ; Cmd+c (copy)
	Send, {Right}{Enter} ; Insert empty line
	Send, {vk5D down}v{vk5D up} ; Cmd+v (paste)
	Send, {vk5D down}{Left}{vk5D up} ; Cmd+Left (Go to start of line)
return

; ***********************************************************************************************
; --- Change log ---
; v.01.01
; Added: Home and End keys

; v.01.02
; Win+d toggles windows desktop.
; Added characters: Pipe, Tilde

; v.02.00
; Functions that now works with Ctrl: Select All, Cut, Copy, Paste, Undo, Open, New, Close tab (Ctrl+w)
; Remapping of misc. Xcode short-cuts (font size etc.)

; v.02.01
; Added X-code short-curt for Run: Ctrl+r
; Added Redo Ctrl+Shift+z

; ***********************************************************************************************

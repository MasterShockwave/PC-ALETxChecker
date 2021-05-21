;Rev 0.2

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2

InputBox, G90COM, TXChecker, Enter 90 COM port number:,,,120
If ErrorLevel = 1
	ExitApp

loop
{
StatusBarGetText, sbTxt3, 3, MIL-STD 188-141C & MIL-STD 188-110

if instr(sbTxt3,"SOUNDING") or instr(sbTxt3,"LISTEN CHAN") or instr(sbTxt3,"CALLING") or instr(sbTxt3,"ACKING") or instr(sbTxt3,"CLEARING") or instr(sbTxt3,"RESPONDING") or instr(sbTxt3,"HANDSHAKING")
	{
	TrayTip, PC-ALE, TX sent to rig, 2
	; function call
	SwitchG90forTX()
	loop
	{
	StatusBarGetText, sbTxt3, 3, MIL-STD 188-141C & MIL-STD 188-110
	if not instr(sbTxt3,"SOUNDING") and not instr(sbTxt3,"LISTEN CHAN") and not instr(sbTxt3,"CALLING") and not instr(sbTxt3,"ACKING") and not instr(sbTxt3,"CLEARING") and not instr(sbTxt3,"RESPONDING") and not instr(sbTxt3,"HANDSHAKING")
		break
	}
	}
}
return

SwitchG90forTX()
{
Global G90COM
StatusBarGetText, sbTxt2, 2, MIL-STD 188-141C & MIL-STD 188-110
FoundPos := InStr(sbTxt2," ",,5)
frequency := SubStr(sbTxt2, 4, FoundPos - 4)

RunWait, %comspec% /c rigctl.exe -m 370 -r COM%G90COM% F %frequency%,,Hide
RunWait, %comspec% /c rigctl.exe -m 309 -r COM%G90COM% M USB 2400,,Hide ; G90 requires Icom IC-706 model for some mode settings.

actualFreq = rigctl -m 370 -r %G90COM% f
}
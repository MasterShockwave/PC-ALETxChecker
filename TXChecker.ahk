;Rev 0.2

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2

InputBox, G90COM, TXChecker, Enter G90 COM port number:,,,120
If ErrorLevel = 1
	ExitApp

loop
{
StatusBarGetText, sbTxt3, 3, MIL-STD 188-141C & MIL-STD 188-110

if instr(sbTxt3,"SOUNDING") or instr(sbTxt3,"LISTEN CHAN") or instr(sbTxt3,"CALLING") or instr(sbTxt3,"ACKING") or instr(sbTxt3,"CLEARING") or instr(sbTxt3,"RESPONDING") or instr(sbTxt3,"HANDSHAKING")
	{
	; Set up G90 for TX
	SwitchG90forTX()
	; Trigger G90 PTT ON
	RunWait, %comspec% /c rigctl.exe -m 370 -r COM%G90COM% T 1,,Hide
	loop
	{
	StatusBarGetText, sbTxt3, 3, MIL-STD 188-141C & MIL-STD 188-110
	if not instr(sbTxt3,"SOUNDING") and not instr(sbTxt3,"LISTEN CHAN") and not instr(sbTxt3,"CALLING") and not instr(sbTxt3,"ACKING") and not instr(sbTxt3,"CLEARING") and not instr(sbTxt3,"RESPONDING") and not instr(sbTxt3,"HANDSHAKING")
		{
		; Trigger G90 PTT OFF
		RunWait, %comspec% /c rigctl.exe -m 370 -r COM%G90COM% T 0,,Hide
		; Offset the G90 away from the channel frequency to move the DC spike present.
		commandStr := "rigctl.exe -m 370 -r COM" . G90COM . " f"
		actualFreq := ComObjCreate("WScript.Shell").Exec(commandStr).StdOut.ReadAll() ;desirable to make this window completely hidden in future, refer to https://www.autohotkey.com/boards/viewtopic.php?t=4075
		StringTrimRight, actualFreq, actualFreq, 2
		offsetFreq := actualFreq - 3000
		RunWait, %comspec% /c rigctl.exe -m 370 -r COM%G90COM% F %offsetFreq%,,Hide
		}
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
}

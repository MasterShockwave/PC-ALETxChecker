;Rev 0.2

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2

InputBox, commPort, TXChecker, Enter transceiver COM port number:,,,120
If ErrorLevel = 1
	ExitApp

loop
{
StatusBarGetText, sbTxt3, 3, MIL-STD 188-141C & MIL-STD 188-110

if instr(sbTxt3,"SOUNDING") or instr(sbTxt3,"LISTEN CHAN") or instr(sbTxt3,"CALLING") or instr(sbTxt3,"ACKING") or instr(sbTxt3,"CLEARING") or instr(sbTxt3,"RESPONDING") or instr(sbTxt3,"HANDSHAKING")
	{
	; Set up transceiver for TX
	MatchTXVRforTX()
	; Trigger transceiver PTT ON
	RunWait, %comspec% /c rigctl.exe -m 311 -r COM%commPort% T 1,,Hide ;*****************************************
	loop
	{
	StatusBarGetText, sbTxt3, 3, MIL-STD 188-141C & MIL-STD 188-110
	if not instr(sbTxt3,"SOUNDING") and not instr(sbTxt3,"LISTEN CHAN") and not instr(sbTxt3,"CALLING") and not instr(sbTxt3,"ACKING") and not instr(sbTxt3,"CLEARING") and not instr(sbTxt3,"RESPONDING") and not instr(sbTxt3,"HANDSHAKING")
		{
		; Trigger transceiver PTT OFF
		RunWait, %comspec% /c rigctl.exe -m 311 -r COM%commPort% T 0,,Hide
		; Offset the transceiver away from the channel frequency to move the DC spike present. Maintained for IC706Mk2G implementation, but haven't yet tested if this is required.
		commandStr := "rigctl.exe -m 311 -r COM" . commPort . " f"
		actualFreq := ComObjCreate("WScript.Shell").Exec(commandStr).StdOut.ReadAll() ;desirable to make this window completely hidden in future, refer to https://www.autohotkey.com/boards/viewtopic.php?t=4075
		StringTrimRight, actualFreq, actualFreq, 2
		offsetFreq := actualFreq - 3000
		RunWait, %comspec% /c rigctl.exe -m 311 -r COM%commPort% F %offsetFreq%,,Hide
		}
		break
	}
	}
}
return

MatchTXVRforTX()
{
Global commPort
StatusBarGetText, sbTxt2, 2, MIL-STD 188-141C & MIL-STD 188-110
FoundPos := InStr(sbTxt2," ",,5)
frequency := SubStr(sbTxt2, 4, FoundPos - 4)

RunWait, %comspec% /c rigctl.exe -m 311 -r COM%commPort% F %frequency%,,Hide
RunWait, %comspec% /c rigctl.exe -m 311 -r COM%commPort% M USB 2400,,Hide
}

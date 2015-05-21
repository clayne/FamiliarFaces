Scriptname vFF_Session Hidden
{Abstracted interface for JContainers that handles data storage within a single game.}

; === [ vFF_Session.psc ] ================================================--- 
; Abstracted interface for JContainers/JDB that handles data storage within a 
; single game. This data is not synchronized between saves! Optionally, if a 
; session value is missing, it can return a default value from a matching 
; Registry entry. Defaults can also be set using the abMakeDefault paramenter.
; ========================================================---

Import vFF_Registry

Function SendSessionEvent(String asPath) Global
	Int iHandle = ModEvent.Create("vFF_SessionUpdate")
	If iHandle
		ModEvent.PushString(iHandle,asPath)
		ModEvent.Send(iHandle)
	Else
		Debug.Trace("vFF/Session: Could not send vFF_SessionUpdate!")
	EndIf
EndFunction

Int Function CreateSessionDataIfMissing() Global
	Int jSessionData = JDB.solveObj(".vFFC.Session")
	If jSessionData
		Return jSessionData
	EndIf
	Debug.Trace("vFF/Session: First SessionData access, creating JDB key!")
	Int _jvFF = JDB.solveObj(".vFFC")
	jSessionData = JMap.Object()
	JMap.SetStr(jSessionData,"SessionID",GetUUID())
	JMap.setObj(_jvFF,"Session",jSessionData)
	Return jSessionData
EndFunction

Function SetSessionID(String asNewSID) Global
	JDB.SolveStrSetter(".vFFC.Session.SessionID",asNewSID,True)
EndFunction

Function SaveSession() Global
	;Debug.Trace("vFF/Reg: SaveReg called!")
	Int jRegData = JDB.solveObj(".vFFC.Session")
	JValue.WriteToFile(jRegData,FFUtils.userDirectory() + "Config/vFF_Session.json")
EndFunction

Bool Function HasSessionKey(String asPath) Global
	Int jSession = CreateSessionDataIfMissing()
	Return JValue.hasPath(jSession,"." + asPath) || JMap.hasKey(jSession,asPath)
EndFunction

Function ClearSessionKey(String asPath) Global
	Int jSession = CreateSessionDataIfMissing()
	JValue.solveObjSetter(jSession,"." + asPath,0)
EndFunction

Function SetSessionStr(String asPath, String asString, Bool abMakeDefault = False) Global
	Int jSession = CreateSessionDataIfMissing()
	JValue.solveStrSetter(jSession,"." + asPath,asString,True)
	If abMakeDefault
		SetRegStr(asPath,asString)
	EndIf
	SendSessionEvent(asPath)
EndFunction

String Function GetSessionStr(String asPath, Bool abUseDefault = False) Global
	If abUseDefault 
		If !JDB.HasPath(".vFFC.Session." + asPath)
			Return GetRegStr(asPath)
		EndIf
	EndIf
	Return JDB.solveStr(".vFFC.Session." + asPath)
EndFunction

Function SetSessionBool(String asPath, Bool abBool, Bool abMakeDefault = False) Global
	Int jSession = CreateSessionDataIfMissing()
	JValue.solveIntSetter(jSession,"." + asPath,abBool as Int,True)
	If abMakeDefault
		SetRegBool(asPath,abBool)
	EndIf
	SendSessionEvent(asPath)
EndFunction

Bool Function GetSessionBool(String asPath, Bool abUseDefault = False) Global
	If abUseDefault 
		If !JDB.HasPath(".vFFC.Session." + asPath)
			Return GetRegBool(asPath)
		EndIf
	EndIf
	Return JDB.solveInt(".vFFC.Session." + asPath) as Bool
EndFunction

Bool Function ToggleSessionBool(String asPath, Bool abMakeDefault = False) Global
	Int jSession = CreateSessionDataIfMissing()
	Bool bToggleValue = !(GetSessionBool(asPath))
	JValue.solveIntSetter(jSession,"." + asPath,bToggleValue as Int,True)
	If abMakeDefault
		SetRegBool(asPath,bToggleValue)
	EndIf
	SendSessionEvent(asPath)
	Return bToggleValue
EndFunction

Function SetSessionInt(String asPath, Int aiInt, Bool abMakeDefault = False) Global
	Int jSession = CreateSessionDataIfMissing()
	JValue.solveIntSetter(jSession,"." + asPath,aiInt,True)
	If abMakeDefault
		SetRegInt(asPath,aiInt)
	EndIf
	SendSessionEvent(asPath)
EndFunction

Int Function GetSessionInt(String asPath, Bool abUseDefault = False) Global
	If abUseDefault 
		If !JDB.HasPath(".vFFC.Session." + asPath)
			Return GetRegInt(asPath)
		EndIf
	EndIf
	Return JDB.solveInt(".vFFC.Session." + asPath)
EndFunction

Function SetSessionFlt(String asPath, Float afFloat, Bool abMakeDefault = False) Global
	Int jSession = CreateSessionDataIfMissing()
	JValue.solveFltSetter(jSession,"." + asPath,afFloat,True)
	If abMakeDefault
		SetRegFlt(asPath,afFloat)
	EndIf
	SendSessionEvent(asPath)
EndFunction

Float Function GetSessionFlt(String asPath, Bool abUseDefault = False) Global
	If abUseDefault 
		If !JDB.HasPath(".vFFC.Session." + asPath)
			Return GetRegFlt(asPath)
		EndIf
	EndIf
	Return JDB.solveFlt(".vFFC.Session." + asPath)
EndFunction

Function SetSessionForm(String asPath, Form akForm, Bool abMakeDefault = False) Global
	Int jSession = CreateSessionDataIfMissing()
	JValue.solveFormSetter(jSession,"." + asPath,akForm,True)
	If abMakeDefault
		SetRegForm(asPath,akForm)
	EndIf
	SendSessionEvent(asPath)
EndFunction

Form Function GetSessionForm(String asPath, Bool abUseDefault = False) Global
	If abUseDefault 
		If !JDB.HasPath(".vFFC.Session." + asPath)
			Return GetRegForm(asPath)
		EndIf
	EndIf
	Return JDB.solveForm(".vFFC.Session." + asPath)
EndFunction

Function SetSessionObj(String asPath, Int ajObj, Bool abMakeDefault = False) Global
	Int jSession = CreateSessionDataIfMissing()
	JValue.solveObjSetter(jSession,"." + asPath,ajObj,True)
	If abMakeDefault
		SetRegObj(asPath,ajObj)
	EndIf
	SendSessionEvent(asPath)
EndFunction

Int Function GetSessionObj(String asPath, Bool abUseDefault = False) Global
	If abUseDefault 
		If !JDB.HasPath(".vFFC.Session." + asPath)
			Return GetRegObj(asPath)
		EndIf
	EndIf
	Return JDB.solveObj(".vFFC.Session." + asPath)
EndFunction
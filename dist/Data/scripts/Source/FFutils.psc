Scriptname FFutils Hidden
{Thanks to Brendan for this plugin}

; Replaces the actorbase's perks with the perks listed in the FormList
Function LoadCharacterPerks(ActorBase akActorbase, FormList perkList) native global

; Replaces the actorbase's shouts with the shouts listed in the FormList
Function LoadCharacterShouts(ActorBase akActorbase, FormList shoutList) native global

; Removes <formid>.nif and .dds from the respective directories.
Function ClearFaceGenData(ActorBase akActorbase) native global
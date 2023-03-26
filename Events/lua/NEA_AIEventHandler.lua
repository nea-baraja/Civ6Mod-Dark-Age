

-- handle event choice for AI
function OnAddEventPopupRequest_AI( kPopupData:table )
	local playerID:number = kPopupData.ForPlayer;
	local pPlayer = Players[playerID];
	if pPlayer:IsHuman() then return; end  --discard if it's for human player
	if kPopupData.Unlocks ~= nil then return; end --discard if there is no choice to make in the event
	local iChoice = 0;
	if kPopupData.AIFavored ~= nil then
		iChoice = kPopupData.AIFavored;  
	else
		if kPopupData.ChoiceAUnlocks ~= nil and (kPopupData.ChoiceAUnlocks.Disabled == nil or kPopupData.ChoiceAUnlocks.Disabled == false) then
			iChoice = 0;
		elseif kPopupData.ChoiceBUnlocks ~= nil and (kPopupData.ChoiceBUnlocks.Disabled == nil or kPopupData.ChoiceBUnlocks.Disabled == false) then
			iChoice = 1;
		elseif kPopupData.ChoiceCUnlocks ~= nil and (kPopupData.ChoiceCUnlocks.Disabled == nil or kPopupData.ChoiceCUnlocks.Disabled == false) then
			iChoice = 2;
		end
	end
	kPopupData.ResponseIndex = iChoice;
	print('AI '..kPopupData.ForPlayer..' choose '..iChoice..' for '..kPopupData.EventKey);
	ReportingEvents.Send("EVENT_POPUP_RESPONSE", kPopupData);
end


function OnEventPopupResponse_AI(pPopupData : table)
	local playerID:number = pPopupData.ForPlayer;
	local pPlayer = Players[playerID];
	if pPlayer:IsHuman() then return; end  --discard if it's for human player

	-- Network choice as a player operation.
	local kParameters:table = {};
	kParameters.EventKey = pPopupData.EventKey;
	kParameters.ResponseIndex = pPopupData.ResponseIndex or -1;
	kParameters.ForPlayer = pPopupData.ForPlayer;
	-- Send this GameEvent when processing the operation
	kParameters.OnStart = "EventPopupChoice";
	--UI.RequestPlayerOperation(pPopupData.ForPlayer, PlayerOperations.EXECUTE_SCRIPT, kParameters);
	GameEvents.EventPopupChoice.Call(pPopupData.ForPlayer, kParameters);
end

Events.EventPopupResponse.Add(OnEventPopupResponse_AI);
-- Handle open events
Events.EventPopupRequest.Add( OnAddEventPopupRequest_AI );
-- This is an alternate way where a script can pass in the request.
LuaEvents.EventPopupRequest.Add( OnAddEventPopupRequest_AI );





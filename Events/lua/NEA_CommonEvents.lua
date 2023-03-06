include "MapEnums"
include "SupportFunctions"

GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

local m_CommonEvents = {};


function OnCommonEventTriggered(iPlayerID :number, EventKey :string, params : table)
	if m_CommonEvents[EventKey] == nil then return; end
	m_CommonEvents[EventKey].Activate(iPlayerID, params);
end

function OnCommonEventPopupChoice(ePlayer : number, params : table)
	local iResponseIndex : number = params.ResponseIndex or -1;
	if string.find(params.EventKey, 'EVENT_COMMON_') == nil then
		return;
	end

	if (iResponseIndex < 0) then
		return;
	end
	local pEventData : table = m_CommonEvents[params.EventKey];
	-- Determine if A or B was chosen
	local pCallback = nil;
	if (iResponseIndex == 0 ) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice A");
		pCallbackFunc = pEventData.ACallback;
	elseif (iResponseIndex == 1) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice B");
		pCallbackFunc = pEventData.BCallback;
	elseif (iResponseIndex == 2) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice C");
		pCallbackFunc = pEventData.CCallback;
	end
	-- Fire callback
	if (pCallbackFunc ~= nil) then
		pCallbackFunc(params);
	end	
end


GameEvents.TriggerCommonEvent.Add( OnCommonEventTriggered );
GameEvents.EventPopupChoice.Add( OnCommonEventPopupChoice );	


m_CommonEvents['EVENT_COMMON_TRIBE_UNITY_QUEST1'] = {};
m_CommonEvents['EVENT_COMMON_TRIBE_UNITY_QUEST1'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_TRIBE_UNITY_QUEST1';
	--Calculate effects
	--No choice, no need for saving data
	--Prepare UI
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_TRIBE_UNITY_QUEST1_UNLOCK")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_10","ICON_TECHUNLOCK_10"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
end

m_CommonEvents['EVENT_COMMON_TRIBE_UNITY_QUEST2'] = {};
m_CommonEvents['EVENT_COMMON_TRIBE_UNITY_QUEST2'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_TRIBE_UNITY_QUEST2';
	--Calculate effects
	--No choice, no need for saving data
	--Prepare UI
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_TRIBE_UNITY_QUEST2_UNLOCK")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_12","ICON_TECHUNLOCK_12"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
end

m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST1'] = {};
m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST1'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_CITYSTATE_QUEST1';
	--Calculate effects
	--No choice, no need for saving data
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST1_EFFECT", Locale.Lookup(params.sCitystateName));  --special effect
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST1_UNLOCK")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_10","ICON_TECHUNLOCK_10"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
end

m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST2'] = {};
m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST2'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_CITYSTATE_QUEST2';
	--Calculate effects
	--No choice, no need for saving data
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST2_EFFECT", Locale.Lookup(params.sCitystateName));  --special effect
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST2_UNLOCK")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_12","ICON_TECHUNLOCK_12"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
	
end


m_CommonEvents['EVENT_COMMON_GREAT_BATH_FLOOD'] = {};
m_CommonEvents['EVENT_COMMON_GREAT_BATH_FLOOD'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_GREAT_BATH_FLOOD';
	--Calculate effects
	local iBathFloodCount = Game.GetProperty('PROP_BATH_FLOOD_TIMES') or 0;
	iBathFloodCount = iBathFloodCount + 1;
	Game.SetProperty('PROP_BATH_FLOOD_TIMES', iBathFloodCount);
	local pPlayer = Players[iPlayerID];
	local CityId = params.CityId;
	local pCity = CityManager.GetCity(iPlayerID, CityId);
	local iPop = pCity:GetPopulation();
	local iHousing = pCity:GetGrowth():GetHousing();
	local bLackHousing = iPop >= iHousing;
	--Save calculation results
	local SavedData = {};
	SavedData.CityId = CityId;
	SavedData.PlayerID = iPlayerID;
	pPlayer:SetProperty('EVENT_COMMON_GREAT_BATH_FLOOD',SavedData);
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_GREAT_BATH_FLOOD_EFFECT", pCity:GetName(), iBathFloodCount);  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_COMMON_GREAT_BATH_FLOOD_GET_AMENITY", pCity:GetName())};
	unlockA.EffectIcons = {{"Amenities"}};
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_COMMON_GREAT_BATH_FLOOD_GET_POP", pCity:GetName())};
	unlockB.EffectIcons = {{"Citizen"}};
	unlockB.Disabled = bLackHousing;
	unlockC = {};
	unlockC.Effects = {Locale.Lookup("LOC_EVENT_COMMON_GREAT_BATH_FLOOD_GET_HOUSING", pCity:GetName())};
	unlockC.EffectIcons = {{"Housing"}};

	if unlockB.Disabled then  
		unlockB.DisabledReasons = {Locale.Lookup('LOC_EVENT_COMMON_GREAT_BATH_FLOOD_NO_HOME', pCity:GetName())};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceCText="LOC_"..sEventKey.."_CHOICE_C",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB,ChoiceCUnlocks=unlockC});
end

m_CommonEvents['EVENT_COMMON_GREAT_BATH_FLOOD'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	print(SavedData.PlayerID)
	local pCity = CityManager.GetCity(SavedData.PlayerID, SavedData.CityId);
	pCity:AttachModifierByID('DA_GREAT_BATH_AMENITY');
end

m_CommonEvents['EVENT_COMMON_GREAT_BATH_FLOOD'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pCity = CityManager.GetCity(SavedData.PlayerID, SavedData.CityId);
	pCity:ChangePopulation(1);
end

m_CommonEvents['EVENT_COMMON_GREAT_BATH_FLOOD'].CCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pCity = CityManager.GetCity(SavedData.PlayerID, SavedData.CityId);
	--pCity:AttachModifierByID('DA_GREAT_BATH_POPULATION');
	pCity:AttachModifierByID('DA_GREAT_BATH_HOUSING');
end






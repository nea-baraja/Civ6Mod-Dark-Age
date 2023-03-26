include "MapEnums"
include "SupportFunctions"

GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

local m_CommonEvents = {};


function OnCommonEventTriggered(iPlayerID :number, EventKey :string, params : table)
	if m_CommonEvents[EventKey] == nil then return; end
	print(iPlayerID..' triggered '..EventKey);
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

--部落联盟任务
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

--城邦共主任务
m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST1'] = {};
m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST1'].Activate = function(iPlayerID :number)
	local sEventKey = 'EVENT_COMMON_CITYSTATE_QUEST1';
	--Calculate effects
	--No choice, no need for saving data
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST1_EFFECT");  --special effect
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST1_UNLOCK")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_10","ICON_TECHUNLOCK_10"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
end

m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST2'] = {};
m_CommonEvents['EVENT_COMMON_CITYSTATE_QUEST2'].Activate = function(iPlayerID :number)
	local sEventKey = 'EVENT_COMMON_CITYSTATE_QUEST2';
	--Calculate effects
	local pPlayer = Players[iPlayerID];
	local pCities:table = pPlayer:GetCities();
	local pCapital = pCities:GetCapitalCity();
	--No choice, no need for saving data
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST2_EFFECT", pCapital:GetName());  --special effect
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_CITYSTATE_QUEST2_UNLOCK")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_12","ICON_TECHUNLOCK_12"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
end

--祭司议会任务
m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_QUEST1'] = {};
m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_QUEST1'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_PRIEST_COUNCIL_QUEST1';
	--Calculate effects
	local sReligion = GameInfo.Religions[params.religionID].Name;
	--No choice, no need for saving data
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_QUEST1_EFFECT", sReligion);  --special effect
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_QUEST1_UNLOCK1"), Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_QUEST1_UNLOCK2")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_10","ICON_TECHUNLOCK_10"}, {"ICON_TECHUNLOCK_12","ICON_TECHUNLOCK_12"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText =Locale.Lookup("LOC_"..sEventKey.."_CONTINUE", sReligion),Unlocks=unlocks});
	--effects
end

m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_QUEST2'] = {};
m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_QUEST2'].Activate = function(iPlayerID :number)
	local sEventKey = 'EVENT_COMMON_PRIEST_COUNCIL_QUEST2';
	--Calculate effects
	local pPlayer = Players[iPlayerID];
	local pCities:table = pPlayer:GetCities();
	local pCapital = pCities:GetCapitalCity();
	--No choice, no need for saving data
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_QUEST2_EFFECT");  --special effect
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_QUEST2_UNLOCK1"), Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_QUEST2_UNLOCK2")};
	unlocks.EffectIcons = {{"ICON_TECHUNLOCK_10","ICON_TECHUNLOCK_10"}, {"ICON_TECHUNLOCK_12","ICON_TECHUNLOCK_12"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
end

--大浴场 洪水事件
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


--祭司议会 多神教还是一神教？
m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_CHOICE'] = {};
m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_CHOICE'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_PRIEST_COUNCIL_CHOICE';
	local pPlayer = Players[iPlayerID];
	--[[local pReligion = pPlayer:GetReligion();
	local iReligionType = pReligion:GetReligionTypeCreated();
	if iReligionType >= 0 then  --已经创建宗教
		GameEvents.TriggerCommonEvent.Call(kParams.ForPlayer, 'EVENT_COMMON_PRIEST_COUNCIL_QUEST1', {religionID = iReligionType});
	end]]
	--Calculate effects
	local iFaithForPantheon = GameInfo.GlobalParameters['RELIGION_PANTHEON_MIN_FAITH'].Value;
	local bBanProphet = false;
	for row in GameInfo.ExcludedGreatPersonClasses() do
		if row.GreatPersonClassType == 'GREAT_PERSON_CLASS_PROPHET' and Utils.PlayerHasTrait(iPlayerID, row.TraitType) then
			bBanProphet = true;
		end
	end
	--Save calculation results
	local SavedData = {};
	SavedData.PlayerID = iPlayerID;
	pPlayer:SetProperty('EVENT_COMMON_PRIEST_COUNCIL_CHOICE',SavedData);
	--Prepare UI
	--EffectText = Locale.Lookup("LOC_EVENT_COMMON_GREAT_BATH_FLOOD_EFFECT", pCity:GetName(), iBathFloodCount);  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_CHOICE_MONOTHEISM")};
	unlockA.EffectIcons = {{"GreatProphet"}};
	unlockA.Disabled = bBanProphet;
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_COMMON_PRIEST_COUNCIL_CHOICE_POLYTHEISM", iFaithForPantheon)};
	unlockB.EffectIcons = {{"Religion"}};
	if unlockA.Disabled then  
		unlockA.DisabledReasons = {Locale.Lookup('LOC_EVENT_COMMON_PRIEST_COUNCIL_CHOICE_BAN_MONOTHEISM')};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_CHOICE'].ACallback = function(kParams : table)
	GameEvents.SetPlayerProperty.Call(kParams.ForPlayer, 'PROP_CHOICE_MONOTHEISM', 1);
	--local pPlayer = Players[kParams.ForPlayer];
end

m_CommonEvents['EVENT_COMMON_PRIEST_COUNCIL_CHOICE'].BCallback = function(kParams : table)
	local pPlayer = Players[kParams.ForPlayer];
	GameEvents.SetPlayerProperty.Call(kParams.ForPlayer, 'PROP_CHOICE_POLYTHEISM', 1);
	local PurchaseNotifications = pPlayer:GetProperty('PROP_PURCHASE_NOTIFICATIONS') or {};
	for _, player in ipairs(PlayerManager.GetAliveMajors()) do
		local iPlayer1 = kParams.ForPlayer;
		local iPlayer2 = player:GetID();
		if iPlayer1 ~= iPlayer2 and (Utils.HasEmbassyAt(iPlayer1, iPlayer2) or Utils.HasDelegationAt(iPlayer1, iPlayer2)) then
			local iPantheon = player:GetReligion():GetPantheon();
			if iPantheon == nil or iPantheon == -1 then return; end
			local PurchasePantheonNotificationHash = DB.MakeHash("NOTIFICATION_PURCHASE_PANTHEON");
			local sTitle = Locale.Lookup('LOC_PURCHASE_PANTHEON_TITLE');
			local sDesc = Locale.Lookup('LOC_PURCHASE_PANTHEON_DESCRIPTION', GameInfo.Civilizations[PlayerConfigurations[player:GetID()]:GetCivilizationTypeName()].Name);
			local notificationData = {};
			notificationData[ParameterTypes.MESSAGE] = sTitle;
    		notificationData[ParameterTypes.SUMMARY] = sDesc
    		notificationData.AlwaysUnique = true; 
    		notificationData.iSeller = player:GetID();
   			NotificationManager.SendNotification(kParams.ForPlayer, PurchasePantheonNotificationHash, notificationData);
   			PurchaseNotifications[player:GetID()] = -1;
   			GameEvents.SetPlayerProperty.Call(kParams.ForPlayer, 'PROP_PURCHASE_NOTIFICATIONS', PurchaseNotifications);
   			print('m_CommonEvents  PurchaseNotifications'..iPlayer1..'   '..iPlayer2..'  ')
   		end
    end
end

--祭司议会 购买万神殿
m_CommonEvents['EVENT_COMMON_PURCHASE_PANTHEON'] = {};
m_CommonEvents['EVENT_COMMON_PURCHASE_PANTHEON'].Activate = function(iPlayerID :number, params : table)
	local sEventKey = 'EVENT_COMMON_PURCHASE_PANTHEON';
	--Calculate effects
	local pPlayer = Players[iPlayerID];
	local iFaith = pPlayer:GetReligion():GetFaithBalance();
	local iFaithForPantheon = GameInfo.GlobalParameters['RELIGION_PANTHEON_MIN_FAITH'].Value;
	local bFaithNotEnough = tonumber(iFaithForPantheon) > iFaith;
	local iSeller = params.iSeller
	local pSeller = Players[iSeller];
	local pReligion = pSeller:GetReligion();
	local iPantheon = pReligion:GetPantheon();
	local sPantheon = GameInfo.Beliefs[iPantheon].BeliefType;
	local sPantheonName = Locale.Lookup(GameInfo.Beliefs[iPantheon].Name);
	local sPantheonDesc = Locale.Lookup(GameInfo.Beliefs[iPantheon].Description);
	--Save calculation results
	local SavedData = {};
	SavedData.sPantheon = sPantheon;
	SavedData.PlayerID = iPlayerID;
	SavedData.iFaithForPantheon = tonumber(iFaithForPantheon);
	SavedData.iSeller = iSeller;

	pPlayer:SetProperty('EVENT_COMMON_PURCHASE_PANTHEON',SavedData);
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_COMMON_PURCHASE_PANTHEON_EFFECT", GameInfo.Civilizations[PlayerConfigurations[iSeller]:GetCivilizationTypeName()].Name, sPantheonName);  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_COMMON_PURCHASE_PANTHEON_PURCHASE", sPantheonName, sPantheonDesc), Locale.Lookup("LOC_EVENT_COMMON_PURCHASE_PANTHEON_COST", iFaithForPantheon)};
	unlockA.EffectIcons = {{"Religion"},{"Faith", "ICON_EVENT_BAD"}};
	unlockA.Disabled = bFaithNotEnough;
	unlockB = {};
	unlockB.Effects = {};
	unlockB.EffectIcons = {};
	if unlockA.Disabled then  
		unlockA.DisabledReasons = {Locale.Lookup('LOC_EVENT_COMMON_PURCHASE_PANTHEON_NO_FAITH', iFaithForPantheon)};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_CommonEvents['EVENT_COMMON_PURCHASE_PANTHEON'].ACallback = function(kParams : table)
	local pPlayer = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local results = DB.Query('SELECT * FROM PantheonModifiers');
	if results then
		if Utils.PlayerHasTrait(kParams.ForPlayer, 'TRAIT_LEADER_QGG_ASUNA_DESCENDEDGODDESSOFCREATION') then 
			for _, row in ipairs(results) do
				if string.find(SavedData.sPantheon, row.GodhoodType) ~= nil or string.find(SavedData.sPantheon, row.PowerType) ~= nil then
					GameEvents.PlayerAttachModifierByID.Call(kParams.ForPlayer,	row.ModifierId);
					print(row.ModifierId);
				end
			end
		else
			for _, row in ipairs(results) do
				if 'BELIEF_'..row.GodhoodType..'_WITH_'..row.PowerType == SavedData.sPantheon then
					GameEvents.PlayerAttachModifierByID.Call(kParams.ForPlayer,	row.ModifierId);
					print(row.ModifierId);
				end
			end
		end
	end
	if not Utils.PlayerHasTrait(kParams.ForPlayer, 'TRAIT_CIVILIZATION_FIRST_CIVILIZATION') then 
		pPlayer:GetReligion():ChangeFaithBalance(-SavedData.iFaithForPantheon);
	end
	local PurchaseNotifications = pPlayer:GetProperty('PROP_PURCHASE_NOTIFICATIONS') or {};
	NotificationManager.Dismiss(kParams.ForPlayer, PurchaseNotifications[SavedData.iSeller]);
	PurchaseNotifications[SavedData.iSeller] = -1;
	pPlayer:SetProperty('PROP_PURCHASE_NOTIFICATIONS', PurchaseNotifications);

	local govID = Utils.GetCurrentGovernments(kParams.ForPlayer);
	if govID == nil or govID == -1 then	 return; end
    local govType = GameInfo.Governments[govID].GovernmentType;
    if govType ~= 'GOVERNMENT_PRIEST_COUNCIL' then return; end
	local iPurchaseCount = pPlayer:GetProperty('PROP_PURCHASE_PANTHEON_COUNT') or 0;
	iPurchaseCount = iPurchaseCount + 1;
	pPlayer:SetProperty('PROP_PURCHASE_PANTHEON_COUNT', iPurchaseCount);
	if iPurchaseCount == 3 then
		GameEvents.TriggerCommonEvent.Call(kParams.ForPlayer, 'EVENT_COMMON_PRIEST_COUNCIL_QUEST2');
	end
	if iPurchaseCount >= 3 then
		local pCapital = pPlayer:GetCities():GetCapitalCity();
		if pCapital ~= nil then
			local iX, iY = pCapital:GetX(), pCapital:GetY();
			local plotID = Map.GetPlotIndex(iX, iY);
			GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_ECOCARD', 1);
			GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_MILICARD', 1);	
		end	
	end
end

m_CommonEvents['EVENT_COMMON_PURCHASE_PANTHEON'].BCallback = function(kParams : table)
	--DO NOTHING
end



include("SupportFunctions");

GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
local m_BarbData = GameInfo.GoodyHutSubTypes["BARB_GOODIES"].Index;
local m_EventGoodyData = GameInfo.GoodyHutSubTypes["GOODYHUT_EVENT"].Index;

local bLoadScreenFinished = false;

--========================QUEST=======================================
function OnBarbHutTriggeredQuest(iPlayerID :number, iUnitID :number, goodyHutType :number)
	if goodyHutType ~= m_BarbData then return; end
	print(iPlayerID)
	local pPlayer = Players[iPlayerID];
	if pPlayer == nil then return; end
	local iBarb = pPlayer:GetProperty('PROP_TRIBE_BARB_COUNT') or 0;
	local govID = pPlayer:GetCulture():GetCurrentGovernment();
	if govID == nil or govID == -1 then	 return; end
    local govType = GameInfo.Governments[govID].GovernmentType;
    if govType ~= 'GOVERNMENT_TRIBE_UNITY' then return; end
    iBarb = iBarb + 1;
    GameEvents.SetPlayerProperty.Call(iPlayerID, 'PROP_TRIBE_BARB_COUNT', iBarb);
    if iBarb >= 2 then
    	local pCapital = pPlayer:GetCities():GetCapitalCity();
    	if pCapital ~= nil then
    		local iX, iY = pCapital:GetX(), pCapital:GetY();
    		local plotID = Map.GetPlotIndex(iX, iY);
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_MILICARD', 1);
    	end
    end
    if iBarb == 2 then
    	GameEvents.TriggerCommonEvent.Call(iPlayerID, 'EVENT_COMMON_TRIBE_UNITY_QUEST1');
    end

end



function OnGoodyHutTriggeredQuest(iPlayerID :number, iUnitID :number, goodyHutType :number)
	if goodyHutType ~= m_EventGoodyData then return; end
	local pPlayer = Players[iPlayerID];
	if pPlayer == nil then return; end
	local iGoody = pPlayer:GetProperty('PROP_TRIBE_GOODY_COUNT') or 0;
	local govID = pPlayer:GetCulture():GetCurrentGovernment();
	if govID == nil or govID == -1 then	 return; end
    local govType = GameInfo.Governments[govID].GovernmentType;
    if govType ~= 'GOVERNMENT_TRIBE_UNITY' then return; end
    iGoody = iGoody + 1;
    GameEvents.SetPlayerProperty.Call(iPlayerID, 'PROP_TRIBE_GOODY_COUNT', iGoody);
    if iGoody >= 5 then
    	local pCapital = pPlayer:GetCities():GetCapitalCity();
    	if pCapital ~= nil then
    		local iX, iY = pCapital:GetX(), pCapital:GetY();
    		local plotID = Map.GetPlotIndex(iX, iY);
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_ECOCARD', 1);
    	end
    end
    if iGoody == 5 then
    	GameEvents.TriggerCommonEvent.Call(iPlayerID, 'EVENT_COMMON_TRIBE_UNITY_QUEST2');
    end
end

GameEvents.UnitTriggerGoodyHut.Add( OnBarbHutTriggeredQuest );
GameEvents.UnitTriggerGoodyHut.Add( OnGoodyHutTriggeredQuest );

--[[function OnInfluenceGivenQuest( citystateID:number, playerID:number )
	local pPlayer = Players[playerID];
	local pCityState = Players[citystateID];
	if pPlayer == nil or pCityState == nil then return; end
	local govID = pPlayer:GetCulture():GetCurrentGovernment();
	if govID == nil or govID == -1 then	 return; end
    local govType = GameInfo.Governments[govID].GovernmentType;
    if govType ~= 'GOVERNMENT_CITY_STATE_ALLIANCE' then return; end
    local iSuzerain = pCityState:GetInfluence():GetSuzerain();
    if playerID == iSuzerain then
    	local leader		:string = PlayerConfigurations[ citystateID ]:GetLeaderTypeName();
		local leaderInfo	:table	= GameInfo.Leaders[leader];
		local citystateName = leaderInfo.Name;
		if (leader == "LEADER_MINOR_CIV_TRADE" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_TRADE") then
			local iTradeSuz = pPlayer:GetProperty('PROP_TRADE_SUZ') or 0;
			if iTradeSuz == 0 then
				GameEvents.TriggerCommonEvent.Call(iPlayerID, 'EVENT_COMMON_CITYSTATE_QUEST2', {sCitystateName = citystateName});
			end
			GameEvents.SetPlayerProperty.Call(playerID, 'PROP_TRADE_SUZ', 1)
    		local pCapital = pPlayer:GetCities():GetCapitalCity();
    		if pCapital ~= nil then
    			local iX, iY = pCapital:GetX(), pCapital:GetY();
    			local plotID = Map.GetPlotIndex(iX, iY);
    			GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_ECOCARD', 1);
    		end
   	 	elseif (leader == "LEADER_MINOR_CIV_MILITARISTIC" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_MILITARISTIC") then
			local iMiliSuz = pPlayer:GetProperty('PROP_MILI_SUZ') or 0;
			if iMiliSuz == 0 then
				GameEvents.TriggerCommonEvent.Call(iPlayerID, 'EVENT_COMMON_CITYSTATE_QUEST1', {sCitystateName = citystateName});
			end   	 		
			GameEvents.SetPlayerProperty.Call(playerID, 'PROP_MILI_SUZ', 1)
    		local pCapital = pPlayer:GetCities():GetCapitalCity();
    		if pCapital ~= nil then
    			local iX, iY = pCapital:GetX(), pCapital:GetY();
    			local plotID = Map.GetPlotIndex(iX, iY);
    			GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_MILICARD', 1);
    		end
    	end
    end
end

Events.InfluenceGiven.Add( OnInfluenceGivenQuest );]]

function OnQuestFinishedQuest(CompletedQuestPlayerID, CityStateID)
	local pCityState = Players[CityStateID]
    local pPlayer = Players[CompletedQuestPlayerID]
    if(pCityState == nil or pPlayer == nil) then return end
    local govID = pPlayer:GetCulture():GetCurrentGovernment();
	if govID == nil or govID == -1 then	 return; end
    local govType = GameInfo.Governments[govID].GovernmentType;
    if govType ~= 'GOVERNMENT_CITY_STATE_ALLIANCE' then return; end
    local iFinishedQuest = pPlayer:GetProperty('PROP_QUEST_COUNT') or 0;
    iFinishedQuest = iFinishedQuest + 1;
    if iFinishedQuest == 2 then
		GameEvents.TriggerCommonEvent.Call(CompletedQuestPlayerID, 'EVENT_COMMON_CITYSTATE_QUEST2');
	end
	GameEvents.SetPlayerProperty.Call(CompletedQuestPlayerID, 'PROP_QUEST_COUNT', iFinishedQuest);
	if iFinishedQuest > 1 then
	    local pCapital = pPlayer:GetCities():GetCapitalCity();
    	if pCapital ~= nil then
    		local iX, iY = pCapital:GetX(), pCapital:GetY();
    		local plotID = Map.GetPlotIndex(iX, iY);
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_ECOCARD', 1);
    	end
    end
end

GameEvents.QuestFinished.Add( OnQuestFinishedQuest );

function OnLevyCounterChangedQuest( originalOwnerID : number )
	if originalOwnerID == nil or originalOwnerID == -1 then return; end
	local pOriginalOwner = Players[originalOwnerID];
	if (pOriginalOwner ~= nil and pOriginalOwner:GetInfluence() ~= nil) then
		local suzerainID = pOriginalOwner:GetInfluence():GetSuzerain();
		local pPlayer = Players[suzerainID];
		if pPlayer == nil then return; end
		local govID = pPlayer:GetCulture():GetCurrentGovernment();
		if govID == -1 then return; end
		local govType = GameInfo.Governments[govID].GovernmentType;
    	if govType ~= 'GOVERNMENT_CITY_STATE_ALLIANCE' then return; end
    	local iLevyCount = pPlayer:GetProperty('PROP_LEVY_COUNT') or 0;
    	iLevyCount = iLevyCount + 1;
    	if iLevyCount == 2 then
			GameEvents.TriggerCommonEvent.Call(suzerainID, 'EVENT_COMMON_CITYSTATE_QUEST1');
		end
		GameEvents.SetPlayerProperty.Call(suzerainID, 'PROP_LEVY_COUNT', iLevyCount)
		if iLevyCount > 1 then
    		local pCapital = pPlayer:GetCities():GetCapitalCity();
    		if pCapital ~= nil then
    			local iX, iY = pCapital:GetX(), pCapital:GetY();
    			local plotID = Map.GetPlotIndex(iX, iY);
    			GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_MILICARD', 1);
    		end
		end
	end
end

Events.LevyCounterChanged.Add( OnLevyCounterChangedQuest );

function OnReligionFoundedQuest(playerID, religionID)
	local pPlayer = Players[playerID];
	if pPlayer == nil then return; end
	local govID = pPlayer:GetCulture():GetCurrentGovernment();
	if govID == nil or govID == -1 then	 return; end
    local govType = GameInfo.Governments[govID].GovernmentType;
    if govType ~= 'GOVERNMENT_PRIEST_COUNCIL' then return; end
    --local bMono = pPlayer:GetProperty('PROP_CHOICE_MONOTHEISM');
    --if bMono ~= 1 then return; end
    GameEvents.SetPlayerProperty.Call(playerID, 'PROP_RELIGION_FOUNDED', 1);
	local pCapital = pPlayer:GetCities():GetCapitalCity();
	if pCapital ~= nil then
		local iX, iY = pCapital:GetX(), pCapital:GetY();
		local plotID = Map.GetPlotIndex(iX, iY);
		GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_ECOCARD', 1);
		GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_MILICARD', 1);		
	end
    GameEvents.TriggerCommonEvent.Call(playerID, 'EVENT_COMMON_PRIEST_COUNCIL_QUEST1', {religionID = religionID});
end

Events.ReligionFounded.Add(OnReligionFoundedQuest);

function GovernmentChanged(playerID)
    local pPlayer = Players[playerID]
    local govID = pPlayer:GetCulture():GetCurrentGovernment()
    if govID ==nil or govID == -1 then return; end
    local govType = GameInfo.Governments[govID].GovernmentType
    local pCapital = pPlayer:GetCities():GetCapitalCity();
    if pCapital ~= nil then
    	local iX, iY = pCapital:GetX(), pCapital:GetY();
    	local plotID = Map.GetPlotIndex(iX, iY);
    	if govType ~= 'GOVERNMENT_TRIBE_UNITY' then 
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_MILICARD', 0);
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_ECOCARD', 0);
    	end
    	if govType ~= 'GOVERNMENT_CITY_STATE_ALLIANCE' then 
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_MILICARD', 0);
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_ECOCARD', 0);
    	end
    	if govType ~= 'GOVERNMENT_PRIEST_COUNCIL' then 
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_ECOCARD', 0);
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_MILICARD', 0);
    	end
		local iBarb = pPlayer:GetProperty('PROP_TRIBE_BARB_COUNT') or 0;
    	if iBarb >= 2 and govType == 'GOVERNMENT_TRIBE_UNITY' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_MILICARD', 1);
    	end
		local iGoody = pPlayer:GetProperty('PROP_TRIBE_GOODY_COUNT') or 0;
    	if iGoody >= 5 and govType == 'GOVERNMENT_TRIBE_UNITY' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_ECOCARD', 1);
    	end
    	local iFinishedQuest = pPlayer:GetProperty('PROP_QUEST_COUNT') or 0;
		if iFinishedQuest >= 2 and govType == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_ECOCARD', 1);
		end
    	local iLevyCount = pPlayer:GetProperty('PROP_LEVY_COUNT') or 0;
		if iLevyCount >= 2 and govType == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_MILICARD', 1);
		end   
		local bReligionFounded = pPlayer:GetProperty('PROP_RELIGION_FOUNDED') or 0;
      	local iPurchaseCount = pPlayer:GetProperty('PROP_PURCHASE_PANTHEON_COUNT') or 0;
      	if bReligionFounded == 1 and iPurchaseCount >= 3 then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_ECOCARD', 1);
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_PRIEST_BONUS_MILICARD', 1);
    	end
    end
end

Events.GovernmentChanged.Add(GovernmentChanged)

--==========================BONUS===================================
--[[
function CityStateAllianceDoubleQuestEnvoy( CityStateID, CompletedQuestPlayerID)
    local pCityState = Players[CityStateID]
    local pPlayer = Players[CompletedQuestPlayerID]
    if(pCityState == nil or pPlayer == nil) then return end
    local sGov0Type = Utils.GetPlayerProperty(CompletedQuestPlayerID, 'PROP_GOVERNMENT_TIER_0')
    if sGov0Type == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
        local iFirstMeet = Utils.GetPlayerProperty(CompletedQuestPlayerID, 'FIRST_MEET_CITYSTATE_'..CityStateID)
        if iFirstMeet == nil then
            GameEvents.SetPlayerProperty.Call(CompletedQuestPlayerID, 'FIRST_MEET_CITYSTATE_'..CityStateID, 0)
            return
        end
        local era = Game.GetEras():GetCurrentEra()
        local iFinishedThisEra = Utils.GetPlayerProperty(CompletedQuestPlayerID, era..'ERA_FINISHED_CITYSTATE_'..CityStateID)
        if iFinishedThisEra == 1 then
            print('just era change')
            return
        end
        GameEvents.SetPlayerProperty.Call(CompletedQuestPlayerID, era..'ERA_FINISHED_CITYSTATE_'..CityStateID, 1)
        GameEvents.SendEnvoytoCityState.Call(CompletedQuestPlayerID, CityStateID)

        print('double envoy')
    end
end

Events.QuestChanged.Add( CityStateAllianceDoubleQuestEnvoy );
]]
    		--GameEvents.TriggerCommonEvent.Call(0, 'EVENT_COMMON_PRIEST_COUNCIL_CHOICE');  

--0级政体传承
function Tier0GovernmentSet(playerID)
    local player = Players[playerID];
    local govID = player:GetCulture():GetCurrentGovernment();
    if govID == -1 then return; end
    local govType = GameInfo.Governments[govID].GovernmentType;
    if Utils.GetPlayerProperty(playerID, 'PROP_GOVERNMENT_TIER_0') ~= nil then
        print('not first gov0')
        return
    end
    if govType == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
        GameEvents.SetPlayerProperty.Call(playerID, 'PROP_GOVERNMENT_TIER_0', 'GOVERNMENT_CITY_STATE_ALLIANCE');
        --Utils.PlayerAttachModifierByID(playerID, 'CITY_STATE_ALLIANCE_FIRST_DOUBLE_ENVOY')
        for i, pPlayer in ipairs(PlayerManager.GetAliveMinors()) do  --城邦共主补齐初始使者
        	if pPlayer:GetDiplomacy():HasMet(playerID) then
        		local iPlayer = pPlayer:GetID();
        		local pPlayerInfluence = pPlayer:GetInfluence();
        		local iReceivedTokens = pPlayerInfluence:GetTokensReceived(playerID);
        		if iReceivedTokens == 0 then
        			GameEvents.SendEnvoytoCityState.Call(playerID, iPlayer);
        		end 
        	end
        end
    elseif govType == 'GOVERNMENT_TRIBE_UNITY' then
        GameEvents.SetPlayerProperty.Call(playerID, 'PROP_GOVERNMENT_TIER_0', 'GOVERNMENT_TRIBE_UNITY');
    elseif govType == 'GOVERNMENT_PRIEST_COUNCIL' then
    	GameEvents.SetPlayerProperty.Call(playerID, 'PROP_GOVERNMENT_TIER_0', 'GOVERNMENT_PRIEST_COUNCIL');
    	local pReligion = player:GetReligion();
		local iPantheon = pReligion:GetPantheon();
		if iPantheon ~= nil and iPantheon ~= -1 then
    		GameEvents.TriggerCommonEvent.Call(playerID, 'EVENT_COMMON_PRIEST_COUNCIL_CHOICE');
    	end
    end

    print('first gov0 '..govType)
end
Events.GovernmentChanged.Add(Tier0GovernmentSet)

function PantheonChosenForPC(iPlayer1)
	if Utils.GetPlayerProperty(iPlayer1, 'PROP_GOVERNMENT_TIER_0') == 'GOVERNMENT_PRIEST_COUNCIL' then
		GameEvents.TriggerCommonEvent.Call(iPlayer1, 'EVENT_COMMON_PRIEST_COUNCIL_CHOICE');
	end
	for _, player in ipairs(PlayerManager.GetAliveMajors()) do
		local iPlayer2 = player:GetID();
		if Utils.GetPlayerProperty(iPlayer2, 'PROP_CHOICE_POLYTHEISM') == 1 then
			local pDiplomacy = Players[iPlayer2]:GetDiplomacy();
    		if iPlayer1 ~= iPlayer2 and (pDiplomacy:HasEmbassyAt(iPlayer1) or pDiplomacy:HasDelegationAt(iPlayer1)) then
    			local PurchaseNotifications = player:GetProperty('PROP_PURCHASE_NOTIFICATIONS') or {};
				if PurchaseNotifications[iPlayer1] == nil then
					local PurchasePantheonNotificationHash = DB.MakeHash("NOTIFICATION_PURCHASE_PANTHEON");
					local sTitle = Locale.Lookup('LOC_PURCHASE_PANTHEON_TITLE');
					local sDesc = Locale.Lookup('LOC_PURCHASE_PANTHEON_DESCRIPTION', GameInfo.Civilizations[PlayerConfigurations[iPlayer1]:GetCivilizationTypeName()].Name);
					local notificationData = {};
					notificationData[ParameterTypes.MESSAGE] = sTitle;
        			notificationData[ParameterTypes.SUMMARY] = sDesc
       		 		notificationData.AlwaysUnique = true; 
        			notificationData.iSeller = iPlayer1;
       				NotificationManager.SendNotification(iPlayer2, PurchasePantheonNotificationHash, notificationData); 
       				PurchaseNotifications[iPlayer1] = -1;
       				GameEvents.SetPlayerProperty.Call(iPlayer2, 'PROP_PURCHASE_NOTIFICATIONS', PurchaseNotifications);
       				print('PantheonChosenForPC  PurchaseNotifications'..iPlayer2..'   '..iPlayer1..'  ')
       			end
       		end
       	end
    end
end

Events.PantheonFounded.Add(PantheonChosenForPC);

--[[function OnPurchasePantheonNotificationAdded( playerID:number, notificationID:number )
	if Utils.GetPlayerProperty(iPlayer, 'PROP_CHOICE_POLYTHEISM') ~= 1 then
		return;
	end
	local PurchasePantheonNotificationHash = DB.MakeHash("NOTIFICATION_PURCHASE_PANTHEON");
	local pNotification	= NotificationManager.Find(playerID, notificationID);
	if pNotification:GetType() ~= PurchasePantheonNotificationHash then
		return;
	end
	local pPlayer = Players[playerID];
	local PurchaseNotifications = pPlayer:GetProperty('PROP_PURCHASE_NOTIFICATIONS') or {};
	print(notificationID)
	PurchaseNotifications[pNotification:GetValue("iSeller")] = notificationID;
	GameEvents.SetPlayerProperty.Call(playerID, 'PROP_PURCHASE_NOTIFICATIONS', PurchaseNotifications);
end


Events.NotificationAdded.Add(OnPurchasePantheonNotificationAdded)
]]


--[[
function DiplomacyRelationshipChanged(p1, p2)
	if Utils.GetPlayerProperty(p1, 'PROP_CHOICE_POLYTHEISM') == 1 then
		local iState = Players[p1]:GetDiplomaticAI():GetDiplomaticStateIndex(p2)
    	local sStateType = GameInfo.DiplomaticStates[iState].StateType
		if (sStateType == 'DIPLO_STATE_ALLIED' or sStateType == 'DIPLO_STATE_DECLARED_FRIEND') then
        	local iPantheon = Players[p2]:GetReligion():GetPantheon();
			if iPantheon == nil or iPantheon == -1 then return; end
			local PurchaseNotifications = Players[p1]:GetProperty('PROP_PURCHASE_NOTIFICATIONS') or {};
			if PurchaseNotifications[p2] == nil then
				local PurchasePantheonNotificationHash = DB.MakeHash("NOTIFICATION_PURCHASE_PANTHEON");
				local sTitle = Locale.Lookup('LOC_PURCHASE_PANTHEON_TITLE');
				local sDesc = Locale.Lookup('LOC_PURCHASE_PANTHEON_DESCRIPTION', GameInfo.Civilizations[PlayerConfigurations[p2]:GetCivilizationTypeName()].Name);
				local notificationData = {};
				notificationData[ParameterTypes.MESSAGE] = sTitle;
        		notificationData[ParameterTypes.SUMMARY] = sDesc
        		notificationData.AlwaysUnique = true; 
        		notificationData.iSeller = p2;
       			NotificationManager.SendNotification(p1, PurchasePantheonNotificationHash, notificationData); 
       			PurchaseNotifications[p2] = -1;
       			GameEvents.SetPlayerProperty.Call(p1, 'PROP_PURCHASE_NOTIFICATIONS', PurchaseNotifications);
       		end
    	end
    end
end

function OnDiplomacyRelationshipChanged(p1, p2)
	DiplomacyRelationshipChanged(p1, p2);
	DiplomacyRelationshipChanged(p2, p1);
end

Events.DiplomacyRelationshipChanged.Add(OnDiplomacyRelationshipChanged)
]]


function DiplomacySessionClosed(p1, p2)

	if Utils.GetPlayerProperty(p1, 'PROP_CHOICE_POLYTHEISM') == 1 then
		local pPlayer = Players[p1];
		local pDiplomacy = pPlayer:GetDiplomacy();

		if (pDiplomacy:HasEmbassyAt(p2) or pDiplomacy:HasDelegationAt(p2)) then
        	local iPantheon = Players[p2]:GetReligion():GetPantheon();
			if iPantheon == nil or iPantheon == -1 then return; end
			local PurchaseNotifications = pPlayer:GetProperty('PROP_PURCHASE_NOTIFICATIONS') or {};
			if PurchaseNotifications[p2] == nil then
				local PurchasePantheonNotificationHash = DB.MakeHash("NOTIFICATION_PURCHASE_PANTHEON");
				local sTitle = Locale.Lookup('LOC_PURCHASE_PANTHEON_TITLE');
				local sDesc = Locale.Lookup('LOC_PURCHASE_PANTHEON_DESCRIPTION', GameInfo.Civilizations[PlayerConfigurations[p2]:GetCivilizationTypeName()].Name);
				local notificationData = {};
				notificationData[ParameterTypes.MESSAGE] = sTitle;
        		notificationData[ParameterTypes.SUMMARY] = sDesc
        		notificationData.AlwaysUnique = true; 
        		notificationData.iSeller = p2;
       			NotificationManager.SendNotification(p1, PurchasePantheonNotificationHash, notificationData); 
       			PurchaseNotifications[p2] = -1;
       			GameEvents.SetPlayerProperty.Call(p1, 'PROP_PURCHASE_NOTIFICATIONS', PurchaseNotifications);
       			print('DiplomacySessionClosed  PurchaseNotifications'..p1..'   '..p2..'  ')
       		end
    	end
    end
end

function OnDiplomacySessionClosed(sessionID)
	local diplomacyInfo:table = DiplomacyManager.GetSessionInfo(sessionID);
	DiplomacySessionClosed(diplomacyInfo.FromPlayer, diplomacyInfo.ToPlayer);
	DiplomacySessionClosed(diplomacyInfo.ToPlayer, diplomacyInfo.FromPlayer);
end

Events.DiplomacySessionClosed.Add(OnDiplomacySessionClosed)

function CityStateAllianceDoubleQuestEnvoy(CompletedQuestPlayerID, CityStateID)
    local pCityState = Players[CityStateID]
    local pPlayer = Players[CompletedQuestPlayerID]
    if(pCityState == nil or pPlayer == nil) then return end
    local sGov0Type = Utils.GetPlayerProperty(CompletedQuestPlayerID, 'PROP_GOVERNMENT_TIER_0')
    if sGov0Type == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
        GameEvents.SendEnvoytoCityState.Call(CompletedQuestPlayerID, CityStateID)
        print('double envoy')
    end
end

GameEvents.QuestFinished.Add( CityStateAllianceDoubleQuestEnvoy );


function CityStateBonusInitialEnvoy(player1ID:number, player2ID:number)
	print('meet1')
	local player1, player2 = Players[player1ID], Players[player2ID];
	if player1:GetProperty('PROP_GOVERNMENT_TIER_0') == 'GOVERNMENT_CITY_STATE_ALLIANCE' and player2:IsMinor() then
		print('meet2')
		local pPlayerInfluence = player2:GetInfluence();
        local iReceivedTokens = pPlayerInfluence:GetTokensReceived(player1:GetID());
        if iReceivedTokens == 0 then
        	GameEvents.SendEnvoytoCityState.Call(player1:GetID(), player2:GetID())
        end
    elseif player2:GetProperty('PROP_GOVERNMENT_TIER_0') == 'GOVERNMENT_CITY_STATE_ALLIANCE' and player1:IsMinor() then
    	print('meet3')
		local pPlayerInfluence = player1:GetInfluence();
        local iReceivedTokens = pPlayerInfluence:GetTokensReceived(player2:GetID());
        if iReceivedTokens == 0 then
        	GameEvents.SendEnvoytoCityState.Call(player2:GetID(), player1:GetID())
        end
    end
end

Events.DiplomacyMeet.Add( CityStateBonusInitialEnvoy );


--[[
function Tier0GovQuestFinished( playerID, districtID, iX, iY )
	local pPlayer = Players[playerID];
	if pPlayer == nil then return; end
	local bIsQuestDistrict = false;
	local sDistrictType = GameInfo.Districts[districtID].DistrictType;
	if sDistrictType == 'DISTRICT_ENCAMPMENT' or sDistrictType == 'DISTRICT_COMMERCIAL_HUB' then
		bIsQuestDistrict = true;
	end
	for row in GameInfo.DistrictReplaces() do
		if (row.ReplacesDistrictType == 'DISTRICT_ENCAMPMENT' or row.ReplacesDistrictType == 'DISTRICT_COMMERCIAL_HUB') then
			bIsQuestDistrict = true;
		end
	end
	if not bIsQuestDistrict then return; end
	local govID = pPlayer:GetCulture():GetCurrentGovernment();
    local govType = GameInfo.Governments[govID].GovernmentType;
    if govType ~= 'GOVERNMENT_TRIBE_UNITY' and govType ~= 'GOVERNMENT_CITY_STATE_ALLIANCE' then
    	return;
    end
end
GameEvents.OnDistrictConstructed.Add();
]]

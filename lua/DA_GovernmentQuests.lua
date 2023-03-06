include("SupportFunctions");

GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
local m_BarbData = GameInfo.GoodyHutSubTypes["BARB_GOODIES"].Index;
local m_EventGoodyData = GameInfo.GoodyHutSubTypes["GOODYHUT_EVENT"].Index;

local bLoadScreenFinished = false;



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

function OnInfluenceGivenQuest( citystateID:number, playerID:number )
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

Events.InfluenceGiven.Add( OnInfluenceGivenQuest );




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
		local iBarb = pPlayer:GetProperty('PROP_TRIBE_BARB_COUNT') or 0;
    	if iBarb >= 2 and govType == 'GOVERNMENT_TRIBE_UNITY' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_MILICARD', 1);
    	end
		local iGoody = pPlayer:GetProperty('PROP_TRIBE_GOODY_COUNT') or 0;
    	if iGoody >= 5 and govType == 'GOVERNMENT_TRIBE_UNITY' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_TRIBE_BONUS_ECOCARD', 1);
    	end
    	local iTradeSuz = pPlayer:GetProperty('PROP_TRADE_SUZ') or 0;
		if iTradeSuz == 1 and govType == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_ECOCARD', 1);
		end
    	local iMiliSuz = pPlayer:GetProperty('PROP_MILI_SUZ') or 0;
		if iMiliSuz == 1 and govType == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
    		GameEvents.SetPlotProperty.Call(plotID, 'PROP_CITYSTATE_BONUS_MILICARD', 1);
		end   
    end
end





Events.GovernmentChanged.Add(GovernmentChanged)











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
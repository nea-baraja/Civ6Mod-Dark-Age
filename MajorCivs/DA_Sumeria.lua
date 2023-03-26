include("SupportFunctions");

ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

function SumeriaQuestFinished(CompletedQuestPlayerID, CityStateID)
	if not Utils.PlayerHasTrait(CompletedQuestPlayerID, 'TRAIT_CIVILIZATION_FIRST_CIVILIZATION') then 
		return;
	end
	local pCityState = Players[CityStateID];
    local pPlayer = Players[CompletedQuestPlayerID];
    local leader		:string = PlayerConfigurations[ CityStateID ]:GetLeaderTypeName();
	local leaderInfo	:table	= GameInfo.Leaders[leader];
	local citystateName = leaderInfo.Name;
	local pCapital = pPlayer:GetCities():GetCapitalCity();
	if (leader == "LEADER_MINOR_CIV_TRADE" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_TRADE") then
		pCapital:AttachModifierByID('DA_SUMERIA_GOLD');
	elseif (leader == "LEADER_MINOR_CIV_CULTURAL" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_CULTURAL") then
		pCapital:AttachModifierByID('DA_SUMERIA_CULTURE');
	elseif (leader == "LEADER_MINOR_CIV_RELIGIOUS" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_RELIGIOUS") then
		pCapital:AttachModifierByID('DA_SUMERIA_FAITH');
	elseif (leader == "LEADER_MINOR_CIV_SCIENTIFIC" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_SCIENTIFIC") then
		pCapital:AttachModifierByID('DA_SUMERIA_SCIENCE');
	elseif (leader == "LEADER_MINOR_CIV_INDUSTRIAL" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_INDUSTRIAL") then
		pCapital:AttachModifierByID('DA_SUMERIA_PRODUCTION_BUILDING');
	elseif (leader == "LEADER_MINOR_CIV_MILITARISTIC" or leaderInfo.InheritFrom == "LEADER_MINOR_CIV_MILITARISTIC") then
		pCapital:AttachModifierByID('DA_SUMERIA_PRODUCTION_UNIT');
	end
end

GameEvents.QuestFinished.Add( SumeriaQuestFinished );














-- function SumeriaPropertyManager(playerID, cityID, AllyCount, ConquestCount)
-- 	local player = Players[playerID];
--     local pCity = CityManager.GetCity(playerID, cityID);
--     if pCity == nil then 
--     	return ;
--     end
--     local cityX = pCity:GetX();
--     local cityY = pCity:GetY();
--     local CityPlot = Map.GetPlot(cityX, cityY);
--     local plotID = CityPlot:GetIndex();
--     local PROP_ALLY_COUNT = 'PROP_ALLY_COUNT';
--     local PROP_WAR_COUNT = 'PROP_CONQUEST_COUNT';
--     GameEvents.SetPlotProperty.Call(plotID, PROP_ALLY_COUNT, AllyCount);
--     GameEvents.SetPlotProperty.Call(plotID, PROP_CONQUEST_COUNT, ConquestCount);
--     print(playerID..'--AllyCount:'..AllyCount..'  ConquestCount:'..ConquestCount);
-- end


-- function OnTurnBegin()
-- 	local players = Game.GetPlayers{Alive = true};
-- 	for _, player in ipairs(Players) do
-- 		local playerID = player:GetID();
-- 		if(Utils.PlayerHasTrait(playerID, 'TRAIT_CIVILIZATION_FIRST_CIVILIZATION')) then
-- 			local AllyCount = 0;
-- 			for _, player1 in ipairs(Players) do
-- 				local pAlly = player1:GetDiplomacy():GetAllianceType(player:GetID())
-- 				if pAlly ~= -1 then
-- 					AllyCount = AllyCount + 1;
-- 				end
-- 			end
-- 			local ConquestCount = 0;
-- 			local pCities = player:GetCities();
-- 			for _, city in pCities:Members() do
-- 				local originalOwnerID:number = city:GetOriginalOwner();
-- 				local pOriginalOwner:table = Players[originalOwnerID];
-- 				if(playerID ~= originalOwnerID and pOriginalOwner:IsMajor() and city:IsOriginalCapital()) then
-- 					ConquestCount = ConquestCount + 1;
-- 				end
-- 			end
-- 			local CulturalDominationCount = 0;
-- 			local pPlayerCulture:table = player:GetCulture();
-- 			local iVistings = pPlayerCulture:GetTouristsTo();
-- 			for i, player2 in ipairs(Players) do
-- 				if i ~= playerID and IsAliveAndMajor(i) then
-- 					local iStaycationers = player2:GetCulture():GetStaycationers();
-- 					if iStaycationers < iVistings then
-- 						CulturalDominationCount = CulturalDominationCount + 1;
-- 					end
-- 				end
-- 			end 
-- 			local ReligionConvertedCount = 0;
-- 			local pReligion = player:GetReligion();
-- 			if pReligion ~= nil then
-- 				local iReligionType = pReligion:GetReligionTypeCreated();
-- 				if iReligionType ~= -1 then
-- 					for i,player3 in ipairs(Players) do
-- 						if IsAliveAndMajor(i) and i ~= playerID then
-- 							local pOtherReligion = player3:GetReligion();
-- 							if pOtherReligion ~= nil then
-- 								local otherReligionType:number = pOtherReligion:GetReligionInMajorityOfCities();
-- 								if otherReligionType == iReligionType then
-- 									ReligionConvertedCount = ReligionConvertedCount + 1;
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end
-- 			for i,city in player:GetCities():Members() do
-- 				local cityX = pCity:GetX();
--     			local cityY = pCity:GetY();
--     			local CityPlot = Map.GetPlot(cityX, cityY);
--     			local plotID = CityPlot:GetIndex();
--     			GameEvents.SetPlotProperty.Call(plotID, 'PROP_ALLY_COUNT', AllyCount);
--    	 			GameEvents.SetPlotProperty.Call(plotID, 'PROP_CONQUEST_COUNT', ConquestCount);
--     			GameEvents.SetPlotProperty.Call(plotID, 'PROP_RELIGION_COUNT', ReligionConvertedCount);
--    	 			GameEvents.SetPlotProperty.Call(plotID, 'PROP_CULTURAL_COUNT', CulturalDominationCount);
-- 			end
-- 		end
-- 	end
-- end

-- if Utils.GameHasTrait('TRAIT_CIVILIZATION_FIRST_CIVILIZATION') then 
-- 	Events.TurnBegin.Add(OnTurnBegin);
-- end






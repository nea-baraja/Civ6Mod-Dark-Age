GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils

function CountCleoAllies()
	local players = Game.GetPlayers{Alive = true};
	for _, player in ipairs(players) do
		local playerId = player:GetID()
		local playerConfig = PlayerConfigurations[playerId]
		local sLeader = playerConfig:GetLeaderTypeName()
        local BuildingInfo = GameInfo.Buildings['BUILDING_FLAG_NO_2_ALLIES']
		if (sLeader == 'LEADER_CLEOPATRA') then
			local pCapital = player:GetCities():GetCapitalCity()
			if(pCapital == nil) then
				return 
			end
			local AllyCount = 0
			for _, player1 in ipairs(players) do
				local pAlly = player1:GetDiplomacy():GetAllianceType(player:GetID())
				if pAlly ~= -1 then
					AllyCount = AllyCount + 1
				end
			end
			if AllyCount < 2 and not Utils.PlayerHasWonder(player1:GetID(),  BuildingInfo.Index) then
                GameEvents.RequestCreateBuilding.Call(playerId,  pCapital:GetID(),   BuildingInfo.Index)
            else
            	for _, city in player:GetCities():Members() do
                	GameEvents.RequestRemoveBuilding.Call(playerId,  city:GetID(),   BuildingInfo.Index)
				end
			end
    	end
	end
end

Events.TurnBegin.Add(CountCleoAllies)


function CountEgyptRiverDistricts()
	local players = Game.GetPlayers{Alive = true};
	for _, player in ipairs(players) do
		local playerId = player:GetID()
		local playerConfig = PlayerConfigurations[playerId]
		local sCiv = playerConfig:GetCivilizationTypeName()
        local PROP_RIVER_COUNT = 'PROP_RIVER_COUNT'
		if (sCiv == 'CIVILIZATION_EGYPT') then
			local RiverSets = {}
			for _, dis in player:GetDistricts():Members() do
				local disX = dis:GetX()
    			local disY = dis:GetY()
    			local CityPlot = Map.GetPlot(disX, disY)
 				local kRivers = RiverManager.GetRiverTypes(CityPlot)
				if kRivers and table.count(kRivers) > 0 then
					for _,eRiver in pairs(kRivers) do
						local szRiverName = RiverManager.GetRiverNameByType(eRiver)
						RiverSets[szRiverName] = RiverSets[szRiverName] or 0
						RiverSets[szRiverName] = RiverSets[szRiverName] + 1
					end
				end
    		end
    		for _, city in player:GetCities():Members() do
    			local cityX = city:GetX()
    			local cityY = city:GetY()
    			local CityPlot = Map.GetPlot(cityX, cityY)
 				local kRivers = RiverManager.GetRiverTypes(CityPlot)
 				local riverCount = 0
				if kRivers and table.count(kRivers) > 0 then
					for _,eRiver in pairs(kRivers) do
						local szRiverName = RiverManager.GetRiverNameByType(eRiver)
						if(riverCount < RiverSets[szRiverName]) then
							riverCount = RiverSets[szRiverName]
						end
					end
				end
				local plotID = CityPlot:GetIndex()			
    			GameEvents.SetPlotProperty.Call(plotID, PROP_RIVER_COUNT, riverCount)
    			--print('river:'..riverCount)
			end
    	end
	end
end

Events.TurnBegin.Add(CountEgyptRiverDistricts)



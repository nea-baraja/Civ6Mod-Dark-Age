Utils = ExposedMembers.DA.Utils;
GameEvents = ExposedMembers.GameEvents;

local m_DistrictCount = {}

GameEvents.UpdateDistrictCount.Add(function(playerID,	cityID, amount)
	m_DistrictCount[playerID] = m_DistrictCount[playerID] or {}
	m_DistrictCount[playerID][cityID] = amount
	--print(amount)
end)






local StrateticResources = {'RESOURCE_IRON',	'RESOURCE_HORSES'}
function GetResourceCost(PlayerId)
	local Cost = {}
	local player = Players[PlayerId]
	for _, v in pairs(StrateticResources) do
		Cost[v] = Cost[v] or 0
	end
	--[[
	for k in GameInfo.StrategicProjects() do
		for _, city in player:GetCities():Members() do
			local buildings = city:GetBuildings()
			if buildings:HasBuilding(GameInfo.Buildings[k.BuildingType].Index) then
				Cost[k.ResourceType] = Cost[k.ResourceType] + k.Maintenance
			end
		end
	end]]
	for _, city in player:GetCities():Members() do
		local buildings = city:GetBuildings()
		if buildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_ANIMAL_MILL'].Index) then
			--print('animal!')
			GameEvents.GetDistrictCount.Call(PlayerId, city:GetID())
			local Maintenance = math.ceil(m_DistrictCount[PlayerId][city:GetID()] / 2)
			Cost['RESOURCE_HORSES'] = Cost['RESOURCE_HORSES'] + Maintenance
		end
	end


	return Cost
end


function RefreshResourceCost (playerId, doReduce)
	local player = Players[playerId]
	if not player:IsMajor() then
		return
	end
	local Cost = GetResourceCost(playerId)
	for _, v in pairs(StrateticResources) do
		local amount = player:GetResources():GetResourceAmount(v)
		if amount >= Cost[v] then
			player:SetProperty('PROP_LACK_' .. v, 0)
		else
			player:SetProperty('PROP_LACK_' .. v, 1)
		end
		for _, city in player:GetCities():Members() do
			local location = city:GetLocation()
			local cityPlot = Map.GetPlot(location.x, location.y)
			if amount >= Cost[v] then
				cityPlot:SetProperty('PROP_LACK_' .. v, 0)
			else
				cityPlot:SetProperty('PROP_LACK_' .. v, 1)
			end
		end
		if doReduce and (amount >= Cost[v]) and (Cost[v] > 0) then
			player:GetResources():ChangeResourceAmount(GameInfo.Resources[v].Index, -Cost[v])
		end
	end
end
local sync = false;
function SyncRefreshResourceCost (playerId, doReduce)
	if sync then
		return;
	end
	sync = true;
	local error, msg = pcall(RefreshResourceCost, playerId, doReduce);
	if not error then
		print(msg);
	end
	sync = false;
end

GameEvents.PlayerTurnStartComplete.Add(function (playerId)
	SyncRefreshResourceCost(playerId, false);
end);
GameEvents.PlayerTurnStarted.Add(function (playerId)
	SyncRefreshResourceCost(playerId, true);
end);
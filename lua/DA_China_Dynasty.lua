include "MapEnums"
include "MapUtilities"
include("SupportFunctions")

local DynastyNotificationHash = DB.MakeHash("NOTIFICATION_CHINA_DYNASTY");


function GetDynasties()
	if(Game.GetProperty('PROP_DYNASTY') ~= nil) then
		return  
	end
	local ValidDynasties = {}
	local Civs = GameInfo.Civilizations()
	for pCiv in Civs do
		if (pCiv.StartingCivilizationLevelType == 'CIVILIZATION_LEVEL_FULL_CIV' and (not IsShownInGame(pCiv.CivilizationType)) and  pCiv.CivilizationType ~= 'CIVILIZATION_SCOTLAND') then
			table.insert(ValidDynasties, pCiv.CivilizationType)
		end
	end
	local aShuffledDynasties = GetShuffledCopyOfTable(ValidDynasties)
	Game.SetProperty('PROP_DYNASTY', aShuffledDynasties)
end

function HasChina()
	Game.SetProperty('PROP_HAS_CHINA', 0)
	if(IsShownInGame('CIVILIZATION_CHINA')) then
		Game.SetProperty('PROP_HAS_CHINA', 1)
	end
end

function IsShownInGame(CivType)
	local players = Game.GetPlayers()
	for _, player in ipairs(players) do
		local playerId = player:GetID()
		local playerConfig = PlayerConfigurations[playerId]
		local sCiv = playerConfig:GetCivilizationTypeName()
		if (sCiv == CivType) then
			return true 
		end
	end
	return false
end



function OnGameEraChanged(previousera, newera)
	if(Game.GetProperty('PROP_DYNASTY') == nil) then
		return
	end
	local Dynasties = Game.GetProperty('PROP_DYNASTY')
	Game.SetProperty('CURRENT_DYNASTY', Dynasties[newera + 1])
	local players = Game.GetPlayers{Alive = true};
	for _, player in ipairs(players) do
		local playerId = player:GetID()
		local sTitle = Locale.Lookup('LOC_DYNASTY_CHANGE_TITLE')
		local sDynasty1 = Locale.Lookup('LOC_'..Dynasties[previousera + 1]..'_NAME')
		local sDynasty2 = Locale.Lookup('LOC_'..Dynasties[newera + 1]..'_NAME')
		NotificationManager.SendNotification(playerId, DynastyNotificationHash, sTitle, Locale.Lookup('LOC_DYNASTY_CHANGE_DESCRIPTION', sDynasty1, sDynasty2))
	end
end

--Events.GameEraChanged.Add(OnGameEraChanged)

function ClearDynasty (playerID, cityID)
	local player = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    if pCity == nil then 
    	return 
    end
    local cityX = pCity:GetX()
    local cityY = pCity:GetY()
    local CityPlot = Map.GetPlot(cityX, cityY)
    local plotID = CityPlot:GetIndex()
    local Dynasties = Game.GetProperty('PROP_DYNASTY')
    for _, row in pairs(Dynasties) do
    	GameEvents.SetPlotProperty.Call(plotID, 'CD_'..row, 0)
    end
end


function OnTurnBegin()
	if(Game.GetProperty('PROP_DYNASTY') == nil) then
		GetDynasties()
	end
	if(Game.GetProperty('PROP_HAS_CHINA') == nil) then
		HasChina() 
	end
	if(Game.GetProperty('PROP_HAS_CHINA') == 0) then
		return
	end	
	local players = Game.GetPlayers{Alive = true};
	local Dynasties = Game.GetProperty('PROP_DYNASTY')
	local era = Game.GetEras():GetCurrentEra()
	if(Game.GetProperty('CURRENT_DYNASTY') == nil) then
		Game.SetProperty('CURRENT_DYNASTY', Dynasties[era + 1])
		for _, player in ipairs(players) do
			local playerId = player:GetID()
			local sTitle = Locale.Lookup('LOC_DYNASTY_BEGIN_TITLE')
			local sDynasty = Locale.Lookup('LOC_'..Dynasties[era + 1]..'_NAME')
			NotificationManager.SendNotification(playerId, DynastyNotificationHash, sTitle, Locale.Lookup('LOC_DYNASTY_BEGIN_DESCRIPTION', sDynasty))
		end
	end
	if(Dynasties[era + 1] ~= Game.GetProperty('CURRENT_DYNASTY')) then
		OnGameEraChanged(era - 1, era)
	end

	for _, player in ipairs(players) do
		local playerId = player:GetID()
		local playerConfig = PlayerConfigurations[playerId]
		local sCiv = playerConfig:GetCivilizationTypeName()
		if (sCiv == 'CIVILIZATION_CHINA') then
			for _, city in player:GetCities():Members() do
				ClearDynasty(player:GetID(), city:GetID())
			end
			local pCapital = player:GetCities():GetCapitalCity()
			if(pCapital == nil) then
				return 
			end
			local cityX = pCapital:GetX()
    		local cityY = pCapital:GetY()
    		local CityPlot = Map.GetPlot(cityX, cityY)
    		local plotID = CityPlot:GetIndex()
    		local currentDy = Game.GetProperty('CURRENT_DYNASTY')
    		GameEvents.SetPlotProperty.Call(plotID, 'CD_'..currentDy, 1)
    	end
	end
end

Events.TurnBegin.Add(OnTurnBegin)

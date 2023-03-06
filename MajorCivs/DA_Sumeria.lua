
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
function CivilizationHasTrait(sCiv, sTrait)
	for tRow in GameInfo.CivilizationTraits() do
		if (tRow.CivilizationType == sCiv and tRow.TraitType == sTrait) then
			return true;
		end
	end
	return false;
end
Utils.CivilizationHasTrait = Utils.CivilizationHasTrait or CivilizationHasTrait;


function SumeriaPropertyManager(playerID, cityID, AllyCount, ConquestCount)
	local player = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    if pCity == nil then 
    	return 
    end
    local cityX = pCity:GetX()
    local cityY = pCity:GetY()
    local CityPlot = Map.GetPlot(cityX, cityY)
    local plotID = CityPlot:GetIndex()
    local PROP_ALLY_COUNT = 'PROP_ALLY_COUNT'
    local PROP_WAR_COUNT = 'PROP_CONQUEST_COUNT'
    GameEvents.SetPlotProperty.Call(plotID, PROP_ALLY_COUNT, AllyCount)
    GameEvents.SetPlotProperty.Call(plotID, PROP_CONQUEST_COUNT, ConquestCount)
    print(playerID..'--AllyCount:'..AllyCount..'  ConquestCount:'..ConquestCount)
end


function OnTurnBegin()
	local players = Game.GetPlayers{Alive = true}
	for _, player in ipairs(players) do
		local playerID = player:GetID()
		local playerConfig = PlayerConfigurations[playerID]
		local sCiv = playerConfig:GetCivilizationTypeName()
		if(CivilizationHasTrait(sCiv, 'TRAIT_CIVILIZATION_FIRST_CIVILIZATION')) then
			local AllyCount = 0
			for _, player1 in ipairs(players) do
				local pAlly = player1:GetDiplomacy():GetAllianceType(player:GetID())
				if pAlly ~= -1 then
					AllyCount = AllyCount + 1
				end
			end
			local ConquestCount = 0
			

		end
	end
end

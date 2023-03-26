
GameEvents = ExposedMembers.GameEvents;
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

function LeaderHasTrait(sLeader, sTrait)
	for tRow in GameInfo.LeaderTraits() do
		if (tRow.LeaderType == sLeader and tRow.TraitType == sTrait) then return
			true;
		end
	end
	return false;
end
Utils.LeaderHasTrait = Utils.LeaderHasTrait or LeaderHasTrait;

function CityTlachtliBuilderExhaust(playerID, cityID, pTlachtli)
	local player = Players[playerID]
	local iTlachtli = player:GetProperty(''..pTlachtli..cityID)
	if iTlachtli ~= false and iTlachtli ~= nil then
		if iTlachtli == true then
			iTlachtli = 1
		end
		iTlachtli = iTlachtli + 1
		GameEvents.SetPlayerProperty.Call(playerID, ''..pTlachtli..cityID, tostring(iTlachtli))
		return iTlachtli%5;
	else
		GameEvents.SetPlayerProperty.Call(playerID, ''..pTlachtli..cityID, '1')
		iTlachtli = 1
	end
	return iTlachtli%5;
end


function TlachtliBuilderBonus(playerID, unitID, newCharges, oldCharges)
	local player = Players[playerID]
	local playerConfig = PlayerConfigurations[playerID]
	local sCiv = playerConfig:GetCivilizationTypeName()
	local sFiveSuns = 'TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS'
	local pTlachtli = GameInfo.Buildings['BUILDING_TLACHTLI'].Index

	if player:IsTurnActive() and CivilizationHasTrait(sCiv, sFiveSuns) and (newCharges + 1 == oldCharges) then
		local unit = player:GetUnits():FindID(unitID)
		if unit ~= nil then
			if unit:GetType() == GameInfo.Units['UNIT_BUILDER'].Index then
				local unitPlot
				if newCharges == 0 then
					-- 次数到0后会找不到单位(-9999, -9999)的原位置，无法显示浮动文本。
					-- unitPlot = Map.GetPlot(unit:GetX(), unit:GetY())
					unitPlot = Map.GetPlotByIndex(Utils.GetPlayerProperty(playerID,	'UNIT_'..unitID..'_POSITION'))
					local city = Cities.GetPlotPurchaseCity(unitPlot)
					local cityID = city:GetID()
					local pBuildings = city:GetBuildings()
					if pBuildings:HasBuilding(pTlachtli) then
						local iTlachtli = CityTlachtliBuilderExhaust(playerID, cityID, pTlachtli)
						-- local growth = city:GetGrowth()
						local message = ''
						if iTlachtli == 1 then
							message = '本城+2 [ICON_Housing] 住房'
							Utils.CityAttachModifierByID(playerID,	cityID,	'DA_AZTEC_HOUSING');
						elseif iTlachtli == 2 then
							message = '本城+1 [ICON_Citizen] 人口'
							Utils.ChangePopulation(playerID,	cityID,		1);
						elseif iTlachtli == 3 then
							message = '本城+1 [ICON_Amenities] 宜居度'
							Utils.CityAttachModifierByID(playerID,	cityID,	'DA_AZTEC_AMENITY')
						elseif iTlachtli == 4 then
							message = '本城+2 [ICON_Culture] 文化值'
							Utils.CityAttachModifierByID(playerID,	cityID,	'DA_AZTEC_CULTURE')
						else
							message = '本城+3 [ICON_Faith] 信仰值'
							Utils.CityAttachModifierByID(playerID,	cityID,	'DA_AZTEC_FAITH')
						end
						Utils.RequestAddWorldView(message, unitPlot:GetX(), unitPlot:GetY())
					end
				end
			end
		end
	end
end

Events.UnitChargesChanged.Add(TlachtliBuilderBonus)





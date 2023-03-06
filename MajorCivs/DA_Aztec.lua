
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
				if newCharges > 0 then
					-- 次数到0后会找不到单位(-9999, -9999)的原位置，无法显示浮动文本。
					unitPlot = Map.GetPlot(unit:GetX(), unit:GetY())
				else
					unitPlot = Map.GetPlotByIndex(Utils.GetPlayerProperty(playerID,	'UNIT_'..unitID..'_POSITION'))
				end
				local city = Cities.GetPlotPurchaseCity(unitPlot)
				local cityID = city:GetID()
				local pBuildings = city:GetBuildings()
				if pBuildings:HasBuilding(pTlachtli) then
					local growth = city:GetGrowth()
					local message = '+1 [ICON_Citizen] 人口[NEWLINE]+1 [ICON_Housing] 住房[NEWLINE]+1 [ICON_AMENITY]宜居度'
					Utils.CityAttachModifierByID(playerID,	cityID,	'DA_AZTEC_AMENITY')
					Utils.CityAttachModifierByID(playerID,	cityID,	'DA_AZTEC_HOUSING')
					Utils.ChangePopulation(playerID,	cityID,		1)
					Utils.RequestAddWorldView(message, unit:GetX(), unit:GetY())
				end
			end
		end
	end
end

Events.UnitChargesChanged.Add(TlachtliBuilderBonus)





include "SupportFunctions"
GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils



function GetValidPlotsInRadiusR(iPlotX, iPlotY, iRadius)
	local tTempTable = {}
	for dx = (iRadius * -1), iRadius do
		for dy = (iRadius * -1), iRadius do
			local pNearPlot = Map.GetPlotXYWithRangeCheck(iPlotX, iPlotY, dx, dy, iRadius)
			if pNearPlot then
				table.insert(tTempTable, pNearPlot)
			end
		end
	end
	return tTempTable;
end

--------------------------------------
--阿尔特密斯神庙给6环送营地
function ArtemisBuildCamps( playerID, cityID, buildingID, plotID, bOriginalConstruction)
	if buildingID ~= GameInfo.Buildings['BUILDING_TEMPLE_ARTEMIS'] then return; end
	local pPlayer = Players[playerID];
	local pPlot = Map.GetPlotByIndex(plotID);
	local iX = pPlot:GetX();
	local iY = pPlot:GetY();
	local tPlots = GetValidPlotsInRadiusR(iX, iY, 6);
	local iForest = GameInfo.Features['FEATURE_FOREST'].Index;
	local iJungle = GameInfo.Features['FEATURE_JUNGLE'].Index;
	local iCamp = GameInfo.Improvements["IMPROVEMENT_CAMP"].Index;

	for k, pPickPlot in ipairs(tPlots) do
		local iResource = pPickPlot:GetResourceType();
		if pPickPlot:GetOwner() == playerID and pPickPlot:GetImprovementType() == -1 and pPickPlot:GetDistrictType() == -1 then
			if iResource ~= -1 and pPlayer:GetResources():IsResourceVisible(iResource) then
				for row in GameInfo.Improvement_ValidResources() do
					if row.ImprovementType == 'IMPROVEMENT_CAMP' and row.ResourceType == GameInfo.Resources[iResource].ResourceType then
						bValid = true;
						break;
					end
				end
			else
				local iFeature = pPickPlot:GetFeatureType();
				local bValid = false;
				if iFeature == iForest or iFeature == iJungle then
					bValid = true;
				end
			end

			if bValid then
		--if pPickPlot:GetOwner() == playerID and ImprovementBuilder.CanHaveImprovement(pPickPlot, iCamp, NO_TEAM) then
				GameEvents.SetPlotImprovement.Call(pPickPlot:GetIndex(), iCamp, playerID);
			end
		end
		--end
	end
end


GameEvents.BuildingConstructed.Add(ArtemisBuildCamps)



--神谕返还伟人点数50%的信仰值  --copied from hd
function UnitGreatPersonCreatedWatOracle(playerId, unitId, greatPersonClassId, greatPersonIndividualId)
	local iOracle = GameInfo.Buildings['BUILDING_ORACLE'].Index;
	local player = Players[playerId];
    if Utils.PlayerHasWonder (playerId, iOracle) then
        local greatPerson = GameInfo.GreatPersonIndividuals[greatPersonIndividualId];
        local era = GameInfo.Eras[greatPerson.EraType];
        local cost = era.GreatPersonBaseCost;
        local percent = 50 / 100; --变现比例
        GameEvents.RequestChangeFaithBalance.Call(playerId, cost * percent);
    end
end

Events.UnitGreatPersonCreated.Add(UnitGreatPersonCreatedWatOracle);

--金字塔让工人永不安息
function BuilderResumeWithPryamid(playerID, unitID, newCharges, oldCharges)
	local iPryamid = GameInfo.Buildings['BUILDING_PYRAMIDS'].Index;
	if not Utils.PlayerHasWonder (playerID, iPryamid) then return; end
	local player = Players[playerID];
	local unit = player:GetUnits():FindID(unitID)
	if unit ~= nil and unit:GetType() == GameInfo.Units['UNIT_BUILDER'].Index and newCharges + 1 == oldCharges then
		GameEvents.RestoreUnitMovement.Call(playerID, unitID);
	end
end

Events.LoadGameViewStateDone.Add(function()
	Events.UnitChargesChanged.Add(BuilderResumeWithPryamid);
end)


--大浴场触发事件
function GreatBathEventOccurred(type:number, severity:number, plotx:number, ploty:number, mitigationLevel:number, randomEventID:number, gameCorePlaybackEventID:number) 
	local sEvent = GameInfo.RandomEvents[type].RandomEventType;
	local iGreatBath = GameInfo.Buildings['BUILDING_GREAT_BATH'].Index;
	if string.find(sEvent, 'FLOOD') ==nil then return; end
	--if type ~= 34 then return; end
	for i, PlayerID in ipairs(PlayerManager.GetWasEverAliveMajorIDs()) do
		if Utils.PlayerHasWonder (PlayerID, iGreatBath) then
			local dist = 6
			local pPlayerCities = Players[PlayerID]:GetCities()
			for i, pCity in pPlayerCities:Members() do
            	local CityHasBath = pCity:GetBuildings():HasBuilding(iGreatBath);
            	if CityHasBath then
            		local location = Map.GetPlotByIndex(Utils.GetBuildingLocation(PlayerID, pCity:GetID(), iGreatBath));
					local iDistance = Map.GetPlotDistance(location:GetX(), location:GetY(), pCity:GetX(), pCity:GetY());
					if (iDistance < dist) then
    					GameEvents.TriggerCommonEvent.Call(PlayerID, 'EVENT_COMMON_GREAT_BATH_FLOOD', {CityId = pCity:GetID()});
					end
					break;
				end
			end
			break;
		end
	end
end

Events.RandomEventOccurred.Add(GreatBathEventOccurred)




GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
--[[
function EagleWarriorCaptureVuilderBonus( currentUnitOwner, unitID, owningPlayer, capturingPlayer )
    local pPlayer = Players[capturingPlayer]
    local pPlayerConfig = PlayerConfigurations[capturingPlayer]
    local sCiv = pPlayerConfig:GetCivilizationTypeName()

    --See if already have captical city--
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    print(pUnit:GetType())
    local unitType = GameInfo.Units[pUnit:GetType()]
    print(unitType.UnitType)
    if unitType.UnitType == "UNIT_BUILDER" then
        print(234)
        local unitX = pUnit:GetX()
        local unitY = pUnit:GetY()
        local unitList = Units.GetUnitsInPlot(iX, iY)
        if unitList ~= nil then 
            for i, rUnit in ipairs(unitList) do
                print(345)
                local unitType1 = GameInfo.Units[rUnit:GetType()]
                if unitType1.UnitType == "UNIT_AZTEC_EAGLE_WARRIOR" then
                    print(456)
                    UnitManager.RestoreMovement(rUnit)
                    rUnit:ChangeDamage(-20)
                end
            end
        end
    end
end

Events.UnitCaptured.Add(EagleWarriorCaptureVuilderBonus)


]]
-- ===========================================================================
-- ===========================================================================
--铺路 game play部分
m_BuildModeEnabled = {};

GameEvents.DA_BuildRoads.Add(function(playerID : number, unitID : number)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    GameEvents.SetAbilityCount.Call(playerID, unitID, 'ABILITY_BUILDROAD_MODE', 1);
    GameEvents.RestoreUnitMovement.Call(playerID, unitID);
    GameEvents.ChangeUnitMovesRemaining.Call(playerID, unitID, 4);  
    GameEvents.SetUnitProperty.Call(playerID, unitID, 'PROP_BUILDROAD_MODE', 1);
    GameEvents.ReduceBuildCharge.Call(playerID, unitID);
    m_BuildModeEnabled[playerID] = m_BuildModeEnabled[playerID] or {};
    m_BuildModeEnabled[playerID][unitID] = 1;
end)
-- ===========================================================================
function OnUnitMoved(playerId:number, unitId:number, tileX, tileY)
    local pUnit = UnitManager.GetUnit(playerId, unitId);
    local player = Players[playerId];
    if pUnit:GetProperty('PROP_BUILDROAD_MODE') ~= nil and pUnit:GetProperty('PROP_BUILDROAD_MODE') == 1 then
        local plot = Map.GetPlot(tileX, tileY);
        if not plot:IsWater() then
            local buildingRouteType = GetPlayerRouteType(player);
            local currentRouteType = plot:GetRouteType();
            if currentRouteType == -1 or buildingRouteType.PlacementValue > GameInfo.Routes[currentRouteType].PlacementValue then
                RouteBuilder.SetRouteType(plot, buildingRouteType.Index);
            end
        end
    end
end
Events.UnitMoved.Add(OnUnitMoved);

function GetPlayerRouteType(player)
    local route = nil;
    local playerEra = GameInfo.Eras[player:GetEra()];
    
    for routeType in GameInfo.Routes() do 
        if route == nil then
            route = routeType;
        else
            if (route.PlacementValue < routeType.PlacementValue) then
                local canBuild = true;
                
                -- Era requirement
                local prereq_era = GameInfo.Eras[routeType.PrereqEra];
                if prereq_era and playerEra.ChronologyIndex < prereq_era.ChronologyIndex  then
                    canBuild = false;
                end
                
                -- Tech requirement
                if canBuild and GameInfo.Routes_XP2 then
                    local routeXp2 = GameInfo.Routes_XP2[routeType.RouteType];
                    
                    if (routeXp2 and routeXp2.PrereqTech) then
                        local playerTech = player:GetTechs();
                        local requiredTech = GameInfo.Technologies[routeXp2.PrereqTech];
                        
                        if not (playerTech:HasTech(requiredTech.Index) and routeType.PlacementValue~=5) then
                            canBuild = false;
                        end
                    end
                end
                
                if (canBuild) then
                    route = routeType;
                end
            end
        end
    end
    
    -- See if player has TRAIT_CIVILIZATION_SATRAPIES trait
    local playerId = player:GetID();
    
    
    if Utils.PlayerHasTrait(playerId, 'TRAIT_CIVILIZATION_SATRAPIES') then
        -- See if there is a road with higher placement value
        for routeType in GameInfo.Routes() do
            if (routeType.PlacementValue == route.PlacementValue + 1) then
                route = routeType;
                break;
            end
        end
    end
    return route;
end

function OnTurnBeginBuildMode()
    for playerID, playerUnits in pairs(m_BuildModeEnabled) do
        for unitID, value in pairs(playerUnits) do
            if value == 1 then
                local pUnit = UnitManager.GetUnit(playerID, unitID);
                if pUnit == nil then 
                    m_BuildModeEnabled[playerID][unitID] = 0;
                    return; 
                end
                pUnit:SetProperty('PROP_BUILDROAD_MODE', 0);
                GameEvents.SetAbilityCount.Call(playerID, unitID, 'ABILITY_BUILDROAD_MODE', 0);
                m_BuildModeEnabled[playerID][unitID] = 0;
            end
        end
    end
end


function OnLoadScreenCloseBuildMode()
    local players = Game.GetPlayers{Alive = true};
    for _, player in ipairs(players) do
        for _, unit in player:GetUnits():Members() do
            if unit:GetProperty('ABILITY_BUILDROAD_MODE') ~= nil and unit:GetProperty('ABILITY_BUILDROAD_MODE') == 1 then
                local playerID = player:GetID();
                local unitID = unit:GetID();
                m_BuildModeEnabled[playerID] = m_BuildModeEnabled[playerID] or {};
                m_BuildModeEnabled[playerID][unitID] = 1;
            end
        end
    end
end



Events.TurnBegin.Add(OnTurnBeginBuildMode);
Events.LoadScreenClose.Add(OnLoadScreenCloseBuildMode);

--GameEvents.RequestChangeFaithBalance.Call(2,21)
----------------------------------------------------------------

--信仰造奇观 game play部分
GameEvents.DA_FaithBuildWonder.Add(function(playerID : number, unitID : number)
    --local playerID = pUnit:GetOwner();
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local player = Players[playerID];
    local iX, iY = pUnit:GetX(), pUnit:GetY();
    local pPlot = Map.GetPlot(iX, iY);
    local pCity = Cities.GetPlotPurchaseCity(pPlot);
    local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
    local iCost = GameInfo.Buildings[sCurrent].Cost;
    local iProductionProgress = Utils.GetCurrentlyBuildingProgress(playerID, pCity:GetID(), GameInfo.Buildings[sCurrent].Index);
    local iRiverCount = pPlot:GetProperty('PROP_RIVER_COUNT') or 0;
    local iFaithNeeded = (iCost - iProductionProgress) * 2 / (1 + iRiverCount * 0.1);
    local iFaithBalance = player:GetReligion():GetFaithBalance();
    player:GetReligion():ChangeFaithBalance(-iFaithNeeded);
    GameEvents.RequestAddProgress.Call(playerID, pCity:GetID(), iFaithNeeded+1);
    --SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
    GameEvents.ReduceBuildCharge.Call(playerID, unitID);
end)


-- function CityStateClearBarbCamp(playerID,unitID,x,y)
--     local pPlayer = Players[playerID];
--     if Utils.IsMinor(playerID) then
--         local pUnit :object = Players[playerID]:GetUnits():FindID(unitID)
--         local pPlayer = Players[playerID]
--         local plotID = Map.GetPlotIndex(x,y)
--         local pPlot = Map.GetPlot(x,y);
--         local eImprovement = pPlot:GetImprovementType();
--         print('reach'..x..'  '..y..'  '..eImprovement)
--         if eImprovement ~= nil and eImprovement ~= -1 then--and GameInfo.Improvements[eImprovement].ImprovementType == 'IMPROVEMENT_BARBARIAN_CAMP' then
--            ImprovementBuilder.SetImprovementType(pPlot, -1);
--         end
--     end
-- end


-- Events.UnitMoveComplete.Add(CityStateClearBarbCamp)


--城邦能清理寨子
function CityStateClearBarbCamp( playerID:number, unitID:number, worldX:number, worldY:number, worldZ:number, bVisible:boolean, isComplete:boolean )
    local pPlayer = Players[playerID];
    if Utils.IsMinor(playerID) then
        local pUnit :object = Players[playerID]:GetUnits():FindID(unitID)
        local pPlayer = Players[playerID]
        local x, y = pUnit:GetX(), pUnit:GetY();
        local pPlot = Map.GetPlot(x,y);
        local eImprovement = pPlot:GetImprovementType();
        --print('reach'..x..'  '..y..'  '..eImprovement)
        if eImprovement ~= nil and eImprovement ~= -1 and GameInfo.Improvements[eImprovement].ImprovementType == 'IMPROVEMENT_BARBARIAN_CAMP' then
           ImprovementBuilder.SetImprovementType(pPlot, -1);
        end
    end
end
Events.UnitSimPositionChanged.Add(CityStateClearBarbCamp)








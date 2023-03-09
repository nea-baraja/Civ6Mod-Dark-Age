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


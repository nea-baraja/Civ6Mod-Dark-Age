
ExposedMembers.GameEvents = GameEvents
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
GameEvents.SetPlotProperty.Add(function(plotID, key, value)
    local plot = Map.GetPlotByIndex(plotID)
  --  print(plot:GetX(), plot:GetY(), plot)
    plot:SetProperty(key, value)
end)

GameEvents.GetGameProperty.Add(function(key)
    return Game.GetProperty(key)
end)

GameEvents.SetGameProperty.Add(function(key, value)
    Game.SetProperty(key, value)
end)

GameEvents.GetPlayerProperty.Add(function(playerID, key)
    local player = Players[playerID]
    return player:GetProperty(key)
end)

GameEvents.SetPlayerProperty.Add(function(playerID, key, value)
    local player = Players[playerID]
    player:SetProperty(key, value)
end)

--[[GameEvents.GetPlotWonderType.Add(function(plotID)
    local plot = Map.GetPlotByIndex(plotID)
    print(plot:GetWonderType())
    return plot:GetWonderType()
end)
--]]

Utils.SetPlayerProperty = function(playerID, key, value)
    local player = Players[playerID]
    player:SetProperty(key, value)
end

Utils.SetGameProperty = function(key, value)
    Game.SetProperty(key, value)
end

Utils.GetGameProperty = function(key)
    return Game.GetProperty(key)
end

Utils.GetPlotProperty = function(plot, key)
    return plot:GetProperty(key)
end

Utils.GetPlayerProperty = function(playerID, key)
    local pPlayer = Players[playerID]
    if pPlayer ~= nil then
        return pPlayer:GetProperty(key)
    end
end





--Utils.SetPlotProperty.Add(function(plotID, key, value)
--    local plot = Map.GetPlotByIndex(plotID)
--    print(plot:GetX(), plot:GetY(), plot)
--    plot:SetProperty(key, value)
--end)

function ChangeFaithBalance(playerID, amount)
    local player = Players[playerID]
    if player ~= nil then
        player:GetReligion():ChangeFaithBalance(amount)
    end
end
GameEvents.RequestChangeFaithBalance.Add(ChangeFaithBalance)


function GetCurrentlyBuilding(playerID, cityID)
    local city = CityManager.GetCity(playerID,    cityID);
    return city:GetBuildQueue():CurrentlyBuilding();
end

Utils.GetCurrentlyBuilding = GetCurrentlyBuilding;
--GameEvents.GetCurrentlyBuilding.Add(Get_CurrentlyBuilding)

GameEvents.RequestFinishProgress.Add(function(playerID, cityID)
    local city = CityManager.GetCity(playerID,    cityID);    
    city:GetBuildQueue():FinishProgress();
end)

GameEvents.RequestAddProgress.Add(function(playerID, cityID,produnction)   
    local city = CityManager.GetCity(playerID,    cityID);
    city:GetBuildQueue():AddProgress(produnction);
end)

GameEvents.AddGreatPeoplePoints.Add(function(playerID, gppID, amount)
    local player = Players[playerID]
    if player ~= nil then
        print('DA DEBUG add great people point', playerID, gppID, amount)
        player:GetGreatPeoplePoints():ChangePointsTotal(gppID, amount)
    end
end)

GameEvents.RequestCreateBuilding.Add(function (playerID, cityID, buildingID)
    local city = CityManager.GetCity(playerID, cityID)
    print('DA DEBUG create building requested', playerID, cityID, buildingID)
    if city then
        local buildingQueue = city:GetBuildQueue()
        -- print(city, buildingQueue)
        buildingQueue:CreateBuilding(buildingID) 
    end
end)

GameEvents.RequestRemoveBuilding.Add(function (playerID, cityID, buildingID)
    local city = CityManager.GetCity(playerID, cityID)
    print('DA DEBUG remove building requested', playerID, cityID, buildingID)
    if city ~= nil then
        local buildings = city:GetBuildings()
        buildings:RemoveBuilding(buildingID)
    end
end)

GameEvents.StrategicResourcesChange.Add(function(playerID, ResourceType, amount)
    local player = Players[playerID]
    local playerResources = Players[playerID]:GetResources()
    local resource_id = GameInfo.Resources[ResourceType].Index
    playerResources:ChangeResourceAmount(resource_id, amount)
end)

GameEvents.SetAbilityCount.Add(function(playerID, unitID, sAbility, count)
    local player = Players[playerID]
    local pUnits = player:GetUnits()
    local pUnit = pUnits:FindID(unitID)
    local pUnitAbility = pUnit:GetAbility()
    local oldCount = pUnitAbility:GetAbilityCount(sAbility)
    pUnitAbility:ChangeAbilityCount(sAbility, count - oldCount)
end)

GameEvents.RestoreUnitMovement.Add(function(playerID, unitID)
    local player = Players[playerID]
    local pUnits = player:GetUnits()
    local pUnit = pUnits:FindID(unitID)
    if pUnit ~= nil then
        UnitManager.RestoreMovement(pUnit)
    end
end)

GameEvents.SendEnvoytoCityState.Add(function(playerID, citystateID)
    -- Need to make sure the second is citystate
    local player = Players[playerID]
    if player ~= nil then
        player:GetInfluence():GiveFreeTokenToPlayer(citystateID)
    end
end)


GameEvents.UnlockPolicy.Add(function(playerID, policyID)
    -- Need to make sure the second is citystate
    local player = Players[playerID]
    if player ~= nil then
        local pCulture = player:GetCulture();
        pCulture:UnlockPolicy(policyID);
    end
end)

GameEvents.PlayerAttachModifierByID.Add( function(playerID, sModifierID)
    local player = Players[playerID]
    if player ~= nil then
        player:AttachModifierByID(sModifierID)
    end
end)

GameEvents.SetPlotImprovement.Add(function(plotID, iImprovement, iPlayer)
    local plot = Map.GetPlotByIndex(plotID);
    iPlayer = iPlayer or -1;
    ImprovementBuilder.SetImprovementType(plot, iImprovement, iPlayer);
end)


Utils.RequestAddWorldView = function (text, iX, iY)
    Game.AddWorldViewText(0,text,iX,iY);
end


Utils.PlayerAttachModifierByID = function(playerID, sModifierID)
    local player = Players[playerID]
    if player ~= nil then
        player:AttachModifierByID(sModifierID)
    end
end

Utils.CityAttachModifierByID = function(playerID,   cityID, sModifierID)
    local city = CityManager.GetCity(playerID, cityID)

    if city ~= nil then
        print(sModifierID)
        city:AttachModifierByID(sModifierID)
    end
end

Utils.ChangePopulation = function(playerID, iCity,  pNewPopulation)
    local pPlayer = Players[playerID]   
    local pCity = pPlayer:GetCities():FindID(iCity) 
    if pCity ~= nil then
        pCity:ChangePopulation(pNewPopulation);
    end
end

Utils.GetUnitType = function(unitID,    playerID)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    print(pUnit)
    print(pUnit:GetID())
    return pUnit:GetType()
end

Utils.GetBuildingLocation = function (playerId, cityId, buildingId)
    local city = CityManager.GetCity(playerId, cityId);
    if city ~= nil then
        return city:GetBuildings():GetBuildingLocation(buildingId);
    end
end

Utils.PlayerHasWonder = function(playerId, wonderId)
    local player = Players[playerId];
    if player == nil then return false; end
    for _, city in player:GetCities():Members() do
        if city:GetBuildings():HasBuilding(wonderId) then
            return true;
        end
    end
    return false;
end


function RecordUnitMove(playerID,unitID,x,y)
    local pUnit :object = Players[playerID]:GetUnits():FindID(unitID)
    --print(" unit type"..UnitManager.GetTypeName(pUnit))
    local pPlayer = Players[playerID]
    local plotID = Map.GetPlotIndex(x,y)
    pPlayer:SetProperty('UNIT_'..unitID..'_POSITION',   plotID)
end


Events.UnitMoveComplete.Add(RecordUnitMove)






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

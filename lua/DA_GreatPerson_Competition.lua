include("SupportFunctions")

GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils

local RAMSES_II_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_RAMSES_II"].Index;


function RamsesIIFaithBuyWonder(unitOwner, unitID,greatPersonClassID, greatPersonIndividualID)
   if greatPersonIndividualID ~= RAMSES_II_INDEX then
      return;
   end
   
   local owner = Players[unitOwner];

   local unit = UnitManager.GetUnit(unitOwner, unitID);
   local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
   --local districtAtPlot = CityManager.GetDistrictAt(unitPlot);
   local city = Cities.GetPlotPurchaseCity(unitPlot);
   --print(city)
   local current = Utils.GetCurrentlyBuilding(unitOwner, city:GetID());
   print(current)
   if not current then
      return;
   end
   local buildingInfo = GameInfo.Buildings[current];
   if not buildingInfo.IsWonder then
      return;
   end
   local cost = buildingInfo.Cost;
   local iProductionProgress = city:GetBuildQueue():GetBuildingProgress( buildingInfo.Index );
   local productionNeeded = cost - iProductionProgress;
   local faithBalance = owner:GetReligion():GetFaithBalance();
   if(faithBalance > productionNeeded) then
      --Utils.RequestAddWorldView(0, "+" .. productionNeeded .. " [ICON_PRODUCTION]", unit:GetX(), unit:GetY());
      GameEvents.RequestChangeFaithBalance.Call(unitOwner,  -productionNeeded);
      GameEvents.RequestFinishProgress.Call(unitOwner, city:GetID());
   else
     -- Utils.RequestAddWorldView(0, "+" .. faithBalance .. " [ICON_PRODUCTION][NEWLINE]".."-" .. faithBalance .. " [ICON_FAITH]", unit:GetX(), unit:GetY());
      GameEvents.RequestChangeFaithBalance.Call(unitOwner,  -faithBalance);
      GameEvents.RequestAddProgress.Call(unitOwner, city:GetID(), faithBalance);
   end
   GreatEngineerSpeedUpNoPoints(unitOwner, unitID,greatPersonClassID, greatPersonIndividualID)
   print('LA II ACTIVATED')
end

Events.UnitGreatPersonActivated.Add( RamsesIIFaithBuyWonder );

function GreatEngineerSpeedUpNoPoints(unitOwner, unitID,greatPersonClassID, greatPersonIndividualID)
    local owner = Players[unitOwner];
 

    local unit = UnitManager.GetUnit(unitOwner, unitID);
    local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
    --local WonderId = unitPlot:GetWonderType()
    --print(unit:GetX(), unit:GetY())
    --print(WonderId)
    --local WonderType = GameInfo.Buildings[WonderId].BuildingType;
    --if(WonderType ~= nil and WonderType ~= -1) then 
       -- print('wonder sped up');
        local PROP_NO_WONDER_BONUS = 'NO_BONUS'..unitPlot:GetIndex();
        GameEvents.SetPlayerProperty.Call(unitOwner,  PROP_NO_WONDER_BONUS ,  1);
    --end

end

Events.UnitGreatPersonActivated.Add( GreatEngineerSpeedUpNoPoints );


local GreatPersonNotificationHash = DB.MakeHash("NOTIFICATION_COMPETITION_GREATPERSON");
-- Great Engineer from wonders
function WonderToGreatEngineerPoints(iX, iY, buildingID, playerID, cityID, iPercentComplete, iUnknown)
    --print(iX, iY, buildingID, playerID, cityID, iPercentComplete, iUnknown)
    local Plot = Map.GetPlot(iX, iY)
    local gameSpeed = GameConfiguration.GetGameSpeedType()
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[gameSpeed].CostMultiplier * 0.01
    local player = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    local building = GameInfo.Buildings[buildingID]
    local PROP_NO_WONDER_BONUS = 'NO_BONUS'..Plot:GetIndex();

    if player:GetProperty(PROP_NO_WONDER_BONUS) == 1 then 
        print(building.BuildingType..'was sped up. No bonus for GreatEngineerPoints.')
        return;
    end
    -- print(building.BuildingType)
    if player ~= nil and pCity ~= nil and building ~= nil then
        local greatEngID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ENGINEER'].Index
        local amount = building.Cost * 30 * 0.01 * iSpeedCostMultiplier
        GameEvents.AddGreatPeoplePoints.Call(playerID, greatEngID, amount)
        local sCityName = Locale.Lookup(pCity:GetName())
        local sWonderName = Locale.Lookup(building.Name)
        local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_ENGINEER_TITLE')
        NotificationManager.SendNotification(playerID, GreatPersonNotificationHash, sTitle, Locale.Lookup('LOC_COMPETITION_WONDER_GREAT_ENGINEER_DESCRIPTION', sCityName, sWonderName, amount), pCity:GetX(), pCity:GetY())
    end
end

Events.WonderCompleted.Add(WonderToGreatEngineerPoints)


-- Great Engineer from first built buildings
function FirstBuildingToGreatEngineerPoints(playerID, cityID, buildingID)
    local gameSpeed = GameConfiguration.GetGameSpeedType()
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[gameSpeed].CostMultiplier * 0.01
    local player = Players[playerID]
    local building = GameInfo.Buildings[buildingID]
    local pCity = CityManager.GetCity(playerID, cityID)
    local PROP_FIRST_BUILT = 'FIRST_'..building.BuildingType
    local bFirstBuilt = player:GetProperty(PROP_FIRST_BUILT) or 0
    local isWonder = building.IsWonder
    --print('isWonder'..isWonder)
    if player ~= nil and pCity ~= nil and bFirstBuilt ~= 1 and building ~= nil and (not isWonder)  and isValidBuilding(buildingID) then
        local greatEngID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ENGINEER'].Index
        local amount = building.Cost * 15 * 0.01 * iSpeedCostMultiplier
        GameEvents.AddGreatPeoplePoints.Call(playerID, greatEngID, amount)
        Utils.SetPlayerProperty(playerID, PROP_FIRST_BUILT, 1)
        local sBuildingName = Locale.Lookup(building.Name)
        local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_ENGINEER_TITLE')
        NotificationManager.SendNotification(playerID, GreatPersonNotificationHash, sTitle, Locale.Lookup('LOC_COMPETITION_BUILDING_GREAT_ENGINEER_DESCRIPTION', sBuildingName, amount), pCity:GetX(), pCity:GetY())
    end
end
GameEvents.BuildingConstructed.Add(FirstBuildingToGreatEngineerPoints)

function FirstTechnologyResearched(playerID, techID)
    local gameSpeed = GameConfiguration.GetGameSpeedType()
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[gameSpeed].CostMultiplier * 0.01
    local tech = GameInfo.Technologies[techID]
    local player = Players[playerID]
    print(playerID,'finished',Locale.Lookup(tech.Name))
    local PROP_FIRST_RESEARCHED = 'FIRST_'..tech.TechnologyType
    local bFinished = Utils.GetGameProperty(PROP_FIRST_RESEARCHED) or 0

    local era = Game.GetEras():GetCurrentEra()
    local techEra = GameInfo.Eras[tech.EraType].ChronologyIndex
    if techEra > era + 2 then 
        print(tech.TechnologyType..' finished too early. No bonus.')
        return 
    end

    local MajorPlayersNumber = 1
    for i,v in pairs(Players) do
        if(v:IsMajor()) then
            MajorPlayersNumber = i + 1
        else 
            break
        end
    end

    if bFinished < math.floor(MajorPlayersNumber * 3 / 8 + 2) and tech ~= nil and player ~= nil then 
        local greatSciID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_SCIENTIST'].Index
        local cost = tech.Cost
        local amount = cost * 10 * 0.01 * iSpeedCostMultiplier
        GameEvents.AddGreatPeoplePoints.Call(playerID, greatSciID, amount)
        Utils.SetGameProperty(PROP_FIRST_RESEARCHED, bFinished + 1)
        local sTechName = Locale.Lookup(tech.Name)
        local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_SCIENTIST_TITLE')
        local notificationData = {};
        notificationData[ParameterTypes.MESSAGE] = sTitle;
        notificationData[ParameterTypes.SUMMARY] = Locale.Lookup('LOC_COMPETITION_GREAT_SCIENTIST_DESCRIPTION', sTechName, amount)
        notificationData.AlwaysAutoActivate = true;
        notificationData.AlwaysUnique = true;        
        NotificationManager.SendNotification(playerID, GreatPersonNotificationHash, notificationData)
    end
end

Events.ResearchCompleted.Add(FirstTechnologyResearched);


function OnUnitPromotionChanged(player, unitId)
    local pPlayer = Players[player];
    local pUnit = UnitManager.GetUnit(player, unitId);
    if pPlayer == nil or pUnit == nil then return; end
    local pExperience = pUnit:GetExperience();
    if (pExperience ~= nil) then
        local promotionList :table = pExperience:GetPromotions();
        print(#promotionList)
        local greatGeneralID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_GENERAL'].Index
        local pGreatPeople  :table  = Game.GetGreatPeople();
        local pTimeline = pGreatPeople:GetTimeline();
        local recruitCost = 0;
        for _, tEntry in pairs(pTimeline) do
            if tEntry.Class == greatGeneralID then
                recruitCost = tEntry.Cost;
                print(recruitCost)
            end
        end
       
        if recruitCost ~= nil and recruitCost > 0 then
            local sUnitName = pUnit:GetName();
            local iGpp = math.ceil(#promotionList * recruitCost / 7 / 4 );
            GameEvents.AddGreatPeoplePoints.Call(player, greatGeneralID, iGpp);
            local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_GENERAL_TITLE')
            local notificationData = {};
            notificationData[ParameterTypes.MESSAGE] = sTitle;
            notificationData[ParameterTypes.SUMMARY] = Locale.Lookup('LOC_COMPETITION_GREAT_GENERAL_DESCRIPTION', sUnitName, #promotionList,iGpp);
            notificationData.AlwaysAutoActivate = true;
            notificationData.AlwaysUnique = true;


            NotificationManager.SendNotification(player, GreatPersonNotificationHash,notificationData);
        end
    end
end

Events.UnitPromoted.Add( OnUnitPromotionChanged );




function isValidBuilding(buildingID)
    local building = GameInfo.Buildings[buildingID]
    if (building ~= nil) then
        local pType = building.BuildingType
        if(string.find(pType, 'CITY_POLICY') ~= nil) then
            return false
        elseif(string.find(pType, 'CTYZ') ~= nil) then
            return false
        elseif(string.find(pType, 'LEGACY') ~= nil) then
            return false
        elseif(string.find(pType, 'FLAG') ~= nil) then
            return false
        end
    else
        return false
    end
    return true
end
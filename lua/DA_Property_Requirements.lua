include("SupportFunctions")

GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils

function AmenityPropertyManager(playerID, cityID)
	local player = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    if pCity == nil then 
    	return 
    end
    local cityX = pCity:GetX()
    local cityY = pCity:GetY()
    local CityPlot = Map.GetPlot(cityX, cityY)
    local plotID = CityPlot:GetIndex()
    local pCityGrowth = pCity:GetGrowth()
    local pAmenity = pCityGrowth:GetAmenities() - pCityGrowth:GetAmenitiesNeeded()
    local PROP_AMENITY = 'CITY_AMENITY'

    if pAmenity ~= nil then 
    	GameEvents.SetPlotProperty.Call(plotID, PROP_AMENITY, pAmenity)
    --	print(playerID..':'..cityID..':amenity is '..Utils.GetPlotProperty(CityPlot, PROP_AMENITY))
    end
end

function SpecialistManager(playerID)
    local player = Players[playerID]
    for _, district in player:GetDistricts():Members() do
    	local districtPlot:table = Map.GetPlot(district:GetX(), district:GetY())
    	local plotID = districtPlot:GetIndex()
    	local citizens = districtPlot:GetWorkerCount()
    	local PROP_WORKER_COUNT = 'WORKER_COUNT'
    	GameEvents.SetPlotProperty.Call(plotID, PROP_WORKER_COUNT, citizens)
    	--print(playerID..' district worker count is '..Utils.GetPlotProperty(districtPlot, PROP_WORKER_COUNT))
    end
end

function AdjacencyManager(playerID)
    local player = Players[playerID]
    local pCityDistricts = player:GetDistricts()
    local kTempDistrictYields :table = {}
    local PROP_ADJANCENCY = 'ADJACENCY_'
    for yield in GameInfo.Yields() do
        kTempDistrictYields[yield.Index] = yield
    end
    for i, district in pCityDistricts:Members() do      
        -- ==========
       --[[ function GetDistrictYield( district:table, yieldType:string )
            for i,yield in ipairs( kTempDistrictYields ) do
                if yield.YieldType == yieldType then
                    return district:GetYield(i);
                end
            end
            return 0;
        end     

        --I do not know why we make local functions, but I am keeping standard
        function GetDistrictBonus( district:table, yieldType:string )
            for i,yield in ipairs( kTempDistrictYields ) do
                if yield.YieldType == yieldType then
                    return district:GetAdjacencyYield(i);
                end
            end
            return 0;
        end]]
        local districtPlot:table = Map.GetPlot(district:GetX(), district:GetY())
        local plotID = districtPlot:GetIndex()
        for j,yield in ipairs( kTempDistrictYields ) do
            GameEvents.SetPlotProperty.Call(plotID, PROP_ADJANCENCY..yield.YieldType , district:GetAdjacencyYield(j))
        end
    end
end
  
function GovernmentLegacyManager(playerID)
    local player = Players[playerID]
    local govID = player:GetCulture():GetCurrentGovernment()
    print(govID)
    if(govID == nil or govID == -1) then
        return 
    end
    local govType = GameInfo.Governments[govID].GovernmentType 
    --print(playerID..'gov:'..govType)
    if govType == 'GOVERNMENT_OLIGARCHY' then
        for _, city in player:GetCities():Members() do
            local cityX = city:GetX()
            local cityY = city:GetY()
            local CityPlot = Map.GetPlot(cityX, cityY)
            local plotID = CityPlot:GetIndex()
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_OLIGARCHY_LEGACY', 1)
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_AUTOCRACY_LEGACY', 0)
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY', 0)
        end
    elseif govType == 'GOVERNMENT_AUTOCRACY' then
        for _, city in player:GetCities():Members() do
            local cityX = city:GetX()
            local cityY = city:GetY()
            local CityPlot = Map.GetPlot(cityX, cityY)
            local plotID = CityPlot:GetIndex()
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_OLIGARCHY_LEGACY', 0)
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_AUTOCRACY_LEGACY', 1)
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY', 0)
        end
    elseif govType == 'GOVERNMENT_CLASSICAL_REPUBLIC' then
        for _, city in player:GetCities():Members() do
            local cityX = city:GetX()
            local cityY = city:GetY()
            local CityPlot = Map.GetPlot(cityX, cityY)
            local plotID = CityPlot:GetIndex()
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_OLIGARCHY_LEGACY', 0)
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_AUTOCRACY_LEGACY', 0)
            GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY', 1)
        end     
    end
end



function OnTurnBegin()
	local players = Game.GetPlayers{Alive = true};
	print('turnbegin')
	for _, player in ipairs(players) do
		SpecialistManager(player:GetID())
        AdjacencyManager(player:GetID())
        GovernmentLegacyManager(player:GetID())
		for _, city in player:GetCities():Members() do
			AmenityPropertyManager(player:GetID(), city:GetID())
		end
	end
end




Events.TurnBegin.Add(OnTurnBegin);
Events.CityAddedToMap.Add(AmenityPropertyManager)

function Tier0GovernmentSet(playerID)
    local player = Players[playerID]
    local govID = player:GetCulture():GetCurrentGovernment()
    local govType = GameInfo.Governments[govID].GovernmentType
    if Utils.GetPlayerProperty(playerID, 'PROP_GOVERNMENT_TIER_0') ~= nil then
        print('not first gov0')
        return
    end
    if govType == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
        GameEvents.SetPlayerProperty.Call(playerID, 'PROP_GOVERNMENT_TIER_0', 'GOVERNMENT_CITY_STATE_ALLIANCE')
        Utils.PlayerAttachModifierByID(playerID, 'CITY_STATE_ALLIANCE_FIRST_DOUBLE_ENVOY')
    end
    if govType == 'GOVERNMENT_TRIBE_UNITY' then
        GameEvents.SetPlayerProperty.Call(playerID, 'PROP_GOVERNMENT_TIER_0', 'GOVERNMENT_TRIBE_UNITY')
    end
    print('first gov0 '..govType)
end



    
function GovernmentChanged(playerID)
    local player = Players[playerID]
    local govID = player:GetCulture():GetCurrentGovernment()
    if govID ==nil or govID == -1 then return; end
    local govType = GameInfo.Governments[govID].GovernmentType
    Tier0GovernmentSet(playerID)
    OligarchyCitizenFoodCostRefresh(playerID,   govType)
    GovernmentLegacyManager(playerID)
end

Events.GovernmentChanged.Add(GovernmentChanged)

function OligarchyOnTurnBegin()
    local players = Game.GetPlayers{Alive = true};
    for _, player in ipairs(players) do
        local govID = player:GetCulture():GetCurrentGovernment()
        if(govID ~= -1 and govID ~= nil) then
            local govType = GameInfo.Governments[govID].GovernmentType
            for _, city in player:GetCities():Members() do
                OligarchyCitizenFoodCostRefresh(player:GetID(),   govType)
            end
        end
    end
end

Events.TurnBegin.Add(OligarchyOnTurnBegin);


--独裁为区域专家加2粮消耗
function OligarchyCitizenFoodCostRefresh(playerID,  govType)
    local pPlayer = Players[playerID]
    if govType == 'GOVERNMENT_OLIGARCHY' then
        for _, city in pPlayer:GetCities():Members() do
            local pBuildings = city:GetBuildings()
            local pDistricts = city:GetDistricts()
            for row in GameInfo.DistrictCitizenYields() do
                if(row.Id == 'OLIGARCHY_FOOD_COST') then
                    BuildingInfo = GameInfo.Buildings[row.BuildingType]
                    DistrictInfo = GameInfo.Districts[row.DistrictType]
                    if((not pBuildings:HasBuilding(BuildingInfo.Index)) and  pDistricts:HasDistrict(DistrictInfo.Index)) then
                        GameEvents.RequestCreateBuilding.Call(playerID,  city:GetID(),   BuildingInfo.Index)
                    end
                end
            end
        end
    else
        for _, city in pPlayer:GetCities():Members() do
            local pBuildings = city:GetBuildings()
            local pDistricts = city:GetDistricts()
            for row in GameInfo.DistrictCitizenYields() do
                if(row.Id == 'OLIGARCHY_FOOD_COST') then
                    BuildingInfo = GameInfo.Buildings[row.BuildingType]
                    DistrictInfo = GameInfo.Districts[row.DistrictType]
                    if pBuildings:HasBuilding(BuildingInfo.Index) then
                        GameEvents.RequestRemoveBuilding.Call(playerID,  city:GetID(),   BuildingInfo.Index)
                    end
                end
            end
        end
    end
end

function CityStateAllianceDoubleQuestEnvoy( CityStateID, CompletedQuestPlayerID)
    local pCityState = Players[CityStateID]
    local pPlayer = Players[CompletedQuestPlayerID]
    if(pCityState == nil or pPlayer == nil) then return end
    local sGov0Type = Utils.GetPlayerProperty(CompletedQuestPlayerID, 'PROP_GOVERNMENT_TIER_0')
    if sGov0Type == 'GOVERNMENT_CITY_STATE_ALLIANCE' then
        local iFirstMeet = Utils.GetPlayerProperty(CompletedQuestPlayerID, 'FIRST_MEET_CITYSTATE_'..CityStateID)
        if iFirstMeet == nil then
            GameEvents.SetPlayerProperty.Call(CompletedQuestPlayerID, 'FIRST_MEET_CITYSTATE_'..CityStateID, 0)
            return
        end
        local era = Game.GetEras():GetCurrentEra()
        local iFinishedThisEra = Utils.GetPlayerProperty(CompletedQuestPlayerID, era..'ERA_FINISHED_CITYSTATE_'..CityStateID)
        if iFinishedThisEra == 1 then
            print('just era change')
            return
        end
        GameEvents.SetPlayerProperty.Call(CompletedQuestPlayerID, era..'ERA_FINISHED_CITYSTATE_'..CityStateID, 1)
        GameEvents.SendEnvoytoCityState.Call(CompletedQuestPlayerID, CityStateID)
        print('double envoy')
    end
end



Events.QuestChanged.Add( CityStateAllianceDoubleQuestEnvoy );


function CivicCompletedInitialPolicy( player:number, civic:number, isCanceled:boolean)
    local pPlayer = Players[player];
    if pPlayer == nil then return; end
    local sCivic = GameInfo.Civics[civic].CivicType;
    print(sCivic)
    if sCivic == 'CIVIC_CODE_OF_LAWS' or sCivic == 'CIVIC_NATIVE_LAND' or sCivic == 'CIVIC_SORCERY_AND_HERB' then
        local iPolicy1, iPolicy2, iPolicy3, iPolicy4 =
        GameInfo.Policies['POLICY_DISCIPLINE'].Index, GameInfo.Policies['POLICY_GOD_KING'].Index, 
        GameInfo.Policies['POLICY_SURVEY'].Index, GameInfo.Policies['POLICY_URBAN_PLANNING'].Index;
       -- GameEvents.UnlockPolicy.Call(iPolicy1);
        GameEvents.UnlockPolicy.Call(iPolicy2);
        GameEvents.UnlockPolicy.Call(iPolicy3);
      --  GameEvents.UnlockPolicy.Call(iPolicy4);
    end
end


Events.CivicCompleted.Add(CivicCompletedInitialPolicy);








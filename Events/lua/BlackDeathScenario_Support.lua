include "SupportFunctions"
include "BlackDeathScenario_StateUtils"

-- ===========================================================================
--	Black Death Scenario - Support Functions
-- ===========================================================================

-- ===========================================================================
-- Notifications
-- ===========================================================================

local m_NotificationsData = {
	Rumor			= { Type = NotificationTypes.USER_DEFINED_1 },
	Outbreak		= { Type = NotificationTypes.USER_DEFINED_2 },
	FrancePapalSlot	= { Type = NotificationTypes.USER_DEFINED_3 },
	PopupEvent		= { Type = NotificationTypes.USER_DEFINED_4 },
};

-- ===========================================================================
function SendNotification_PlagueRumor(iPlayerID : number, pCity : object)
	if (pCity == nil) then
		return false;
	end

	local msgString = Locale.Lookup("LOC_BLACKDEATH_NOTIFICATION_PLAGUE_RUMOR_MESSAGE");
	local sumString = Locale.Lookup("LOC_BLACKDEATH_NOTIFICATION_PLAGUE_RUMOR_SUMMARY", pCity:GetName());

	NotificationManager.SendNotification(iPlayerID, m_NotificationsData.Rumor.Type, msgString, sumString, pCity:GetX(), pCity:GetY());
	return true;
end

-- ===========================================================================
function SendNotification_PlagueOutbreak(pCity : object)
	if (pCity == nil) then
		return;
	end

	local msgString = Locale.Lookup("LOC_BLACKDEATH_NOTIFICATION_PLAGUE_OUTBREAK_MESSAGE");
	local sumString = Locale.Lookup("LOC_BLACKDEATH_NOTIFICATION_PLAGUE_OUTBREAK_SUMMARY", pCity:GetName());

	NotificationManager.SendNotification(pCity:GetOwner(), m_NotificationsData.Outbreak.Type, msgString, sumString, pCity:GetX(), pCity:GetY());
	return true;
end

-- ===========================================================================
function SendNotification_FrancePapalSlotCleared(iPlayerID : number)
	local msgString = Locale.Lookup("LOC_BLACKDEATH_NOTIFICATION_FRANCE_PAPAL_SLOT_MESSAGE");
	local sumString = Locale.Lookup("LOC_BLACKDEATH_NOTIFICATION_FRANCE_PAPAL_SLOT_SUMMARY");

	NotificationManager.SendNotification(iPlayerID, m_NotificationsData.FrancePapalSlot.Type, msgString, sumString);
	return true;
end

-- ===========================================================================
-- Popup Events
-- ===========================================================================
function ShowPopupEvent(sEventKey : string, iForPlayerID : number, pParams : table, hideUnlocks : boolean)
	if (sEventKey == nil) then
		return false;
	end

	-- Ensure there is event data for this type
	local pEventData : table = ScenarioEventDefinitions[sEventKey];
	if (pEventData == nil) then
		return false;
	end

	-- Populate popup data
	local pPopupData = {};
	pPopupData.ForPlayer = iForPlayerID or Game.GetLocalPlayer();
	pPopupData.EventKey = sEventKey;
	if (pEventData.EventDescription ~= nil) then
		pPopupData.EventDescription = pEventData.EventDescription;
	end

	if(hideUnlocks == nil or not hideUnlocks) then
		pPopupData.Unlocks = pEventData.Unlocks;
	end

	pParams = pParams or {};
	for key,value in pairs(pParams) do
		pPopupData[key] = value;
	end

	if (pEventData.ChoiceA ~= nil and pEventData.ChoiceB ~= nil) then
		pPopupData.ChoiceAText = pEventData.ChoiceA.Text or "Choice A";
		pPopupData.ChoiceBText = pEventData.ChoiceB.Text or "Choice B";
		pPopupData.ChoiceAUnlocks = pEventData.ChoiceA.Unlocks or {};
		pPopupData.ChoiceBUnlocks = pEventData.ChoiceB.Unlocks or {};
	end
	
	-- If event def should apply effects , do them here while we are on the Game Core side.
	if (pEventData.ApplyEffects ~= nil) then
		pEventData.ApplyEffects(pPopupData);
	end

	-- Send Popup request to the UI side through a custom notification.  Notifications are safe to use in multiplayer/hotseat.
	local notificationData = {}
	-- The notification will auto-activate on the player's turn.
	-- Note that we are seeing the AlwaysAutoActivate flag, rather than just the AutoActivate flag.  The AutoActivate will be ignored in multiplayer, if the SeverityLevel is not set to VERY_HIGH
	notificationData.AlwaysAutoActivate = true;
	notificationData.AlwaysUnique = true;		-- We are using the same notification type, but our contents are different, so tell the manager that there is no redundancy
	notificationData.ShowIcon = false			-- Since the notification is auto-activate and we are not setting an icon/message, just hide the icon in the UI so it doesn't briefly appear with the default icon.

	-- Attach the popup data to a custom entry in the notification, we will extract it when the notification is activated.
	-- Remember, notification data is going to be serialized, etc., so no lua function references etc. are allowed!
	notificationData.PopupData = pPopupData;

	NotificationManager.SendNotification( pPopupData.ForPlayer, m_NotificationsData.PopupEvent.Type, notificationData);

	pEventData.Seen = true;
	return true;
end

-- ===========================================================================
function OnEventPopupChoice(ePlayer : number, params : table)
	local pEventData : table = ScenarioEventDefinitions[params.EventKey];
	if (pEventData == nil) then
		print("OnEventPopupChoice: " .. params.EventKey .. "entry not found in ScenarioEventDefinitions");
		return;
	end

	local iResponseIndex : number = params.ResponseIndex or -1;
	if (iResponseIndex < 0) then
		return;
	end

	-- Determine if A or B was chosen
	local pCallback = nil;
	if (iResponseIndex == 0 and pEventData.ChoiceA ~= nil) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice A");
		pCallbackFunc = pEventData.ChoiceA.Callback;
	elseif (iResponseIndex == 1 and pEventData.ChoiceB ~= nil) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice B");
		pCallbackFunc = pEventData.ChoiceB.Callback;
	end

	-- Fire callback
	if (pCallbackFunc ~= nil) then
		pCallbackFunc(params);
	end	
end

-- ===========================================================================
-- Map Setup
-- ===========================================================================

-- Params
local m_CitySetupParams = {
	{ MinImproves = 10, MaxImproves = 12 }, -- Large
	{ MinImproves = 7, MaxImproves = 9 }, -- Med
	{ MinImproves = 5, MaxImproves = 6 }, -- Small
};

local m_ValidResourceImprovementMap = {
	[GameInfo.Resources["RESOURCE_CATTLE"].Index] = GameInfo.Improvements["IMPROVEMENT_PASTURE"].Index,
	[GameInfo.Resources["RESOURCE_SHEEP"].Index]	= GameInfo.Improvements["IMPROVEMENT_PASTURE"].Index,
	[GameInfo.Resources["RESOURCE_STONE"].Index]	= GameInfo.Improvements["IMPROVEMENT_QUARRY"].Index,
	[GameInfo.Resources["RESOURCE_WHEAT"].Index]	= GameInfo.Improvements["IMPROVEMENT_FARM"].Index,
	[GameInfo.Resources["RESOURCE_FISH"].Index]	= GameInfo.Improvements["IMPROVEMENT_FISHING_BOATS"].Index,
	[GameInfo.Resources["RESOURCE_SILVER"].Index]	= GameInfo.Improvements["IMPROVEMENT_MINE"].Index,
	[GameInfo.Resources["RESOURCE_SALT"].Index]	= GameInfo.Improvements["IMPROVEMENT_MINE"].Index,
}

local m_eFarmImprovement : number = GameInfo.Improvements["IMPROVEMENT_FARM"].Index;
local m_eLumberMillImprovement : number = GameInfo.Improvements["IMPROVEMENT_LUMBER_MILL"].Index;
local m_ePastureImprovement : number = GameInfo.Improvements["IMPROVEMENT_PASTURE"].Index;

local m_eCatholicismReligion : number = GameInfo.Religions["RELIGION_CATHOLICISM"].Index;

-- ===========================================================================
function SetupPlayerTerritory(pPlayer : object, iOverrideSizeParam : number)
	if (pPlayer == nil) then
		return;
	end

	local NO_TEAM = -1;

	local pPlayerCities : object = pPlayer:GetCities();
	if (pPlayerCities == nil) then 
		return;
	end
	local pCityPlots = {};	
	local iCitySizeDivisor : number = math.ceil(pPlayerCities:GetCount() / 3);

	for iCityIndex : number, pCity : object in pPlayerCities:Members() do
		
		local iPlayer = pCity:GetOwner();
		local pResourcePlots = {};
		local pFarmPlots = {};
		local pLumberMillPlots = {};

		-- Determine the size params to setup the city's territory and population
		local iSizeIndex = iOverrideSizeParam or (Round(iCityIndex / iCitySizeDivisor) + 1);
		local pCitySetupParams = m_CitySetupParams[iSizeIndex] or { MinImproves = 3, MaxImproves = 3 };
		
		pCityPlots = pCity:GetOwnedPlots();
		for _, pPlot : object in ipairs(pCityPlots) do
			
			-- plot can have Farm			
			if (ImprovementBuilder.CanHaveImprovement(pPlot, m_eFarmImprovement, NO_TEAM)) then
				table.insert(pFarmPlots, pPlot);
			end

			-- plot can have Lumber Mill
			if (ImprovementBuilder.CanHaveImprovement(pPlot, m_eLumberMillImprovement, NO_TEAM)) then
				table.insert(pLumberMillPlots, pPlot);
			end

			-- plot has an improvable resource
			local ePlotResource = pPlot:GetResourceType();
			if (ePlotResource >= 0) then
				for eResource, eImprovement in pairs(m_ValidResourceImprovementMap) do
					if (ePlotResource == eResource and ImprovementBuilder.CanHaveImprovement(pPlot, eImprovement, NO_TEAM)) then
						table.insert(pResourcePlots, pPlot);
					end
				end
			end
		end

		-- Improve a random number of resource-ful plots first
		local iResourceNum : number = RandRange(pCitySetupParams.MinImproves, pCitySetupParams.MaxImproves);
		local iResourceActual : number = 0;
		pResourcePlots = ShuffleTable(pResourcePlots);
		for i = 1, iResourceNum do
			if (#pResourcePlots > 0) then
				local pPlot : object = table.remove(pResourcePlots, 1);
				local eResource = pPlot:GetResourceType();
				local eImprovementType = m_ValidResourceImprovementMap[eResource];
				if (eImprovementType >= 0) then
					ImprovementBuilder.SetImprovementType(pPlot, eImprovementType, iPlayer);
					iResourceActual = iResourceActual + 1;
				end
			else
				break;
			end
		end

		-- Improve a random number of farm plots second, less the number of resource plots improved above
		local iFarmNum : number = RandRange(pCitySetupParams.MinImproves, pCitySetupParams.MaxImproves);
		iFarmNum = math.max(iFarmNum - iResourceActual, 1);
		pFarmPlots = ShuffleTable(pFarmPlots);
		for i = 1, iFarmNum do
			if (#pFarmPlots > 0) then
				local pPlot : object = table.remove(pFarmPlots, 1);
				ImprovementBuilder.SetImprovementType(pPlot, m_eFarmImprovement, iPlayer);
			else
				break;
			end
		end

		-- Improve 0-1 lumber mill plots
		local iLumberMillNum : number = RandRange(0, 1);
		pLumberMillPlots = ShuffleTable(pLumberMillPlots);
		for i = 1, iLumberMillNum do
			if (#pLumberMillPlots > 0) then
				local pPlot : object = table.remove(pLumberMillPlots, 1);
				ImprovementBuilder.SetImprovementType(pPlot, m_eLumberMillImprovement, iPlayer);
			else
				break;
			end
		end

		-- Fill city almost to max housing
		local iDesiredPop = pCity:GetGrowth():GetHousing() - 1;
		pCity:ChangePopulation(iDesiredPop - pCity:GetPopulation());

		-- Set all city to religion
		local pCityReligion = pCity:GetReligion();
		if (pCityReligion ~= nil) then
			pCityReligion:SetAllCityToReligion(m_eCatholicismReligion);
		end
	end
end

local m_ValidDistricts = {
	"DISTRICT_CAMPUS",
	"DISTRICT_HOLY_SITE",
	"DISTRICT_COMMERCIAL_HUB",
	"DISTRICT_THEATER",
};

local m_DistrictSpawnRates = { 1, 2, 2, 2, 1 };
-- ===========================================================================
function SpawnRandomDistricts(pPlayer : object)
	if (pPlayer == nil) then
		return;
	end

	local NO_TEAM = -1;

	local pPlayerCities : object = pPlayer:GetCities();
	if (pPlayerCities == nil) then 
		return;
	end
	local pCityPlots = {};	

	for iCityIndex : number, pCity : object in pPlayerCities:Members() do
		
		local tDistrictPlotOptions : table = {};
		
		local tNeighborPlots = Map.GetAdjacentPlots(pCity:GetX(), pCity:GetY());
		for _, pNeighborPlot : object in ipairs(tNeighborPlots) do
			if (not pNeighborPlot:IsWater() and not pNeighborPlot:IsMountain()) then
				table.insert(tDistrictPlotOptions, pNeighborPlot:GetIndex());
			end
		end

		local iRandomSpawnRate : number = m_DistrictSpawnRates[RandRange(1, #m_DistrictSpawnRates)] or 1;
		local iNumDistrictsToPlace = math.min(#tDistrictPlotOptions, iRandomSpawnRate);
		while (iNumDistrictsToPlace > 0) do
			iNumDistrictsToPlace = iNumDistrictsToPlace - 1;

			local iRandomPlotIndex : number = tDistrictPlotOptions[RandRange(1, #tDistrictPlotOptions)];
			local sRandomDistrictType : string = m_ValidDistricts[RandRange(1, #m_ValidDistricts)];
			local eDistrict = GameInfo.Districts[sRandomDistrictType].Index;

			WorldBuilder.CityManager():CreateDistrict(pCity, eDistrict, 100, iRandomPlotIndex);
		end
	end
end

-- ===========================================================================
-- Plot Inspection
-- ===========================================================================
function IsPlotRural(pPlot : object)
	local eImprovementType : number = pPlot:GetImprovementType();
	if (eImprovementType == m_eFarmImprovement or
		eImprovementType == m_ePastureImprovement) 
	then
		return true;
	end

	return false;
end

-- ===========================================================================
function IsPlotPort(pPlot : object)
	local eDistrictType : number = pPlot:GetDistrictType();
	if (eDistrictType == GameInfo.Districts["DISTRICT_HARBOR"].Index) then
		return true;
	end

	return false;
end
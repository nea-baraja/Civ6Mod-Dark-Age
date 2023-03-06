include "MapEnums"
include "SupportFunctions"
local m_BarbData = GameInfo.GoodyHutSubTypes["BARB_GOODIES"].Index;
local m_BarbEvents = {};


function OnBarbHutTriggered(iPlayerID :number, iUnitID :number, goodyHutType :number)
	if goodyHutType ~= m_BarbData then return; end
	m_BarbEvents['EVENT_BARB_TRIBE_UNITE'].Activate(iPlayerID, iUnitID);
end

function OnBarbEventPopupChoice(ePlayer : number, params : table)
	local iResponseIndex : number = params.ResponseIndex or -1;
	if string.find(params.EventKey, 'EVENT_BARB_') == nil then
		return;
	end

	if (iResponseIndex < 0) then
		return;
	end
	local pEventData : table = m_BarbEvents[params.EventKey];
	-- Determine if A or B was chosen
	local pCallback = nil;
	if (iResponseIndex == 0 ) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice A");
		pCallbackFunc = pEventData.ACallback;
	elseif (iResponseIndex == 1) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice B");
		pCallbackFunc = pEventData.BCallback;
	elseif (iResponseIndex == 2) then
		print("OnEventPopupResponse: " .. params.EventKey .. " handling Choice C");
		pCallbackFunc = pEventData.CCallback;
	end

	-- Fire callback
	if (pCallbackFunc ~= nil) then
		pCallbackFunc(params);
	end	
end


GameEvents.UnitTriggerGoodyHut.Add( OnBarbHutTriggered );
GameEvents.EventPopupChoice.Add( OnBarbEventPopupChoice );	


m_BarbEvents['EVENT_BARB_TRIBE_UNITE'] = {};
m_BarbEvents['EVENT_BARB_TRIBE_UNITE'].EventKey = 'EVENT_BARB_TRIBE_UNITE'
m_BarbEvents['EVENT_BARB_TRIBE_UNITE'].Activate = function(iPlayerID :number, iUnitID :number)
	local pPlayer = Players[iPlayerID];
	if pPlayer:GetProperty('PROP_GOVERNMENT_TIER_0') ~= 'GOVERNMENT_TRIBE_UNITY' then
		return;
	end
	local sEventKey = 'EVENT_BARB_TRIBE_UNITE'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local unitX, unitY = pUnit:GetX(), pUnit:GetY();
	local pBarb = Players[63];  -- Barbarian Player
	local pBarbUnits = pBarb:GetUnits();
	local iConversionCount = 0;
	for ii, pBarbUnit in pBarbUnits:Members() do
		local barbX, barbY = pBarbUnit:GetX(), pBarbUnit:GetY();
		local iDistance = Map.GetPlotDistance(unitX, unitY, barbX, barbY);
		local iCombat = GameInfo.Units[pBarbUnit:GetType()].Combat;
		if iDistance <= 5 and iCombat > 0 then
			iConversionCount = iConversionCount + 1;
		end
	end
	local pCulture = pPlayer:GetCulture();
	local bStateLabor = pCulture:HasCivic(GameInfo.Civics['CIVIC_STATE_WORKFORCE'].Index);
	local bEarlyEmpire = pCulture:HasCivic(GameInfo.Civics['CIVIC_EARLY_EMPIRE'].Index);
	local pCity = FindClosestCity(iPlayerID, unitX, unitY);
	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	pPlayer:SetProperty('EVENT_BARB_TRIBE_UNITE',SavedData);
	--Prepare UI
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_BARB_TRIBE_UNITE_GET_UNITS", iConversionCount)};
	unlockA.EffectIcons = {{"Unit"}};
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_BARB_TRIBE_UNITE_GET_BUILDER", iConversionCount, math.ceil(iConversionCount / 3))};
	unlockB.EffectIcons = {{"Charges"}};
	unlockB.Disabled = not bStateLabor;
	unlockC = {};
	unlockC.Effects = {Locale.Lookup("LOC_EVENT_BARB_TRIBE_UNITE_GET_POP", iConversionCount, pCity:GetName())};
	unlockC.EffectIcons = {{"Citizen"}};
	unlockC.Disabled = not bEarlyEmpire;

	if unlockB.Disabled then  
		unlockB.DisabledReasons = {Locale.Lookup('LOC_EVENT_BARB_TRIBE_UNITE_NO_STATE_LABOR')};
	end
	if unlockC.Disabled then  
		unlockC.DisabledReasons = {Locale.Lookup('LOC_EVENT_BARB_TRIBE_UNITE_NO_EARLY_EMPIRE')};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceCText="LOC_"..sEventKey.."_CHOICE_C",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB,ChoiceCUnlocks=unlockC});
end

m_BarbEvents['EVENT_BARB_TRIBE_UNITE'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	local unitX, unitY = pUnit:GetX(), pUnit:GetY();
	local pBarb = Players[63];  -- Barbarian Player
	local pBarbUnits = pBarb:GetUnits();
	for ii, pBarbUnit in pBarbUnits:Members() do
		local barbX, barbY = pBarbUnit:GetX(), pBarbUnit:GetY();
		local iDistance = Map.GetPlotDistance(unitX, unitY, barbX, barbY);
		local iCombat = GameInfo.Units[pBarbUnit:GetType()].Combat;
		if iDistance <= 5 and iCombat > 0 then
			local sUnitType = GameInfo.Units[pBarbUnit:GetType()].UnitType;
			UnitManager.Kill(pBarbUnit, false);								
			UnitManager.InitUnit(SavedData.PlayerID, sUnitType, barbX, barbY);
		end
	end
end

m_BarbEvents['EVENT_BARB_TRIBE_UNITE'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	local unitX, unitY = pUnit:GetX(), pUnit:GetY();
	local pBarb = Players[63];  -- Barbarian Player
	local pBarbUnits = pBarb:GetUnits();
	local iConversionCount = 0;
	for ii, pBarbUnit in pBarbUnits:Members() do
		local barbX, barbY = pBarbUnit:GetX(), pBarbUnit:GetY();
		local iDistance = Map.GetPlotDistance(unitX, unitY, barbX, barbY);
		local iCombat = GameInfo.Units[pBarbUnit:GetType()].Combat;
		if iDistance <= 5 and iCombat > 0 then
			local sUnitType = GameInfo.Units[pBarbUnit:GetType()].UnitType;
			UnitManager.Kill(pBarbUnit, false);		
			iConversionCount = iConversionCount + 1;						
			--UnitManager.InitUnit(SavedData.PlayerID, sUnitType, unitX, unitY);
		end
	end
	local iBulderCount = math.ceil(iConversionCount / 3);
	for i = 1, iBulderCount do
		UnitManager.InitUnit(SavedData.PlayerID, 'UNIT_BUILDER', unitX, unitY);
	end
end


m_BarbEvents['EVENT_BARB_TRIBE_UNITE'].CCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	local unitX, unitY = pUnit:GetX(), pUnit:GetY();
	local pBarb = Players[63];  -- Barbarian Player
	local pBarbUnits = pBarb:GetUnits();
	local iConversionCount = 0;
	for ii, pBarbUnit in pBarbUnits:Members() do
		local barbX, barbY = pBarbUnit:GetX(), pBarbUnit:GetY();
		local iDistance = Map.GetPlotDistance(unitX, unitY, barbX, barbY);
		local iCombat = GameInfo.Units[pBarbUnit:GetType()].Combat;
		if iDistance <= 5 and iCombat > 0 then
			local sUnitType = GameInfo.Units[pBarbUnit:GetType()].UnitType;
			UnitManager.Kill(pBarbUnit, false);		
			iConversionCount = iConversionCount + 1;						
			--UnitManager.InitUnit(SavedData.PlayerID, sUnitType, unitX, unitY);
		end
	end
	local pCity = FindClosestCity(SavedData.PlayerID, unitX, unitY);
	pCity:ChangePopulation(iConversionCount);
end



function FindClosestCity(player, iStartX, iStartY)

    local pCity = nullptr;
    local iShortestDistance = 10000;
	local pPlayer = Players[player];
   
	local pPlayerCities:table = pPlayer:GetCities();
	for i, pLoopCity in pPlayerCities:Members() do
		local iDistance = Map.GetPlotDistance(iStartX, iStartY, pLoopCity:GetX(), pLoopCity:GetY());
		if (iDistance < iShortestDistance) then
			pCity = pLoopCity;
			iShortestDistance = iDistance;
		end
	end

	if (pCity == nullptr) then
		print ("No closest city found of player " .. tostring(player) .. " from " .. tostring(iStartX) .. ", " .. tostring(iStartX));
	end
   
    return pCity;
end

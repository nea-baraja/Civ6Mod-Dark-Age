include "MapEnums"
include "SupportFunctions"

local m_GoodyHutEventDefs:table = {};	
local m_GoodyHutEventIndex:table = {};
local m_EventGoodyData = GameInfo.GoodyHutSubTypes["GOODYHUT_EVENT"].Index;


-- ===========================================================================
--   Event Triggers Function
-- ===========================================================================
function OnGoodyHutTriggered(iPlayerID :number, iUnitID :number, goodyHutType :number)
	if goodyHutType ~= m_EventGoodyData then 
		print(goodyHutType);
		return; 
	end
	local pUnit :object = UnitManager.GetUnit(iPlayerID, iUnitID);
	if (pUnit == nil) then
		return;
	end
	local randomEvent = PickEvent();
	print(randomEvent);
	m_GoodyHutEventDefs[randomEvent].Activate(iPlayerID, iUnitID);
end

function OnGoodyEventPopupChoice(ePlayer : number, params : table)
	if string.find(params.EventKey, 'EVENT_GOODY_') == nil then
		return;
	end
	local pEventData : table = m_GoodyHutEventDefs[params.EventKey];
	if (pEventData == nil) then
		print("OnEventPopupChoice: " .. params.EventKey .. "entry not found in NEAEventDefinitions");
		return;
	end
	local iResponseIndex : number = params.ResponseIndex or -1;
	if (iResponseIndex < 0) then
		return;
	end
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

function PickEvent()
	local randomVal = TerrainBuilder.GetRandomNumber(#m_GoodyHutEventIndex, 'GoodyHutEvent') + 1;
	if m_GoodyHutEventDefs[m_GoodyHutEventIndex[randomVal]].Ready == nil or m_GoodyHutEventDefs[m_GoodyHutEventIndex[randomVal]].Ready() then
		return m_GoodyHutEventIndex[randomVal];
	end
	return PickEvent();
end


GameEvents.UnitTriggerGoodyHut.Add( OnGoodyHutTriggered );
GameEvents.EventPopupChoice.Add( OnGoodyEventPopupChoice );	


-- ===========================================================================
--	 Utility Functions
-- ===========================================================================
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


function length(t)
    local res=0
    for k,v in pairs(t) do
        res=res+1
    end
    return res
end

function readRandomValueInTable(Table)
    local tmpKeyT = {};
    local n=0;
    for k, v in pairs(Table) do
    	n = n + 1;
        tmpKeyT[n] = DeepCopy(v);
    end
	local randomVal = TerrainBuilder.GetRandomNumber(n, 'GoodyHutEvent');    
	return tmpKeyT[randomVal + 1]
end




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

-- ===========================================================================
--	 Event Functions
-- ===========================================================================

for row in GameInfo.EventPopupData() do
	if string.find(row.Type, 'EVENT_GOODY_') ~= nil then
		m_GoodyHutEventDefs[row.Type] = {};
	end
end

-- 人祭
m_GoodyHutEventDefs['EVENT_GOODY_HUMAN_SACRIFICE'].EventKey = 'EVENT_GOODY_HUMAN_SACRIFICE'
m_GoodyHutEventDefs['EVENT_GOODY_HUMAN_SACRIFICE'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_HUMAN_SACRIFICE'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local pCity = FindClosestCity(iPlayerID, pUnit:GetX(), pUnit:GetY());
	local pPlayer = Players[iPlayerID];
	local pPantheon = pPlayer:GetReligion():GetPantheon();
	local smallFaith, LargeFaith = 0, 0;
	if (pPantheon == nil or pPantheon < 0) then  
		smallFaith, LargeFaith = 5, 20;
	else
		smallFaith, LargeFaith = 20, 80;
	end
	local InvalidPop = false;
	if pCity:GetPopulation() == 1 then 
		InvalidPop = true;
	end
	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	SavedData.CityID = pCity:GetID();
	SavedData.smallFaith = smallFaith;
	SavedData.LargeFaith = LargeFaith;
	pPlayer:SetProperty('EVENT_GOODY_HUMAN_SACRIFICE',SavedData);
	--Prepare UI
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_HUMAN_SACRIFICE_GAIN_FAITH",smallFaith)};
	unlockA.EffectIcons = {{"Faith"}};
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_HUMAN_SACRIFICE_GAIN_FAITH",LargeFaith), Locale.Lookup('LOC_EVENT_GOODY_HUMAN_SACRIFICE_LOSE_POP',pCity:GetName())};
	unlockB.EffectIcons = {{"Faith"}, {"Citizen", "ICON_EVENT_BAD"}};
	unlockB.Disabled = InvalidPop;
	if unlockB.Disabled then  
		unlockB.DisabledReasons = {Locale.Lookup('LOC_EVENT_GOODY_HUMAN_SACRIFICE_NO_POP_TO_LOSE',pCity:GetName())};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", { ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_GoodyHutEventDefs['EVENT_GOODY_HUMAN_SACRIFICE'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	if (pPlayer == nil) then
		return false;
	end
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	if(SavedData ~= nil) then
	    pPlayer:GetReligion():ChangeFaithBalance(SavedData.smallFaith)
	end
end

m_GoodyHutEventDefs['EVENT_GOODY_HUMAN_SACRIFICE'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	if (pPlayer == nil) then
		return false;
	end
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	if(SavedData ~= nil) then
	    pPlayer:GetReligion():ChangeFaithBalance(SavedData.LargeFaith)
	    local pCity = CityManager.GetCity(SavedData.PlayerID, SavedData.CityID);
	    pCity:ChangePopulation(-1);
	end
end

--制图专家
m_GoodyHutEventDefs['EVENT_GOODY_CARTOGRAPHER'].EventKey = 'EVENT_GOODY_CARTOGRAPHER'
m_GoodyHutEventDefs['EVENT_GOODY_CARTOGRAPHER'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_CARTOGRAPHER'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local sUnitName = pUnit:GetName()
	local pPlayer = Players[iPlayerID];
	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	pPlayer:SetProperty('EVENT_GOODY_CARTOGRAPHER',SavedData);
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_GOODY_CARTOGRAPHER_EFFECT", sUnitName);  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_CARTOGRAPHER_SHOW_MAP")};
	unlockA.EffectIcons = {{"Terrain"}};
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_CARTOGRAPHER_HORIZON", sUnitName)};
	unlockB.EffectIcons = {{"Promotion"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", {EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_GoodyHutEventDefs['EVENT_GOODY_CARTOGRAPHER'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	local tPlots = GetValidPlotsInRadiusR(pUnit:GetX(), pUnit:GetY(), 6);
	local pVis = PlayersVisibility[kParams.ForPlayer]
	for k, pPickPlot in ipairs(tPlots) do		
		pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), 1);
		pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), -1);
	end
end

m_GoodyHutEventDefs['EVENT_GOODY_CARTOGRAPHER'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local sAbility = 'ABILTY_EVENT_GOODY_CARTOGRAPHER'
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	local pUnitAbility = pUnit:GetAbility();
    local oldCount = pUnitAbility:GetAbilityCount(sAbility);
    pUnitAbility:ChangeAbilityCount(sAbility, 1 - oldCount);
end


--神奇的草药
m_GoodyHutEventDefs['EVENT_GOODY_MAGIC_HERB'].EventKey = 'EVENT_GOODY_MAGIC_HERB'
m_GoodyHutEventDefs['EVENT_GOODY_MAGIC_HERB'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_MAGIC_HERB'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local sUnitName = pUnit:GetName()
	local pPlayer = Players[iPlayerID];
	local iUnitProduction = GameInfo.Units[pUnit:GetType()].Cost;
	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	SavedData.UnitProduction = iUnitProduction;
	pPlayer:SetProperty('EVENT_GOODY_MAGIC_HERB',SavedData);
	--Prepare UI
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_MAGIC_HERB_KILL_UNIT", sUnitName), Locale.Lookup("LOC_EVENT_GOODY_MAGIC_HERB_FAITH", iUnitProduction)};
	unlockA.EffectIcons = {{"Damaged", "ICON_EVENT_BAD"}, {"Faith"}};
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_MAGIC_HERB_HEAL_UNIT", sUnitName), Locale.Lookup("LOC_EVENT_GOODY_MAGIC_HERB_MOVEMENT", sUnitName)};
	unlockB.EffectIcons = {{"Damaged"}, {"Movement"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", { ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_GoodyHutEventDefs['EVENT_GOODY_MAGIC_HERB'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	UnitManager.Kill(pUnit, false);
	pPlayer:GetReligion():ChangeFaithBalance(SavedData.UnitProduction);
end

m_GoodyHutEventDefs['EVENT_GOODY_MAGIC_HERB'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	pUnit:SetDamage(0);
	UnitManager.ChangeMovesRemaining(pUnit, 5);
end


-- 饥荒
m_GoodyHutEventDefs['EVENT_GOODY_FAMINE'].EventKey = 'EVENT_GOODY_FAMINE'
m_GoodyHutEventDefs['EVENT_GOODY_FAMINE'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_FAMINE'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local pCity = FindClosestCity(iPlayerID, pUnit:GetX(), pUnit:GetY());
	local pPlayer = Players[iPlayerID];
	local sUnitName = pUnit:GetName()

	local InvalidGold = false;
	if pPlayer:GetTreasury():GetGoldBalance() < 100 then 
		InvalidGold = true;
	end
	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	SavedData.CityID = pCity:GetID();
	pPlayer:SetProperty('EVENT_GOODY_FAMINE',SavedData);
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_GOODY_FAMINE_EFFECT", sUnitName, pCity:GetName());  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_FAMINE_GAIN_1_POPULATION",pCity:GetName())};
	unlockA.EffectIcons = {{"Citizen"}};
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_FAMINE_GAIN_2_POPULATION",pCity:GetName()),Locale.Lookup('LOC_EVENT_GOODY_FAMINE_PAY_GOLD')};
	unlockB.EffectIcons = {{"Citizen"}, {"Gold", "ICON_EVENT_BAD"}};
	unlockB.Disabled = InvalidGold;
	if unlockB.Disabled then  
		unlockB.DisabledReasons = {Locale.Lookup('LOC_EVENT_GOODY_FAMINE_NO_GOLD_TO_LOSE',pCity:GetName())};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", { EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText=Locale.Lookup("LOC_"..sEventKey.."_CHOICE_B",pCity:GetName()),ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_GoodyHutEventDefs['EVENT_GOODY_FAMINE'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	if(SavedData ~= nil) then
	    local pCity = CityManager.GetCity(SavedData.PlayerID, SavedData.CityID);
	    pCity:ChangePopulation(1);
	end
end

m_GoodyHutEventDefs['EVENT_GOODY_FAMINE'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	pPlayer:GetTreasury():ChangeGoldBalance(-100);
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	if(SavedData ~= nil) then
	    local pCity = CityManager.GetCity(SavedData.PlayerID, SavedData.CityID);
	    pCity:ChangePopulation(2);
	end
end



--古老工事
m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION'].EventKey = 'EVENT_GOODY_ANCIENT_FORTIFICATION'
m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_ANCIENT_FORTIFICATION'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local sUnitName = pUnit:GetName();
	local iCombat = GameInfo.Units[pUnit:GetType()].Combat;
	local pPlayer = Players[iPlayerID];

	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	pPlayer:SetProperty('EVENT_GOODY_ANCIENT_FORTIFICATION',SavedData);
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_EFFECT", sUnitName);  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_GOOD_END"), Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_BAD_END", sUnitName)};
	unlockA.EffectIcons = {{"New"}, {"New", "ICON_EVENT_BAD"}};
	unlockA.Disabled = (iCombat == 0);
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_STOP")};
	unlockB.EffectIcons = {{"Gold"}};
	if unlockA.Disabled then  
		unlockA.DisabledReasons = {Locale.Lookup('LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_NO_STRENNGTH')};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", { EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	local oldDamage = pUnit:GetDamage();
	local randomVal = TerrainBuilder.GetRandomNumber(10, 'Ancient Fortification');    
	if randomVal > 3 then
		pUnit:SetDamage(oldDamage + 25);
		m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_2'].Activate(SavedData.PlayerID, SavedData.UnitID);
	else
		m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_1'].Activate(SavedData.PlayerID, SavedData.UnitID);
	end
end

m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	pPlayer:GetTreasury():ChangeGoldBalance(25);
end

--古老工事 子事件 攻克工事
m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_1'].Ready = function() return false end;
m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_1'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_ANCIENT_FORTIFICATION_1'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local sUnitName = pUnit:GetName()
	local pPlayer = Players[iPlayerID];
	--No choice, no need for saving data
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_1_EFFECT", sUnitName);  --special effect
	unlocks = {};
	unlocks.Effects = {Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_1_GOLD"), Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_1_PROMOTION", sUnitName)};
	unlocks.EffectIcons = {{"Gold"}, {"Promotion"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", { EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ContinueText ="LOC_"..sEventKey.."_CONTINUE",Unlocks=unlocks});
	--effects
	pPlayer:GetTreasury():ChangeGoldBalance(100);
	local iXP = pUnit:GetExperience():GetExperienceForNextLevel() - pUnit:GetExperience():GetExperiencePoints();
	pUnit:GetExperience():ChangeExperience(iXP);
end



--古老工事 子事件 没有进展
m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_2'].Ready = function() return false end;
m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_2'].EventKey = 'EVENT_GOODY_ANCIENT_FORTIFICATION_2'
m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_2'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_ANCIENT_FORTIFICATION_2'
	--Calculate effects
	local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);
	local sUnitName = pUnit:GetName();
	local iCombat = GameInfo.Units[pUnit:GetType()].Combat;
	local pPlayer = Players[iPlayerID];
	local bDead = pUnit:IsDead();

	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	pPlayer:SetProperty('EVENT_GOODY_ANCIENT_FORTIFICATION_2',SavedData);
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_2_EFFECT", sUnitName);  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_2_GOOD_END"), Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_2_BAD_END", sUnitName)};
	unlockA.EffectIcons = {{"New"}, {"New", "ICON_EVENT_BAD"}};
	unlockA.Disabled = bDead;
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_STOP")};
	unlockB.EffectIcons = {{"Gold"}};
	if unlockA.Disabled then  
		unlockA.DisabledReasons = {Locale.Lookup('LOC_EVENT_GOODY_ANCIENT_FORTIFICATION_2_UNIT_KILLED', sUnitName)};
	end
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", { EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_2'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	local oldDamage = pUnit:GetDamage();
	local randomVal = TerrainBuilder.GetRandomNumber(10, 'Ancient Fortification');    
	if randomVal > 3 then
		pUnit:SetDamage(oldDamage + 25);
		m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_2'].Activate(SavedData.PlayerID, SavedData.UnitID);
	else
		m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_1'].Activate(SavedData.PlayerID, SavedData.UnitID);
	end
end

m_GoodyHutEventDefs['EVENT_GOODY_ANCIENT_FORTIFICATION_2'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	local pUnit = UnitManager.GetUnit(SavedData.PlayerID, SavedData.UnitID);
	pPlayer:GetTreasury():ChangeGoldBalance(25);
end


-- 壁画艺术
--m_GoodyHutEventDefs['EVENT_GOODY_MURAL'].Weight=20;
m_GoodyHutEventDefs['EVENT_GOODY_MURAL'].EventKey = 'EVENT_GOODY_MURAL'
m_GoodyHutEventDefs['EVENT_GOODY_MURAL'].Activate = function(iPlayerID :number, iUnitID :number)
	local sEventKey = 'EVENT_GOODY_MURAL'
	--Calculate effects
	local pPlayer = Players[iPlayerID];
	local pCities:table = pPlayer:GetCities();
	local pCapital = pCities:GetCapitalCity();

	--Save calculation results
	local SavedData = {};
	SavedData.UnitID = iUnitID;
	SavedData.PlayerID = iPlayerID;
	SavedData.CityID = pCapital:GetID();
	pPlayer:SetProperty('EVENT_GOODY_MURAL',SavedData);
	--Prepare UI
	EffectText = Locale.Lookup("LOC_EVENT_GOODY_MURAL_EFFECT", pCapital:GetName());  --special effect
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_MURAL_CULTURE")};
	unlockA.EffectIcons = {{"Culture"}};
	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_MURAL_SCIENCE")};
	unlockB.EffectIcons = {{"Science"}};
	--Call event popup
	ReportingEvents.Send("EVENT_POPUP_REQUEST", { EventEffect = EffectText, ForPlayer = iPlayerID, EventKey = sEventKey, ChoiceAText ="LOC_"..sEventKey.."_CHOICE_A", ChoiceBText="LOC_"..sEventKey.."_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
end

m_GoodyHutEventDefs['EVENT_GOODY_MURAL'].ACallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	if (pPlayer == nil) then
		return false;
	end
	local SavedData = pPlayer:GetProperty(kParams.EventKey);
	if(SavedData ~= nil) then
	    local pCity = CityManager.GetCity(SavedData.PlayerID, SavedData.CityID);
	    pCity:AttachModifierByID("EVENT_GOODY_MURAL_PALACE_CULTURE");
	    pCity:AttachModifierByID("EVENT_GOODY_MURAL_PALACE_CULTURE_MORE");
	end
end

m_GoodyHutEventDefs['EVENT_GOODY_MURAL'].BCallback = function(kParams : table)
	local pPlayer : object = Players[kParams.ForPlayer];
	if (pPlayer == nil) then
		return false;
	end
	pPlayer:AttachModifierByID("EVENT_GOODY_MURAL_PALACE_SCIENCE");
	pPlayer:AttachModifierByID("EVENT_GOODY_MURAL_PALACE_SCIENCE_MORE");
end




local EventId = 0;
for k, v in pairs(m_GoodyHutEventDefs) do
	if v.Weight ~= nil then
		for m = 1, v.Weight, 1 do
			EventId = EventId + 1;
			m_GoodyHutEventIndex[EventId] = k;
		end
	else
		EventId = EventId + 1;
		m_GoodyHutEventIndex[EventId] = k;
	end
end








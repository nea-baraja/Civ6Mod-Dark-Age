
GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;


----CivilizationandLeaderHasTrait
function CivilizationHasTrait(sCiv, sTrait)
	for tRow in GameInfo.CivilizationTraits() do
		if (tRow.CivilizationType == sCiv and tRow.TraitType == sTrait) then
			return true
		end
	end
	return false
end

function LeaderHasTrait(sLeader, sTrait)
	for tRow in GameInfo.LeaderTraits() do
		if (tRow.LeaderType == sLeader and tRow.TraitType == sTrait) then return true end
	end
	return false
end


m_DAUnitCommands = {};
--[[ =======================================================================
	BUILDROAD

	Usable by Builders to Build road.
-- =========================================================================]]
m_DAUnitCommands.BUILDROAD = {};
m_DAUnitCommands.BUILDROAD.Properties = {};

-- UI Data
m_DAUnitCommands.BUILDROAD.EventName		= "DA_BuildRoads";
m_DAUnitCommands.BUILDROAD.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.BUILDROAD.Icon				= "ICON_UNITOPERATION_BUILD_ROUTE";
m_DAUnitCommands.BUILDROAD.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_BUILDROAD_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_BUILDROAD_DESCRIPTION");
m_DAUnitCommands.BUILDROAD.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_BUILDROAD_DISABLED_TT");
m_DAUnitCommands.BUILDROAD.VisibleInUI	= true;


-- ===========================================================================
function m_DAUnitCommands.BUILDROAD.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_BUILDER";
	-- or GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_MILITARY_ENGINEER";
end

-- ===========================================================================
function m_DAUnitCommands.BUILDROAD.IsVisible(pUnit : object)
	local playerID = pUnit:GetOwner();
	local player = Players[playerID];
	local bResearchedWheel = player:GetTechs():HasTech(GameInfo.Technologies['TECH_THE_WHEEL'].Index);
	local iBuildRoad = pUnit:GetProperty('PROP_BUILDROAD_MODE');
	local bBuildRoadEnabled = (iBuildRoad ~= nil and iBuildRoad == 1);
	if bResearchedWheel and not bBuildRoadEnabled then
		return true;
	end
	return false;
end

-- ===========================================================================
function m_DAUnitCommands.BUILDROAD.IsDisabled(pUnit : object)
	if pUnit == nil or pUnit:GetBuildCharges() < 2 then
		return true;
	end
	return false;
end

--[[ =======================================================================
	RAMSES II FAITH BUILD WONDER

	Usable by Builders to Build road.
-- =========================================================================]]
m_DAUnitCommands.FAITHWONDER = {};
m_DAUnitCommands.FAITHWONDER.Properties = {};

-- UI Data
m_DAUnitCommands.FAITHWONDER.EventName		= "DA_FaithBuildWonder";
m_DAUnitCommands.FAITHWONDER.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.FAITHWONDER.Icon				= "ICON_UNITCOMMAND_WONDER_PRODUCTION";
m_DAUnitCommands.FAITHWONDER.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_FAITHWONDER_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_FAITHWONDER_DESCRIPTION");
m_DAUnitCommands.FAITHWONDER.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_FAITHWONDER_DISABLED_TT");
m_DAUnitCommands.FAITHWONDER.VisibleInUI	= true;

-- ===========================================================================
function m_DAUnitCommands.FAITHWONDER.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_BUILDER";
	-- or GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_MILITARY_ENGINEER";
end

-- ===========================================================================
function m_DAUnitCommands.FAITHWONDER.IsVisible(pUnit : object)
	local playerID = pUnit:GetOwner();
	local player = Players[playerID];
	local bRamses = Utils.PlayerHasTrait(playerID, 'TRAIT_LEADER_RAMSES');
	if not bRamses then return false; end
	local iX, iY = pUnit:GetX(), pUnit:GetY();
	local pPlot = Map.GetPlot(iX, iY);
	local iWonder = pPlot:GetWonderType();
		--print(iWonder)
	if iWonder == nil or iWonder == -1 then return false; end
	local sWonder = GameInfo.Buildings[iWonder].BuildingType;
   	local pCity = Cities.GetPlotPurchaseCity(pPlot);
   	local pBuildings = pCity:GetBuildings();
   	if pBuildings:HasBuilding(iWonder) then return false; end
   	local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
   	--print(sCurrent)
   	if not sCurrent or sCurrent ~= sWonder then return false; end
   	return true;
end

-- ===========================================================================
function m_DAUnitCommands.FAITHWONDER.IsDisabled(pUnit : object)
	local playerID = pUnit:GetOwner();
	local player = Players[playerID];
	local iX, iY = pUnit:GetX(), pUnit:GetY();
	local pPlot = Map.GetPlot(iX, iY);
   	local pCity = Cities.GetPlotPurchaseCity(pPlot);
   	local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
   	local iCost = GameInfo.Buildings[sCurrent].Cost;
   	local iProductionProgress = pCity:GetBuildQueue():GetBuildingProgress( GameInfo.Buildings[sCurrent].Index );
   	local iRiverCount = pPlot:GetProperty('PROP_RIVER_COUNT') or 0;
   	local iFaithNeeded = (iCost - iProductionProgress) * 2 / (1 + iRiverCount * 0.1);
   	local iFaithBalance = player:GetReligion():GetFaithBalance();
   	if iFaithBalance < iFaithNeeded then return true; end
   	return false;
end


GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

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



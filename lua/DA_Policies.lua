GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils

local playerPolicies = {}

function RefreshPoliciesForAll()
	local players = Game.GetPlayers{Alive = true};
	for _, player in ipairs(players) do
		local PlayerID = player:GetID()
		RefreshPolicies(PlayerID)
	end
end
Events.TurnBegin.Add(RefreshPoliciesForAll);
Events.LoadScreenClose.Add(RefreshPoliciesForAll);

function RefreshPolicies(ePlayerID:number)
	--print("FUN GetSlottedPolicies", ePlayerID);
	local pPlayer:table = Players[ePlayerID];
	local pPlayerCulture:table = pPlayer:GetCulture();
	local tPolicies:table = {};
	for i = 0, pPlayerCulture:GetNumPolicySlots()-1 do
		local ePolicyID:number = pPlayerCulture:GetSlotPolicy(i);
		print("player",ePlayerID,"slot", i, "has policy", ePolicyID);
		if ePolicyID > -1 then
			table.insert(tPolicies, GameInfo.Policies[ePolicyID].PolicyType);
			print("...slotted", GameInfo.Policies[ePolicyID].PolicyType);
		end
	end
	playerPolicies[ePlayerID] =  {};
	playerPolicies[ePlayerID] = tPolicies;
end

Events.GovernmentPolicyChanged.Add( RefreshPolicies );
Events.GovernmentPolicyObsoleted.Add( RefreshPolicies );









--沿海调查
function PolicyCoastalSurvey(playerID,unitID,x,y)
	local pUnit :object = Players[playerID]:GetUnits():FindID(unitID)
	--print(" unit type"..UnitManager.GetTypeName(pUnit))
	local range = 5
	if (pUnit) then
		for _, policy in pairs(playerPolicies[playerID]) do
			if (policy == 'POLICY_COASTAL_SURVEY') then
				local uDomainType = GameInfo.Units[pUnit:GetType()].Domain
				if (uDomainType == 'DOMAIN_SEA') then
					ShowNeabySurvey(playerID, unitID, x, y, range)
				end
			end
		end
	end
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

function ShowNeabySurvey(playerID, unitID, x, y, range)
	local player = Players[playerID]
	local pVis = PlayersVisibility[playerID]
	local rad = range
	local tPlots = GetValidPlotsInRadiusR(x, y, rad)
	for k, pPickPlot in ipairs(tPlots) do		
		local improvement = pPickPlot:GetImprovementType()
		local improvementData:table = GameInfo.Improvements[improvement]
		if (improvement ~= -1) and ((improvementData.ImprovementType == "IMPROVEMENT_GOODY_HUT") or (improvementData.ImprovementType == "IMPROVEMENT_BARBARIAN_CAMP")) then
			pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), 1);
			pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), -1);
		end
		local districtID = pPickPlot:GetDistrictType()
		if(districtID ~= -1) then
			local districtType = GameInfo.Districts[districtID].DistrictType
			if(DistrictType == 'DISTRICT_CITY_CENTER') then
				pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), 1);
				pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), -1);
			end
		end
 	end
end


Events.UnitMoveComplete.Add(PolicyCoastalSurvey)
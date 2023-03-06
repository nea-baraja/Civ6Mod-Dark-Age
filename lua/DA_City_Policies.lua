include("SupportFunctions");

GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

local bLoadScreenFinished = false;

function EncampmentUnitTrained(playerId, unitId)
	if bLoadScreenFinished == false then return; end
	local pUnit = UnitManager.GetUnit(playerId,	unitId);
	local pPlayer = Players[playerId];
	local sUnitPromotionClass = GameInfo.Units[pUnit:GetType()].PromotionClass;
	local iCombat = GameInfo.Units[pUnit:GetType()].Combat;
	local sDomain = GameInfo.Units[pUnit:GetType()].Domain;	
	if sUnitPromotionClass == nil then return; end
	local pPlot = Map.GetPlot(pUnit:GetX(), pUnit:GetY());
	local pCity = Cities.GetPlotPurchaseCity(pPlot);
	if pCity == nil then return; end
	local pBuildings = pCity:GetBuildings();
	if pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_BARRACK_FARM'].Index) and (sUnitPromotionClass == 'PROMOTION_CLASS_MELEE' or sUnitPromotionClass == 'PROMOTION_CLASS_RANGED' or sUnitPromotionClass == 'PROMOTION_CLASS_ANTI_CAVALRY') then
		if pPlayer:GetResources():GetResourceAmount('RESOURCE_IRON') >= 10 then
			GameEvents.StrategicResourcesChange.Call(playerId, 'RESOURCE_IRON', -10);
			GameEvents.SetAbilityCount.Call(playerId, unitId, 'ABILITY_BARRACK_FARM', 1);
		end
	elseif pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_STABLED_CAMP'].Index) and (sUnitPromotionClass == 'PROMOTION_CLASS_LIGHT_CAVALRY' or sUnitPromotionClass == 'PROMOTION_CLASS_HEAVY_CAVALRY') then
		if pPlayer:GetResources():GetResourceAmount('RESOURCE_HORSES') >= 10 then
			GameEvents.StrategicResourcesChange.Call(playerId, 'RESOURCE_HORSES', -10);
			GameEvents.SetAbilityCount.Call(playerId, unitId, 'ABILITY_STABLED_CAMP', 1);
		end
	elseif pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_BARRACK_WEAPON'].Index) and (iCombat > 0) then
		if pPlayer:GetResources():GetResourceAmount('RESOURCE_IRON') >= 10 then
			GameEvents.StrategicResourcesChange.Call(playerId, 'RESOURCE_IRON', -10);
			GameEvents.SetAbilityCount.Call(playerId, unitId, 'ABILITY_FORGE_WEAPON_STRENGTH', 1);
		end
	elseif pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_STABLED_TRANSPORT'].Index) and (sDomain == 'DOMAIN_LAND') then
		if pPlayer:GetResources():GetResourceAmount('RESOURCE_HORSES') >= 10 then
			GameEvents.StrategicResourcesChange.Call(playerId, 'RESOURCE_HORSES', -10);
			GameEvents.SetAbilityCount.Call(playerId, unitId, 'ABILITY_CARRIAGE_TRANSPORT_MOVEMENT', 1);
		end
	end	
end

function BarrackFarmAfterCombat(attackerPlayerID :number, attackerUnitID :number, defenderPlayerID :number, defenderUnitID :number, attackerDistrictID :number, defenderDistrictID :number)
	if(attackerPlayerID == NO_PLAYER 
		or defenderPlayerID == NO_PLAYER) then
		return;
	end
	local pAttackerPlayer = Players[attackerPlayerID];
	local pAttackingUnit :object = attackerUnitID ~= NO_UNIT and pAttackerPlayer:GetUnits():FindID(attackerUnitID) or nil;
	if(pAttackingUnit ~= nil) then
		GameEvents.SetAbilityCount.Call(attackerPlayerID, attackerUnitID, 'ABILITY_BARRACK_FARM', 0);
		GameEvents.SetAbilityCount.Call(attackerPlayerID, attackerUnitID, 'ABILITY_STABLED_CAMP', 0);
	end
end


function OnLoadScreenClose()
	bLoadScreenFinished = true;
end





Events.UnitAddedToMap.Add(EncampmentUnitTrained);
Events.LoadScreenClose.Add(OnLoadScreenClose)
GameEvents.OnCombatOccurred.Add(BarrackFarmAfterCombat);




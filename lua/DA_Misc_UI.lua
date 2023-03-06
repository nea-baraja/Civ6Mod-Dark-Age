Utils = ExposedMembers.DA.Utils;
GameEvents = ExposedMembers.GameEvents;

GameEvents.GetDistrictCount.Add(function(playerID,	cityID)
	local pCity = CityManager:GetCity(playerID, cityID)
	if pCity == nil then
		return
	end
	local amount = pCity:GetDistricts():GetCount()
	--print(amount)
	GameEvents.UpdateDistrictCount.Call(playerID,	cityID, amount)
end)




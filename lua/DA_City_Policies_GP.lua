
function ManuscriptCollection(UnitOwner, UnitId, GreatPersonType, GreatPersonClass)
	local player = Players[UnitOwner]
	if (player ~= nil and player:IsBarbarian() == false) then
		local unit = player:GetUnits():FindID(UnitId)	
		if player:GetProperty('ACTIVATED'..GreatPersonType) == 1 then
			return
		end
		player:SetProperty('ACTIVATED'..GreatPersonType, 1)
		local unitX, unitY = unit:GetX(), unit:GetY()
    	local unitPlot = Map.GetPlot(unitX, unitY);
    	local pCity = Cities.GetPlotPurchaseCity(unitPlot)

    	if pCity == nil then
    		return
    	end
    	local sGreatPersonClassText = GameInfo.GreatPersonClasses[GreatPersonClass].GreatPersonClassType
    	pCity:AttachModifierByID('DA_MANUSCRIPT_COLLECTION_'..sGreatPersonClassText)
    end
end

GameEvents.OnGreatPersonActivated.Add(ManuscriptCollection)

function ScriptureCollection(playerId, cityId, x, y, purchaseType, objectType)

	if (purchaseType == EventSubTypes.UNIT) and (GameInfo.Units[objectType].TrackReligion == true) then
		local unitPlot = Map.GetPlot(x, y);
    	local pCity = Cities.GetPlotPurchaseCity(unitPlot)
    	if pCity == nil then
    		return
    	end
    	pCity:AttachModifierByID('DA_SCRIPTURE_COLLECTION_FAITH')
    end
end
    

Events.CityMadePurchase.Add(ScriptureCollection)






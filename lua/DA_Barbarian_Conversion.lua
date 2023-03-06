function BarbarianConversion(iX, iY, eOwner)
	if eOwner == 63 then
		local pPlayer = Players[63]  -- Barbarian Player
		local pUnits = pPlayer:GetUnits()
		local unitList = Units.GetUnitsInPlot(iX, iY)
		local pConqueror = -1
		if unitList ~= nil then 
			for i, pUnit in ipairs(unitList) do
				if pUnit:GetOwner() ~= -1 then
					pConqueror = pUnit:GetOwner()
					--print(pConqueror)

				end
			end
		end

		for ii, pUnit in pUnits:Members() do
			local unitX, unitY = pUnit:GetX(), pUnit:GetY()
			local iDistance = Map.GetPlotDistance(unitX, unitY, iX, iY)							
			if ( iDistance <= 5 ) then 
				local pUnitType = GameInfo.Units[pUnit:GetType()].UnitType
				--print(pConqueror)
				if pConqueror ~= -1 then
					UnitManager.Kill(pUnit, false)								
					UnitManager.InitUnit(pConqueror, pUnitType, unitX, unitY)
				end
			end				
		end	
	end		
end
--print('loading good')
--Events.ImprovementRemovedFromMap.Add(BarbarianConversion)
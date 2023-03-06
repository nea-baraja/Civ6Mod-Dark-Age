function OnGreatPersonActivated(unitOwner, unitID)
    local era = Game.GetEras():GetCurrentEra()
    if (era >= 2) then
        return  
    end
    print('yes')
    local m_Building = GameInfo.Buildings["BUILDING_VICTORY_HARMONY_IN_DIVERSTY"].Index
    local unit = UnitManager.GetUnit(unitOwner, unitID);
    if (unit ~= nil) and (unit:GetGreatPerson() ~= nil) and (unit:GetX() < 0) and (unit:GetY() < 0) then
        local PROP_KEY_NUMBER_USED_GREAT_PEOPLE = 'NumberOfUsedGreatPeople'
        -- Check if the owner has "To the Glory of God" belief.
        local player = Players[unitOwner];

        local amount = player:GetProperty(PROP_KEY_NUMBER_USED_GREAT_PEOPLE)
        if amount == nil then
            amount = 0
        end
        amount = amount + 1
        print(amount)
        player:SetProperty(PROP_KEY_NUMBER_USED_GREAT_PEOPLE, amount)
        if amount == 10 then
            local pCapital = player:GetCities():GetCapitalCity()
            local cityID = pCapital:GetID()
            GameEvents.RequestCreateBuilding.Call(unitOwner, cityID, m_Building)
        end
    end
end

Events.UnitGreatPersonActivated.Add(OnGreatPersonActivated)



function DevinInspirationUnlockBelief(iX, iY, buildingID, playerID, cityID, iPercentComplete, iUnknown)
    --print(iX, iY, buildingID, playerID, cityID, iPercentComplete, iUnknown)
    local player = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    local building = GameInfo.Buildings[buildingID]
    -- print(building.BuildingType)
    if player ~= nil and pCity ~= nil and building ~= nil then
        local religions = Game.GetReligion():GetReligions();
        for _, religion in ipairs(religions) do
            print(religion.Founder)
            if (religion.Founder == playerID) then
                for _, beliefIndex in ipairs(religion.Beliefs) do
                    if GameInfo.Beliefs[beliefIndex].BeliefType == "BELIEF_DIVINE_INSPIRATION" then
                        player:AttachModifierByID('DA_ADD_BELIEF')
                        print('add belief')
                    end
                end
            end
        end
    end
end

Events.WonderCompleted.Add(DevinInspirationUnlockBelief)

--[[
            if (pPlayerConfig ~= nil and pPlayerConfig:GetCivilizationTypeName() == RULES.HolyRomanEmpireTypeString) then
                local pPlayer : object = Players[iPlayerID];
                local pPlayerReligion : object = pPlayer:GetReligion();
            
                -- Set holy city to Rome player's first city
                for _,pCity in pPlayer:GetCities():Members() do
                    pPlayerReligion:SetHolyCity(pCity);
                    break;
                end

                local pGameReligion = Game.GetReligion();
                if (pGameReligion ~= nil) then
                    pGameReligion:FoundReligion(iPlayerID, m_eCatholicismReligion);
                    pGameReligion:AddBelief(iPlayerID, GameInfo.Beliefs["BELIEF_CATHEDRAL"].Index);
                end
            end

        end]]
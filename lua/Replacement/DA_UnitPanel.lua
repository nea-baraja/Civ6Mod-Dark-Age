-- =================================================================================
-- Import base file
-- =================================================================================
local files = {
    "UnitPanel_Expansion2.lua",
    "UnitPanel_Expansion1.lua",
    "UnitPanel.lua",
}

for _, file in ipairs(files) do
    include(file)
    if Initialize then
        print("DA Loading " .. file .. " as base file");
        break
    end
end

include("DA_UnitCommandDefs");

Utils = ExposedMembers.DA.Utils;
GameEvents = ExposedMembers.GameEvents;

-- =================================================================================
-- Cache base functions
-- =================================================================================
local BASE_BuildActionModHook = BuildActionModHook;
local BASE_LateInitialize = LateInitialize;
local BASE_OnUnitActionClicked = OnUnitActionClicked;
local BASE_AddActionButton = AddActionButton;
local BASE_OnUnitActionClicked_FoundCity = OnUnitActionClicked_FoundCity;
--local BASE_GetUnitActionsTable = GetUnitActionsTable;

local m_ShouldUpdateBestImprovement = false;
-- ===========================================================================
--  REWRITE BASE FUNCTIONS
-- ===========================================================================

function BASE_GetUnitActionsTable( pUnit )

    -- Build action table; holds sub-tables of commands & operations based on UI categories set in DB.
    -- Also defines order actions show in panel.
    local actionsTable  = {
        ATTACK          = {},
        BUILD           = {},
        GAMEMODIFY      = {},
        MOVE            = {},
        OFFENSIVESPY    = {},
        INPLACE         = {},
        SECONDARY       = {},
        SPECIFIC        = {},
        displayOrder = {
            primaryArea = {"ATTACK","OFFENSIVESPY","SPECIFIC","MOVE","INPLACE","GAMEMODIFY"},   -- How they appear in the UI
            secondaryArea = {"SECONDARY"}
        }       
    };

    local bestValidImprovement:number  = -1;    -- To recommend to player.
  
    if pUnit == nil then
        UI.DataError("NIL unit when attempting to get action table.");
        return;
    end

    local unitType :string = GameInfo.Units[pUnit:GetUnitType()].UnitType;

    for commandRow in GameInfo.UnitCommands() do
        if ( commandRow.VisibleInUI ) then
            local actionHash    :number     = commandRow.Hash;
            local isDisabled    :boolean    = IsDisabledByTutorial(unitType, actionHash ); 

            if (actionHash == UnitCommandTypes.MOVE_JUMP) then
                local foo = 0;
            end

            if (actionHash == UnitCommandTypes.ENTER_FORMATION) then
                --Check if there are any units in the same tile that this unit can create a formation with
                --Call CanStartCommand asking for results
                local bCanStart, tResults = UnitManager.CanStartCommand( pUnit, actionHash, nil, true);
                if (bCanStart and tResults) then
                    if (tResults[UnitCommandResults.UNITS] ~= nil and #tResults[UnitCommandResults.UNITS] ~= 0) then
                        local tUnits = tResults[UnitCommandResults.UNITS];
                        for i, unit in ipairs(tUnits) do
                            local pUnitInstance = Players[unit.player]:GetUnits():FindID(unit.id);
                            if (pUnitInstance ~= nil) then

                                local toolTipString :string     = Locale.Lookup(commandRow.Description, GameInfo.Units[pUnitInstance:GetUnitType()].Name);
                                local callback      :ifunction  = function() OnUnitActionClicked_EnterFormation(pUnitInstance) end                              

                                AddActionToTable( actionsTable, commandRow, isDisabled, toolTipString, actionHash, callback );
                            end
                        end
                    end
                end
            elseif (actionHash == UnitCommandTypes.PROMOTE) then
                --Call CanStartCommand asking for a list of possible promotions for that unit
                local bCanStart, tResults = UnitManager.CanStartCommand( pUnit, actionHash, true, true);
                if (bCanStart and tResults) then
                    if (tResults[UnitCommandResults.PROMOTIONS] ~= nil and #tResults[UnitCommandResults.PROMOTIONS] ~= 0) then
                        local tPromotions       = tResults[UnitCommandResults.PROMOTIONS];                      
                        local toolTipString     = Locale.Lookup(commandRow.Description);
                        local callback          = function() ShowPromotionsList(tPromotions); end

                        AddActionToTable( actionsTable, commandRow, isDisabled, toolTipString, actionHash, callback );
                    end
                end
            elseif (actionHash == UnitCommandTypes.NAME_UNIT) then
                local bCanStart = UnitManager.CanStartCommand( pUnit, UnitCommandTypes.NAME_UNIT, true) and GameCapabilities.HasCapability("CAPABILITY_RENAME");
                if (bCanStart) then         
                    local toolTipString = Locale.Lookup(commandRow.Description);
                    AddActionToTable( actionsTable, commandRow, isDisabled, toolTipString, actionHash, OnNameUnit );
                end
            elseif (actionHash == UnitCommandTypes.DELETE) then             
                local bCanStart = UnitManager.CanStartCommand( pUnit, UnitCommandTypes.DELETE, true);
                if (bCanStart) then
                    local toolTipString = Locale.Lookup(commandRow.Description);
                    AddActionToTable( actionsTable, commandRow, isDisabled, toolTipString, actionHash, OnPromptToDeleteUnit );
                end
            elseif (actionHash == UnitCommandTypes.CANCEL and GameInfo.Units[unitType].Spy) then
                -- Route the cancel action for spies to the espionage popup for cancelling a mission
                local bCanStart = UnitManager.CanStartCommand( pUnit, actionHash, true);
                if (bCanStart) then
                    local bCanStartNow, tResults = UnitManager.CanStartCommand( pUnit, actionHash, false, true);
                    AddActionToTable( actionsTable, commandRow, isDisabled, Locale.Lookup("LOC_UNITPANEL_ESPIONAGE_CANCEL_MISSION"), actionHash, OnUnitActionClicked_CancelSpyMission, UnitCommandTypes.TYPE, actionHash  );
                end 
            else
                -- The UI check of an operation is a loose check where it only fails if the unit could never do the command.
                local bCanStart = UnitManager.CanStartCommand( pUnit, actionHash, true);
                if (bCanStart) then
                    -- Check again if the operation can occur, this time for real.
                    local bCanStartNow, tResults = UnitManager.CanStartCommand( pUnit, actionHash, false, true);
                    local bDisabled = not bCanStartNow;
                    local toolTipString:string;

                    if (actionHash == UnitCommandTypes.UPGRADE) then
                        -- if it's a unit upgrade action, add the unit it will upgrade to in the tooltip as well as the upgrade cost
                        if (tResults ~= nil) then
                            if (tResults[UnitCommandResults.UNIT_TYPE] ~= nil) then
                                local upgradeUnitName = GameInfo.Units[tResults[UnitCommandResults.UNIT_TYPE]].Name;
                                toolTipString = Locale.Lookup(upgradeUnitName);
                                local upgradeCost = pUnit:GetUpgradeCost();
                                if (upgradeCost ~= nil) then
                                    toolTipString = Locale.Lookup("LOC_UNITOPERATION_UPGRADE_INFO", upgradeUnitName, upgradeCost);
                                end
                                toolTipString = toolTipString .. AddUpgradeResourceCost(pUnit);
                            end
                        end
                    elseif (actionHash == UnitCommandTypes.FORM_CORPS) then
                        if (GameInfo.Units[unitType].Domain == "DOMAIN_SEA") then
                            toolTipString = Locale.Lookup("LOC_UNITCOMMAND_FORM_FLEET_DESCRIPTION");
                        else
                            toolTipString = Locale.Lookup(commandRow.Description);
                        end
                    elseif (actionHash == UnitCommandTypes.FORM_ARMY) then
                        if (GameInfo.Units[unitType].Domain == "DOMAIN_SEA") then
                            toolTipString = Locale.Lookup("LOC_UNITCOMMAND_FORM_ARMADA_DESCRIPTION");
                        else
                            toolTipString = Locale.Lookup(commandRow.Description);
                        end
                    else
                        toolTipString = Locale.Lookup(commandRow.Description);
                    end
                    if (tResults ~= nil) then
                        if (tResults[UnitOperationResults.ACTION_NAME] ~= nil and tResults[UnitOperationResults.ACTION_NAME] ~= "") then
                            toolTipString = Locale.Lookup(tResults[UnitOperationResults.ACTION_NAME]);
                        end

                        if (tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION] ~= nil) then
                            toolTipString = toolTipString .. "[NEWLINE]"; -- Line break before add'l desc block
                            for i,v in ipairs(tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION]) do
                                toolTipString = toolTipString .. "[NEWLINE]" .. Locale.Lookup(v);
                            end
                            
                            if (tResults[UnitOperationResults.FAILURE_REASONS] ~= nil) then
                                if (table.count(tResults[UnitOperationResults.FAILURE_REASONS]) > 0) then
                                    toolTipString = toolTipString .. "[NEWLINE]"; -- Line break after add'l desc block if there are failure reasons to report
                                end
                            end
                        end

                        -- Are there any failure reasons?
                        if ( bDisabled ) then
                            if (tResults[UnitOperationResults.FAILURE_REASONS] ~= nil) then
                                -- Add the reason(s) to the tool tip
                                for i,v in ipairs(tResults[UnitOperationResults.FAILURE_REASONS]) do
                                    toolTipString = toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup(v) .. "[ENDCOLOR]";
                                end
                            end
                        end
                    end
                    isDisabled = bDisabled or isDisabled;   -- Mix in tutorial disabledness
                    local overrideIcon:string = nil;

                    isDisabled, tooltipString, overrideIcon = LateCheckActionBeforeAdd( kActionsTable, actionHash, isDisabled, tooltipString, overrideIcon );
                    AddActionToTable( actionsTable, commandRow, isDisabled, toolTipString, actionHash, OnUnitActionClicked, UnitCommandTypes.TYPE, actionHash, overrideIcon  );
                end
            end
        end
    end


    -- Loop over the UnitOperations (like commands but may take 1 to N turns to complete)
    
    -- Only show the operations if the unit has moves left.
    local isHasMovesLeft = pUnit:GetMovesRemaining() > 0;
    if isHasMovesLeft then
        
        for operationRow in GameInfo.UnitOperations() do

            local actionHash    :number = operationRow.Hash;
            local isDisabled    :boolean= IsDisabledByTutorial( unitType, actionHash ); 

            -- if unit can build an improvement, show all the buildable improvements for that tile
            if IsBuildingImprovement(actionHash) then
                local tParameters = GetBuildImprovementParameters(actionHash, pUnit);

                --Call CanStartOperation asking for results
                local bCanStart, tResults = UnitManager.CanStartOperation( pUnit, actionHash, nil, tParameters, true);

                if (bCanStart and tResults ~= nil) then
                    if (tResults[UnitOperationResults.IMPROVEMENTS] ~= nil and #tResults[UnitOperationResults.IMPROVEMENTS] ~= 0) then
                        
                        bestValidImprovement = tResults[UnitOperationResults.BEST_IMPROVEMENT];
                        
                        local tImprovements = tResults[UnitOperationResults.IMPROVEMENTS];
                        for i, eImprovement in ipairs(tImprovements) do
                            
                            tParameters[UnitOperationTypes.PARAM_IMPROVEMENT_TYPE] = eImprovement;
                            
                            local improvement       = GameInfo.Improvements[eImprovement];

                            -- Lag fix - start

                            bCanStart, tResults = UnitManager.CanStartOperation(pUnit, actionHash, nil, tParameters, false, false);
                            
                            -- Lag fix - end
                            
                            local isDisabled        = not bCanStart;
                            local toolTipString     = Locale.Lookup(operationRow.Description) .. ": " .. Locale.Lookup(improvement.Name);

                            if tResults ~= nil then

                                if (tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION] ~= nil) then
                                    for i,v in ipairs(tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION]) do
                                        toolTipString = toolTipString .. "[NEWLINE]" .. Locale.Lookup(v);
                                    end
                                end

                                -- Are there any failure reasons?
                                if isDisabled then
                                    if (tResults[UnitOperationResults.FAILURE_REASONS] ~= nil) then
                                        -- Add the reason(s) to the tool tip
                                        for i,v in ipairs(tResults[UnitOperationResults.FAILURE_REASONS]) do
                                            toolTipString = toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup(v) .. "[ENDCOLOR]";
                                        end
                                    end
                                end
                            end

                            -- If this improvement is the same enum as what the game marked as "the best" for this plot, set this flag for the UI to use.
                            if ( bestValidImprovement ~= nil and bestValidImprovement ~= -1 and bestValidImprovement == eImprovement ) then
                                improvement["IsBestImprovement"] = true;
                            else
                                improvement["IsBestImprovement"] = false;
                            end

                            improvement["CategoryInUI"] = "BUILD";  -- TODO: Force improvement to be a type of "BUILD", this can be removed if CategoryInUI is added to "Improvements" in the database schema. ??TRON
                            local callbackFn, isDisabled = GetBuildImprovementCallback( actionHash, isDisabled );
                            AddActionToTable( actionsTable, improvement, isDisabled, toolTipString, actionHash, callbackFn, improvement.Hash );
                        end
                    end
                end
            elseif (actionHash == UnitOperationTypes.MOVE_TO) then
                local bCanStart     :boolean= UnitManager.CanStartOperation( pUnit,  UnitOperationTypes.MOVE_TO, nil, false, false);    -- No exclusion test, no results
                if (bCanStart) then
                    local toolTipString :string = Locale.Lookup(operationRow.Description);
                    AddActionToTable( actionsTable, operationRow, isDisabled, toolTipString, actionHash, OnUnitActionClicked_MoveTo );
                end
            elseif (operationRow.CategoryInUI == "OFFENSIVESPY") then
                local bCanStart     :boolean= UnitManager.CanStartOperation( pUnit, actionHash, nil, false, false); -- No exclusion test, no result
                if (bCanStart) then
                    ---- We only want a single offensive spy action which opens the EspionageChooser side panel
                    if actionsTable[operationRow.CategoryInUI] ~= nil and table.count(actionsTable[operationRow.CategoryInUI]) == 0 then
                        local toolTipString :string = Locale.Lookup("LOC_UNITPANEL_ESPIONAGE_CHOOSE_MISSION");
                        AddActionToTable( actionsTable, operationRow, isDisabled, toolTipString, actionHash, OnUnitActionClicked, UnitOperationTypes.TYPE, actionHash, "ICON_UNITOPERATION_SPY_MISSIONCHOOSER");
                    end
                end
            elseif (actionHash == UnitOperationTypes.SPY_COUNTERSPY) then
                local bCanStart, tResults = UnitManager.CanStartOperation( pUnit, actionHash, nil, true );
                if (bCanStart) then
                    local toolTipString = Locale.Lookup(operationRow.Description);
                    AddActionToTable( actionsTable, operationRow, isDisabled, toolTipString, actionHash, OnUnitActionClicked, UnitOperationTypes.TYPE, actionHash, "ICON_UNITOPERATION_SPY_COUNTERSPY_ACTION");
                end
            elseif (actionHash == UnitOperationTypes.FOUND_CITY) then
                local bCanStart, tResults = UnitManager.CanStartOperation( pUnit,  UnitOperationTypes.FOUND_CITY, nil, false, OperationResultsTypes.ALL);   -- No exclusion test
                if (bCanStart) then
                    local toolTipString :string = Locale.Lookup(operationRow.Description);
                    AddActionToTable( actionsTable, operationRow, isDisabled, toolTipString, actionHash, function() OnUnitActionClicked_FoundCity(tResults); end);
                end
            elseif (actionHash == UnitOperationTypes.WMD_STRIKE) then
                -- if unit can deploy a WMD, create a unit action for each type
                -- first check if the unit is capable of deploying a WMD
                local bCanStart = UnitManager.CanStartOperation( pUnit, UnitOperationTypes.WMD_STRIKE, nil, true);
                if (bCanStart) then
                    for entry in GameInfo.WMDs() do
                        local tParameters = {};
                        tParameters[UnitOperationTypes.PARAM_WMD_TYPE] = entry.Index;
                        bCanStart, tResults = UnitManager.CanStartOperation(pUnit, actionHash, nil, tParameters, true);
                        local isWMDTypeDisabled:boolean = (not bCanStart) or isDisabled;
                        local toolTipString :string = Locale.Lookup(operationRow.Description);
                        local wmd = entry.Index;
                        toolTipString = toolTipString .. "[NEWLINE]" .. Locale.Lookup(entry.Name);
                        local callBack = 
                            function(void1,void2,mode) 
                                OnUnitActionClicked_WMDStrike(wmd,mode); 
                            end
                        -- Are there any failure reasons?
                        if ( not bCanStart ) then
                            if tResults ~= nil and (tResults[UnitOperationResults.FAILURE_REASONS] ~= nil) then
                                -- Add the reason(s) to the tool tip
                                for i,v in ipairs(tResults[UnitOperationResults.FAILURE_REASONS]) do
                                    toolTipString = toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup(v) .. "[ENDCOLOR]";
                                end
                            end
                            if(not IsActionLimited(entry.WeaponType))then
                                AddActionToTable( actionsTable, operationRow, isWMDTypeDisabled, toolTipString, actionHash, callBack );     
                            end
                        else
                            AddActionToTable( actionsTable, operationRow, isWMDTypeDisabled, toolTipString, actionHash, callBack ); 
                        end
                                            
                    end
                end
            else
                -- Is this operation visible in the UI?
                -- The UI check of an operation is a loose check where it only fails if the unit could never do the operation.
                if ( operationRow.VisibleInUI ) then
                    local bCanStart:boolean, tResults:table = UnitManager.CanStartOperation( pUnit, actionHash, nil, true );

                    if (bCanStart) then
                        -- Check again if the operation can occur, this time for real.
                        bCanStart, tResults = UnitManager.CanStartOperation(pUnit, actionHash, nil, false, OperationResultsTypes.NO_TARGETS);       -- Hint that we don't require possibly expensive target results.
                        local bDisabled:boolean = not bCanStart;
                        local toolTipString:string = GetUnitOperationTooltip(operationRow);

                        if (tResults ~= nil) then
                            if (tResults[UnitOperationResults.ACTION_NAME] ~= nil and tResults[UnitOperationResults.ACTION_NAME] ~= "") then
                                toolTipString = Locale.Lookup(tResults[UnitOperationResults.ACTION_NAME]);
                            end

                            if (tResults[UnitOperationResults.FEATURE_TYPE] ~= nil) then
                                local featureName = GameInfo.Features[tResults[UnitOperationResults.FEATURE_TYPE]].Name;
                                toolTipString = toolTipString .. ": " .. Locale.Lookup(featureName);
                            end

                            if (tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION] ~= nil) then
                                for i,v in ipairs(tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION]) do
                                    toolTipString = toolTipString .. "[NEWLINE]" .. Locale.Lookup(v);
                                end
                            end

                            -- Are there any failure reasons?
                            if ( bDisabled ) then
                                if (tResults[UnitOperationResults.FAILURE_REASONS] ~= nil) then
                                    -- Add the reason(s) to the tool tip
                                    for i,v in ipairs(tResults[UnitOperationResults.FAILURE_REASONS]) do
                                        toolTipString = toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup(v) .. "[ENDCOLOR]";
                                    end
                                end
                            end
                        end
                        isDisabled = bDisabled or isDisabled;

                        if(not IsActionLimited(operationRow.PrimaryKey, pUnit))then
                            local overrideIcon:string = nil;

                            isDisabled, toolTipString, overrideIcon = LateCheckOperationBeforeAdd( tResults, actionsTable, actionHash, isDisabled, toolTipString, overrideIcon );
                            AddActionToTable( actionsTable, operationRow, isDisabled, toolTipString, actionHash, OnUnitActionClicked, UnitOperationTypes.TYPE, actionHash, overrideIcon  );
                        end
                    end
                end
            end
        end
    end
    
    return actionsTable;
end
-- ===========================================================================
--  OVERRIDE BASE FUNCTIONS
-- ===========================================================================

function GetUnitActionsTable(pUnit : object)
    local pBaseActionsTable : table = BASE_GetUnitActionsTable(pUnit);

    --  Unit Commands
    --  Test all custom commands in table defined in "DA_UnitCommands" to add
    --  to the selected unit's table.
    for sCommandKey, pCommandTable in pairs(m_DAUnitCommands) do
        
        --if UnitManager.CanStartCommand(pUnit, UnitCommandTypes.EXECUTE_SCRIPT) then
            local bVisible : boolean = true;
            if (pCommandTable.IsVisible ~= nil) then
                bVisible = pCommandTable.IsVisible(pUnit);
            end
            if (bVisible) then

                if (pCommandTable.CanUse ~= nil and pCommandTable.CanUse(pUnit) == true) then

                    local bIsDisabled : boolean = false;
                    if (pCommandTable.IsDisabled ~= nil) then
                        bIsDisabled = pCommandTable.IsDisabled(pUnit);
                    end
            
                    local sToolTipString : string = pCommandTable.ToolTipString or "Undefined Unit Command";
					if pCommandTable.GetToolTipString ~= nil then
						local noErr, ttp = pcall(pCommandTable.GetToolTipString, pUnit);
						if noErr then
							sToolTipString = ttp;
						else
							print(ttp);
						end
					end

                    local pCallback : ifunction = function()
                        local pSelectedUnit = UI.GetHeadSelectedUnit();
                        if (pSelectedUnit == nil) then
                            return;
                        end

                        local tParameters = {};
                        tParameters[UnitCommandTypes.PARAM_NAME] = pCommandTable.EventName or "";
                        UnitManager.RequestCommand(pSelectedUnit, UnitCommandTypes.EXECUTE_SCRIPT, tParameters);
						--if (pCommandTable.DoNotDelete == nil) or (pCommandTable.DoNotDelete ~= true) then
	                        --UnitManager.RequestCommand(pSelectedUnit, UnitCommandTypes.DELETE);
						--end
                    end

					local sDisabledToolTipString : string = pCommandTable.DisabledToolTipString;
					if pCommandTable.GetDisabledToolTipString ~= nil then
						local noErr, ttp = pcall(pCommandTable.GetDisabledToolTipString, pUnit);
						if noErr then
							sDisabledToolTipString = ttp;
						else
							print(ttp);
						end
					end
                    if (bIsDisabled and sDisabledToolTipString ~= nil) then
                        sToolTipString = sToolTipString .. "[NEWLINE][NEWLINE]" .. sDisabledToolTipString;
                    end

                    AddActionToTable(pBaseActionsTable, pCommandTable, bIsDisabled, sToolTipString, UnitCommandTypes.EXECUTE_SCRIPT, pCallback);
                end
            end
        end
    --end

    return pBaseActionsTable;
end

-- ===========================================================================
-- Handle some app side Unit animation
-- ===========================================================================

local g_ActivateReason_Demolish = DB.MakeHash("DEMOLISH");

-- ===========================================================================
function OnUnitActivate(owner : number, unitID : number, x : number, y : number, eReason : number, bVisibleToLocalPlayer : boolean)

    if bVisibleToLocalPlayer then

        local pUnit = UnitManager.GetUnit(owner, unitID);
        if pUnit ~= nil then

            -- Trigger custom animations based on the Activate event.
            if eReason == g_ActivateReason_DEMOLISH then
                SimUnitSystem.SetAnimationState(pUnit, "ACTION_A", "IDLE");
            end
        end
    end
end
Events.UnitActivate.Add(OnUnitActivate);

-- =================================================================================
-- Overrides
-- =================================================================================
--[[
function BuildActionModHook(instance:table, action:table)
    -- Is the player and unit is valid?
    -- print('DEBUG', action.userTag, action.IconId)
    if g_selectedPlayerId ~= nil and g_selectedPlayerId ~= -1
            and g_UnitId ~= nil and g_UnitId ~= -1 then
        -- Is this the "build improvement" action
        if action.userTag == UnitOperationTypes.BUILD_IMPROVEMENT then
            if action.IconId == "ICON_IMPROVEMENT_FARM" then
                local player = Players[g_selectedPlayerId];
                local unit =  player:GetUnits():FindID(g_UnitId);
                if unit ~= nil then
                    local unitPos:number = unit:GetPlotId();
                    if Map.IsPlot(unitPos) then
                        local plot:table = Map.GetPlotByIndex(unitPos);
                        if plot ~= nil then
                            if action.Disabled == false and ShouldDisableHillFarm(plot, player) then
                                action.Disabled = true;
                                action.IsBestImprovement = false;
                                m_ShouldUpdateBestImprovement = true;
                            end
                        end
                    end
                end
            elseif action.IconId == "ICON_IMPROVEMENT_MINE" and action.Disabled == false then
                -- Update best improvement to mine if the best improvement was cleared because hill farm couldn't be built.
                -- This logic can work because mine action is checked after farm.
                if m_ShouldUpdateBestImprovement then
                    action.IsBestImprovement = true;
                    m_ShouldUpdateBestImprovement = false;
                end
            end
        end
        -- Is this the "remove feature" action
        if action.userTag == UnitOperationTypes.REMOVE_FEATURE then
            local player = Players[g_selectedPlayerId];
            local unit =  player:GetUnits():FindID(g_UnitId);
            if unit ~= nil then
                local unitInfo = GameInfo.Units[unit:GetUnitType()]
                if unitInfo ~= nil then
                    if unitInfo.PromotionClass == 'PROMOTION_CLASS_RECON' then
                        action.Disabled = true;
                        action.helpString = Locale.Lookup("LOC_CANNOT_REMOVE_FEATURE_USING_RECONS");
                    end
                end
            end
        end
        -- local plant_forest_hash = GameInfo.UnitOperations.UNITOPERATION_PLANT_FOREST.Hash
        -- if action.userTag == plant_forest_hash then
        --     print('!!!')
        -- end
    end
    BASE_BuildActionModHook(instance, action);
end
]]
local mGreatPersonActivateHash = GameInfo.Types['UNITCOMMAND_ACTIVATE_GREAT_PERSON'].Hash;
-- local mUnitoperationRemoveFeatureHash = GameInfo.Types['UNITOPERATION_REMOVE_FEATURE'].Hash;
-- local mMilitaryEngineer = GameInfo.Units['UNIT_MILITARY_ENGINEER'].Index;
-- -- =================================================================================
-- -- Overrides
-- -- =================================================================================
function OnUnitActionClicked( actionType:number, actionHash:number, currentMode:number )
--     -- print('OnUnitActionClicked', actionType, actionHash) -- OnUnitActionClicked -1572680103 374670040
    if g_isOkayToProcess then
        local pSelectedUnit :table = UI.GetHeadSelectedUnit();
        if (pSelectedUnit ~= nil) then
            if (actionType == UnitCommandTypes.TYPE) then
                if actionHash == mGreatPersonActivateHash then
                    local individual = pSelectedUnit:GetGreatPerson():GetIndividual();
                    -- GreatPersonUtils.HandleActivation(pSelectedUnit:GetOwner(), pSelectedUnit:GetID(), individual);
                    GameEvents.GreatPersonHandleActivation.Call(pSelectedUnit:GetOwner(), pSelectedUnit:GetID(), individual);
                end
            end
        end
    end
    BASE_OnUnitActionClicked(actionType, actionHash, currentMode)
end

function AddActionButton(instance:table, action:table)
    if action.IconId == 'ICON_UNITOPERATION_HARVEST_RESOURCE' then
        local pSelectedUnit = UI.GetHeadSelectedUnit();
        local owner = pSelectedUnit:GetOwner();
        local player = Players[owner];
        if pSelectedUnit:GetUnitType() == GameInfo.Units['UNIT_BUILDER'].Index then
            -- NOTE: GetX and GetY may not work in UI environment.
            -- local x = pSelectedUnit:GetX()
            -- local y = pSelectedUnit:GetY()
            local plotID = pSelectedUnit:GetPlotId();
            local plot = Map.GetPlotByIndex(plotID);
            local r = plot:GetResourceType();
            -- print(r, plot:GetX(), plot:GetY())
            if r ~= -1 then
                local resource = GameInfo.Resources[r];
                if resource ~= nil then
                    if ((resource.ResourceClassType == 'RESOURCECLASS_STRATEGIC') or (resource.ResourceClassType == 'RESOURCECLASS_ARTIFACT')) then
                        if not player:GetResources():IsResourceVisible(r) then
                            print('hide harvest resource: ', resource.ResourceType);
                            instance.UnitActionButton:SetHide(true);
                            return;
                        end
                    end
                end
            end
        end
    end
    if action.IconId == 'ICON_UNITCOMMAND_ACTIVATE_GREAT_PERSON' then
        local pSelectedUnit = UI.GetHeadSelectedUnit();
        local individual = pSelectedUnit:GetGreatPerson():GetIndividual();
        -- local playerID = pSelectedUnit:GetOwner();
        local playerID = Game.GetLocalPlayer();
        -- print('HD_DEBUG_2', pSelectedUnit:GetOwner(), playerID);
        -- TODO: Add GreatPerson support for DA
        --local rawActivationPlots = HDGreatPersonGetActivationPlots(playerID, individual);
        if rawActivationPlots ~= nil then
            -- print('here')
            local validActivation = false;
            local selectedPlotId = pSelectedUnit:GetPlotId();
            -- for _, plotId in ipairs(rawActivationPlots) do
            --     print('HD_DEBUG', _, selectedPlotId, plotId)
            -- end
            for _, plotId in ipairs(rawActivationPlots) do
                if selectedPlotId == plotId then
                    validActivation = true;
                    break;
                end
            end
            if not validActivation then
                -- Not activatable plot.
                local errorHint = "";
                for row in GameInfo.GreatPersonIndividuals() do
                    if row.Index == individual then
                        local hint = Locale.Lookup("LOC_" .. row.GreatPersonIndividualType .."_ACTIVATION_HINT");
                        if hint ~= "LOC_" .. row.GreatPersonIndividualType .."_ACTIVATION_HINT" then
                            errorHint = "[NEWLINE][COLOR_Red]" .. hint .. "[ENDCOLOR]";
                        end
                    end
                end
                if not action.Disabled then
                    -- Not disabled, append additional newline.
                    if errorHint ~= "" then
                        errorHint = "[NEWLINE]" .. errorHint;
                    end
                    action.Disabled = true;
                end
                action.helpString = action.helpString .. errorHint;
            end
        end
    end
    BASE_AddActionButton(instance, action)
end

-- ===========================================================================
--  UnitAction<FoundCity> was clicked.
-- ===========================================================================
function OnUnitActionClicked_FoundCity(kResults:table)
    if (g_isOkayToProcess) then
        local pSelectedUnit = UI.GetHeadSelectedUnit();
        if ( pSelectedUnit ~= nil ) then
            UnitManager.RequestOperation( pSelectedUnit, UnitOperationTypes.FOUND_CITY );
            -- if kResults ~= nil and table.count(kResults) ~= 0 then
            --     local popupString:string = Locale.Lookup("LOC_FOUND_CITY_CONFIRM_POPUP");
            --     if (kResults[UnitOperationResults.FEATURE_TYPE] ~= nil) then
            --         local featureName = GameInfo.Features[kResults[UnitOperationResults.FEATURE_TYPE]].Name;
            --         popupString = popupString .. "[NEWLINE]" .. Locale.Lookup("LOC_FOUND_CITY_WILL_REMOVE_FEATURE", featureName);
            --     end
                
            --     --Request confirmation
            --     local pPopupDialog :table = PopupDialogInGame:new("FoundCityAt"); -- unique identifier
            --     pPopupDialog:AddText(popupString);
            --     pPopupDialog:AddConfirmButton(Locale.Lookup("LOC_YES"), function()
            --         UnitManager.RequestOperation( pSelectedUnit, UnitOperationTypes.FOUND_CITY );
            --     end);
            --     pPopupDialog:AddCancelButton(Locale.Lookup("LOC_NO"), nil);
            --     pPopupDialog:Open();
            -- else
            --     UnitManager.RequestOperation( pSelectedUnit, UnitOperationTypes.FOUND_CITY );
            -- end
        end
    end
    if UILens.IsLayerOn( m_HexColoringWaterAvail ) then
        UILens.ToggleLayerOff(m_HexColoringWaterAvail);
    end
    UILens.SetActive("Default");
end


function OnGreatPersonActivated(unitOwner, unitID, greatPersonClassID, greatPersonIndividualID)
    local owner = Players[unitOwner];
    if owner:IsAI() then
        -- Only need to handle AI activation since player activation will be handled in OnUnitActionClicked.
        -- GreatPersonUtils.HandleActivation(unitOwner, unitID, greatPersonIndividualID);
        GameEvents.GreatPersonHandleActivation.Call(unitOwner, unitID, greatPersonIndividualID);
    end
end

function LateInitialize()
    BASE_LateInitialize();
    Events.UnitGreatPersonActivated.Add(OnGreatPersonActivated);
end
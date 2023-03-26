-- Copyright 2019, Firaxis Games
include("InstanceManager");
-- ===========================================================================
--	CONSTANTS
-- ===========================================================================

local SIZE_BELIEF_ICON_LARGE					:number = 64;
local BELIEFS_PANEL_RELATIVE_SIZE_UNSELECTED	:number = 0;
local BELIEFS_PANEL_RELATIVE_SIZE_SELECTED		:number = 0;

local DATA_FIELD_BELIEF_INDEX:string = "DataField_BeliefIndex";

GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils


-- ===========================================================================
--	VARIABLES
-- ===========================================================================

local m_pSelectBeliefsIM:table = InstanceManager:new("BeliefSlot", "BeliefButton", Controls.BeliftStack);
local m_pSelectBeliefsIM_R:table = InstanceManager:new("BeliefSlot", "BeliefButton", Controls.BeliftStack_R);

local m_pGameReligion:table = Game.GetReligion();

local m_uiSelectedBeliefInstance:table = nil;
local m_uiSelectedBeliefInstance_R:table = nil;

-- ===========================================================================
function Realize()
	Controls.Header_OriginText:SetText("选择神格");  --needloc
	Controls.Header_OriginText_R:SetText("选择权柄");  --needloc
	Controls.Header_OriginText_T:SetText("创造神灵");  --needloc

	-- Update available pantheon beliefs
	m_pSelectBeliefsIM:ResetInstances();
	m_pSelectBeliefsIM_R:ResetInstances();
	local Godhoods = DB.Query('SELECT DISTINCT GodhoodType FROM Godhood');
	local Powers = DB.Query('SELECT DISTINCT PowerType FROM Power');

	for _, row_ in ipairs(Godhoods) do
		local row = GameInfo.Pantheons['BELIEF_'..row_.GodhoodType];
		if row ~= nil then
			local beliefInst:table = m_pSelectBeliefsIM:GetInstance();
			beliefInst[DATA_FIELD_BELIEF_INDEX] = row.Index;
			beliefInst.BeliefLabel:LocalizeAndSetText(Locale.ToUpper(row.Name));
			beliefInst.BeliefDescription:LocalizeAndSetText(row.Description);
			SetBeliefIcon(beliefInst.BeliefIcon, row.BeliefType, SIZE_BELIEF_ICON_LARGE);
			beliefInst.BeliefButton:SetSelected(beliefInst == m_uiSelectedBeliefInstance);
			beliefInst.BeliefButton:RegisterCallback( Mouse.eLClick, function() OnBeliefSelected(beliefInst); end );
			beliefInst.BeliefButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
		end
	end
	for _, row_ in ipairs(Powers) do
		local row = GameInfo.Pantheons['BELIEF_'..row_.PowerType];
		if row ~= nil then
			local beliefInst_R:table = m_pSelectBeliefsIM_R:GetInstance();
			beliefInst_R[DATA_FIELD_BELIEF_INDEX] = row.Index;
			beliefInst_R.BeliefLabel:LocalizeAndSetText(Locale.ToUpper(row.Name));
			beliefInst_R.BeliefDescription:LocalizeAndSetText(row.Description);
			SetBeliefIcon(beliefInst_R.BeliefIcon, row.BeliefType, SIZE_BELIEF_ICON_LARGE);
			beliefInst_R.BeliefButton:SetSelected(beliefInst_R == m_uiSelectedBeliefInstance_R);
			beliefInst_R.BeliefButton:RegisterCallback( Mouse.eLClick, function() OnBeliefSelected_R(beliefInst_R); end );
			beliefInst_R.BeliefButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
		end
	end

	RealizeCurrentSelection();
end

-- ===========================================================================
function RealizeCurrentSelection()
	if m_uiSelectedBeliefInstance == nil then
		--Controls.ReligionOrPatheonTitle_one:SetText(Locale.ToUpper("LOC_UI_RELIGION_CHOOSING_PANTHEON"));
		--Controls.SelectedBeliefGrid_one:SetHide(true);
		Controls.SelectedBeliefLabel_one:LocalizeAndSetText("");
		Controls.SelectedBeliefDescription_one:LocalizeAndSetText("");

		--Controls.ConfirmGrid:SetHide(true);
		--Controls.BottomGrid:SetParentRelativeSizeY(BELIEFS_PANEL_RELATIVE_SIZE_UNSELECTED);
	else
		local kBeliefDef:table = GameInfo.Pantheons[m_uiSelectedBeliefInstance[DATA_FIELD_BELIEF_INDEX]];
		--Controls.ReligionOrPatheonTitle_one:SetText(Locale.ToUpper(Locale.Lookup("LOC_UI_RELIGION_PANTHEON_NAME", kBeliefDef.Name)));
	
		-- Show selected belief
		Controls.SelectedBeliefLabel_one:LocalizeAndSetText(Locale.ToUpper(kBeliefDef.Name));
		Controls.SelectedBeliefDescription_one:LocalizeAndSetText(kBeliefDef.Description);
		SetBeliefIcon(Controls.SelectedBeliefIcon_one, kBeliefDef.BeliefType, SIZE_BELIEF_ICON_LARGE);
		--Controls.SelectedBeliefGrid_one:SetHide(false);

		--Controls.ConfirmGrid:SetHide(false);
		--Controls.BottomGrid:SetParentRelativeSizeY(BELIEFS_PANEL_RELATIVE_SIZE_SELECTED);
	end

	if m_uiSelectedBeliefInstance_R == nil then
		--Controls.ReligionOrPatheonTitle_R:SetText(Locale.ToUpper("LOC_UI_RELIGION_CHOOSING_PANTHEON"));
		--Controls.SelectedBeliefGrid_R:SetHide(true);
		Controls.SelectedBeliefLabel_two:LocalizeAndSetText("");
		Controls.SelectedBeliefDescription_two:LocalizeAndSetText("");

		--Controls.ConfirmGrid_R:SetHide(true);
		--Controls.BottomGrid_R:SetParentRelativeSizeY(BELIEFS_PANEL_RELATIVE_SIZE_UNSELECTED);
	else
		local kBeliefDef:table = GameInfo.Pantheons[m_uiSelectedBeliefInstance_R[DATA_FIELD_BELIEF_INDEX]];
		--Controls.ReligionOrPatheonTitle_R:SetText(Locale.ToUpper(Locale.Lookup("LOC_UI_RELIGION_PANTHEON_NAME", kBeliefDef.Name)));
	
		-- Show selected belief
		Controls.SelectedBeliefLabel_two:LocalizeAndSetText(Locale.ToUpper(kBeliefDef.Name));
		Controls.SelectedBeliefDescription_two:LocalizeAndSetText(kBeliefDef.Description);
		SetBeliefIcon(Controls.SelectedBeliefIcon_two, kBeliefDef.BeliefType, SIZE_BELIEF_ICON_LARGE);
		--Controls.SelectedBeliefGrid_R:SetHide(false);

		--Controls.ConfirmGrid_R:SetHide(false);
		--Controls.BottomGrid_R:SetParentRelativeSizeY(BELIEFS_PANEL_RELATIVE_SIZE_SELECTED);
	end
	RefreshPantheonText();
	if m_uiSelectedBeliefInstance == nil or m_uiSelectedBeliefInstance_R == nil then
		Controls.PantheonChooser_T:SetParentRelativeSizeY(-400);
		Controls.ConfirmGrid_T:SetHide(true);
	else
		local GodhoodType = GameInfo.Pantheons[m_uiSelectedBeliefInstance[DATA_FIELD_BELIEF_INDEX]].BeliefType:gsub('BELIEF_','');
		local PowerType = GameInfo.Pantheons[m_uiSelectedBeliefInstance_R[DATA_FIELD_BELIEF_INDEX]].BeliefType:gsub('BELIEF_','');
		local BeliefType = 'BELIEF_'..GodhoodType..'_WITH_'..PowerType;
		local BeliefIndex = GameInfo.Beliefs[BeliefType].Index;
		if m_pGameReligion:IsInSomePantheon(BeliefIndex) or m_pGameReligion:IsInSomeReligion(BeliefIndex) then
			Controls.Confirm_Text:SetText('[COLOR_RED]该万神殿已被选择[ENDCOLOR]'); --needloc
			Controls.ConfirmPantheonButton_T:SetDisabled(true);
		else
			Controls.Confirm_Text:SetText('建立该万神殿信仰'); --needloc
			Controls.ConfirmPantheonButton_T:SetDisabled(false);
		end
		Controls.PantheonChooser_T:SetParentRelativeSizeY(-400);
		Controls.ConfirmGrid_T:SetHide(false);

	end

end


-- ===========================================================================
function SetBeliefIcon(targetControl:table, beliefType:string, iconSize:number)
	local textureOffsetX:number, textureOffsetY:number, textureSheet:string = IconManager:FindIconAtlas("ICON_" .. beliefType, iconSize);
	if(textureSheet == nil or textureSheet == "") then
		error("Could not find icon in SetBeliefIcon: beliefType=\""..beliefType.."\", iconSize="..tostring(iconSize) );
	else
		targetControl:SetTexture(textureOffsetX, textureOffsetY, textureSheet);
		targetControl:SetSizeVal(iconSize, iconSize);
	end
end

-- ===========================================================================
function OnBeliefSelected( instance:table )
	-- Ignore select if this belief is already selected
	if m_uiSelectedBeliefInstance == instance then
		return;
	end
	
	SetSelectedBeliefInstance(instance);
end

function OnBeliefSelected_R( instance:table )
	-- Ignore select if this belief is already selected
	if m_uiSelectedBeliefInstance_R == instance then
		return;
	end
	
	SetSelectedBeliefInstance_R(instance);
end
-- ===========================================================================
function SetSelectedBeliefInstance( instance:table )
	-- Unselect the previous selection
	if m_uiSelectedBeliefInstance ~= nil then
		m_uiSelectedBeliefInstance.BeliefButton:SetSelected(false);
	end

	-- Select new belief instance
	m_uiSelectedBeliefInstance = instance;
	m_uiSelectedBeliefInstance.BeliefButton:SetSelected(true);

	RealizeCurrentSelection();
end
function SetSelectedBeliefInstance_R( instance:table )
	-- Unselect the previous selection
	if m_uiSelectedBeliefInstance_R ~= nil then
		m_uiSelectedBeliefInstance_R.BeliefButton:SetSelected(false);
	end

	-- Select new belief instance
	m_uiSelectedBeliefInstance_R = instance;
	m_uiSelectedBeliefInstance_R.BeliefButton:SetSelected(true);

	RealizeCurrentSelection();
end
-- ===========================================================================
function ClearBeliefSelection()
	if m_uiSelectedBeliefInstance ~= nil then
		m_uiSelectedBeliefInstance.BeliefButton:SetSelected(false);
		m_uiSelectedBeliefInstance = nil;
	end

	RealizeCurrentSelection();
	RefreshPantheonText();
end
function ClearBeliefSelection_R()
	if m_uiSelectedBeliefInstance_R ~= nil then
		m_uiSelectedBeliefInstance_R.BeliefButton:SetSelected(false);
		m_uiSelectedBeliefInstance_R = nil;
	end
	RealizeCurrentSelection();
	RefreshPantheonText();
end
function ClearBeliefSelection_all()
	ClearBeliefSelection();
	ClearBeliefSelection_R();
end
-- ===========================================================================

function RefreshPantheonText()
	if m_uiSelectedBeliefInstance == nil or m_uiSelectedBeliefInstance_R == nil then
		Controls.SelectedBeliefLabel_unite:SetText('');
		Controls.SelectedBeliefDescription_unite:SetText('');
	else
		local GodhoodIndex:number = m_uiSelectedBeliefInstance[DATA_FIELD_BELIEF_INDEX];
		local PowerIndex:number = m_uiSelectedBeliefInstance_R[DATA_FIELD_BELIEF_INDEX];
		local GodhoodType = GameInfo.Pantheons[GodhoodIndex].BeliefType:gsub('BELIEF_','');
		local PowerType = GameInfo.Pantheons[PowerIndex].BeliefType:gsub('BELIEF_','');
		--[[
		local PantheonName = '';
		local PantheonDescription = '';
		local results = DB.Query('SELECT * FROM PantheonTexts');
		local currentLanguage = Locale.GetCurrentLanguage();
		if results then
			for _, row in ipairs(results) do

				if row.GodhoodType == GodhoodType and row.PowerType == PowerType and row.Language == currentLanguage.Type then
					PantheonDescription = PantheonDescription..Locale.Lookup(row.Texts);
					print(Locale.Lookup(row.Texts))
				end
			end
		end	
		]]	
		Controls.SelectedBeliefLabel_unite:SetText(Locale.Lookup('LOC_BELIEF_'..GodhoodType..'_WITH_'..PowerType..'_NAME'));
		Controls.SelectedBeliefDescription_unite:SetText(Locale.Lookup('LOC_BELIEF_'..GodhoodType..'_WITH_'..PowerType..'_DESCRIPTION'));
	end
end


-- ===========================================================================
function ConfirmPantheon()
	if m_uiSelectedBeliefInstance ~= nil and m_uiSelectedBeliefInstance_R ~= nil then

		local GodhoodIndex:number = m_uiSelectedBeliefInstance[DATA_FIELD_BELIEF_INDEX];
		local PowerIndex:number = m_uiSelectedBeliefInstance_R[DATA_FIELD_BELIEF_INDEX];

		local GodhoodType = GameInfo.Pantheons[GodhoodIndex].BeliefType:gsub('BELIEF_','');
		local PowerType = GameInfo.Pantheons[PowerIndex].BeliefType:gsub('BELIEF_','');

		local results = DB.Query('SELECT * FROM PantheonModifiers');

		local iPlayer = Game.GetLocalPlayer();
		if results then
			if Utils.PlayerHasTrait(iPlayer, 'TRAIT_LEADER_QGG_ASUNA_DESCENDEDGODDESSOFCREATION') then 
				for _, row in ipairs(results) do
					if row.GodhoodType == GodhoodType or row.PowerType == PowerType then
						GameEvents.PlayerAttachModifierByID.Call(iPlayer,	row.ModifierId);
						print(row.ModifierId);
					end
				end
			else
				for _, row in ipairs(results) do
					if row.GodhoodType == GodhoodType and row.PowerType == PowerType then
						GameEvents.PlayerAttachModifierByID.Call(iPlayer,	row.ModifierId);
						print(row.ModifierId);
					end
				end
			end
		end


		local tParameters:table = {};
		tParameters[PlayerOperations.PARAM_BELIEF_TYPE] = GameInfo.Beliefs['BELIEF_'..GodhoodType..'_WITH_'..PowerType].Hash;
		--tParameters[PlayerOperations.PARAM_BELIEF_TYPE] = GameInfo.Beliefs['BELIEF_STONE_CIRCLES'].Hash;
		--tParameters[PlayerOperations.PARAM_BELIEF_TYPE] = GameInfo.Beliefs['BELIEF_EARTH_GODDESS'].Hash;
		tParameters[PlayerOperations.PARAM_INSERT_MODE] = PlayerOperations.VALUE_EXCLUSIVE ;
		GameEvents.SetPlayerProperty.Call(iPlayer,	'PROP_PANTHEON_ACTIVATED',	1);
		UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.FOUND_PANTHEON, tParameters);
		UI.PlaySound("Confirm_Religion");

		NewClose();

		--LuaEvents.PantheonChooser_OpenReligionPanel();
	end
end
-- ===========================================================================

function PantheonForAI(iPlayer)
	local pPlayer = Players[iPlayer];
	local bActivated = pPlayer:GetProperty('PROP_PANTHEON_ACTIVATED');
	if bActivated ~= nil then
		return;
	end
	local pReligion = pPlayer:GetReligion();
	local iPantheon = pReligion:GetPantheon();
	local sPantheon = GameInfo.Beliefs[iPantheon].BeliefType;
	local results = DB.Query('SELECT * FROM PantheonModifiers');
	if results then
		if Utils.PlayerHasTrait(iPlayer, 'TRAIT_LEADER_QGG_ASUNA_DESCENDEDGODDESSOFCREATION') then 
			for _, row in ipairs(results) do
				if string.find(sPantheon, row.GodhoodType) ~= nil or string.find(sPantheon, row.PowerType) ~= nil then
					GameEvents.PlayerAttachModifierByID.Call(iPlayer,	row.ModifierId);
					print(row.ModifierId);
				end
			end
		else
			for _, row in ipairs(results) do
				if 'BELIEF_'..row.GodhoodType..'_WITH_'..row.PowerType == sPantheon then
					GameEvents.PlayerAttachModifierByID.Call(iPlayer,	row.ModifierId);
					print(row.ModifierId);
				end
			end
		end
	end
	GameEvents.SetPlayerProperty.Call(iPlayer,	'PROP_PANTHEON_ACTIVATED',	1);
end


-- ===========================================================================


--[[function AIChoosePantheon()
	if GameInfo.Governments['GOVERNMENT_PRIEST_COUNCIL'] == nil then
		print('not da')
		return;
	end
	print(1)
	local Godhoods = DB.Query('SELECT * FROM Godhood');
	print(1)
	local Powers = DB.Query('SELECT * FROM Power');
	print(1)
	for _, player in ipairs(Game.GetAliveMajors()) do
		print(2)
		local pReligion = player:GetReligion();
		print(2)
		local iPantheon = pReligion:GetPantheon();
		print(2)
		if iPantheon == nil or iPantheon == -1 then
			print(3)
			local iFaithBalance = pReligion:GetFaithBalance();
			print(3)
			local iFaithThreshold = GameInfo.GlobalParameters['RELIGION_PANTHEON_MIN_FAITH'].Value;
			print(3)
			if iFaithBalance > tonumber(iFaithThreshold) + 10 then -- 10 !
			print(3)
				GameEvents.GetRandNum.Call(#Godhoods, 'Godhoods');
				local iGodhood = Game.GetProperty('Godhoods');
				local sGodhood = GameInfo.Godhood[iGodhood].GodhoodType;
				GameEvents.GetRandNum.Call(#Powers, 'Powers');
				local iPower = Game.GetProperty('Powers');
				local sPower = GameInfo.Godhood[iPower].PowerType;
				print('BELIEF_'..sGodhood..'_WITH_'..sPower..'  for AI')
				tParameters[PlayerOperations.PARAM_BELIEF_TYPE] = GameInfo.Beliefs['BELIEF_'..sGodhood..'_WITH_'..sPower].Hash;
				tParameters[PlayerOperations.PARAM_INSERT_MODE] = PlayerOperations.VALUE_EXCLUSIVE ;
				UI.RequestPlayerOperation(player:GetID(), PlayerOperations.FOUND_PANTHEON, tParameters);
			end
		end
	end
end



Events.TurnBegin(AIChoosePantheon);]]

-- ===========================================================================

function NewClose()
	if not ContextPtr:IsHidden() and not Controls.PantheonChooserSlideAnim:IsReversing() then
		Controls.PantheonChooserSlideAnim:SetToEnd();
        Controls.PantheonChooserSlideAnim:Reverse();
		Controls.PantheonChooserSlideAnim_R:SetToEnd();
        Controls.PantheonChooserSlideAnim_R:Reverse();
        Controls.PantheonChooserSlideAnim_T:SetToEnd();
        Controls.PantheonChooserSlideAnim_T:Reverse();
		UI.PlaySound("Tech_Tray_Slide_Closed");

        --LuaEvents.PantheonChooser_CloseReligion();
	end
end

-- ===========================================================================
function NewOpen()
--print(ContextPtr.IsHidden)
	if ContextPtr:IsHidden() then
		ContextPtr:SetHide(false);
        m_uiSelectedBeliefInstance = nil;

        --LuaEvents.PantheonChooser_OpenReligion();

		-- Play Open Animation
		Controls.PantheonChooserSlideAnim:SetToBeginning();
		Controls.PantheonChooserSlideAnim:Play();
		Controls.PantheonChooserSlideAnim_R:SetToBeginning();
		Controls.PantheonChooserSlideAnim_R:Play();

		Controls.PantheonChooserSlideAnim_T:SetToBeginning();
		Controls.PantheonChooserSlideAnim_T:Play();

		UI.PlaySound("Tech_Tray_Slide_Open");

		Realize();
	end
end

-- ===========================================================================
-- Context Event
-- ===========================================================================
function OnInit( isReload:boolean )
	LateInitialize();

	if isReload and not ContextPtr:IsHidden() then
		Realize();
	end
end

-- ===========================================================================
-- Context Event
-- ===========================================================================
function OnInputHandler( pInputStruct:table )
	if pInputStruct:GetMessageType() == KeyEvents.KeyUp and pInputStruct:GetKey() == Keys.VK_ESCAPE then 
		NewClose();
		return true;
	end
	return false;
end

-- ===========================================================================
-- Context Event
-- ===========================================================================
function OnShutdown()
	LuaEvents.NotificationPanel_OpenPantheonChooser.Remove( NewOpen );
	LuaEvents.LaunchBar_OpenPantheonChooser.Remove( NewOpen );
	LuaEvents.LaunchBar_ClosePantheonChooser.Remove( NewClose );	
	--LuaEvents.NotificationPanel_OpenPantheonChooser.Remove( BASE_Open );
	--LuaEvents.LaunchBar_OpenPantheonChooser.Remove( BASE_Open );
	--LuaEvents.LaunchBar_ClosePantheonChooser.Remove( BASE_Close );
end

-- ===========================================================================
function OnAnimEnd()
	if Controls.PantheonChooserSlideAnim:IsReversing() then
		-- If we're reversing due to closing the panel then hide the context after that anim ends
		ContextPtr:SetHide(true);
	end
end

-- ===========================================================================
function LateInitialize()
	LuaEvents.NotificationPanel_OpenPantheonChooser.Add( NewOpen );
	LuaEvents.LaunchBar_OpenPantheonChooser.Add( NewOpen );
	GameEvents.InitialPantheon_DA.Add( NewOpen );
	LuaEvents.LaunchBar_ClosePantheonChooser.Add( NewClose );
	Controls.Header_CloseButton_T:RegisterCallback( Mouse.eLClick, NewClose );


	Controls.Header_CloseButton:RegisterCallback( Mouse.eLClick, NewClose );
	Controls.SelectedBeliefGrid_one:RegisterCallback( Mouse.eLClick, ClearBeliefSelection );
	Controls.ConfirmPantheonButton_T:RegisterCallback( Mouse.eLClick, ConfirmPantheon );
	Controls.ConfirmPantheonButton_T:RegisterCallback(Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end); 
	Controls.CancelButton_T:RegisterCallback( Mouse.eLClick, ClearBeliefSelection_all );
	Controls.CancelButton_T:RegisterCallback(Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end); 
	Controls.PantheonChooserSlideAnim:RegisterEndCallback( OnAnimEnd );

	Controls.Header_CloseButton_R:RegisterCallback( Mouse.eLClick, NewClose );
	Controls.SelectedBeliefGrid_two:RegisterCallback( Mouse.eLClick, ClearBeliefSelection_R );
	--Controls.ConfirmPantheonButton_R:RegisterCallback( Mouse.eLClick, ConfirmPantheon );
	--Controls.ConfirmPantheonButton_R:RegisterCallback(Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end); 
	--Controls.CancelButton_R:RegisterCallback( Mouse.eLClick, ClearBeliefSelection_R );
	--Controls.CancelButton_R:RegisterCallback(Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end); 
	Controls.PantheonChooserSlideAnim_R:RegisterEndCallback( OnAnimEnd );
	Events.PantheonFounded.Add(PantheonForAI);
end

-- ===========================================================================
function Initialize()
	ContextPtr:SetInitHandler( OnInit );
	ContextPtr:SetShutdown( OnShutdown );
	ContextPtr:SetInputHandler( OnInputHandler, true );
end
Initialize();
-- NewOpen();
  -- BASE_Open()                
-- TopPanel_DA
-- Author: 皮皮凯
-- DateCreated: 2022/9/10 9:56:40
--------------------------------------------------------------
local files = {
    "TopPanel.lua",
	"TopPanel_Expansion1.lua",
    "TopPanel_Expansion2.lua"
}

for _, file in ipairs(files) do
    include(file)
end
--内部详细备注版,对外或许可以删除这些，随E酱了
include( "SupportFunctions" ); -- Round(必要调用)
PPK_RefreshYields = RefreshYields;
PPK_FormatValuePerTurn = FormatValuePerTurn;
local GameEvents = ExposedMembers.GameEvents
local FaithAmount = 0; --扣掉的信仰数值
local AddPROPHET = 0; --增加的大仙数值
local AddRed = 0; --
whetherToConvert = {};
PPK_FixBug = {};
local greatEngID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_PROPHET'].Index
function GetGreatPeopleInfo(playerID)
	local player = Players[playerID]
	local PointsTotal	= player:GetGreatPeoplePoints():GetPointsTotal(greatEngID);
	local PointsPerTurn	= player:GetGreatPeoplePoints():GetPointsPerTurn(greatEngID);
	local pGreatPeople	:table  = Game.GetGreatPeople();
	local pTimeline = pGreatPeople:GetTimeline();
	local recruitCost = pTimeline[greatEngID].Cost;
	return PointsTotal, PointsPerTurn, recruitCost;
end

function FaithConvertGreatPeoplePoints(playerID)
	local PointsTotal, PointsPerTurn, recruitCost = GetGreatPeopleInfo(playerID)
	local NeedToEndTheRound = recruitCost - PointsTotal -- - PointsPerTurn;
	if NeedToEndTheRound <= 0 and whetherToConvert[playerID] then whetherToConvert[playerID] = false; PPK_FixBug[playerID] = true; return; end
	local faithBalance:number = Round( Players[playerID]:GetReligion():GetFaithBalance() );--目前信仰值（不是当前回合产量）--这个貌似给UI环境，没测试game环境
	--local faithYield :number = Round( Players[playerID]:GetReligion():GetFaithYield(),1 );--信仰产量
	local gameSpeed = GameConfiguration.GetGameSpeedType()
	--local iSpeedCostMultiplier = GameInfo.GameSpeeds[gameSpeed].CostMultiplier * 0.01--游戏速度
	--local greatEngID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_PROPHET'].Index
	--local amount = faithBalance * 0.01 * iSpeedCostMultiplier--具体怎么给大仙数值？？
	
	FaithAmount = 0; --清除
	if faithBalance ~= nil then
		if faithBalance < 2 then  return; end --目前为2信仰转1大仙数值,所以必须大于2
		local Amount1,Amount2 = math.modf(faithBalance / 2)
		--当转的大仙数大于成功招聘大仙需要数时，加的数等于大仙需要数，同时及时锁函数
		if Amount1 > NeedToEndTheRound then Amount1 = NeedToEndTheRound; whetherToConvert[playerID] = false; PPK_FixBug[playerID] = true; end
		AddPROPHET = Amount1
		GameEvents.AddGreatPeoplePoints.Call(playerID, greatEngID, Amount1)
		FaithAmount = Amount1 * 2;
	end
	
	GameEvents.RequestChangeFaithBalance.Call(playerID, -FaithAmount);--修改信仰，需要调用game函数环境
	--print(FaithAmount)
	RefreshYields()
end

function DA_ppkPlayerTurnActivated()
	local playerID = Game.GetLocalPlayer()
	local pPlayer = Players[playerID];
	local pReligion = pPlayer:GetReligion();
	local m_Religion = pReligion:GetReligionTypeCreated();
	local m_PantheonBelief = pReligion:GetPantheon();
	if PPK_FixBug[playerID] == nil then PPK_FixBug[playerID] = false; end
	if PPK_FixBug[playerID] then return; end
	if whetherToConvert[playerID] == nil then whetherToConvert[playerID] = false; end
	whetherToConvert[playerID] = false;
	-- 万神殿未完成或宗教创建后结束转换
	if (m_PantheonBelief < 0) or (m_Religion >= 0) then return; else whetherToConvert[playerID] = true; end
	if whetherToConvert[playerID] then FaithConvertGreatPeoplePoints(playerID); end
end

function GetFaithTooltip()
	local szReturnValue = "";

	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local playerReligion		:table	= Players[localPlayerID]:GetReligion();
		local faithYield			:number = playerReligion:GetFaithYield();
		local faithBalance			:number = playerReligion:GetFaithBalance();

		szReturnValue = Locale.Lookup("LOC_TOP_PANEL_FAITH_YIELD");
		local faith_tt_details = playerReligion:GetFaithYieldToolTip();
		if(#faith_tt_details > 0) then
			szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]" .. faith_tt_details;
		end
	end
	local ePlayer:number = Game.GetLocalPlayer();
	if whetherToConvert[ePlayer] == nil then whetherToConvert[ePlayer] = false; end
	if whetherToConvert[ePlayer] then szReturnValue = "[COLOR:ResMilitaryLabelCS]" .."本回合已转化" ..FaithAmount .." [ICON_FAITH] 信仰值为"..AddPROPHET .. " [ICON_GreatProphet] 大预言家点数，在招募第一个大预言家后转化即会停止。[ENDCOLOR][NEWLINE]" ..szReturnValue end
	return szReturnValue;
end
function FormatValuePerTurn( value:number )
	local String1 = PPK_FormatValuePerTurn(value);
	local ePlayer:number = Game.GetLocalPlayer();
	if whetherToConvert[ePlayer] == nil then whetherToConvert[ePlayer] = false; end
	if whetherToConvert[ePlayer] then
		AddRed = AddRed + 1
		if AddRed == 3 then String1 = "[COLOR:ButtonCS][COLOR:ResMilitaryLabelCS]" ..String1 .. "[ENDCOLOR][ENDCOLOR][ICON_GreatProphet]" end
	end
	return String1;
end
function RefreshYields()
	AddRed = 0
	PPK_RefreshYields()
end
function AddGreatPersonProphet(playerID:number, unitID:number)
	if PPK_FixBug[playerID] == nil then PPK_FixBug[playerID] = false; end
	if PPK_FixBug[playerID] then return end
	local player:table = Players[playerID]
	local unit:table = player:GetUnits():FindID(unitID)

	if not unit then return end
	
	local greatPerson:table = unit:GetGreatPerson()
	if greatPerson:IsGreatPerson() then
		local greatPersonID = greatPerson:GetIndividual()
		local greatPersonDetails = GameInfo.GreatPersonIndividuals[greatPersonID]
		local greatPersonType = Locale.Lookup(greatPersonDetails.GreatPersonClassType)
		if greatPersonType == "GREAT_PERSON_CLASS_PROPHET" then PPK_FixBug[playerID] = true; whetherToConvert[playerID] = false end--print("--ppkk--"); end
	end
end
local function ppkInitialize()
	Events.LoadGameViewStateDone.Add(function()
		Events.UnitAddedToMap.Add(AddGreatPersonProphet);
	end)
	Events.PlayerTurnActivated.Add(DA_ppkPlayerTurnActivated);
end

ppkInitialize()
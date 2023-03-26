
GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils
function AIChoosePantheon()
	--print(1)
	local Godhoods = DB.Query('SELECT distinct GodhoodType FROM Godhood');
	local Powers = DB.Query('SELECT distinct PowerType FROM Power');
	for _, player in ipairs(PlayerManager.GetAliveMajors()) do
		local pReligion = player:GetReligion();
		if pReligion ~= nil and Utils.IsAI(player:GetID()) then
			local iPantheon = pReligion:GetPantheon();
			if iPantheon == nil or iPantheon == -1 then
				local iFaithBalance = pReligion:GetFaithBalance();
				local iFaithThreshold = GameInfo.GlobalParameters['RELIGION_PANTHEON_MIN_FAITH'].Value;
				if iFaithBalance > tonumber(iFaithThreshold) - 10 then -- 10 !
					local iGodhood = Game.GetRandNum(#Godhoods, 'Godhoods')+1;
					local sGodhood = Godhoods[iGodhood]['GodhoodType'];
					local iPower = Game.GetRandNum(#Powers, 'Powers')+1;
					local sPower = Powers[iPower]['PowerType']
					print('BELIEF_'..sGodhood..'_WITH_'..sPower..'  for AI'..player:GetID())
					local gReligion = Game.GetReligion();
					if not gReligion:HasBeenFounded(GameInfo.Beliefs['BELIEF_'..sGodhood..'_WITH_'..sPower].Index) then
						gReligion:FoundPantheon(player:GetID(), GameInfo.Beliefs['BELIEF_'..sGodhood..'_WITH_'..sPower].Index);
					end
				end
			end
		end
	end
end
Events.LoadGameViewStateDone.Add(function()	
	Events.TurnBegin.Add(AIChoosePantheon);
end)



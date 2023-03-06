include( "InstanceManager" );
include( "SupportFunctions" ); -- Round
include( "ToolTipHelper_PlayerYields" );

function RefreshAll()
	local pGameReligion:table = Game.GetReligion();
	local allReligions:table = pGameReligion:GetReligions();
	for _, religionInfo in ipairs(allReligions) do
		local religionData = GameInfo.Religions[religionInfo.Religion];
		if(religionData.Pantheon == false and pGameReligion:HasBeenFounded(religionInfo.Religion)) then


end

 

function GetPantheonOfReligion(pReligion:number)
	local majorPlayers:table = PlayerManager.GetAlive();
	local pPanthons:table = {};
	for _, player in ipairs(majorPlayers) do
		local playerID:number = player:GetID();
		local playerReligion:table = player:GetReligion();
		local playerPantheon:number = playerReligion:GetPantheon();
		local playerMajorReligion:number = playerReligion:GetReligionInMajorityOfCities();
		if(playerMajorReligion == pReligion) then
			pPanthons.insert(playerPantheon);
		end
	end	
	return pPanthons;
end

function OnTurnBegin()	
	RefreshAll();
end

Events.TurnBegin.Add(OnTurnBegin);

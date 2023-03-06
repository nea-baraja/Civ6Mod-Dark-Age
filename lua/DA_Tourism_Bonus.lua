
GameEvents = ExposedMembers.GameEvents


MajorPlayersNumber = 0;
Tourists = {}
function CalculateTourists()
	for i = 0,MajorPlayersNumber do
		Tourists[i] = {}
		Tourists[i].LocalTourists = Players[i]:GetCulture():GetLifetimeCulture()/100
		Tourists[i].InternationalTourists = {}
		Tourists[i].TotalLosed = 0
		Tourists[i].TotalGained = 0
		for j = 0,MajorPlayersNumber do
			Tourists[i].InternationalTourists[j] = Players[i]:GetCulture():GetTouristsFrom(j)
			Tourists[i].TotalGained = Tourists[i].TotalGained + Tourists[i].InternationalTourists[j]

		end
	end
	for i = 0,MajorPlayersNumber do
		Tourists[i].LosedTourists = {}
		for j = 0,MajorPlayersNumber do
			Tourists[i].LosedTourists[j] = Players[j]:GetCulture():GetTouristsFrom(i)
			Tourists[i].TotalLosed = Tourists[i].TotalLosed + Tourists[i].LosedTourists[j]
		end
	end
	Game.SetProperty('PROP_TOURISTS', Tourists)
end


function GainBonus(oldTour)
	
end

function onNextTurn()
	local oldTour = Game.GetProperty('PROP_TOURISTS') 
	CalculateTourists()
	GainBonus()
	print('haha'..Tourism[0].InternationalTourists[2]..'and'..Tourism[2].LocalTourists..'and'..Tourism[2].TotalLosed)
end

Events.TurnBegin.Add(onNextTurn);



function Initialize()
	for i,v in pairs(Players) do
		if(v:IsMajor()) then
			MajorPlayersNumber = i
		else 
			break
		end
  end
end
Initialize()

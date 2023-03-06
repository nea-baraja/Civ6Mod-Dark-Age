--include("EventPopup")
function OnTurnBegin()
	print(1111);
	unlockA = {};
	unlockA.Effects = {Locale.Lookup("LOC_EVENT_GOODY_HUMAN_SACRIFICE_GAIN_FAITH",10)};
	unlockA.EffectIcons = {"Faith"};

	unlockB = {};
	unlockB.Effects = {Locale.Lookup("LOC_EVENT_GOODY_HUMAN_SACRIFICE_GAIN_FAITH",20), 'LOC_EVENT_GOODY_HUMAN_SACRIFICE_LOSE_POP'};
	unlockB.EffectIcons = {"Faith", "Citizen"};

	ReportingEvents.Send("EVENT_POPUP_REQUEST", { ForPlayer = 0, EventKey = "EVENT_GOODY_HUMAN_SACRIFICE", ChoiceAText ="LOC_EVENT_GOODY_HUMAN_SACRIFICE_CHOICE_A", ChoiceBText="LOC_EVENT_GOODY_HUMAN_SACRIFICE_CHOICE_B",ChoiceAUnlocks=unlockA,ChoiceBUnlocks=unlockB});
	--ReportingEvents.Send("EVENT_POPUP_REQUEST", { ForPlayer = 0, EventKey = "POPUP_SCENARIO_PLAGUE_APPEARS", ChoiceAText ="qqq", ChoiceBText="www"});

	--ReportingEvents.Send("EVENT_POPUP_REQUEST", { ForPlayer = 0, EventKey = "POPUP_SCENARIO_PLAGUE_APPEARS"});


end

--Events.TurnBegin.Add(OnTurnBegin);
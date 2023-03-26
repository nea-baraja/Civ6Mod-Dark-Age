-- Copyright 2020, Firaxis Games

-- This file is being included into the base NotificationPanel file using the wildcard include setup in NotificationPanel.lua
-- Refer to the bottom of NotificationPanel.lua to see how that's happening
-- DO NOT include any NotificationPanel files here or it will cause problems
GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils

local BASE_RegisterHandlers = RegisterHandlers;
local BASE_LateInitialize = LateInitialize;
local m_PurchasePantheon = DB.MakeHash("NOTIFICATION_PURCHASE_PANTHEON")


function OnActivatePantheonPurchase(notificationEntry, notificationID:number, activatedByUser:boolean)
	if (notificationEntry ~= nil and notificationEntry.m_PlayerID == Game.GetLocalPlayer()) then
		local pNotification :table = GetActiveNotificationFromEntry(notificationEntry, notificationID);
		if pNotification ~= nil then
			local iSeller = pNotification:GetValue("iSeller");
			print(iSeller)
			local pPlayer = Players[ Game.GetLocalPlayer()];
		--[[local pPlayer = Players[iSellPlayer];
		local pReligion = pPlayer:GetReligion();
		local iPantheon = pReligion:GetPantheon();
		local sPantheon = GameInfo.Beliefs[iPantheon].BeliefType;
		local sPantheonName = Locale.Lookup(GameInfo.Beliefs[iPantheon].Name);
		local sPantheonDesc = Locale.Lookup(GameInfo.Beliefs[iPantheon].Description);]]
			local PurchaseNotifications = pPlayer:GetProperty('PROP_PURCHASE_NOTIFICATIONS') or {};
			print(notificationID)
			PurchaseNotifications[iSeller] = notificationID;
			GameEvents.SetPlayerProperty.Call(Game.GetLocalPlayer(), 'PROP_PURCHASE_NOTIFICATIONS', PurchaseNotifications);
			GameEvents.TriggerCommonEvent.Call(Game.GetLocalPlayer(), 'EVENT_COMMON_PURCHASE_PANTHEON', {iSeller = iSeller});
		end
	end
end

function OnTryDismissPantheonPurchase( notificationEntry : NotificationType )
	--Do not dismiss
end


function RegisterHandlers()

	BASE_RegisterHandlers();

	g_notificationHandlers[m_PurchasePantheon]						= MakeDefaultHandlers();
	g_notificationHandlers[m_PurchasePantheon].Activate				= OnActivatePantheonPurchase;
	g_notificationHandlers[m_PurchasePantheon].AddSound				= "ALERT_POSITIVE";
	g_notificationHandlers[m_PurchasePantheon].TryDismiss			= OnTryDismissPantheonPurchase;

end
--[[function LateInitialize()
	BASE_LateInitialize();
	--LuaEvents.Notification_ShowSoraLaTriggeredNotification.Add(OnSoraLaTriggered);
end]]










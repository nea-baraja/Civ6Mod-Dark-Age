-- ===========================================================================
-- UI Side script for handling the popups in the scenario
--
-- Note, this is currently being loaded into the UI side by getting included
-- in the TopOptions override for this scenario.
-- ===========================================================================

-- ===========================================================================
-- Handle the local user's choice in a popup and send a player operation
-- to call a script on the GameCore side through the "EventPopupChoice" GameEvent on every client.  
-- This ensures that all netwrok clients handle the choice in the same way.
function OnEventPopupResponse(pPopupData : table)
	print("OnEventPopupResponse: Event Received: " .. pPopupData.EventKey);

	-- Verify data
	if (Game.GetLocalPlayer() ~= pPopupData.ForPlayer) then
		print("OnEventPopup: " .. pPopupData.EventKey .. "not for local player, discarding");
		return;
	end

	-- Network choice as a player operation.
	local kParameters:table = {};
	kParameters.EventKey = pPopupData.EventKey;
	kParameters.ResponseIndex = pPopupData.ResponseIndex or -1;
	kParameters.ForPlayer = pPopupData.ForPlayer;
	-- Send this GameEvent when processing the operation
	kParameters.OnStart = "EventPopupChoice";
	UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters);
end

-- ===========================================================================
function OnUserNotificationActivate( notificationPlayerID : number, notificationID : number )

	-- This handles the activation of one of the User Defined notifications.
	-- This scenario uses several types and all of them will pass through here, though
	-- this is only checking for the ones that have PopupData attached.
	local pNotification	:table = NotificationManager.Find( notificationPlayerID, notificationID );
	if pNotification ~= nil then
		if not pNotification:IsDismissed() then
			-- Get the popup data
			local pPopupData = pNotification:GetValue("PopupData");
			-- Does it have any?  If not, then this is one of the other user notifications
			if pPopupData ~= nil then
				-- Yes, dismiss the notification and pass the popup request through.
				NotificationManager.Dismiss( pNotification );
				LuaEvents.EventPopupRequest( pPopupData );
			end
		end
	end

end

-- ===========================================================================
function InitializePopups()
	Events.EventPopupResponse.Add(OnEventPopupResponse);

	LuaEvents.NotificationPanel_UserNotificationActivate.Add( OnUserNotificationActivate );

end

-- ===========================================================================
InitializePopups();

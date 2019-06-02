----------------------------------------
-- Server Notification, Made by FAXES --
----------------------------------------

-- Config Area --

rPeacetime = true		-- Enables the peacetime command(s) Values: true, false

-- Code --
AddEventHandler('chatMessage', function(source, name, msg)

-- Server Restart Commands List Command
RegisterCommand("svrlist", function()
	if IsPlayerAceAllowed(source, "fax.cmds") then
		TriggerClientEvent('RestartList', source)
	else
		TriggerClientEvent('Restart:NoPerms', source)
	end
end)

-- Server Restart in 5 Mins Command
RegisterCommand("svr5", function()
	if IsPlayerAceAllowed(source, "fax.cmds") then
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n SERVER KHỞI ĐỘNG LẠI SAU 5 PHÚT \n Vui lòng hoàn thành và thoát game \n ——————————————————————", {239, 0, 0})
	else
		TriggerClientEvent('Restart:NoPerms', source)
	end
end)

-- Server Restart in 10 Mins Command
RegisterCommand("svr10", function()
	if IsPlayerAceAllowed(source, "fax.cmds") then
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n SERVER KHỞI ĐỘNG LẠI SAU 10 PHÚT \n Vui lòng hoàn thành và thoát game \n ——————————————————————", {239, 0, 0})
	else
		TriggerClientEvent('Restart:NoPerms', source)
	end
end)

-- Server Restart Now Command
RegisterCommand("svrnow", function()
	if IsPlayerAceAllowed(source, "fax.cmds") then
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n SERVER RESTART IS IN PROGRESS \n Please Rejoin the server  \n ——————————————————————", {239, 0, 0})
		SetGameType("SERVER CURRENTLY RESTARTING")
			AddEventHandler("playerConnecting", function()
				DropPlayer(source, 'The Server is restarting, Rejoin in a minute.')
			end)
	else
		TriggerClientEvent('Restart:NoPerms', source)
	end
end)

-- Server Restart Start Timer
RegisterCommand("svrstart", function()
	if IsPlayerAceAllowed(source, "fax.cmds") then
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n SERVER RESTART IN 10 MINUTES \n Please Finish Your Current RP Scenario \n ——————————————————————", {239, 0, 0})
		Wait(300000)
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n SERVER RESTART IN 5 MINUTES \n Please Finish Your Current RP Scenario \n ——————————————————————", {239, 0, 0})
		SetGameType("Server Restarting Soon")
		Wait(300000)
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n SERVER RESTART IS IN PROGRESS \n Please Rejoin the server  \n ——————————————————————", {239, 0, 0})
		SetGameType("SERVER CURRENTLY RESTARTING")
	else
		TriggerClientEvent('Restart:NoPerms', source)
	end
end)

-- Command for Peace Time on
RegisterCommand("pton", function()
	if IsPlayerAceAllowed(source, "fax.cmds") then
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n PEACE TIME IS NOW IN EFFECT \n This Means No Priority Calls.  \n ——————————————————————", {239, 0, 0})
		SetGameType("Peace Time In Effect")
	else
		TriggerClientEvent('Restart:NoPerms', source)
	end
end)

-- Command for Peace Time on
RegisterCommand("ptoff", function()
	if IsPlayerAceAllowed(source, "fax.cmds") then
		TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n PEACE TIME IS NO LONGER IN EFFECT \n Resume Normal RP.  \n ——————————————————————", {239, 0, 0})
			SetGameType("Freeroam")
	else
		TriggerClientEvent('Restart:NoPerms', source)
	end
end)

end)

-- Announcement Command
AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/a" then
		if IsPlayerAceAllowed(source, "fax.cmds") then
        CancelEvent()
				TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n ADMINISTRATION ANNOUNCEMENT \n " .. string.sub(msg,3) .. " \n ——————————————————————", {239, 0, 0})
		else
			TriggerClientEvent('AOP:NoPerms', source)
		end
  end
end)

-- Function for Announcement Command
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
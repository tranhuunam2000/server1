-- CONFIG --

-- Ping Limit
pingLimit = 600

-- CODE --

RegisterServerEvent("checkMyPingBro")
AddEventHandler("checkMyPingBro", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "Ping qua cao gioi han " .. pingLimit .. " Ping cua ban: " .. ping .. ")")
	end
end)
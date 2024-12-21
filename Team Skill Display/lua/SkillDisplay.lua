if not MUIStats then return end

if RequiredScript == "lib/network/base/networkpeer" then
	Hooks:Add("NetworkManagerOnPeerAdded", "Skillinfo:PeerAdded", function()
		Skillinfo:UpdatePanelPositions()
	end)

	Hooks:Add("BaseNetworkSessionOnPeerRemoved", "Skillinfo:PeerRemoved", function(peer, peer_id)
		for j = 1, 9 do
			Skillinfo.Players[peer_id][j] = 0
		end

		for i = 1, 4 do
			if Skillinfo.stats and Skillinfo.stats[i]:alpha() > 0 then
				Skillinfo.stats[i]:hide()
			end
		end
		Skillinfo:UpdatePanelPositions()
	end)

elseif RequiredScript == "lib/managers/hudmanagerpd2" then	
	Hooks:PostHook(HUDManager, "show_stats_screen", "HUDManager_show_stats_screen_skillinfo", function (self)
		if managers.network:session() and Utils:IsInHeist() then
			Skillinfo:Information_To_HUD(managers.network:session():peer(_G.LuaNetworking:LocalPeerID()))
			for _, peer in pairs(managers.network:session():peers()) do
				Skillinfo:Information_To_HUD(peer)
			end
			Skillinfo:InfoPanel()
		end
	end)
	
	Hooks:PostHook(HUDManager, "hide_stats_screen", "HUDManager_hide_stats_screen_skillinfo", function (self)
		if managers.network:session() and Utils:IsInHeist() then
			for i = 1, 4 do
				if Skillinfo.stats and Skillinfo.stats[i]:alpha() > 0 then
					Skillinfo:FadeEffect(Skillinfo.stats[i], "out", 0.4, 25)
				end
			end
		end
	end)

elseif RequiredScript == "lib/utils/accelbyte/telemetry" then
	Hooks:PostHook(Telemetry, "on_end_heist", "skillinfo_on_end_heist", function(self)
		for i = 1, 4 do
			if Skillinfo.stats and Skillinfo.stats[i]:alpha() > 0 then
				Skillinfo.stats[i]:hide()
			end
		end
	end)
end
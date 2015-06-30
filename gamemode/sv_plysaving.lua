
util.AddNetworkString("SendInventoryToClient")

local function LoadData(ply)
	if IsValid(ply:GetPData("PlayerData")) then
		ply.Inventory = ply:GetPData("PlayerData")
			net.Start("SendInventoryToClient")
				net.WriteTable(ply.Inventory)
			net.Send(ply)
	else
		ply.Inventory = {}
		ply.Inventory["Money"] = 0
		-- Any first time set vars
		net.Start("SendInventoryToClient")
			net.WriteTable(ply.Inventory)
		net.Send(ply)
	end
end
hook.Add("PlayerInitialSpawn", "Heist_LoadData", LoadData)
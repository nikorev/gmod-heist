
local function GetInventory()
	Inventory = net.ReadTable()
	PrintTable(Inventory)
end
net.Receive("SendInventoryToClient", GetInventory)

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self:SetModel("models/props/cs_assault/Money.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetPos(self:GetPos() + Vector(0,0,10))
	self:SetAngles(angle_zero)
	self:SetUseType( SIMPLE_USE )
	local phys = self:GetPhysicsObject()

	phys:Wake()
end

function ENT:Use( activator, caller )
local moneyvalues = {20,100,1000,2000,5000,10000}
local key,value = table.Random(moneyvalues)
	activator.Inventory["Money"] = activator.Inventory["Money"] + value
	
net.Start("SendInventoryToClient")
	net.WriteTable(activator.Inventory)
net.Send(activator)

self:Remove()
end
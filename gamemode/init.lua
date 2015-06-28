// SERVERSIDE

include("shared.lua")
include("sh_teams.lua")
include("sh_marking.lua")

include("sv_marking.lua")
include("sv_fastdl.lua")

AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_marking.lua")


//ebell@comsewogue.k12.ny.us

util.AddNetworkString( "openhudplayerlist" )


function openhudderma(ply)
timer.Simple(1, function()
	net.Start( "openhudplayerlist" )
	net.Send( ply )
end)
end
hook.Add("PlayerSpawn", "openhudderma", openhudderma)

function setteam(ply)
	ply:SetTeam(1)
	ply:Give("weapon_crowbar")
end
hook.Add("PlayerSpawn", "setteam", setteam)

function GM:PlayerSetModel( ply )
	if ply:Team(1) then
		ply:SetModel("models/player/kleiner.mdl")
	end
end


-- GET ENTITY LOOKING AT
function lolol(ply, key)
if ( key == IN_USE ) then
	print(ply:GetEyeTrace().Entity)
end
end
hook.Add("KeyPress", "lolol", lolol)



function IsDoorLocked()
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "prop_door_rotating" then
			if v:GetSaveTable( ).m_bLocked == true then
				-- LOCKED IMAGE ON DOOR 3D2D
			else
				-- UNLOCKED IMAGE ON DOOR 3D2D
			end
		end
	end
end
hook.Add("InitPostEntity", "IsDoorLocked", IsDoorLocked)


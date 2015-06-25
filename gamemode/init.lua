// SERVERSIDE

include("shared.lua")

AddCSLuaFile("cl_hud.lua")

//ebell@comsewogue.k12.ny.us

util.AddNetworkString( "openhudplayerlist" )


function openhudderma(ply)
	net.Start( "openhudplayerlist" )
	net.Send( ply )
end
hook.Add("PlayerSpawn", "openhudderma", openhudderma)

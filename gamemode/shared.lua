// SHARED

GM.Name = "GMOD Heist"
GM.Author = "Nikorev and Helix Original"
GM.Email = "N/A"
GM.Website = "N/A"

if SERVER then
  AddCSLuaFile("shared.lua")
end

function GM:Initialize()
	MsgC(Color(0, 255, 0), "GMOD HEIST INITIALIZED\n")
end

function antiteamdamage(ply, attacker)
if ply:Team() == attacker:Team() then return false end
end
hook.Add("PlayerShouldTakeDamage", "antiteamdamage", antiteamdamage)



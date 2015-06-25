AddCSLuaFile("cl_hud.lua")

function heisthud()
	if LocalPlayer():Alive() then
		draw.RoundedBox(0, 50, 50, 300, 300, Color(255, 0, 0, 255))
	end
end
hook.Add("HUDPaint", "heisthud", heisthud)

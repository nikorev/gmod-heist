// SERVERSIDE

include("shared.lua")


-- AUTO INCLUDE

function svModules()
	for k,v in pairs(file.Find("gmod-heist/gamemode/*.lua", "LUA")) do
		if string.sub(v,1,2) == "sv" then
			MsgC( Color(0, 255, 0), "[GMOD-Heist]", Color(255, 255, 255), ": Loaded serverside file "..v.."\n")
			include("gmod-heist/gamemode/"..v)
		end
	end
end
svModules()

//ebell@comsewogue.k12.ny.us

local function AddClModules()
	for k,v in pairs(file.Find("gmod-heist/gamemode/*.lua", "LUA")) do
		if string.sub(v,1,3) == "cli" then
			MsgC( Color(0, 255, 0), "[GMOD-Heist]", Color(255, 255, 255), ": Loaded clientside file "..v.."\n")
			AddCSLuaFile("gmod-heist/gamemode/"..v)
		end
	end
end
hook.Add("Initialize", "Cl_Modules_Hook", AddClModules) 


local function AddShModules()
	for k,v in pairs(file.Find("gmod-heist/gamemode/*.lua", "LUA")) do
		if string.sub(v,1,2) == "sh" then 
			MsgC( Color(0, 255, 0), "[GMOD-Heist]", Color(255, 255, 255), ": Loaded shared file "..v.."\n")
			AddCSLuaFile(v)
			include(v)
		end
	end
end
AddShModules()
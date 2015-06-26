// MARKING ENEMIES
local markeditemscli

net.Receive("markeditemstocli", function(len, ply)
	markeditemscli = net.ReadTable()
end)

function halos()
    if istable(markeditemscli) then
        for k,v in pairs(markeditemscli) do
            if not IsValid(v) or LocalPlayer() == v then continue; end
			
			local dist = (LocalPlayer():GetShootPos() - v:GetPos()):Length()
			
			if (dist < 1000) then
				halo.Add({v}, Color(255, 0, 0, 255), .1, .1, 2, true, true)
			end
        end
    end
end
hook.Add("PreDrawHalos", "halos", halos)
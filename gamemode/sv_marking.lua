// MARKING ENEMIES

util.AddNetworkString( "markeditemstocli" )
 
markeditems = { }
 
function marktotable( ply, key )
local oldent
 
local trace_ent = ply:GetEyeTrace().Entity
 
if ( key == IN_USE ) then
if trace_ent:Health() > 0 then
table.insert(markeditems, ply:GetEyeTrace().Entity)
 
net.Start("markeditemstocli")
net.WriteTable(markeditems)
net.Send(ply)
 
for k,v in pairs(markeditems) do
        if v == trace_ent then
                oldent = k
        end
end
 
-- AUTOMATIC REMOVE
 
timer.Simple(10, function()
markeditems[oldent] = nil
net.Start("markeditemstocli")
net.WriteTable(markeditems)
net.Send(ply)
 
end)
 
end
end
end
hook.Add("KeyPress", "marktotable", marktotable)
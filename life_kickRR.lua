--SERVER_SV_S
local life_rr = 0
RegisterCommand('lfrr',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"SuaPermissao") then
        if not args[1] then return end
        if args[1] == "cancelar" then
            life_rr = 0
        end
        if parseInt(args[1]) > 0 then
            life_rr = parseInt(args[1])
            TriggerClientEvent('chatMessage',-1,"Aviso",{255,160,0},"Terremoto Previsto na cidade em "..life_rr.." minutos!")
            TriggerClientEvent("Notify",source,"important","Cuidado com o TERREMOTO em "..life_rr.."MINUTOS.. Se esconda!!",5000)
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(60000)
                    if life_rr > 0 then
                        life_rr = life_rr - 1
                        if life_rr == 0 then
                            local users = vRP.getUsers()
                            for k,v in pairs(users) do
                                local id = vRP.getUserSource(parseInt(k))
                                if id then
                                    vRP.kick(user_id,"Reiniciando Servidor!!")
                                end
                            end
                        else
                           TriggerClientEvent('chatMessage',-1,"[Aviso]",{255,160,0},"Terremoto Previsto na cidade em "..life_rr.." minutos, se esconda e guarde seus itens!")
                           TriggerClientEvent("Notify",source,"amarelo","Cuidado com o TERREMOTO em "..life_rr.."MINUTOS.. Se esconda!!",5000)
                        end
                    end
                end
            end)
        end
    end
end)

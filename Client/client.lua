local spawnedExtinguishers = {}
local IsCarrying = false
local currentExtinguisher = ""

AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then 
        return
    end 

    local extinguisherModel = config.extinguisherName

    for i,v in pairs(config.locations) do 
        RequestModel(extinguisherModel)

        while not HasModelLoaded(extinguisherModel) do
            Wait(500)
        end

        local spawnedExtinguisher = CreateVehicle(extinguisherModel, v.x, v.y, v.z, v.w, true, false)

        FreezeEntityPosition(spawnedExtinguisher, true)
        SetEntityInvincible(spawnedExtinguisher, true)

        SetVehicleExtra(spawnedExtinguisher, 1, 0)
        SetVehicleExtra(spawnedExtinguisher, 2, 0)

        table.insert(spawnedExtinguishers, spawnedExtinguisher)

    end
end)

RegisterCommand("delex", function()
    for i,v in pairs(spawnedExtinguishers) do 
        DeleteVehicle(v)
    end
end)



function extinguisherPickup(extinguisherSet, extra)
    IsCarrying = true
    currentExtinguisher = config.types[extra]

    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher"), 9999, false, true)
    SetVehicleExtra(extinguisherSet, extra, 1)
end


function extinguisherReplace(extinguisherSet, type)
    IsCarrying = false
    extra = 0

    for i,v in pairs(config.types) do 
        if v == type then 
            extra = i
        end
    end

    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher"))
    SetVehicleExtra(extinguisherSet, extra, 0)
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        for i,v in pairs(spawnedExtinguishers) do 
            local extinguisherCoord = GetEntityCoords(spawnedExtinguishers[i])
            local playerCoord = GetEntityCoords(PlayerPedId(), false)

            if Vdist2(playerCoord, extinguisherCoord) < 2*1.12 then 

                if IsCarrying then 

                    AddTextEntry('HelpMsg2', 'Press ~INPUT_CONTEXT~ to replace '.. currentExtinguisher ..' extinguisher.')

                    BeginTextCommandDisplayHelp('HelpMsg2')
                    EndTextCommandDisplayHelp(0, false, true, 3000)
                    
                    if IsControlJustReleased(0, 38) then 
                        extinguisherReplace(v, currentExtinguisher)
                    end
                
                else 
                    AddTextEntry('HelpMsg', 'Press ~INPUT_CONTEXT~ to pick up water extinguisher. \nPress ~INPUT_ARREST~ to pick up foam extinguisher.')

                    BeginTextCommandDisplayHelp('HelpMsg')
                    EndTextCommandDisplayHelp(0, false, true, 3000)
                    
                    if IsControlJustReleased(0, 38) then
                        extinguisherPickup(v, 1)
                    elseif IsControlJustReleased(0, 49) then 
                        extinguisherPickup(V, 2)
                    end
                end
            end
        end
    end
end)

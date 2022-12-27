local spawnedExtinguishers = {}
local IsCarrying = false
local currentExtinguisher = ""

function loadExtinguishers()
    local extinguisherModel = config.extinguisherName

    for i,v in pairs(config.locations) do 
        RequestModel(extinguisherModel)

        while not HasModelLoaded(extinguisherModel) do
            Wait(500)
        end

        local spawnedExtinguisher = CreateVehicle(extinguisherModel, v.x, v.y, v.z, v.w, true, false)

        FreezeEntityPosition(spawnedExtinguisher, true)
        SetEntityInvincible(spawnedExtinguisher, true)
        SetVehicleAutoRepairDisabled(spawnedExtinguisher, true)

        if DoesExtraExist(spawnedExtinguisher, 1) and DoesExtraExist(spawnedExtinguisher, 2) then 
            SetVehicleExtra(spawnedExtinguisher, 1, 0)
            SetVehicleExtra(spawnedExtinguisher, 2, 0)
        end

        table.insert(spawnedExtinguishers, spawnedExtinguisher)

    end
end

RegisterCommand("delex", function()
    for i,v in pairs(spawnedExtinguishers) do 
        DeleteVehicle(v)
    end
end, false)


function extinguisherPickup(extinguisherSet, extra)
    currentExtinguisher = config.types[extra]
    IsCarrying = true

    if config.playAnimation then 

        local dict = "anim@heists@narcotics@trash"
        loadAnimDict(dict)
        TaskPlayAnim(GetPlayerPed(-1), dict, 'pickup', 8.0, 1.0, -1, 48, 1)

        Wait(2000)
    
        SetVehicleExtra(extinguisherSet, extra, 1)
        if extra == 1 then 
            GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher"), 9999, false, true)
        else
            GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher2"), 9999, false, true)
        end
    else 
        SetVehicleExtra(extinguisherSet, extra, 1)
        if extra == 1 then 
            GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher"), 9999, false, true)
        else
            GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher2"), 9999, false, true)
        end
    end
end


function extinguisherReplace(extinguisherSet, type)
    IsCarrying = false
    extra = 0

    for i,v in pairs(config.types) do 
        if v == type then 
            extra = i
        end
    end

    if config.playAnimation then
        
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher"))
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher2"))

        local dict = "anim@heists@narcotics@trash"
        loadAnimDict(dict)
        TaskPlayAnim(GetPlayerPed(-1), dict, 'pickup', 8.0, 1.0, -1, 48, 1)

        Wait(2000)

        SetVehicleExtra(extinguisherSet, extra, 0)
    else 
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher"))
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("weapon_fireextinguisher2"))

        SetVehicleExtra(extinguisherSet, extra, 0)

    end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end



Citizen.CreateThread(function()

    loadExtinguishers()

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
                        extinguisherPickup(v, 2)
                    end
                end
            end
        end
    end
end)

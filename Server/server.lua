RegisterNetEvent("loadExtinguishers", function()
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
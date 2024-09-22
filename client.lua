-- client.lua
local healthData = {}

RegisterNetEvent('showHealthStatus')
AddEventHandler('showHealthStatus', function(data)
    healthData = data
    -- Display health data 
    print(('Health: %d, Hunger: %d, Thirst: %d'):format(data.health, data.hunger, data.thirst))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Update every minute
        
        if healthData.hunger > 0 then
            healthData.hunger = healthData.hunger - 1 -- Decrease hunger
        end

        if healthData.thirst > 0 then
            healthData.thirst = healthData.thirst - 1 -- Decrease thirst
        end

        -- Health effects based on hunger and thirst
        if healthData.hunger < 20 or healthData.thirst < 20 then
            healthData.health = healthData.health - 1 -- Decrease health if hungry or thirsty
        end
        
        -- Send updated data to server
        TriggerServerEvent('updateHealthData', healthData)
    end
end)

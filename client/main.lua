local QBCore = exports['qb-core']:GetCoreObject()
local insideLester = false
local LesterHouse = PolyZone:Create({
    vector2(1273.87, -1714.95),
    vector2(1274.74, -1716.98),
    vector2(1278.85, -1714.55),
    vector2(1276.05, -1708.7),
    vector2(1270.41, -1711.36),
    vector2(1271.5, -1713.62),
    vector2(1273.06, -1713.11)
}, {
    name="LesterHouse",
    minZ=51.0,
    maxZ=57.0,
    debugGrid=false,
    gridDivisions=25
})

Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetEntityCoords(plyPed)
        insideLester = LesterHouse:isPointInside(coord)
        Citizen.Wait(500)
    end
end)

local function SendEmail()
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = 'Лудия Джак',
        subject = "Стока",
        message = 'Сега съм тук побързай ще тръгвам скоро по работа',
        button = {
            enabled = true,
            buttonEvent = 'qb-blackmarket:Getjacklocation',
        }
    })
end

local function DisplayNotification(message, type, duration)
    TriggerEvent('QBCore:Notify', message, type, duration)
end

RegisterNetEvent('qb-blackmarket:Uselaptop', function()
    if insideLester then
        exports['ps-ui']:Thermite(function(success)
            if success then
                DisplayNotification('You just connected to Lester wifi', 'success', 5000)
                SendEmail()
            else
                DisplayNotification('No wifi', 'error', 5000)
            end
        end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10)
    end
end)

RegisterNetEvent('qb-blackmarket:Getjacklocation', function(data)
    local model = Config.model
    local coords2 = Config.Coords[math.random(#Config.Coords)]

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local entity = CreatePed(0, model, coords2, true, false)
    SetWaypointOff()
    SetNewWaypoint(coords2.x, coords2.y, coords2.z, 4) -- Set waypoint color to red (4)
end)

RegisterNetEvent('qb-blackmarket:Jackmenu', function()
    local jackList = {
        {
            isMenuHeader = true,
            header = 'Лудия Джак',
            icon = 'fa-solid fas fa-shop'
        }
    }

    for k, v in pairs(Config.Items) do
        jackList[#jackList + 1] = {
            header = QBCore.Shared.Items[k].label,
            txt = '$' .. v,
            icon = k,
            params = {
                isServer = true,
                event = 'qb-blackmarket:Buyitems',
                args = {
                    item = k,
                    price = v,
                }
            }
        }
    end

    jackList[#jackList + 1] = {
        header = 'Затвори',
        icon = 'fas fa-xmark',
        params = {
            event = 'qb-menu:client:closeMenu',
        }
    }

    exports['qb-menu']:openMenu(jackList)
end)

Citizen.CreateThread(function()
    local models = {
        Config.model,
    }

    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                num = 1,
                type = "client",
                event = "qb-blackmarket:Jackmenu",
                icon = 'fas fa-face-laugh-wink',
                label = 'Лудия Джак',
                canInteract = function(entity, distance, data) 
                    if GetEntityHealth(entity) <= 190 then
                        return false
                    end
                    return true
                end,
            }
        },
        distance = 1.5,
    })
end)

Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetEntityCoords(plyPed)
        insideLester = LesterHouse:isPointInside(coord)
        Citizen.Wait(500)
    end
end)

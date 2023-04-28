local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('darklaptop', function(source)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('vpn') then
    TriggerClientEvent('qb-blackmarket:Uselaptop', source)
    end
end)

RegisterNetEvent('qb-blackmarket:Buyitems', function (cd)
    local src = source 
	local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.Functions.GetMoney('cash')
    item = cd.item
    price = cd.price
    if Player.Functions.AddItem(item, 1) and cash >= price then
        Player.Functions.RemoveMoney('cash', price)
        Player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Cash", 'error')
    end
end)

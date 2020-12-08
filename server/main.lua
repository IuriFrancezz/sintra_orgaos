 
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sintra_orgaos:putInBed')
AddEventHandler('sintra_orgaos:putInBed', function(target)
	TriggerClientEvent('sintra_orgaos:putInBed', target)
end)

RegisterServerEvent('sintra_orgaos:remOnBed')
AddEventHandler('sintra_orgaos:remOnBed', function(target)
	TriggerClientEvent('sintra_orgaos:remOnBed', target)
end)

RegisterServerEvent('sintra_orgaos:remrim')
AddEventHandler('sintra_orgaos:remrim', function(target)
	TriggerClientEvent('sintra_orgaos:remrim', target)
end)

RegisterServerEvent('sintra_orgaos:remfigado')
AddEventHandler('sintra_orgaos:remfigado', function(target)
	TriggerClientEvent('sintra_orgaos:remfigado', target)
end)

RegisterServerEvent('sintra_orgaos:rempulmao')
AddEventHandler('sintra_orgaos:rempulmao', function(target)
	TriggerClientEvent('sintra_orgaos:rempulmao', target)
end)

RegisterServerEvent('sintra_orgaos:remcoracao')
AddEventHandler('sintra_orgaos:remcoracao', function(target)
	TriggerClientEvent('sintra_orgaos:remcoracao', target)
end)

RegisterServerEvent('sintra_orgaos:orgao')
AddEventHandler('sintra_orgaos:orgao', function(orgao)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addInventoryItem(orgao, 1)
end)

RegisterServerEvent('sintra_orgaos:buy')
AddEventHandler('sintra_orgaos:buy', function(name, price, label)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Quantity = xPlayer.getInventoryItem(name).count
	local pagamento = price * Quantity

	if Quantity >= 1 then
		xPlayer.removeInventoryItem(name, Quantity)
		xPlayer.addAccountMoney('black_money', pagamento)
		TriggerClientEvent('esx:showNotification', source, ("Você vendeu " .. Quantity .. " " .. label))
	else
		TriggerClientEvent('esx:showNotification', source, ("Você não tem " .. label .. " para vender"))
	end
end)
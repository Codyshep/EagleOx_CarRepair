ESX = exports['es_extended']:getSharedObject()

require('config')

RegisterServerEvent('RepairVehicle')
AddEventHandler('RepairVehicle', function()
    
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carkit', 1)

	TriggerClientEvent('EagleOx:onCarkit', source)
	
end)
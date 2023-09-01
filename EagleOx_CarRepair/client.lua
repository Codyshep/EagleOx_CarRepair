ESX = exports['es_extended']:getSharedObject()

require('config')

local itemForRepair = Repair_Config.RepairItem
local TimeToRepair = Repair_Config.TimeToRepair
local AllowedJob = Repair_Config.AllowedJob

exports.ox_target:addGlobalVehicle({
    {
        label = 'Repair Car',
        icon = 'fa-solid fa-toolbox',
        distance = 2,
        groups = {
            AllowedJob, -1
        },
        items = itemForRepair, 1,
        onSelect = function()
            TriggerServerEvent('RepairVehicle')
        end
    }
})

RegisterNetEvent('EagleOx:onCarkit')
AddEventHandler('EagleOx:onCarkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			CreateThread(function()
                lib.progressBar({
                    duration = TimeToRepair,
                    label = 'Repairing Vehicle',
                    allowCuffed = false,
                    canCancel = true
                })
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				lib.notify({
					title = 'Notification',
					description = 'You successfully repaired your vehicle',
					type = 'success'
				})
			end)
		end
	end
end)
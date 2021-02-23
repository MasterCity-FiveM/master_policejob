
local spawnedVehicles = {}

function OpenVehicleSpawnerMenu(type, station, part, partNum, StationData)
	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'right',
		elements = {
			{label = _U('garage_storeditem'), action = 'garage'},
			{label = _U('garage_storeitem'), action = 'store_garage'}
	}}, function(data, menu)
		if data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('esx_vehicleshop:retrieveJobGradeVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					local allVehicleProps = {}

					for k,v in ipairs(jobVehicles) do
					
						if IsModelInCdimage(v.name) then
							local label = v.label
							local car_plate = 'PD ' .. v.id
							car_data = {}
							if v.model_data ~= nil then
								car_data = json.decode(v.model_data)
							end
							
							car_data.plate = car_plate
							
							table.insert(garage, {
								label = label,
								model = v.name,
								plate = car_plate,
								stored = true
							})

							allVehicleProps[car_plate] = car_data
						end
					end

					if #garage > 0 then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
							title    = _U('garage_title'),
							align    = 'right',
							elements = garage
						}, function(data2, menu2)
							if data2.current.stored then
								local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum, StationData)

								if foundSpawn then
									menu2.close()

									ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
										local vehicleProps = allVehicleProps[data2.current.plate]
										
										ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
										--local debugp = ESX.Game.GetVehicleProperties(vehicle)
										--print_r(debugp)
										TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
										--TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.plate, false)

										local vehNet = NetworkGetNetworkIdFromEntity(vehicle)
										local plate = GetVehicleNumberPlateText(vehicle)
										TriggerServerEvent("car_lock:GiveKeys", vehNet, plate)
										exports.pNotify:SendNotification({text = _U('garage_released'), type = "success", timeout = 5000})
									end)
								else
									exports.pNotify:SendNotification({text = "فضای خالی برای خارج کردن خودرو وجود ندارد.", type = "error", timeout = 5000})
								end
							else
								exports.pNotify:SendNotification({text = _U('garage_notavailable'), type = "error", timeout = 4000})
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					else
						exports.pNotify:SendNotification({text = _U('garage_empty'), type = "error", timeout = 4000})
					end
				else
					exports.pNotify:SendNotification({text = _U('garage_empty'), type = "error", timeout = 4000})
				end
			end, type)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function StoreNearbyVehicle(playerCoords)
	local vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
	if #vehicles == 0 then
		exports.pNotify:SendNotification({text = "خودرویی اطراف شما نیست.", type = "error", timeout = 4000})
		return
	end
	
	for k,entity in ipairs(vehicles) do
		local attempt = 0

		while not NetworkHasControlOfEntity(entity) and attempt < 30.0 and DoesEntityExist(entity) do
			Wait(100)
			NetworkRequestControlOfEntity(entity)
			attempt = attempt + 1
		end

		if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
			ESX.Game.DeleteVehicle(entity)
			exports.pNotify:SendNotification({text = "خودرو به پارکینگ منتقل شد.", type = "success", timeout = 4000})
			return
		end
	end
	exports.pNotify:SendNotification({text = "خودرو به پارکینگ منتقل نشد، اگر شهروندی در خودرو می باشد، می بایست پیاده شود.", type = "error", timeout = 6000})	
end

function GetAvailableVehicleSpawnPoint(station, part, partNum, StationData)
	local spawnPoints = StationData[part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		exports.pNotify:SendNotification({text = _U('vehicle_blocked'), type = "error", timeout = 6000})	
		return false
	end
end
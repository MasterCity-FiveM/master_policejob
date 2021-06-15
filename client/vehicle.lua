local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

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
							--local car_plate = 'PD ' .. v.id
							local car_plate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(4))
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

									ESX.TriggerServerCallback('master_policejob:SpawnGarageCar', function(status)
										if status == true then
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
										end
									end, data2.current.model)
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
			StoreVehicleToGarage()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function StoreVehicleToGarage()
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(PlayerPedId())
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        local pos = GetEntityCoords(ped)

        if (IsPedSittingInAnyVehicle(ped)) then 
            local vehicle = GetVehiclePedIsIn(ped, false)
			local vehicleProps = GetVehicleProperties(vehicle)
			if vehicleProps and vehicleProps.plate ~= nil then
				if (GetPedInVehicleSeat( vehicle, -1 ) == ped) then 
					ESX.TriggerServerCallback('master_policejob:storeVehicle', function(success)
						if success then
							local entity = vehicle
							local attempt = 0

							exports.pNotify:SendNotification({text = "خودرو شما به گاراژ منتقل شد.", type = "success", timeout = 4000})
							while not NetworkHasControlOfEntity(entity) and attempt < 30.0 and DoesEntityExist(entity) do
								Wait(100)
								NetworkRequestControlOfEntity(entity)
								attempt = attempt + 1
							end

							if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
								ESX.Game.DeleteVehicle(entity)
								return
							end
						else
							exports.pNotify:SendNotification({text = "شما امکان تحویل این خودرو به گاراژ را ندارید.", type = "error", timeout = 4000})
						end
					end, vehicleProps)
				else 
					exports.pNotify:SendNotification({text = "شما باید پشت فرمان باشید.", type = "error", timeout = 4000})
				end
			else
				exports.pNotify:SendNotification({text = "شما امکان تحویل این خودرو را ندارید.", type = "error", timeout = 4000})
				return
			end
        else
            exports.pNotify:SendNotification({text = "شما باید در خودرو باشید.", type = "error", timeout = 4000})
        end 
    end
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 7 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)

        return vehicleProps
	else
		return nil
    end
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

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

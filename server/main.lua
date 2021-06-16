ESX = nil
FineList = {}
jobItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_service:activateService', 'police', 500)
TriggerEvent('esx_service:activateService', 'sheriff', 500)
TriggerEvent('esx_service:activateService', 'fbi', 500)
TriggerEvent('esx_service:activateService', 'dadsetani', 500)

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_phone:registerNumber', 'sheriff', 'Sheriff Alert', true, true)
TriggerEvent('esx_phone:registerNumber', 'fbi', 'FBI Alert', true, true)
TriggerEvent('esx_phone:registerNumber', 'dadsetani', 'Dadsetani Alert', true, true)

TriggerEvent('master_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})
TriggerEvent('master_society:registerSociety', 'sheriff', 'Sheriff', 'society_sheriff', 'society_sheriff', 'society_sheriff', {type = 'public'})
TriggerEvent('master_society:registerSociety', 'fbi', 'FBI', 'society_fbi', 'society_fbi', 'society_fbi', {type = 'public'})
TriggerEvent('master_society:registerSociety', 'dadsetani', 'Dadsetani', 'society_dadsetani', 'society_dadsetani', 'society_dadsetani', {type = 'public'})

ESX.RegisterServerCallback('master_policejob:SpawnGarageCar', function (source, cb, carname)
	-- TODO CHECK CAR ALLOWED
	local _source = source
	ESX.RunCustomFunction("anti_ddos", _source, 'master_vehicles:SpawnGarageCar', {})
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani' then
		TriggerEvent('master_warden:AllowSpawnCar', xPlayer.source)
		cb(true)
	else
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to Spawn Garage Car!', xPlayer.source)
	end
end)

-- Store Vehicles
ESX.RegisterServerCallback('master_policejob:storeVehicle', function (source, cb, vehicleProps)
	ESX.RunCustomFunction("anti_ddos", source, 'master_policejob:storeVehicle')
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani' then
		for i=1, #Config.JobAllowedCars, 1 do
			if Config.JobAllowedCars[i] == vehiclemodel then
				cb(true)
				return
			end
		end
		cb(false)
	else
		TriggerEvent('master_warden:InvalidRequest', '[PoliceJob] storeVehicle!', xPlayer.source)
	end
end)

RegisterServerEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:confiscatePlayerItem', {target = target, itemType = itemType, itemName = itemName, amount = amount})
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'police' and sourceXPlayer.job.name ~= 'sheriff' and sourceXPlayer.job.name ~= 'fbi' and not (sourceXPlayer.job.name == 'dadsetani' and sourceXPlayer.job.grade_name == 'bodyguard') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to Search Player!', sourceXPlayer.source)
		return
	end
	
	if targetXPlayer == nil then
		return
	end
	
	local SourceName = GetPlayerName(_source)
	local TargetName = GetPlayerName(target)
	
	if itemType == 'item_standard' then
		if GetItemCount(target, itemName) < amount then
			TriggerClientEvent("pNotify:SendNotification", _source, { text = "این مورد در جیب شهروند نمیباشد.", type = "error", timeout = 5000, layout = "bottomCenter"})
			return
		end
		
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent("pNotify:SendNotification", _source, { text = "تعداد صحیح نیست.", type = "error", timeout = 5000, layout = "bottomCenter"})
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent("pNotify:SendNotification", _source, { text = "تعداد " .. amount .. " عدد،" .. sourceItem.label .. " از " .. TargetName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
				TriggerClientEvent("pNotify:SendNotification", target, { text = "تعداد " .. amount .. " عدد،" .. sourceItem.label .. " از  شما توسط " .. SourceName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
				ESX.RunCustomFunction("discord", source, 'factionmenuactivity', 'Used Search and Stole!', "Target: **" .. GetPlayerName(target) .. "**\nItem Type: **" .. itemType .. "**\nItem Name: **" .. itemName .. "**\nAmount: **" .. amount .."**")
			end
		else
			TriggerClientEvent("pNotify:SendNotification", _source, { text = "تعداد صحیح نیست.", type = "error", timeout = 5000, layout = "bottomCenter"})
		end

	elseif itemType == 'item_account' then
		if targetXPlayer.getAccountMoney(itemName) <= amount then
			TriggerClientEvent("pNotify:SendNotification", _source, { text = "این مورد در جیب شهروند نمیباشد.", type = "error", timeout = 5000, layout = "bottomCenter"})
			return
		end
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)
		TriggerClientEvent("pNotify:SendNotification", _source, { text = "تعداد " .. amount .. " عدد،" .. itemName .. " از " .. TargetName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
		TriggerClientEvent("pNotify:SendNotification", target, { text = "تعداد " .. amount .. " عدد،" .. itemName .. " از  شما توسط " .. SourceName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
		ESX.RunCustomFunction("discord", source, 'factionmenuactivity', 'Used Search and Stole!', "Target: **" .. GetPlayerName(target) .. "**\nItem Type: **" .. itemType .. "**\nItem Name: **" .. itemName .. "**\nAmount: **" .. amount .."**")
	elseif itemType == 'item_weapon' then
		if not targetXPlayer.hasWeapon(itemName) then
			TriggerClientEvent("pNotify:SendNotification", _source, { text = "این مورد در جیب شهروند نمیباشد.", type = "error", timeout = 5000, layout = "bottomCenter"})
			return
		end
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon(itemName, amount)

		TriggerClientEvent("pNotify:SendNotification", _source, { text = "اسلحه " .. ESX.GetWeaponLabel(itemName) .." با " .. amount .. " عدد تیر، از " .. TargetName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
		TriggerClientEvent("pNotify:SendNotification", target, { text = "اسلحه " .. ESX.GetWeaponLabel(itemName) .." با " .. amount .. " عدد تیر، از شما توسط " .. SourceName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})	
		ESX.RunCustomFunction("discord", source, 'factionmenuactivity', 'Used Search and Stole!', "Target: **" .. GetPlayerName(target) .. "**\nItem Type: **" .. itemType .. "**\nItem Name: **" .. itemName .. "**\nAmount: **" .. amount .."**")
	end
end)

function GetItemCount(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.getInventoryItem(item)

    if items == nil then
        return 0
    else
        return items.count
    end
end

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target, foot)
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'esx_policejob:handcuff', {target = target, foot = foot})
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		distance = #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(tPlayer.source)))
		if distance > 15 then
			return
		end
	
		local SourceName = xPlayer.firstname .. ' ' .. xPlayer.lastname
		local TargetName = tPlayer.firstname .. ' ' .. tPlayer.lastname
		
		if not tPlayer.get("HandCuff") and GetItemCount(xPlayer.source, 'handcuffs') >= 1 then
			xPlayer.removeInventoryItem('handcuffs', 1)
			tPlayer.set('HandCuff', true)
			ESX.RunCustomFunction("discord", source, 'factionmenuactivity', 'Used Cuff', "Target: **" .. GetPlayerName(target) .. "**\nFoot: **" .. tostring(foot) .. "**")
			TriggerClientEvent("pNotify:SendNotification", target, { text = "شما توسط " .. SourceName .." دستگیر شدید.", type = "info", timeout = 8000, layout = "bottomCenter"})
			TriggerClientEvent('esx_policejob:animtarget', target, source)
			TriggerClientEvent('esx_policejob:cuffanimpolice', source, target)
			TriggerClientEvent('esx_policejob:handcuff', target, foot)
		elseif tPlayer.get("HandCuff") then
			tPlayer.set('HandCuff', false)
			if GetItemCount(source, 'handcuffs') < 2 then
				xPlayer.addInventoryItem('handcuffs', 1)
			end
			
			TriggerClientEvent('esx_policejob:uncuffanimpolice', source)
			TriggerClientEvent('esx_policejob:animuncufftarget', target, source)
			TriggerClientEvent('esx_policejob:handuncuff', target, foot)
			ESX.RunCustomFunction("discord", source, 'factionmenuactivity', 'Used UnCuff', "Target: **" .. GetPlayerName(target) .. "**\nFoot: **" .. tostring(foot) .. "**")
		else
			TriggerClientEvent("pNotify:SendNotification", source, { text = "شما دستبند ندارید.", type = "error", timeout = 8000, layout = "bottomCenter"})
		end
	elseif not(xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to Handcuff!', sourceXPlayer.source)
	end
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	_source = source
	ESX.RunCustomFunction("anti_ddos", _source, 'esx_policejob:drag', {target = target})
	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)

	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		distance = #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(tPlayer.source)))
		if distance > 15 then
			return
		end
	
		local SourceName = GetPlayerName(_source)
		local TargetName = GetPlayerName(target)
		if tPlayer.get("HandCuff") then
			TriggerClientEvent('esx_policejob:dargOff', -1, tPlayer.source)
			TriggerClientEvent('esx_policejob:darg', tPlayer.source, xPlayer.source)
		else
			TriggerClientEvent("pNotify:SendNotification", xPlayer.source, { text = "ابتدا به فرد دستبند بزنید.", type = "error", timeout = 5000, layout = "bottomCenter"})
		end
	elseif not(xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to Drag!', sourceXPlayer.source)
	end
end)
		
RegisterServerEvent('esx_policejob:dragOff')
AddEventHandler('esx_policejob:dragOff', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'esx_policejob:dragOff', {})
	if xPlayer then
		TriggerClientEvent('esx_policejob:dargOff', -1, xPlayer.source)
	end
end)	

RegisterServerEvent('esx_policejob:dragOnCop')
AddEventHandler('esx_policejob:dragOnCop', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'esx_policejob:dragOnCop', {target = tPlayer.source})
	if xPlayer then
		TriggerClientEvent('esx_policejob:dargCopOn', tPlayer.source, xPlayer.source)
	end
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target, netID)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:putInVehicle', {target = target})
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') and tPlayer.get('HandCuff') then
		distance = #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(tPlayer.source)))
		if distance > 15 then
			return
		end
		TriggerClientEvent('esx_policejob:darg', source, nil)
		TriggerClientEvent('esx_policejob:dargOff', -1, target)
		Citizen.Wait(500)
		TriggerClientEvent('esx_policejob:putInVehicle', target, netID)
		ESX.RunCustomFunction("discord", source, 'factionmenuactivity', 'Used Put in Vehicle', "Target: **" .. GetPlayerName(target) .. "**")
		Citizen.Wait(1000)
		TriggerClientEvent('master_hud:CloseSeatBelt', target)
	elseif not(xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to put In Vehicle!', sourceXPlayer.source)
	end
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:OutVehicle', {target = target})
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then	
		distance = #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(tPlayer.source)))
		if distance > 15 then
			return
		end
		TriggerClientEvent('esx_policejob:OutVehicle', target)
		ESX.RunCustomFunction("discord", source, 'factionmenuactivity', 'Used Put out of Vehicle', "Target: **" .. GetPlayerName(target) .. "**")
	elseif not(xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to Put out of Vehicle!', sourceXPlayer.source)
	end
end)

RegisterServerEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:putStockItems', {itemName = itemName, count = count})
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = itemName
	local sourceItem = xPlayer.getInventoryItem(item)
	local ItemFound = false
	local item_amount = tonumber(count)
	
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		return
	end
	
	if jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['item'] == nil then
		GetJobItems(xPlayer.job.name, xPlayer.job.grade_name, 'item')
		return
	end
	
	if item_amount < 1 and item_amount > 500 then
		return
	end
	
	local items = jobItems[xPlayer.job.name][xPlayer.job.grade_name]['item']
	
	for i=1, #items, 1 do
		if items[i].name == item then
			ItemFound = true
			break
		end
	end
	
	if not ItemFound then
		TriggerClientEvent("pNotify:SendNotification", source, { text = "امکان تحویل اموال شخصی وجود ندارد!", type = "error", timeout = 5000, layout = "bottomCenter"})
		return
	end

	if sourceItem.count >= item_amount and item_amount > 0 then
		xPlayer.removeInventoryItem(item, count)
		TriggerClientEvent("pNotify:SendNotification", source, { text = "از شما بابت تحویل اموال نیروی انتظامی متشکریم.", type = "success", timeout = 4000, layout = "bottomCenter"})
	else
		TriggerClientEvent("pNotify:SendNotification", source, { text = _U('quantity_invalid'), type = "error", timeout = 4000, layout = "bottomCenter"})
	end
end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:getOtherPlayerData', {target = target})
	local sPlayer = ESX.GetPlayerFromId(source)
	
	if sPlayer == nil or sPlayer.job == nil or not (sPlayer.job.name == 'police' or sPlayer.job.name == 'sheriff' or sPlayer.job.name == 'fbi' or sPlayer.job.name == 'dadsetani') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to getOtherPlayerData!', sourceXPlayer.source)
		cb({})
		return
	end
		
	if Config.EnableESXIdentity then
		local xPlayer = ESX.GetPlayerFromId(target)
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			id   	  = target,
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	else
		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)
	end
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:getFineList', {category = category})
	if FineList[category] and FineList[category] ~= nil then
		cb(FineList[category])
		return
	end
	
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		if not FineList[category] and FineList[category] == nil then
			FineList[category] = {}
		end
		
		FineList[category] = fines
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:getVehicleInfos', {plate = plate})
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil or xPlayer.job == nil or not (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to getVehicleInfos!', sourceXPlayer.source)
		return
	end
	
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}
		
		if result[1] then
			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)
				retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:getVehicleFromPlate', {plate = plate})
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getItems', function(source, cb, item_type)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:getItems', {item_type = item_type})
	local xPlayer = ESX.GetPlayerFromId(source)
	items = {}
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		cb(items)
		return
	end	
	
	if not (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] getItems!', sourceXPlayer.source)
		cb(items)
		return
	end
	
	if jobItems[xPlayer.job.name] == nil then
		jobItems[xPlayer.job.name] = {}
	end
	
	if jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil  then
		jobItems[xPlayer.job.name][xPlayer.job.grade_name] = {}
	end
	
	if jobItems[xPlayer.job.name][xPlayer.job.grade_name][item_type] == nil  then
		jobItems[xPlayer.job.name][xPlayer.job.grade_name][item_type] = {}
	else
		cb(jobItems[xPlayer.job.name][xPlayer.job.grade_name][item_type])
		return
	end
	
	if xPlayer.job_sub ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM job_items WHERE job = @job AND (grade = @grade or grade = @subjob) AND item_type = @item_type', {
			['@job'] = xPlayer.job.name,
			['@grade'] = xPlayer.job.grade_name,
			['@item_type'] = item_type,
			['@subjob'] = xPlayer.job_sub
		}, function(result)
			jobItems[xPlayer.job.name][xPlayer.job.grade_name .. '_' .. xPlayer.job_sub][item_type] = result
			cb(result)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM job_items WHERE job = @job AND grade = @grade AND item_type = @item_type', {
			['@job'] = xPlayer.job.name,
			['@grade'] = xPlayer.job.grade_name,
			['@item_type'] = item_type
		}, function(result)
			jobItems[xPlayer.job.name][xPlayer.job.grade_name][item_type] = result
			cb(result)
		end)
	end
end)

function GetJobItems(job, grade, item_type)
	if jobItems[job] == nil then
		jobItems[job] = {}
	end
	
	if jobItems[job][grade] == nil  then
		jobItems[job][grade] = {}
	end
	
	if jobItems[job][grade][item_type] == nil  then
		jobItems[job][grade][item_type] = {}
	else
		return
	end
	
	MySQL.Async.fetchAll('SELECT * FROM job_items WHERE job = @job AND grade = @grade AND item_type = @item_type', {
		['@job'] = job,
		['@grade'] = grade,
		['@item_type'] = item_type
	}, function(result)
		jobItems[job][grade][item_type] = result
	end)
end

ESX.RegisterServerCallback('esx_policejob:GiveWeapon', function(source, cb, weaponName, amount)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:GiveWeapon', {weaponName = weaponName, amount = amount})
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local weapon = weaponName:upper()
	local ammo_amount = tonumber(amount)
	local ItemFound = false
	
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		cb()
		return
	end
	
	if ammo_amount < 1 and ammo_amount > 500 then
		cb()
		return
	end
	
	if not (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') or jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['weapon'] == nil then
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] GiveWeapon!', xPlayer.source)
		GetJobItems(xPlayer.job.name, xPlayer.job.grade_name, 'weapon')
		cb()
		return
	end
	
	local weapons = jobItems[xPlayer.job.name][xPlayer.job.grade_name]['weapon']
	
	for i=1, #weapons, 1 do
		if weapons[i].name:upper() == weapon then
			ItemFound = true
			break
		end
	end
	
	if not ItemFound then
		TriggerClientEvent("pNotify:SendNotification", source, { text = "شما مجوز دریافت این اسلحه را ندارید.", type = "error", timeout = 5000, layout = "bottomCenter"})
		cb()
		return
	end
	
	if xPlayer.hasWeapon(weapon) then
		TriggerClientEvent("pNotify:SendNotification", source, { text = "شما قبلا این اسلحه را تحویل گرفته اید.", type = "error", timeout = 5000, layout = "bottomCenter"})
	else
		xPlayer.addWeapon(weapon, ammo_amount)
		TriggerClientEvent("pNotify:SendNotification", source, { text = "اسلحه به شما تحویل داده شد.", type = "success", timeout = 5000, layout = "bottomCenter"})
	end
	
	cb()
end)

ESX.RegisterServerCallback('esx_policejob:GetWeapon', function(source, cb, weaponName)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:GetWeapon', {weaponName = weaponName})
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local weapon = weaponName:upper()
	local ItemFound = false
	
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		cb()
		return
	end
	
	if jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['weapon'] == nil then
		GetJobItems(xPlayer.job.name, xPlayer.job.grade_name, 'weapon')
		cb()
		return
	end
	
	local weapons = jobItems[xPlayer.job.name][xPlayer.job.grade_name]['weapon']
	
	for i=1, #weapons, 1 do
		if weapons[i].name:upper() == weapon then
			ItemFound = true
			break
		end
	end
	
	--[[if not ItemFound then
		TriggerClientEvent("pNotify:SendNotification", source, { text = "شما مجوز تحویل این اسلحه را ندارید.", type = "error", timeout = 5000, layout = "bottomCenter"})
		cb()
		return
	end]]--
	
	if xPlayer.hasWeapon(weapon) then
		xPlayer.removeWeapon(weapon)
		TriggerClientEvent("pNotify:SendNotification", source, { text = "اسلحه تحویل اسلحه خانه داده شد.", type = "success", timeout = 5000, layout = "bottomCenter"})
	else
		TriggerClientEvent("pNotify:SendNotification", source, { text = "اسلحه در جیب شما نیست!", type = "error", timeout = 5000, layout = "bottomCenter"})
	end
	
	cb()
end)

ESX.RegisterServerCallback('esx_policejob:GetItem', function(source, cb, itemName, amount)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:GetItem', {itemName = itemName, amount = amount})
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local item = itemName
	local ItemFound = false
	local item_amount = tonumber(amount)
	
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		cb()
		return
	end
	
	if jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['item'] == nil then
		GetJobItems(xPlayer.job.name, xPlayer.job.grade_name, 'item')
		cb()
		return
	end
	
	if item_amount < 1 and item_amount > 500 then
		cb()
		return
	end
	
	local items = jobItems[xPlayer.job.name][xPlayer.job.grade_name]['item']
	
	for i=1, #items, 1 do
		if items[i].name == item then
			ItemFound = true
			break
		end
	end
	
	if not ItemFound then
		TriggerClientEvent("pNotify:SendNotification", source, { text = "شما مجوز دریافت این وسیله را ندارید.", type = "error", timeout = 5000, layout = "bottomCenter"})
		cb()
		return
	end
	
	if GetItemCount(source, item) > 0 then
		TriggerClientEvent("pNotify:SendNotification", source, { text = "شما قبلا این وسیله را تحویل گرفتید، ابتدا آن را تحویل دهید.", type = "error", timeout = 5000, layout = "bottomCenter"})
	else
		xPlayer.addInventoryItem(item, item_amount)
		TriggerClientEvent("pNotify:SendNotification", source, { text = "وسیله مورد نظر تحویل شما داده شد.", type = "success", timeout = 5000, layout = "bottomCenter"})
	end
	cb()
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_vehicleshop:getVehicles', {})
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
		TriggerEvent('esx_phone:removeNumber', 'fbi')
		TriggerEvent('esx_phone:removeNumber', 'sheriff')
		TriggerEvent('esx_phone:removeNumber', 'dadsetani')
	end
end)

--[[
RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	ESX.RunCustomFunction("anti_ddos", source, 'esx_policejob:message', {msg = msg})
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani' then
		TriggerClientEvent("pNotify:SendNotification", target, { text = msg, type = "info", timeout = 5000, layout = "bottomCenter"})
	end
end)
]]--

RegisterServerEvent('master_policejob:try_tackle')
AddEventHandler('master_policejob:try_tackle', function(target)
	ESX.RunCustomFunction("anti_ddos", source, 'master_policejob:try_tackle', {})
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	
	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'dadsetani') then
		distance = #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(tPlayer.source)))
		if distance > 15 then
			return
		end

		TriggerClientEvent('master_policejob:getTackled', tPlayer.source, xPlayer.source)
		TriggerClientEvent('master_policejob:playTackle', xPlayer.source)
	else
		TriggerEvent('master_warden:InvalidRequest', '[POLICE] Try to tackle!', xPlayer.source)
	end
end)
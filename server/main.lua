ESX = nil
FineList = {}
jobItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})


RegisterServerEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'police' then
		print(('esx_policejob: %s attempted to confiscate!'):format(xPlayer.identifier))
		return
	end
	
	if targetXPlayer == nil then
		return
	end
	
	local SourceName = GetPlayerName(_source)
	local TargetName = GetPlayerName(target)

	if itemType == 'item_standard' then
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
			end
		else
			TriggerClientEvent("pNotify:SendNotification", _source, { text = "تعداد صحیح نیست.", type = "error", timeout = 5000, layout = "bottomCenter"})
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)
		TriggerClientEvent("pNotify:SendNotification", _source, { text = "تعداد " .. amount .. " عدد،" .. itemName .. " از " .. TargetName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
		TriggerClientEvent("pNotify:SendNotification", target, { text = "تعداد " .. amount .. " عدد،" .. itemName .. " از  شما توسط " .. SourceName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon(itemName, amount)

		TriggerClientEvent("pNotify:SendNotification", _source, { text = "اسلحه " .. ESX.GetWeaponLabel(itemName) .." با " .. amount .. " عدد تیر، از " .. TargetName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})
		TriggerClientEvent("pNotify:SendNotification", target, { text = "اسلحه " .. ESX.GetWeaponLabel(itemName) .." با " .. amount .. " عدد تیر، از شما توسط " .. SourceName .. " مصادره شد.", type = "info", timeout = 5000, layout = "bottomCenter"})	
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

RegisterServerEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target, foot)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	
	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and xPlayer.job.name == 'police' then
		local SourceName = GetPlayerName(source)
		local TargetName = GetPlayerName(target)
		
		if GetItemCount(source, 'handcuffs') == 1 and not xPlayer.get("HandCuffedPlayer") and not tPlayer.get('HandCuff') then
			xPlayer.removeInventoryItem('handcuffs', 1)
			
			tPlayer.set('HandCuff', true)
			xPlayer.set('HandCuffedPlayer', target)
			tPlayer.set('HandCuffedBy', source)
			
			TriggerClientEvent('esx_policejob:animtarget', target, source)
			TriggerClientEvent('esx_policejob:cuffanimpolice', source, target)
			TriggerClientEvent('esx_policejob:handcuff', target, foot)
			
			TriggerClientEvent("pNotify:SendNotification", target, { text = "شما توسط " .. SourceName .." دستگیر شدید.", type = "info", timeout = 8000, layout = "bottomCenter"})
		elseif tPlayer.get('HandCuff') and xPlayer.get("HandCuffedPlayer") then
			if xPlayer.get("HandCuffedPlayer") == target then
				if GetItemCount(source, 'handcuffs') == 0 then
					xPlayer.addInventoryItem('handcuffs', 1)
				end
				
				tPlayer.set('HandCuff', false)
				xPlayer.set('HandCuffedPlayer', nil)
				tPlayer.set('HandCuffedBy', nil)
				TriggerClientEvent('esx_policejob:uncuffanimpolice', source)
				TriggerClientEvent('esx_policejob:animuncufftarget', target, source)
				TriggerClientEvent('esx_policejob:handuncuff', target, foot)
			else
				TriggerClientEvent("pNotify:SendNotification", source, { text = "شما کلید این دستبند را ندارید.", type = "info", timeout = 8000, layout = "bottomCenter"})
			end
		elseif xPlayer.get("HandCuffedPlayer") and not tPlayer.get('HandCuff') then
			local yPlayer = ESX.GetPlayerFromId(xPlayer.get("HandCuffedPlayer"))
			if not yPlayer then
				xPlayer.set('HandCuffedPlayer', nil)
				if GetItemCount(source, 'handcuffs') == 0 then
					xPlayer.addInventoryItem('handcuffs', 1)
				end
				TriggerClientEvent("pNotify:SendNotification", source, { text = "فردی که توسط شما دستگیر شده بود، در شهر نیست، دستبند شما برگردانده شد.", type = "info", timeout = 8000, layout = "bottomCenter"})
			else
				TriggerClientEvent("pNotify:SendNotification", source, { text = "شما قبلا یک نفر را دستگیر کرده اید.", type = "info", timeout = 8000, layout = "bottomCenter"})
			end
		elseif tPlayer.get('HandCuff') and tPlayer.get("HandCuffedBy") then
			local yPlayer = ESX.GetPlayerFromId(tPlayer.get("HandCuffedBy"))
			if not yPlayer then
				xPlayer.set('HandCuffedBy', nil)
				if GetItemCount(source, 'handcuffs') == 0 then
					xPlayer.addInventoryItem('handcuffs', 1)
				end
				
				tPlayer.set('HandCuff', false)
				tPlayer.set('HandCuffedBy', nil)
				TriggerClientEvent('esx_policejob:uncuffanimpolice', source)
				TriggerClientEvent('esx_policejob:animuncufftarget', target, source)
				TriggerClientEvent('esx_policejob:handuncuff', target, foot)
			else
				TriggerClientEvent("pNotify:SendNotification", source, { text = "شما کلید این دستبند را ندارید.", type = "info", timeout = 8000, layout = "bottomCenter"})
			end
		elseif GetItemCount(source, 'handcuffs') == 0 and not xPlayer.get("HandCuffedPlayer") and not tPlayer.get('HandCuff') then
			TriggerClientEvent("pNotify:SendNotification", source, { text = "شما دستبند ندارید.", type = "error", timeout = 8000, layout = "bottomCenter"})
		end		
	end
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)

	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and xPlayer.job.name == 'police' then
		local SourceName = GetPlayerName(source)
		local TargetName = GetPlayerName(target)
		
		if not xPlayer.get("EscortPlayer") and not tPlayer.get('EscortBy') and tPlayer.get('HandCuff') then
			xPlayer.set('EscortPlayer', target)
			tPlayer.set('EscortBy', source)
			
			TriggerClientEvent('esx_policejob:dragOn', target, source)
			TriggerClientEvent('esx_policejob:dragCopOn', source, target)
			
		elseif xPlayer.get("EscortPlayer") and tPlayer.get('EscortBy') and tPlayer.get('EscortBy') == source and xPlayer.get('EscortPlayer') == target then
			xPlayer.set('EscortPlayer', nil)
			tPlayer.set('EscortBy', nil)
			
			TriggerClientEvent('esx_policejob:dragOff', target)
			TriggerClientEvent('esx_policejob:dragCopOff', source)
		elseif xPlayer.get("EscortPlayer") then
			local yPlayer = ESX.GetPlayerFromId(xPlayer.get("EscortPlayer"))
			if not yPlayer then
				xPlayer.set('EscortPlayer', nil)
				TriggerClientEvent('esx_policejob:dragCopOff', source)
				TriggerClientEvent("pNotify:SendNotification", source, { text = "فردی که اسکورت میکردید در شهر نیست، از حالت اسکورت خارج شدید.", type = "info", timeout = 8000, layout = "bottomCenter"})
			elseif not yPlayer.get('EscortBy') then
				xPlayer.set('EscortPlayer', nil)
				TriggerClientEvent('esx_policejob:dragCopOff', source)
				TriggerClientEvent("pNotify:SendNotification", source, { text = "شما از حالت اسکورت خارج شدید.", type = "info", timeout = 8000, layout = "bottomCenter"})
			else
				TriggerClientEvent("pNotify:SendNotification", source, { text = "شما در حال اسکورت شخص دیگری می باشید.", type = "info", timeout = 8000, layout = "bottomCenter"})
			end
		elseif tPlayer.get('EscortBy') then
			local yPlayer = ESX.GetPlayerFromId(tPlayer.get("EscortBy"))
			if not yPlayer then
				tPlayer.set('EscortBy', nil)
				TriggerClientEvent('esx_policejob:dragOff', target)
				TriggerClientEvent("pNotify:SendNotification", source, { text = "شهروند، به دلیل نبود اسکورت کننده در شهر، از حالت اسکورت خارج شد.", type = "info", timeout = 8000, layout = "bottomCenter"})
			elseif not yPlayer.get('EscortPlayer') then
				tPlayer.set('EscortBy', nil)
				TriggerClientEvent('esx_policejob:dragOff', target)
				TriggerClientEvent("pNotify:SendNotification", source, { text = "شهروند از حالت اسکورت خارج شد.", type = "info", timeout = 8000, layout = "bottomCenter"})
			else
				TriggerClientEvent("pNotify:SendNotification", source, { text = "این شهروند توسط شخص دیگری در حال اسکورت می باشد.", type = "info", timeout = 8000, layout = "bottomCenter"})
			end
		elseif not xPlayer.get("EscortPlayer") and not tPlayer.get('EscortBy') and tPlayer.get('HandCuff') then
			TriggerClientEvent("pNotify:SendNotification", source, { text = "جهت اسکورت ابتدا باید به فرد دستبند بزنید.", type = "info", timeout = 5000, layout = "bottomCenter"})
		end
	end
end)
		
RegisterServerEvent('esx_policejob:dragCopOff')
AddEventHandler('esx_policejob:dragCopOff', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("EscortPlayer") then
		local yPlayer = ESX.GetPlayerFromId(xPlayer.get("EscortPlayer"))
		if yPlayer then
			yPlayer.set('EscortBy', nil)
			TriggerClientEvent('esx_policejob:dragOff', yPlayer.source)
		end
	end
	
	xPlayer.set('EscortPlayer', nil)
	TriggerClientEvent('esx_policejob:dragCopOff', source)
end)

RegisterServerEvent('esx_policejob:dragOff')
AddEventHandler('esx_policejob:dragOff', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("EscortBy") then
		local yPlayer = ESX.GetPlayerFromId(xPlayer.get("EscortBy"))
		if yPlayer then
			yPlayer.set('EscortPlayer', nil)
			TriggerClientEvent('esx_policejob:dragCopOff', yPlayer.source)
		end
	end
	
	xPlayer.set('EscortBy', nil)
	TriggerClientEvent('esx_policejob:dragOff', source)
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and xPlayer.job.name == 'police' and tPlayer.get('HandCuff') then
		xPlayer.set('EscortPlayer', nil)
		tPlayer.set('EscortBy', nil)
		TriggerClientEvent('esx_policejob:dragCopOff', source)
		TriggerClientEvent('esx_policejob:dragOff', source)
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	end
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	if xPlayer and xPlayer ~= nil and tPlayer and tPlayer ~= nil and xPlayer.job.name == 'police' then	
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	end
end)

RegisterServerEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = itemName
	local sourceItem = xPlayer.getInventoryItem(item)
	local ItemFound = false
	local item_amount = tonumber(count)
	
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		return
	end
	
	if xPlayer.job.name ~= 'police' or jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['item'] == nil then
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
	local sPlayer = ESX.GetPlayerFromId(source)
	
	if sPlayer == nil or sPlayer.job == nil or sPlayer.job.name ~= 'police' then
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
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name ~= 'police' then
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
	local xPlayer = ESX.GetPlayerFromId(source)
	items = {}
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		cb(items)
		return
	end	
	
	if xPlayer.job.name ~= 'police' then
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
	
	MySQL.Async.fetchAll('SELECT * FROM job_items WHERE job = @job AND grade = @grade AND item_type = @item_type', {
		['@job'] = xPlayer.job.name,
		['@grade'] = xPlayer.job.grade_name,
		['@item_type'] = item_type
	}, function(result)
		jobItems[xPlayer.job.name][xPlayer.job.grade_name][item_type] = result
		cb(result)
	end)
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
	
	if xPlayer.job.name ~= 'police' or jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['weapon'] == nil then
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
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local weapon = weaponName:upper()
	local ItemFound = false
	
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		cb()
		return
	end
	
	if xPlayer.job.name ~= 'police' or jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['weapon'] == nil then
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
		TriggerClientEvent("pNotify:SendNotification", source, { text = "شما مجوز تحویل این اسلحه را ندارید.", type = "error", timeout = 5000, layout = "bottomCenter"})
		cb()
		return
	end
	
	if xPlayer.hasWeapon(weapon) then
		xPlayer.removeWeapon(weapon)
		TriggerClientEvent("pNotify:SendNotification", source, { text = "اسلحه تحویل اسلحه خانه داده شد.", type = "success", timeout = 5000, layout = "bottomCenter"})
	else
		TriggerClientEvent("pNotify:SendNotification", source, { text = "اسلحه در جیب شما نیست!", type = "error", timeout = 5000, layout = "bottomCenter"})
	end
	
	cb()
end)

ESX.RegisterServerCallback('esx_policejob:GetItem', function(source, cb, itemName, amount)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local item = itemName
	local ItemFound = false
	local item_amount = tonumber(amount)
	
	if xPlayer == nil or xPlayer.job == nil or xPlayer.job.name == nil then
		cb()
		return
	end
	
	if xPlayer.job.name ~= 'police' or jobItems[xPlayer.job.name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name] == nil or jobItems[xPlayer.job.name][xPlayer.job.grade_name]['item'] == nil then
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
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('esx_policejob:spawned')
AddEventHandler('esx_policejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_policejob:forceBlip')
AddEventHandler('esx_policejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	TriggerClientEvent("pNotify:SendNotification", target, { text = msg, type = "info", timeout = 5000, layout = "bottomCenter"})
end)

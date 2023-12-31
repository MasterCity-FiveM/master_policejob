Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local CurrentActionData, dragStatus, currentTask = {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, isHandFootcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg, underDragPlayer
dragStatus.isDragged = false, false
underDrag = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(2000)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
	if ESX.GetPlayerData().job.name == 'fbi' then
		playerInService = true
		ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
			if not canTakeService then
				ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
			else
				awaitService = true
				playerInService = true

				local notification = {
					title    = _U('service_anonunce'),
					subject  = '',
					msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
					iconType = 1
				}

				TriggerServerEvent('esx_service:notifyAllInService', notification, ESX.PlayerData.job.name)
			end
		end, ESX.PlayerData.job.name)
	end
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		local uniform = uniform
		
		if skin.sex == 0 then
			uniformObject = Config.Uniforms[ESX.PlayerData.job.name][uniform].male
		else
			uniformObject = Config.Uniforms[ESX.PlayerData.job.name][uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)

			if uniform == 'bullet_wear' or (uniformObject.bproof_1 ~= nil and uniformObject.bproof_1 > 0) then
				SetPedArmour(playerPed, 100)
			elseif uniform == 'unbullet_wear' then
				SetPedArmour(playerPed, 0)
			end
		else
			exports.pNotify:SendNotification({text = _U('no_outfit'), type = "info", timeout = 3000})
		end
	end)
end

function setCustomUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = uniform.male
		else
			uniformObject = uniform.female
		end

		if uniformObject.bproof_1 ~= nil and uniformObject.bproof_1 > 0 then
			SetPedArmour(playerPed, 100)
		else
			SetPedArmour(playerPed, 0)
		end
		
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		else
			exports.pNotify:SendNotification({text = _U('no_outfit'), type = "info", timeout = 3000})
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	local elements = {
		{label = _U('citizen_wear'), value = 'citizen_wear'},
		{label = "برداشتن " .. _U('bullet_wear'), uniform = 'unbullet_wear'}
	}
	table.insert(elements, {label = _U('bullet_wear') .. ' 2', uniform = 'bullet_wear2'})
	if ESX.PlayerData.job.name == 'dadsetani' then
		elements = {
			{label = _U('citizen_wear'), value = 'citizen_wear'}
		}		
	end
	
	if ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade >= 4 then
		table.insert(elements, {label = _U('bullet_wear') .. ' 1', uniform = 'bullet_wear'})
	end
	

	if Config.CustomUniforms[ESX.PlayerData.job.name][grade] ~= nil then
		for k,v in ipairs(Config.CustomUniforms[ESX.PlayerData.job.name][grade]) do
			table.insert(elements, {label = v.label, value = 'custom_players', model = v.model})
		end
	end
	
	if ESX.PlayerData.job.job_sub ~= nil and Config.SubJobUniforms[ESX.PlayerData.job.name][ESX.PlayerData.job.job_sub] ~= nil then
		for k,v in ipairs(Config.SubJobUniforms[ESX.PlayerData.job.name][ESX.PlayerData.job.job_sub]) do
			table.insert(elements, {label = v.label, value = 'custom_players', model = v.model})
		end
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local model = nil
				
				if skin.sex == 0 then
            		model = GetHashKey("mp_m_freemode_01")
          		else
            		model = GetHashKey("mp_f_freemode_01")
          		end

          		RequestModel(model)
          		while not HasModelLoaded(model) do
            	RequestModel(model)
            		Citizen.Wait(1)
          		end

          		SetPlayerModel(PlayerId(), model)
          		SetModelAsNoLongerNeeded(model)

          		TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
			end)
		
			if Config.EnableESXService then
				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService and ESX.PlayerData.job.name ~= 'fbi' then
						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, ESX.PlayerData.job.name)

						TriggerServerEvent('esx_service:disableService', ESX.PlayerData.job.name)
						exports.pNotify:SendNotification({text = _U('service_out'), type = "info", timeout = 3000})
					end
				end, ESX.PlayerData.job.name)
			end
		end

		if Config.EnableESXService and data.current.value ~= 'citizen_wear' then
			local awaitService

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						if not canTakeService then
							ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						else
							awaitService = true
							playerInService = true

							local notification = {
								title    = _U('service_anonunce'),
								subject  = '',
								msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								iconType = 1
							}

							TriggerServerEvent('esx_service:notifyAllInService', notification, ESX.PlayerData.job.name)
							exports.pNotify:SendNotification({text = _U('service_in'), type = "info", timeout = 3000})
						end
					end, ESX.PlayerData.job.name)

				else
					awaitService = true
				end
			end, ESX.PlayerData.job.name)

			while awaitService == nil do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not awaitService then
				return
			end
		end

		if data.current.value == 'custom_players' then
			setCustomUniform(data.current.model, playerPed)
			return
		end
		
		if data.current.uniform then
			setUniform(data.current.uniform, playerPed)
		end
		
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu(station)
	local elements = {}

	if Config.EnableArmoryManagement then
		table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		table.insert(elements, {label = _U('put_weapon'),     value = 'put_weapon'})
		table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
		table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = _U('armory'),
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end, function(data, menu)
		menu.close()
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end)
end

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()
	
	Citizen.Wait(100)
	elements = {
		{label = _U('citizen_interaction'), value = 'citizen_interaction'},
		{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
		{label = 'درخواست نیرو کمکی', value = 'need_support'},
		--{label = _U('object_spawner'), value = 'object_spawner'},
		{label = "اشخاص تحت تعقیب", value = 'wanted_menu'}
	}
	
	if ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = 'پنل مدیریت', value = 'boss_action'})
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = ESX.PlayerData.job.label_fa,
		align    = 'right',
		elements = elements
		
	}, function(data, menu)
		if data.current.value == 'wanted_menu' then		-- This
			TriggerEvent("esx_wanted:openWantedMenu")
		end	

		if data.current.value == 'boss_action' then
			menu.close()
			TriggerEvent('master_society:RequestOpenBossMenu')
		elseif data.current.value == 'need_support' then
			menu.close()
			OpenSupportMenu()
		elseif data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('id_card') .. ' - Identity', value = 'identity_card'},
				{label = _U('search') .. ' - Search', value = 'search'},
				{label = 'دست بند' .. ' - Handcuff',   value = 'handcuff'},
				{label = 'دست بند و پابند' .. ' - Hand & foot cuff', value = 'handfootcuff'},
				{label = _U('drag') .. ' - Drag', value = 'drag'},
				{label = _U('put_in_vehicle') .. ' - Put in Veh', value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle') .. ' - Out the Veh', value = 'out_the_vehicle'},
				{label = _U('fine') .. ' - Fine', value = 'fine'},
				{label = _U('unpaid_bills') .. ' - Unpaid Bills', value = 'unpaid_bills'},
				{label = 'سوابق کیفری',   value = 'criminalrecords'},
				{label = "خدمات اجتماعی",	value = 'communityservice'},
			}

			if Config.EnableLicenses and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job.name == 'fbi') then
				table.insert(elements, {label = 'گواهی نامه ها' .. ' - License', value = 'license'})
				table.insert(elements, {label = 'اعطای گواهی نامه', value = 'addlicense'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('citizen_interaction'),
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 2.0 then
					local action = data2.current.value
					menu.close()
					menu2.close()

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'search' then
						OpenBodySearchMenu(closestPlayer)
					elseif action == 'handcuff' then
						TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer), false)
					elseif action == 'handfootcuff' then
						TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer), true)
					elseif action == 'drag' then
						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						local vehicle = ESX.Game.GetVehicleInDirection(4)
							if vehicle == 0 then
								exports.pNotify:SendNotification({text = "خودرویی در نزدیکی شما نیست.", type = "error", timeout = 3000})
								return
							end
						local NetId = NetworkGetNetworkIdFromEntity(vehicle)
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer), NetId)
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'addlicense' then
						addPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					elseif action == 'criminalrecords' then
						TriggerEvent('esx_criminalrecords:open', GetPlayerServerId(closestPlayer))
					elseif action == 'communityservice' then
						SendToCommunityService(GetPlayerServerId(closestPlayer))	
					end
					
					Citizen.Wait(100)
				else
					exports.pNotify:SendNotification({text = "شهروندی نزدیک شما نیست.", type = "error", timeout = 3000})
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'), value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'), value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('impound'), value = 'impound'})
			else
				table.insert(elements, {label = _U('search_database'), value = 'search_database'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = _U('vehicle_interaction'),
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value

				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					if action == 'vehicle_infos' then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							
							if currentTask.busy then
								exports.pNotify:SendNotification({text = "شما مشغول انجام کار هستید.", type = "info", timeout = 4000})
								return
							end
							
							currentTask.busy = true
							
							SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) 
							RequestAnimDict("mp_arresting")
							while not HasAnimDictLoaded("mp_arresting") do
								RequestAnimDict("mp_arresting")
								Citizen.Wait(10)
							end
							
							TaskPlayAnim(playerPed, "mp_arresting", "a_uncuff", 8.0, 8.0, 5000, 1, 1, 0, 0, 0)
							Citizen.Wait(5000)
							ClearPedTasks(playerPed)
							--TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							--Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)
							
							currentTask.busy = false
							
							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							exports.pNotify:SendNotification({text = _U('vehicle_unlocked'), type = "success", timeout = 4000})
						end
					elseif action == 'impound' then
						-- is the script busy?
						
						if currentTask.busy then
							exports.pNotify:SendNotification({text = "شما مشغول انجام کار هستید.", type = "info", timeout = 4000})
							return
						end
						
						currentTask.busy = true

						ESX.ShowHelpNotification(_U('impound_prompt'))
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

						currentTask.task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)

						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while currentTask.busy do
								Citizen.Wait(1000)

								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and currentTask.busy then
									exports.pNotify:SendNotification({text = "انتقال خودرو کنسل شد.", type = "error", timeout = 4000})
									
									ESX.ClearTimeout(currentTask.task)
									ClearPedTasks(playerPed)
									currentTask.busy = false
									break
								end
							end
						end)
					end
				else
					exports.pNotify:SendNotification({text = "شما نزدیک خودرو نیستید.", type = "error", timeout = 4000})
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'right',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					{label = _U('box'), model = 'prop_boxpile_07d'},
					{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)
				
				if currentTask.busy then
					exports.pNotify:SendNotification({text = "شما مشغول انجام کار هستید.", type = "info", timeout = 4000})
					return
				end

				currentTask.busy = true
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(3000)
				ClearPedTasks(playerPed)
				
				currentTask.busy = false
				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'خدمات اجتماعی', {
		title = "خدمات اجتماعی",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			exports.pNotify:SendNotification({text = "تعداد درخواستی صحیح نیست.", type = "error", timeout = 4000})
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService", player, community_services_count, 0)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {}
		local nameLabel = _U('name', data.name)
		local jobLabel, sexLabel, idLabel

		if data.job ~= nil then
			if data.job.grade_label_fa and data.job.grade_label_fa ~= '' and data.job.label_fa and data.job.label_fa ~= '' then
				jobLabel = _U('job', data.job.label_fa .. ' - ' .. data.job.grade_label_fa)
			elseif data.job.grade_label_fa and data.job.grade_label_fa ~= '' then
				jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label_fa)
			elseif data.job.grade_label and data.job.grade_label ~= '' then
				jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
			elseif data.job.label_fa and data.job.label_fa ~= '' then
				jobLabel = _U('job', data.job.label_fa)
			else
				jobLabel = _U('job', data.job.label)
			end
		end

		if Config.EnableESXIdentity then
			if data.lastname and data.firstname then
				nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
			end

			if data.sex then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end

			--[[if data.name then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end]]--
		end

		local elements = {
			{label = nameLabel},
			{label = jobLabel}
		}
		
		if data.id then
			table.insert(elements, {label = _U('userID', data.id)})
		end
		
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel})
			-- table.insert(elements, {label = idLabel})
		end

		if data.drunk then
			table.insert(elements, {label = _U('bac', data.drunk)})
		end

		if data.licenses then
			table.insert(elements, {label = _U('license_label')})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = _U('guns_label')})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label')})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = _U('search'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				local playerCoords = GetEntityCoords(GetPlayerPed(-1))
				local playerCoords2 = GetEntityCoords(GetPlayerPed(player))
				if IsPedDeadOrDying(GetPlayerPed(player)) or IsEntityPlayingAnim(GetPlayerPed(player), 'missminuteman_1ig_2', 'handsup_base', 3) or IsEntityPlayingAnim(GetPlayerPed(player), 'anim@gangops@morgue@table@', 'ko_front', 3) or IsEntityPlayingAnim(GetPlayerPed(player), "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 1) then
					TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
					OpenBodySearchMenu(player)
				else
					menu.close()
					exports.pNotify:SendNotification({text = "شهروند باید یا مرده باشد، یا دستهایش بالا باشد.", type = "error", timeout = 4000})
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenSupportMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'support', {
		title    = 'درخواست نیرو',
		align    = 'right',
		elements = {
			{label = 'درخواست نیرو پشتیبانی', value = 0},
			{label = 'درخواست نیرو از کلیه یگانهای نظامی',   value = 1},
	}}, function(data, menu)
		menu.close()
		TriggerServerEvent('master_policejob:request_support', data.current.value)
		RequestAnimDict("random@arrests")

		while not HasAnimDictLoaded("random@arrests") do
			Citizen.Wait(150)
		end
		
		TaskPlayAnim(PlayerPedId(), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
		Citizen.Wait(3000)
		RemoveAnimDict("random@arrests")
		ClearPedTasks(PlayerPedId())
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'right',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = _U('fine'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', data.current.fineLabel), data.current.amount)
			else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
				local elements = {{label = _U('plate', retrivedInfo.plate)}}
				menu.close()

				if not retrivedInfo.owner then
					table.insert(elements, {label = _U('owner_unknown')})
				else
					table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
					title    = _U('vehicle_info'),
					align    = 'right',
					elements = elements
				}, nil, function(data2, menu2)
					menu2.close()
				end)
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					table.insert(elements, {
						label = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'right',
			elements = elements,
		}, function(data, menu)
			
			exports.pNotify:SendNotification({text = "گواهینامه باطل شد.", type = "success", timeout = 4000})
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function addPlayerLicense(player)
	local elements = {
			{label = 'رانندگی', value = 'driver'},
			{label = 'حمل اسلحه',   value = 'gun'},
			{label = 'حمل مواد',   value = 'drugs'},
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'add_license', {
		title    = 'اعطای گواهینامه',
		align    = 'right',
		elements = elements,
	}, function(data, menu)
		menu.close()
		exports.pNotify:SendNotification({text = "گواهینامه صادر شد.", type = "success", timeout = 4000})
		TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(player), data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if not retrivedInfo.owner then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_policejob:getItems', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			table.insert(elements, {
				label = weapons[i].label,
				value = i
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = _U('get_weapon_menu'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_policejob:GiveWeapon', function()
				OpenGetWeaponMenu()
			end, weapons[data.current.value].name, weapons[data.current.value].amount)
		end, function(data, menu)
			menu.close()
		end)
	end, 'weapon')
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = _U('put_weapon_menu'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('esx_policejob:GetWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value )
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = items[i].label,
				value = i
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('police_stock'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_policejob:GetItem', function()
				OpenGetStocksMenu()
			end, items[data.current.value].name, items[data.current.value].amount)
		end, function(data, menu)
			menu.close()
		end)
	end, 'item')
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					exports.pNotify:SendNotification({text = "تعداد صحیح نیست.", type = "error", timeout = 4000})
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	if job.name == 'fbi' then
		playerInService = true
		ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
			if not canTakeService then
				ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
			else
				awaitService = true
				playerInService = true

				local notification = {
					title    = _U('service_anonunce'),
					subject  = '',
					msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
					iconType = 1
				}

				TriggerServerEvent('esx_service:notifyAllInService', notification, job)
			end
		end, job)
	end
end)

RegisterNetEvent('esx:setJobSub')
AddEventHandler('esx:setJobSub', function(job)
	ESX.PlayerData.job.job_sub = job
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_police'),
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
--[[AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.EnableESXService and not playerInService then
			CancelEvent()
		end
	end
end)]]--

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum, jobData)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'Jail' then
		CurrentAction     = 'menu_jail'
		CurrentActionMsg  = 'Baz Kardane Menu Zendan'
		CurrentActionData = {}
	elseif part == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum, data = jobData}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum, data = jobData}
	--[[elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}]]--
	elseif part == 'FastTravelsPrompt' then
		CurrentAction     = 'FastTravelsPrompt'
		CurrentActionMsg  = 'جهت استفاده از آسانسور E بزنید.'
		CurrentActionData = {to = jobData.FastTravelsPrompt[partNum].To.coords, heading = jobData.FastTravelsPrompt[partNum].To.heading}
	end
	
	if CurrentActionMsg ~= nil then
		exports.pNotify:SendNotification({text = CurrentActionMsg, type = "info", timeout = 4000})
	end
end)


function FastTravel(coords, heading)
	TeleportFadeEffect(PlayerPedId(), coords, heading)
end

function TeleportFadeEffect(entity, coords, heading)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)

			if heading then
				SetEntityHeading(entity, heading)
			end
		end)
	end)
end

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	
	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(foot)
	isHandcuffed = not foot
	isHandFootcuffed = foot
	local playerPed = PlayerPedId()
	HandCuffDisableActions()
	TriggerServerEvent('InteractSound_SV:PlayOnSource', 'cuff', 0.3)
	Citizen.Wait(4010)
	SetEnableHandcuffs(playerPed, true)
	DisablePlayerFiring(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
	SetPedCanPlayGestureAnims(playerPed, false)
	if foot then
		FreezeEntityPosition(playerPed, true)
	end
end)

RegisterNetEvent('esx_policejob:handuncuff')
AddEventHandler('esx_policejob:handuncuff', function(foot)
	isHandcuffed = false
	isHandFootcuffed = false
	local playerPed = PlayerPedId()
	TriggerServerEvent('InteractSound_SV:PlayOnSource', 'cuff', 0.3)
	Citizen.Wait(5600)
	ClearPedSecondaryTask(playerPed)
	SetEnableHandcuffs(playerPed, false)
	DisablePlayerFiring(playerPed, false)
	SetPedCanPlayGestureAnims(playerPed, true)
	FreezeEntityPosition(playerPed, false)
end)

RegisterNetEvent('esx_policejob:darg')
AddEventHandler('esx_policejob:darg', function(copId)
	if not (isHandcuffed or isHandFootcuffed) then
		return
	end
	if copId == nil then
		dragStatus.isDragged = false
		dragStatus.CopId = nil
		TriggerServerEvent('esx_policejob:dragOff')
	elseif dragStatus.isDragged == false then
		dragStatus.isDragged = true
		TriggerServerEvent('esx_policejob:dragOnCop', copId)
		dragStatus.CopId = copId
		DisableActionsForDrag()
	else
		dragStatus.isDragged = false
		dragStatus.CopId = nil
		TriggerServerEvent('esx_policejob:dragOff')
	end
end)

RegisterNetEvent('esx_policejob:dargOff')
AddEventHandler('esx_policejob:dargOff', function(PlayerID)
	if underDragPlayer ~= nil and underDragPlayer == PlayerID then
		underDragPlayer = nil
	end
end)

RegisterNetEvent('esx_policejob:dargCopOn')
AddEventHandler('esx_policejob:dargCopOn', function(TargetPlayer)
	dragStatus.isDragged = false
	dragStatus.CopId = nil
	underDragPlayer = TargetPlayer
	DisableActionsForDrag()
end)

function DisableActionsForDrag()
	Citizen.CreateThread(function()
		local wasDragged = false
		while dragStatus.isDragged or underDragPlayer ~= nil do
			Citizen.Wait(0)
			local playerPed = PlayerPedId()
			if underDragPlayer and underDragPlayer ~= nil then
				local targetPed = GetPlayerPed(GetPlayerFromServerId(underDragPlayer))
				if targetPed and DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
					DisableControlAction(0, 24, true) -- Attack
					DisableControlAction(0, 257, true) -- Attack 2
					DisableControlAction(0, 25, true) -- Aim
					DisableControlAction(0, 263, true) -- Melee Attack 1
					DisableControlAction(0, 21, true) -- RUN
					DisableControlAction(0, 45, true) -- Reload
					DisableControlAction(0, 22, true) -- Jump
					DisableControlAction(0, 44, true) -- Cover
					DisableControlAction(0, 37, true) -- Select Weapon
					DisableControlAction(0, 23, true) -- Also 'enter'?
					DisableControlAction(0, 49, true) -- Disable F
				else
					underDragPlayer = nil
				end
			elseif dragStatus.isDragged then
				local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				if targetPed and DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
					if not wasDragged then
						AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
						wasDragged = true
					else
						Citizen.Wait(500)
					end
				else
					TriggerServerEvent('esx_policejob:dragOff')
					wasDragged = false
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end
			elseif wasDragged then
				TriggerServerEvent('esx_policejob:dragOff')
				wasDragged = false
				DetachEntity(playerPed, true, false)
			end
		end
		
		if wasDragged then
			wasDragged = false
			DetachEntity(GetPlayerPed(-1), true, false)
			TriggerServerEvent('esx_policejob:dragOff')
		end
	end)
end

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(veh)
	if isHandcuffed or isHandFootcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
        local vehicle = NetworkGetEntityFromNetworkId(veh)
		if veh and vehicle then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
			if maxSeats and maxSeats > 1 then
				for i = maxSeats, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end
			else
				if IsVehicleSeatFree(vehicle, 1) then
					freeSeat = 1
				end
			end

			if freeSeat and freeSeat > 0 then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 16)
		if isHandcuffed or isHandFootcuffed then
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetPedCanPlayGestureAnims(playerPed, false)
			Citizen.Wait(500)
			ESX.Streaming.RequestAnimDict('mp_arresting', function()
				TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
			end)
		end
	end
end)

-- Handcuff or HandFootcuff
function HandCuffDisableActions()
	Citizen.CreateThread(function()
		while isHandcuffed or isHandFootcuffed do
			Citizen.Wait(0)
			local playerPed = PlayerPedId()
			
			DisableAllControlActions(0)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['N'], true)
			EnableControlAction(0, Keys['F10'], true)
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
			EnableControlAction(0, Keys['G'], true)
			--EnableControlAction(0, Keys['L'], true)
				
			if not isHandFootcuffed then
				EnableControlAction(0, 32, true) -- W
				EnableControlAction(0, 34, true) -- A
				EnableControlAction(0, 31, true) -- S
				EnableControlAction(0, 30, true) -- D
			end
			
			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		end
	end)
end

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale(blip, 1.2)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.Blip.name)
		EndTextCommandSetBlipName(blip)
	end
	
	for k,v in pairs(Config.SheriffStation) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale(blip, 1.2)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.Blip.name)
		EndTextCommandSetBlipName(blip)
	end
	
	for k,v in pairs(Config.FBIStation) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale(blip, 1.2)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.Blip.name)
		EndTextCommandSetBlipName(blip)
	end
	
	for k,v in pairs(Config.JusticeStation) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale(blip, 1.2)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.Blip.name)
		EndTextCommandSetBlipName(blip)
	end
end)

local isInMarker, hasExited, letSleep = false, false, true
local currentStation, currentPart, currentPartNum
	
function CreateJobBlips(v, k)
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	
	for i=1, #v.Cloakrooms, 1 do
		local distance = #(playerCoords - v.Cloakrooms[i])

		if distance < Config.DrawDistance then
			DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
			letSleep = false

			if distance < Config.MarkerSize.x then
				isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
			end
		end
	end

	for i=1, #v.Armories, 1 do
		local distance = #(playerCoords - v.Armories[i])

		if distance < Config.DrawDistance then
			DrawMarker(21, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
			letSleep = false

			if distance < Config.MarkerSize.x then
				isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
			end
		end
	end

	for i=1, #v.Jail, 1 do
		local distance = #(playerCoords - v.Jail[i])

		if distance < Config.DrawDistance then
			DrawMarker(21, v.Jail[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
			letSleep = false

			if distance < Config.MarkerSize.x then
				isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Jail', i
			end
		end
	end

	for i=1, #v.Vehicles, 1 do
		local distance = #(playerCoords - v.Vehicles[i].Spawner)

		if distance < Config.DrawDistance then
			DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
			letSleep = false

			if distance < Config.MarkerSize.x then
				isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
			end
		end
	end

	if v.Helicopters ~= nil then
		for i=1, #v.Helicopters, 1 do
			local distance =  #(playerCoords - v.Helicopters[i].Spawner)

			if distance < Config.DrawDistance then
				DrawMarker(34, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				letSleep = false

				if distance < Config.MarkerSize.x then
					isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
				end
			end
		end
	end

	if v.FastTravelsPrompt ~= nil then
		for i=1, #v.FastTravelsPrompt, 1 do
			local distance =  #(playerCoords - v.FastTravelsPrompt[i].From)

			if distance < Config.DrawDistance then
				DrawMarker(21, v.FastTravelsPrompt[i].From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				letSleep = false

				if distance < Config.MarkerSize.x then
					isInMarker, currentStation, currentPart, currentPartNum = true, k, 'FastTravelsPrompt', i
				end
			end
		end
	end
	
	--[[if v.BossActions ~= nil then
		for i=1, #v.BossActions, 1 do
			local distance = #(playerCoords - v.BossActions[i])

			if distance < Config.DrawDistance then
				DrawMarker(21, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				letSleep = false

				if distance < Config.MarkerSize.x then
					isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
				end
			end
		end
	end]]--	
end

-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job.name == 'fbi' or ESX.PlayerData.job.name == 'dadsetani') then
			
			isInMarker, hasExited, letSleep = false, false, true
			currentStation, currentPart, currentPartNum = nil, nil, nil
			jobData = nil
			if ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PoliceStations) do
					jobData = v
					CreateJobBlips(v, k)
				end
			elseif ESX.PlayerData.job.name == 'sheriff' then
				for k,v in pairs(Config.SheriffStation) do
					jobData = v
					CreateJobBlips(v, k)
				end
			elseif ESX.PlayerData.job.name == 'fbi' then
				for k,v in pairs(Config.FBIStation) do
					jobData = v
					CreateJobBlips(v, k)
				end
			elseif ESX.PlayerData.job.name == 'dadsetani' then
				for k,v in pairs(Config.JusticeStation) do
					jobData = v
					CreateJobBlips(v, k)
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if (LastStation and LastPart and LastPartNum) and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end
				
				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum, jobData)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(2000)
			end
		else
			Citizen.Wait(10000)
		end
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}
	
	while true do
		letSleep = true
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance = #(playerCoords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
				
				letSleep = false
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
				letSleep = false
			end
		else
			if LastEntity then
				TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
		
		if letSleep then
			Citizen.Wait(4500)
		end
	end
end)

RegisterNetEvent('master_keymap:e')
AddEventHandler('master_keymap:e', function() 
	if CurrentAction then
		if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job.name == 'fbi' or ESX.PlayerData.job.name == 'dadsetani') then
			if CurrentAction == 'menu_cloakroom' then
				OpenCloakroomMenu()
			elseif CurrentAction == 'menu_jail' then
				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then
						TriggerEvent("master_jail:openJailMenu")
					else
						exports.pNotify:SendNotification({text = _U('service_not'), type = "info", timeout = 3000})
					end
				end, ESX.PlayerData.job.name)
			elseif CurrentAction == 'menu_armory' then
				if not Config.EnableESXService then
					OpenArmoryMenu(CurrentActionData.station)
				elseif playerInService then
					OpenArmoryMenu(CurrentActionData.station)
				else
					exports.pNotify:SendNotification({text = _U('service_not'), type = "info", timeout = 3000})
				end
			elseif CurrentAction == 'menu_vehicle_spawner' then
				if not Config.EnableESXService then
					OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum, CurrentActionData.data)
				elseif playerInService then
					OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum, CurrentActionData.data)
				else
					exports.pNotify:SendNotification({text = _U('service_not'), type = "info", timeout = 3000})
				end
			elseif CurrentAction == 'Helicopters' then
				if not Config.EnableESXService then
					OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum, CurrentActionData.data)
				elseif playerInService then
					OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum, CurrentActionData.data)
				else
					exports.pNotify:SendNotification({text = _U('service_not'), type = "info", timeout = 3000})
				end
			elseif CurrentAction == 'FastTravelsPrompt' then
				FastTravel(CurrentActionData.to, CurrentActionData.heading)
				--CurrentActionData.Data.to
			elseif CurrentAction == 'delete_vehicle' then
				ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
			--[[elseif CurrentAction == 'menu_boss_actions' then
				ESX.UI.Menu.CloseAll()
				TriggerEvent('master_society:RequestOpenBossMenu')]]--
			elseif CurrentAction == 'remove_entity' then
				
				if currentTask.busy then
					exports.pNotify:SendNotification({text = "شما مشغول انجام کار هستید.", type = "info", timeout = 4000})
					return
				end

				currentTask.busy = true
				TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(3000)
				ClearPedTasks(GetPlayerPed(-1))
				
				currentTask.busy = false
				DeleteEntity(CurrentActionData.entity)
			end

			CurrentAction = nil
		end
	end -- CurrentAction end
	if currentTask.busy then
		ESX.ShowNotification(_U('impound_canceled'))
		ESX.ClearTimeout(currentTask.task)
		ClearPedTasks(PlayerPedId())

		currentTask.busy = false
	end
end)

RegisterNetEvent('master_keymap:f6')
AddEventHandler('master_keymap:f6', function()
	if not isDead and ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job.name == 'fbi' or ESX.PlayerData.job.name == 'dadsetani') then
		if not Config.EnableESXService then
			OpenPoliceActionsMenu()
		elseif playerInService then
			OpenPoliceActionsMenu()
		else
			exports.pNotify:SendNotification({text = _U('service_not'), type = "info", timeout = 3000})
		end
	end
end)

-- Animations
RegisterNetEvent('esx_policejob:animtarget')
AddEventHandler('esx_policejob:animtarget', function(target)
	TriggerEvent('dpemotes:cancelEmote')
	Citizen.Wait(100)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	Citizen.Wait(250)
	RequestAnimDict('mp_arrest_paired')
	while not HasAnimDictLoaded("mp_arrest_paired") do
		RequestAnimDict("mp_arrest_paired")
		Citizen.Wait(10)
	end
	TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p2_back_left', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	DetachEntity(GetPlayerPed(-1), true, false)
end)

RegisterNetEvent('esx_policejob:animuncufftarget')
AddEventHandler('esx_policejob:animuncufftarget', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	Citizen.Wait(5500)
	DetachEntity(GetPlayerPed(-1), true, false)
end)

RegisterNetEvent('esx_policejob:cuffanimpolice')
AddEventHandler('esx_policejob:cuffanimpolice', function(target)
	TriggerEvent('dpemotes:cancelEmote')
	Citizen.Wait(100)
	local playerPed = GetPlayerPed(-1)
	TriggerEvent('dpemotes:cancelEmote')
	Citizen.Wait(100)
	RequestAnimDict('mp_arrest_paired')
	while not HasAnimDictLoaded('mp_arrest_paired') do
		Citizen.Wait(10)
	end
	TaskPlayAnim(playerPed, 'mp_arrest_paired', 'cop_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)
	Citizen.Wait(3000)
end)

RegisterNetEvent('esx_policejob:uncuffanimpolice')
AddEventHandler('esx_policejob:uncuffanimpolice', function()
	local playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) 
	Citizen.Wait(250)
	RequestAnimDict('mp_arrest_paired')
	while not HasAnimDictLoaded("mp_arrest_paired") do
		RequestAnimDict("mp_arrest_paired")
		Citizen.Wait(10)
	end
	TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(playerPed)
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
	isHandcuffed = false
	isHandFootcuffed = false
	dragStatus.isDragged = false
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		if ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name then
			TriggerEvent('esx_phone:removeSpecialContact', ESX.PlayerData.job.name)

			if Config.EnableESXService then
				TriggerServerEvent('esx_service:disableService', ESX.PlayerData.job.name)
			end
		end
	end
end)

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	exports.pNotify:SendNotification({text = "خودرو به پارکینگ منتقل شد.", type = "success", timeout = 4000})
	currentTask.busy = false
end


----------
-- Mapping 
----------
Citizen.CreateThread(function()
	LoadInterior(GetInteriorAtCoords(440.84, -983.14, 30.69))
end)

-----

local isTackling				= false
local isGettingTackled			= false

local tackleLib					= 'missmic2ig_11'
local tackleAnim 				= 'mic_2_ig_11_intro_goon'
local tackleVictimAnim			= 'mic_2_ig_11_intro_p_one'

local lastTackleTime			= 0
local isRagdoll					= false

-- Main thread
RegisterNetEvent('master_keymap:shiftg')
AddEventHandler('master_keymap:shiftg', function()
	if not isTackling and playerInService and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff') then
		Citizen.Wait(10)
		local closestPlayer, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 and not isTackling and not isGettingTackled and not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
			isTackling = true
			lastTackleTime = GetGameTimer()

			TriggerServerEvent('master_policejob:try_tackle', GetPlayerServerId(closestPlayer))
		end
	end
end)

RegisterNetEvent('master_policejob:playTackle')
AddEventHandler('master_policejob:playTackle', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(tackleLib)

	while not HasAnimDictLoaded(tackleLib) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, tackleLib, tackleAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

	Citizen.Wait(3000)

	isTackling = false
end)

RegisterNetEvent('master_policejob:getTackled')
AddEventHandler('master_policejob:getTackled', function(target)
	isGettingTackled = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(tackleLib)

	while not HasAnimDictLoaded(tackleLib) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, 0.25, 0.5, 0.0, 0.5, 0.5, 180.0, false, false, false, false, 2, false)
	TaskPlayAnim(playerPed, tackleLib, tackleVictimAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

	Citizen.Wait(3000)
	DetachEntity(GetPlayerPed(-1), true, false)

	isRagdoll = true
	
	Citizen.CreateThread(function()
		while isRagdoll do
			Citizen.Wait(0)
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		end
	end)
	
	Citizen.Wait(3000)
	isRagdoll = false

	isGettingTackled = false
end)

function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end


RegisterNetEvent('master_police:ShowEmergencyBlip')
AddEventHandler('master_police:ShowEmergencyBlip', function(Coords)
-- Create blips
	Citizen.CreateThread(function()
		local blip = AddBlipForCoord(Coords)

		SetBlipSprite (blip, 161)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 1.2)
		SetBlipColour (blip, 53)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Support')
		EndTextCommandSetBlipName(blip)
		
		Citizen.Wait(120000)
		RemoveBlip(blip)
	end)
end)

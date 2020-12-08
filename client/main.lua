 
local Keys = {
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

ESX							= nil
local jogadornamaca				= false
local namaca					= false
local rim						= false
local figado					= false
local pulmao					= false
local coracao 					= false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil




Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	
	local blip2 = AddBlipForCoord(Config.VendadeOrgaos.x, Config.VendadeOrgaos.y, Config.VendadeOrgaos.z)
	SetBlipSprite(blip2, 480)
	SetBlipDisplay(blip2, 4)
	SetBlipScale(blip2, 1.0)
	SetBlipColour(blip2, 55)
	SetBlipAsShortRange(blip2, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("^1Venda de Orgãos")
	EndTextCommandSetBlipName(blip2)
	
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local bed = GetClosestObjectOfType(283.24, -1338.28, 24.54, 10.0, GetHashKey("v_med_cor_emblmtable"), false, false, false)
		if DoesEntityExist(bed) then
			local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
			local bedpos = GetEntityCoords(bed, 1)
			local distanceToBed = GetDistanceBetweenCoords(bedpos, playerpos, 1)
			local coordsb6 = {
						["x"] = bedpos.x + 0.2, 
						["y"] = bedpos.y, 
						["z"] = bedpos.z + 1.4}
			local coordsb5 = {
						["x"] = bedpos.x + 0.2, 
						["y"] = bedpos.y, 
						["z"] = bedpos.z + 1.6}
			local coordsb4 = {
						["x"] = bedpos.x + 0.2, 
						["y"] = bedpos.y, 
						["z"] = bedpos.z + 1.8}
			local coordsb3 = {
						["x"] = bedpos.x + 0.2, 
						["y"] = bedpos.y, 
						["z"] = bedpos.z + 2.0}
			local coordsb = {
						["x"] = bedpos.x + 0.2, 
						["y"] = bedpos.y, 
						["z"] = bedpos.z + 1.2}
			local coordsb2 = {
						["x"] = bedpos.x + 0.2, 
						["y"] = bedpos.y, 
						["z"] = bedpos.z + 1.0}
			if distanceToBed < 1.6 and namaca == false then
				ESX.Game.Utils.DrawText3D(coordsb, "[E] Colocar Vitima na Cama", 0.7)
				if IsControlJustReleased(0, Keys['E']) then
					if player ~= nil then
						local playerold, distance = ESX.Game.GetClosestPlayer()
						if player ~= playerold then
							rim						= false
							figado					= false
							pulmao					= false
						    coracao 					= false
							player, distance = ESX.Game.GetClosestPlayer()
							if distance ~= -1 and distance <= 3.0 then
								jogadornamaca = true
								TriggerServerEvent('sintra_orgaos:putInBed', GetPlayerServerId(player))
							else
								exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
							end
						else
							player, distance = ESX.Game.GetClosestPlayer()
							if distance ~= -1 and distance <= 3.0 then
								jogadornamaca = true
								TriggerServerEvent('sintra_orgaos:putInBed', GetPlayerServerId(player))
							else
								exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
							end
						end
					else
						player, distance = ESX.Game.GetClosestPlayer()
						if distance ~= -1 and distance <= 3.0 then
							jogadornamaca = true
							TriggerServerEvent('sintra_orgaos:putInBed', GetPlayerServerId(player))
						else
							exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
						end
					end
				end
				ESX.Game.Utils.DrawText3D(coordsb2, "[Y] Retirar Vitima da Cama", 0.7)
				if IsControlJustReleased(0, Keys['Y']) then
					player, distance = ESX.Game.GetClosestPlayer()
					if distance ~= -1 and distance <= 3.0 then
						jogadornamaca = false
						TriggerServerEvent('sintra_orgaos:remOnBed', GetPlayerServerId(player))
					else
						exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
					end
				end
				if jogadornamaca == true then
					if rim == false then
						ESX.Game.Utils.DrawText3D(coordsb3, "[1] Retirar Rim", 0.7)
						if IsControlJustReleased(0, Keys['1']) then
							player, distance = ESX.Game.GetClosestPlayer()
							local vida = GetEntityHealth(player)
							if distance ~= -1 and distance <= 3.0 then
								local vida = GetEntityHealth(GetPlayerPed(player))
								if vida > 1 then
									rim = true
									TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
									TriggerEvent("mythic_progbar:client:progress", {
										name = "remrim",
										duration = 10000,
										label = "Removendo Rim",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										}
									}, function(status)
										if not status then
											-- Do Something If Event Wasn't Cancelled
										end
									end)
									Citizen.Wait(10000)
									ClearPedTasksImmediately(playerPed)
									TriggerServerEvent('sintra_orgaos:remrim', GetPlayerServerId(player))
									exports['mythic_notify']:DoHudText('success', 'Você removeu o rim')
									TriggerServerEvent('sintra_orgaos:orgao', 'rim')
								else
									exports['mythic_notify']:DoHudText('error', 'Você não pode remover o rim de um morto')
								end
							else
								exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
							end
						end
					end
					if figado == false then
						ESX.Game.Utils.DrawText3D(coordsb4, "[2] Retirar Figado", 0.7)
						if IsControlJustReleased(0, Keys['2']) then
							player, distance = ESX.Game.GetClosestPlayer()
							local vida = GetEntityHealth(player)
							if distance ~= -1 and distance <= 3.0 then
								local vida = GetEntityHealth(GetPlayerPed(player))
								if vida > 1 then
									figado = true
									TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
									TriggerEvent("mythic_progbar:client:progress", {
										name = "remfigado",
										duration = 10000,
										label = "Removendo figado",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										}
									}, function(status)
										if not status then
											-- Do Something If Event Wasn't Cancelled
										end
									end)
									Citizen.Wait(10000)
									ClearPedTasksImmediately(playerPed)
									TriggerServerEvent('sintra_orgaos:remfigado', GetPlayerServerId(player))
									exports['mythic_notify']:DoHudText('success', 'Você removeu o figado')
									TriggerServerEvent('sintra_orgaos:orgao', 'figado')
								else
									exports['mythic_notify']:DoHudText('error', 'Você não pode remover o figado de um morto')
								end
							else
								exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
							end
						end
					end
					if pulmao == false then
						ESX.Game.Utils.DrawText3D(coordsb5, "[3] Retirar Pulmao", 0.7)
						if IsControlJustReleased(0, Keys['3']) then
							player, distance = ESX.Game.GetClosestPlayer()
							local vida = GetEntityHealth(player)
							if distance ~= -1 and distance <= 3.0 then
								local vida = GetEntityHealth(GetPlayerPed(player))
								if vida > 1 then
									pulmao = true
									TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
									TriggerEvent("mythic_progbar:client:progress", {
										name = "rempumao",
										duration = 10000,
										label = "Removendo Pulmao",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										}
									}, function(status)
										if not status then
											-- Do Something If Event Wasn't Cancelled
										end
									end)
									Citizen.Wait(10000)
									ClearPedTasksImmediately(playerPed)
									TriggerServerEvent('sintra_orgaos:rempulmao', GetPlayerServerId(player))
									exports['mythic_notify']:DoHudText('success', 'Você removeu o pulmao')
									TriggerServerEvent('sintra_orgaos:orgao', 'pulmao')
								else
									exports['mythic_notify']:DoHudText('error', 'Você não pode remover o pulmao de um morto')
								end
							else
								exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
							end
						end
					end
					if coracao == false then
						ESX.Game.Utils.DrawText3D(coordsb6, "[4] Retirar Coracao", 0.7)
						if IsControlJustReleased(0, Keys['4']) then
							player, distance = ESX.Game.GetClosestPlayer()
							local vida = GetEntityHealth(player)
							if distance ~= -1 and distance <= 3.0 then
								local vida = GetEntityHealth(GetPlayerPed(player))
								if vida > 1 then
									coracao = true
									TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
									TriggerEvent("mythic_progbar:client:progress", {
										name = "rempumao",
										duration = 10000,
										label = "Removendo Coracao",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										}
									}, function(status)
										if not status then
											-- Do Something If Event Wasn't Cancelled
										end
									end)
									Citizen.Wait(10000)
									ClearPedTasksImmediately(playerPed)
									TriggerServerEvent('sintra_orgaos:remcoracao', GetPlayerServerId(player))
									exports['mythic_notify']:DoHudText('success', 'Você removeu o coracao')
									TriggerServerEvent('sintra_orgaos:orgao', 'coracao')
								else
									exports['mythic_notify']:DoHudText('error', 'Você não pode remover o coracao de um morto')
								end
							else
								exports['mythic_notify']:DoHudText('error', 'Nenhum Jogador Proximo')
							end
						end
					end
				end
			end
		end
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('sintra_orgaos:putInBed')
AddEventHandler('sintra_orgaos:putInBed', function(player)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local bed = GetClosestObjectOfType(283.24, -1338.28, 24.54, 10.0, GetHashKey("v_med_cor_emblmtable"), false, false, false)
	local bedrot = GetEntityHeading(bed)
	namaca = true
	
	RequestAnimDict('anim@gangops@morgue@table@')
			while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
				Citizen.Wait(0)
			end
	TaskPlayAnim(playerPed, 'anim@gangops@morgue@table@' , 'ko_front' ,8.0, -8.0, -1, 1, 0, false, false, false )
	AttachEntityToEntity(PlayerPedId(), bed, 1, 0.0, 0.0, 2.0, 0.0, 0.0, 100, 1, 1, 1, 1, 0, 1)
	while namaca do
		DisableControlAction(0, Keys['X'], true)
		DisableControlAction(0, Keys['F1'], true)
		DisableControlAction(0, Keys['F2'], true)
		DisableControlAction(0, Keys['F3'], true)
		DisableControlAction(0, Keys['F5'], true)
		DisableControlAction(0, Keys['F6'], true)
		DisableControlAction(0, Keys['F7'], true)
		DisableControlAction(0, Keys['F8'], true)
		DisableControlAction(0, Keys['F9'], true)
		DisableControlAction(0, Keys['F10'], true)
		--DisableControlAction(0, Keys['T'], true)
		--DisableControlAction(0, Keys['Y'], true)
		DisableControlAction(0, Keys['E'], true)
		DisableControlAction(0, Keys['H'], true)
		DisableControlAction(0, Keys['R'], true)
		DisableControlAction(0, Keys['SPACE'], true)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('sintra_orgaos:remOnBed')
AddEventHandler('sintra_orgaos:remOnBed', function(player)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local bed = GetClosestObjectOfType(283.24, -1338.28, 24.54, 10.0, GetHashKey("v_med_cor_emblmtable"), false, false, false)
	local bedrot = GetEntityRotation(bed)
	namaca = false

	DetachEntity(playerPed)
	ClearPedTasksImmediately(playerPed)

end)

RegisterNetEvent('sintra_orgaos:remrim')
AddEventHandler('sintra_orgaos:remrim', function(player)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local dano = math.random(0, 100)
	DoScreenFadeOut(1800)
	
	if dano < 20 then
		SetEntityHealth(playerPed, 0)
		exports['mythic_notify']:DoHudText('error', 'Seu Rim foi removido, mas Você não sobreviveu a cirurgia.')
		local bed = GetClosestObjectOfType(283.24, -1338.28, 24.54, 10.0, GetHashKey("v_med_cor_emblmtable"), false, false, false)
		local bedrot = GetEntityRotation(bed)
		namaca = false
		DetachEntity(playerPed)
		StopAnimTask(playerPed,'anim@gangops@morgue@table@', 'ko_front')
	else
		local vida = GetEntityHealth(playerPed)
		SetEntityHealth(playerPed, vida - 20)
		exports['mythic_notify']:DoHudText('error', 'Seu Rim foi removido')
	end
	Citizen.Wait(2000)
	DoScreenFadeIn(1800)
end)

RegisterNetEvent('sintra_orgaos:remfigado')
AddEventHandler('sintra_orgaos:remfigado', function(player)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local dano = math.random(0, 100)
	DoScreenFadeOut(1800)
	
	if dano < 10 then
		SetEntityHealth(playerPed, 0)
		exports['mythic_notify']:DoHudText('error', 'Seu Figado foi removido, mas Você não sobreviveu a cirurgia.')
		local bed = GetClosestObjectOfType(283.24, -1338.28, 24.54, 10.0, GetHashKey("v_med_cor_emblmtable"), false, false, false)
		local bedrot = GetEntityRotation(bed)
		namaca = false
		DetachEntity(playerPed)
		StopAnimTask(playerPed,'anim@gangops@morgue@table@', 'ko_front')
	else
		local vida = GetEntityHealth(playerPed)
		SetEntityHealth(playerPed, vida - 10)
		exports['mythic_notify']:DoHudText('error', 'Seu Figado foi removido')
	end
	Citizen.Wait(2000)
	DoScreenFadeIn(1800)
end)

RegisterNetEvent('sintra_orgaos:rempulmao')
AddEventHandler('sintra_orgaos:rempulmao', function(player)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local dano = math.random(0, 100)
	DoScreenFadeOut(1800)
	
	if dano < 30 then
		SetEntityHealth(playerPed, 0)
		exports['mythic_notify']:DoHudText('error', 'Seu Pulmao foi removido, mas Você não sobreviveu a cirurgia.')
		local bed = GetClosestObjectOfType(283.24, -1338.28, 24.54, 10.0, GetHashKey("v_med_cor_emblmtable"), false, false, false)
		local bedrot = GetEntityRotation(bed)
		namaca = false
		DetachEntity(playerPed)
		StopAnimTask(playerPed,'anim@gangops@morgue@table@', 'ko_front')
	else
		local vida = GetEntityHealth(playerPed)
		SetEntityHealth(playerPed, vida - 50)
		exports['mythic_notify']:DoHudText('error', 'Seu Pulmao foi removido')
	end
	Citizen.Wait(2000)
	DoScreenFadeIn(1800)
end)

RegisterNetEvent('sintra_orgaos:remcoracao')
AddEventHandler('sintra_orgaos:remcoracao', function(player)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	DoScreenFadeOut(1800)
	
	Citizen.Wait(2000)
	DoScreenFadeIn(1800)
	
	local vida = GetEntityHealth(playerPed)
	SetEntityHealth(playerPed, 0)
	exports['mythic_notify']:DoHudText('error', 'Seu coracao foi removido e Você não sobreviveu a cirurgia')
	local bed = GetClosestObjectOfType(283.24, -1338.28, 24.54, 10.0, GetHashKey("v_med_cor_emblmtable"), false, false, false)
	local bedrot = GetEntityRotation(bed)
	namaca = false
	DetachEntity(playerPed)
	StopAnimTask(playerPed,'anim@gangops@morgue@table@', 'ko_front')
end)

function OpenBuyOrgaos()

    local elements = {}

    for i=1, #Config.LojaOrgaos, 1 do
		local orgaos = Config.LojaOrgaos[i]

      table.insert(elements, {label = orgaos.label .. ' €' .. orgaos.price, value = orgaos.id, price = orgaos.price, label = orgaos.label})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'buy_sementes_menu',
      {
        title    = "Venda de Orgãos",
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)
		local name = data.current.value
		local price = data.current.price
		local label = data.current.label
        TriggerServerEvent('sintra_orgaos:buy', name, price, label)

      end,
      function(data, menu)
        menu.close()
      end
    )
end

-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

			DrawMarker(Config.MarkerType, Config.VendadeOrgaos.x, Config.VendadeOrgaos.y, Config.VendadeOrgaos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.VendadeOrgaos.x, Config.VendadeOrgaos.y, Config.VendadeOrgaos.z)
							
		if dist <= 1.8 then
			SetTextComponentFormat('STRING')
			AddTextComponentString("Pressione ~INPUT_CONTEXT~ para abrir a venda de orgãos")
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlPressed(0,  Keys['E']) then	
					OpenBuyOrgaos()
					open = true
			end
		end
		
		if dist >= 1.8 then
			if open then
				open = false
				ESX.UI.Menu.CloseAll()
			end
		end
	end
end)


function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
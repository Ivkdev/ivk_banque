ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('atm', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed, true)

	for i = 1, #Config.ATM do
        local atm = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 1.0, Config.ATM[i], false, false, false)
        local atmPos = GetEntityCoords(atm)
        local dist = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, atmPos.x, atmPos.y, atmPos.z, true)
        if dist < 1.5 then
            openATM()
        end
    end
end)

local letSleep = true
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		letSleep = true
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed, true)
		local src = source

		for k,v in pairs(Config.Banks) do
			for i=1, #v.BankCoords, 1 do
				local bankDist = #(playerCoords - v.BankCoords[i])
				local bankCoords = v.BankCoords[i]
				if bankDist > 1.5 and bankDist < 5.0 then
					letSleep = false
					DrawMarker(20, v.BankCoords[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.30, 0.30, 0.30, 19, 112, 219, 100, false, true, 2, false, false, false, false)
				elseif bankDist < 1.5 then
					letSleep = false
					DrawText3Ds(bankCoords.x, bankCoords.y, bankCoords.z, "~b~[E]~s~ | Open Bank")
					if IsControlJustReleased(0, 38) then
						openBank()
					end
				end
			end
		end

		if letSleep then
            Citizen.Wait(100)
        end
	end
end)

RegisterNetEvent('ivk-Banking:sendBalance')
AddEventHandler('ivk-Banking:sendBalance', function(money, bank, name)
	SendNUIMessage({
		type = 'sendBalnce',
		currentCashBalance = money,
		currentBalance = bank,
		customer = string.upper(name)
	})
end)

-- Functions

Citizen.CreateThread(function()
	Citizen.Wait(1)
	for k,v in pairs(Config.Banks) do
		local blip = AddBlipForCoord(v.BlipCoords)

		SetBlipSprite (blip, 108)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Bank')
		EndTextCommandSetBlipName(blip)
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- NUI

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
end)

function openBank()
	ESX.TriggerServerCallback('ivk-Banking:hasSavingsAccount', function(data)
		if data then
			ESX.TriggerServerCallback('ivk-Banking:SavingsAccountBalance', function(amount)
				SetNuiFocus(true, true)
				SendNUIMessage({
					type = 'openbank',
					currency = Config.Currency,
					savings = data,
					currentSavingBalance = amount
				})
				TriggerServerEvent('ivk-Banking:checkBlance')
			end, GetPlayerServerId())
		else
			SetNuiFocus(true, true)
			SendNUIMessage({
				type = 'openbank',
				currency = Config.Currency,
				serverName = Config.ServerName,
				savings = data,
			})
			TriggerServerEvent('ivk-Banking:checkBlance')
		end
	end, GetPlayerServerId())
end

function openATM()
	ESX.TriggerServerCallback('ivk-Banking:hasBankCard', function(data)
		if data then
			TriggerEvent('FzD-Numpad:OpenUI')
		else
			ESX.ShowNotification('You need a bank card to use an ATM!')
		end
	end)
end

RegisterNetEvent('ivk-Banking:openATM')
AddEventHandler('ivk-Banking:openATM', function(pin)
	ESX.TriggerServerCallback('ivk-Banking:checkPin', function(data)
		print(data)
		print(pin)
		if pin == data then
			openBank()
		else
			ESX.ShowNotification('~r~Incorrect~s~ Pin')
		end
	end, GetPlayerServerId())
end)

RegisterNetEvent('ivk-Banking:correctPin')
AddEventHandler('ivk-Banking:correctPin', function()
	openBank()
end)

RegisterNetEvent('ivk-Banking:wrongPin')
AddEventHandler('ivk-Banking:wrongPin', function()
	ESX.ShowNotification('~r~Incorrect Pin')
end)

RegisterCommand('closeui', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closebank'})
end)

RegisterNUICallback('Deposit100', function()
	TriggerServerEvent('ivk-Banking:Deposit100')
	TriggerServerEvent('ivk-Banking:checkBlance')
end)

RegisterNUICallback('Deposit1000', function()

	TriggerServerEvent('ivk-Banking:Deposit1000')
	TriggerServerEvent('ivk-Banking:checkBlance')
end)

RegisterNUICallback('Deposit10000', function()
	TriggerServerEvent('ivk-Banking:Deposit10000')
	TriggerServerEvent('ivk-Banking:checkBlance')
end)

RegisterNUICallback('Withdraw100', function()
	TriggerServerEvent('ivk-Banking:Withdraw100')
	TriggerServerEvent('ivk-Banking:checkBlance')
end)

RegisterNUICallback('Withdraw1000', function()
	TriggerServerEvent('ivk-Banking:Withdraw1000')
	TriggerServerEvent('ivk-Banking:checkBlance')
end)

RegisterNUICallback('Withdraw10000', function()
	TriggerServerEvent('ivk-Banking:Withdraw10000')
	TriggerServerEvent('ivk-Banking:checkBlance')
end)

RegisterNUICallback('withdraw', function(data)
	if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
		TriggerServerEvent('ivk-Banking:withdraw', data.amount)
		TriggerServerEvent('ivk-Banking:checkBlance')
	end
end)

RegisterNUICallback('deposit', function(data)
	if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
		TriggerServerEvent('ivk-Banking:deposit', data.amount)
		TriggerServerEvent('ivk-Banking:checkBlance')
	end
end)

RegisterNUICallback('createSavingsAccount', function(data)
	TriggerServerEvent('ivk-Banking:CreateSavingsAccount')
end)

RegisterNUICallback('deleteSavingsAccount', function(data)
	TriggerServerEvent('ivk-Banking:DeleteSavingsAccount')
end)

RegisterNetEvent('ivk-Banking:refreshSavings')
AddEventHandler('ivk-Banking:refreshSavings', function()
	ESX.TriggerServerCallback('ivk-Banking:hasSavingsAccount', function(data)
		SendNUIMessage({
			type = 'CreatedSavings',
			savings = data
		})
	end, GetPlayerServerId())
end)

RegisterNetEvent('ivk-Banking:refreshSavingsBalance')
AddEventHandler('ivk-Banking:refreshSavingsBalance', function()
	ESX.TriggerServerCallback('ivk-Banking:hasSavingsAccount', function(data)
		if data then
			ESX.TriggerServerCallback('ivk-Banking:SavingsAccountBalance', function(amount)
				SendNUIMessage({
					type = 'CreatedSavings',
					savings = data,
					currentSavingBalance = amount
				})
			end, GetPlayerServerId())
		end
	end, GetPlayerServerId())
end)

RegisterNUICallback('savingsWithdraw', function(data)
	if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
		ESX.TriggerServerCallback('ivk-Banking:SavingsAccountBalanceNoFormat', function(balance)
			TriggerServerEvent('ivk-Banking:savingsWithdraw', data.amount, balance)
			TriggerServerEvent('ivk-Banking:checkBlance')
		end, GetPlayerServerId(), false)
	end
end)

RegisterNUICallback('savingsDeposit', function(data)
	if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
		ESX.TriggerServerCallback('ivk-Banking:SavingsAccountBalanceNoFormat', function(balance)
			TriggerServerEvent('ivk-Banking:savingsDeposit', data.amount, balance)
			TriggerServerEvent('ivk-Banking:checkBlance')
		end, GetPlayerServerId(), false)
	end
end)

RegisterNUICallback('transferMoney', function(data)
	if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
		TriggerServerEvent('ivk-Banking:transferMoney', data.amount, data.identifier)
		TriggerServerEvent('ivk-Banking:checkBlance')
	end
end)

RegisterNUICallback('orderNewCard', function(data)
	print('test')
	TriggerServerEvent('ivk-Banking:GiveBankCard')
end)

RegisterNUICallback('createPin', function(data)
	TriggerServerEvent('ivk-Banking:CreateNewPin', data.pin)
end)
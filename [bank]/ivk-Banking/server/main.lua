ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ivk-Banking:checkBlance')
AddEventHandler('ivk-Banking:checkBlance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    bankBalance = format_int(xPlayer.getAccount('bank').money)
    moneyBalance = format_int(xPlayer.getMoney())
    name = xPlayer.getName()
    TriggerClientEvent('ivk-Banking:sendBalance', _source, moneyBalance, bankBalance, name)
end)

function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

RegisterServerEvent('ivk-Banking:deposit')
AddEventHandler('ivk-Banking:deposit', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= amount then
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', amount)
    end
end)

RegisterServerEvent('ivk-Banking:withdraw')
AddEventHandler('ivk-Banking:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('bank').money >= amount then
        xPlayer.addMoney(amount)
        xPlayer.removeAccountMoney('bank', amount)
    end
end)


RegisterServerEvent('ivk-Banking:Deposit100')
AddEventHandler('ivk-Banking:Deposit100', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 100 then
        xPlayer.removeMoney(100)
        xPlayer.addAccountMoney('bank', 100)
    end
end)

RegisterServerEvent('ivk-Banking:transferMoney')
AddEventHandler('ivk-Banking:transferMoney', function(amount, identifier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerTarget = ESX.GetPlayerFromId(identifier)

    if xPlayer then
        if xPlayerTarget then
            if xPlayer.getAccount('bank').money >= amount then
                xPlayer.removeAccountMoney('bank', amount)
                xPlayerTarget.addAccountMoney('bank', amount)
                TriggerClientEvent('ivk-Banking:sendBalance', xPlayer.source, format_int(xPlayer.getMoney()), format_int(xPlayer.getAccount('bank').money), xPlayer.getName())
                TriggerClientEvent('ivk-Banking:sendBalance', xPlayerTarget.source, format_int(xPlayerTarget.getMoney()), format_int(xPlayerTarget.getAccount('bank').money), xPlayerTarget.getName())
            end
        end
    end
end)

RegisterServerEvent('ivk-Banking:Deposit1000')
AddEventHandler('ivk-Banking:Deposit1000', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 1000 then
        xPlayer.removeMoney(1000)
        xPlayer.addAccountMoney('bank', 1000)
    end
end)

RegisterServerEvent('ivk-Banking:Deposit10000')
AddEventHandler('ivk-Banking:Deposit10000', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 10000 then
        xPlayer.removeMoney(10000)
        xPlayer.addAccountMoney('bank', 10000)
    end
end)

RegisterServerEvent('ivk-Banking:Withdraw100')
AddEventHandler('ivk-Banking:Withdraw100', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('bank').money >= 100 then
        xPlayer.addMoney(100)
        xPlayer.removeAccountMoney('bank', 100)
    end
end)

RegisterServerEvent('ivk-Banking:Withdraw1000')
AddEventHandler('ivk-Banking:Withdraw1000', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('bank').money >= 1000 then
        xPlayer.addMoney(1000)
        xPlayer.removeAccountMoney('bank', 1000)
    end
end)

RegisterServerEvent('ivk-Banking:Withdraw10000')
AddEventHandler('ivk-Banking:Withdraw10000', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('bank').money >= 10000 then
        xPlayer.addMoney(10000)
        xPlayer.removeAccountMoney('bank', 10000)
    end
end)

RegisterServerEvent('ivk-Banking:CreateSavingsAccount')
AddEventHandler('ivk-Banking:CreateSavingsAccount', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        MySQL.Async.execute('INSERT INTO saving_accounts (id, money) VALUES (@id, @money)', {
            ['@id'] = xPlayer.identifier,
            ['@money']  = 0
        }, function(result)
            TriggerClientEvent('ivk-Banking:refreshSavings', _source)
            TriggerClientEvent('ivk-Banking:refreshSavingsBalance', _source)
        end)
    end
end)

RegisterServerEvent('ivk-Banking:DeleteSavingsAccount')
AddEventHandler('ivk-Banking:DeleteSavingsAccount', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        MySQL.Async.execute('DELETE FROM saving_accounts WHERE id = @id', {
            ['@id'] = xPlayer.identifier
        }, function(result)
            TriggerClientEvent('ivk-Banking:refreshSavings', _source)
            TriggerClientEvent('ivk-Banking:refreshSavingsBalance', _source)
        end)
    end
end)

ESX.RegisterServerCallback('ivk-Banking:hasSavingsAccount', function(source, cb, player) 
    print(player)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(xPlayer)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM saving_accounts WHERE id = @id', {
            ['@id'] = xPlayer.identifier
		}, function(result)
            if tonumber(result[1].count) > 0 then
				cb(true)
			else
				cb(false)
			end
		end)
    end
end)

ESX.RegisterServerCallback('ivk-Banking:SavingsAccountBalance', function(source, cb, player) 
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT money FROM saving_accounts WHERE id = @id', {
            ['@id'] = xPlayer.identifier
		}, function(result)
            for k,v in pairs(result) do
                cb(format_int(v.money))
            end
		end)
    end
end)

RegisterServerEvent('ivk-Banking:savingsDeposit')
AddEventHandler('ivk-Banking:savingsDeposit', function(amount, balance)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
  
    if xPlayer.getAccount('bank').money >= amount then
        xPlayer.removeAccountMoney('bank', amount)
        MySQL.Async.execute('UPDATE saving_accounts SET money = @money WHERE id = @id', {
            ['@id'] = xPlayer.identifier,
            ['@money']  = balance + amount
        }, function(result)
            TriggerClientEvent('ivk-Banking:refreshSavingsBalance', _source)
        end)
    end
end)

RegisterServerEvent('ivk-Banking:savingsWithdraw')
AddEventHandler('ivk-Banking:savingsWithdraw', function(amount, balance) 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT money FROM saving_accounts WHERE id = @id', {
            ['@id'] = xPlayer.identifier
		}, function(result)
            for k,v in pairs(result) do
                if v.money >= amount then
                    xPlayer.addAccountMoney('bank', amount)
                    MySQL.Async.execute('UPDATE saving_accounts SET money = @money WHERE id = @id', {
                        ['@id'] = xPlayer.identifier,
                        ['@money']  = tonumber(balance) - amount
                    }, function(result)
                        TriggerClientEvent('ivk-Banking:refreshSavingsBalance', _source)
                    end)
                end
            end
		end)
end)

ESX.RegisterServerCallback('ivk-Banking:SavingsAccountBalanceNoFormat', function(source, cb, player) 
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT money FROM saving_accounts WHERE id = @id', {
            ['@id'] = xPlayer.identifier
		}, function(result)
            for k,v in pairs(result) do
                cb(v.money)
            end
		end)
    end
end)

RegisterServerEvent('ivk-Banking:GiveBankCard')
AddEventHandler('ivk-Banking:GiveBankCard', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getInventoryItem('bankcard').count < 1 then
            xPlayer.addInventoryItem('bankcard', 1)
        end
    end
end)

RegisterServerEvent('ivk-Banking:CreateNewPin')
AddEventHandler('ivk-Banking:CreateNewPin', function(newPin)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('UPDATE users SET pin = @pin WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@pin']  = tonumber(newPin)
    })
end)

ESX.RegisterServerCallback('ivk-Banking:checkPin', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT pin FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
		}, function(result)
            for k,v in pairs(result) do
                cb(v.pin)
            end
		end)
    end
end)

ESX.RegisterServerCallback('ivk-Banking:hasBankCard', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getInventoryItem('bankcard').count == 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)
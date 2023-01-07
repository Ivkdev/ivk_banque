keys = {
  ["F10"] = 0x77,
}


function openGui()
  SetNuiFocus(true,true)
  SendNUIMessage({open = true})
end

function CloseGui()
  SetNuiFocus(false,false)
  SendNUIMessage({close = true})
end

RegisterNUICallback('close', function(data, cb)
  CloseGui()
  cb('ok')
end)

RegisterNUICallback('complete', function(data, cb)
  TriggerEvent('ivk-Banking:openATM', data.pin)
  CloseGui()
  cb('ok')
end)

RegisterNetEvent('ivk-Numpad:OpenUI')
AddEventHandler('ivk-Numpad:OpenUI', function()
  Citizen.Wait(75)
  openGui()
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)

    if IsControlJustReleased(0, keys["F10"]) then
      SendNUIMessage({
        type = "close"
      })
    end
  end
end)



RegisterCommand('test', function()
  TriggerEvent('ivk-Numpad:OpenUI')
end)

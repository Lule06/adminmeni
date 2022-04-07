ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("lukex_core:proveriRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

RegisterServerEvent('adminsistem:logovi')
AddEventHandler('adminsistem:logovi', function(bot, msg)
    adminmeni(bot, msg, 0)
end)

function adminmeni(name,message, color)
  local vreme = os.date("*t")
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
        ["text"]= "Vrijeme: " .. vreme.hour .. ":" .. vreme.min .. ":" .. vreme.sec,

         },
      }
  }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds}), { ['Content-Type'] = 'application/json' })
  end
  
RegisterServerEvent("adminmeni:PortajDoMene")
AddEventHandler("adminmeni:PortajDoMene", function(id, portLoc)
    TriggerClientEvent("adminmeni:PortajDoMene", id, portLoc)
end)

RegisterServerEvent("adminmeni:healigrac")
AddEventHandler("adminmeni:healigrac", function(id)
    TriggerClientEvent("adminmeni:healigrac", id)
end)

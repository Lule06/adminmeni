ESX                = nil
local nevidljivost = false
local state = true
local idovi = false
local PlayerData = {}
local disPlayerNames = 20
local open = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function karakterNotifikacija(title, subject, msg)

	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
  
	ESX.ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
  
	UnregisterPedheadshot(mugshot)

end

RegisterNetEvent('kastm:popravi')
AddEventHandler('kastm:popravi', function()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
		admin_notifikacije("~g~Tvoje vozilo je popravljeno!")
	else
		admin_notifikacije("~r~Nisi u vozilu i ne mozes ga popravi!")
	end
end)

RegisterNetEvent('kastm:ocisti')
AddEventHandler('kastm:ocisti', function()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDirtLevel(vehicle, 0)
		admin_notifikacije("~g~Tvoje vozilo je ocisceno!")
	else
		admin_notifikacije("~r~Nisi u vozilu i ne mozes ga ocistiti!")
	end
end)


function OtvoriAdminMeni()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'admin_meni',
  {
    css      = 'meni',
    title    = 'Admin Meni | 🔑',
    align    = 'top-left',
    elements = {
	  {label = 'AdminDuznost | 🏋️‍', value = 'duznost'},
	  {label = 'Auta | 🏎️', value = 'auti'},
	  {label = 'Teleport | 🕴️', value = 'teleport'},
	  {label = 'Igraci | 🔥', value = 'igraci'},
    }
  },
    
    function(data, menu)      
	  if data.current.value == 'auti' then
			OtvoriAutiMeni()
      end
	  if data.current.value == 'duznost' then
			OtvoriAdminMeni2()
      end
	  if data.current.value == 'teleport' then
			OtvoriTeleportMeni()
      end
	  if data.current.value == 'igraci' then
			OtvoriIgraciMeni()
      end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

RegisterNetEvent("luli:admin")
AddEventHandler("luli:admin", function()
  ESX.TriggerServerCallback("lukex_core:proveriRank", function(playerRank)
    if playerRank == "mod" or playerRank == "admin" or playerRank == "superadmin" then
      OtvoriAdminMeni()
	  admin_notifikacije('~r~Otvorio Si Admin Meni')
    else
      karakterNotifikacija('~r~Admin Meni', '~w~Pristup odbijen', 'Nemate dozvolu!.')
    end
  end)
end)

RegisterKeyMapping('adminmeni', 'Ukljuci Admin Meni', 'keyboard', 'HOME')
RegisterCommand('adminmeni', function()
OtvoriAdminMeni()
end, false)


UnosTastatura = function(TextEntry, ExampleText, MaxStringLength)
AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
DisableAllControlActions(0)
if IsDisabledControlPressed(0, 322) then return "" end
Wait(0)
end
if (GetOnscreenKeyboardResult()) then
print(GetOnscreenKeyboardResult())
return GetOnscreenKeyboardResult()
  end
end

function OtvoriAutiMeni()

  ESX.UI.Menu.CloseAll()
  
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'auti_actions',
    {
      css      = 'meni',
      title    = 'AutoMobili | 🚗',
      align    = 'top-left',
      elements = {
	  {label = 'Blista | 🚘️', value = 'auto'},
      {label = 'Bmx | 🚴', value = 'auto2'},
      {label = 'Bager | 🔧', value = 'auto3'},
      {label = 'Motor | 🛵', value = 'auto4'},
	  {label = 'Kawasaki | 🛺', value = 'auto5'},
	  {label = 'Gorivo | ⛽', value = 'pumpa'},
      }
    },
    function(data, menu)
      if data.current.value == 'auto' then
				blista("blista")
      end

      if data.current.value == 'auto2' then
				bmx("bmx")
      end

      if data.current.value == 'auto3' then
				bulldozer("bulldozer")
      end

      if data.current.value == 'auto4' then
				bati("bati")
      end
	  
	  if data.current.value == 'auto5' then
				zx10("zx10")
      end
	  if data.current.value == 'pumpa' then
	      local igrac = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(igrac,false)
        SetVehicleFuelLevel(vehicle, 100)
		  --exports["esx_legacyfuel"]:SetFuel(vehicle, 100)
      if Config.UkljuciLogove then
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je napunio gorivo '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
      end
      end
    end,
  function(data, menu)
    OtvoriAdminMeni()
  end
  )
end

function bmx(somecar) 
  Wait(100)
  TriggerEvent('esx:spawnVehicle', somecar)
  admin_notifikacije("~g~Spawno Si Bmx")
  if Config.UkljuciLogove then
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local player = PlayerId()
  local ime = GetPlayerName(player)
  local msg = ''.. ime .. ' je spawno bmx '
  local bot = "ADMIN MENI"
		  
  TriggerServerEvent('adminsistem:logovi', bot, msg)
  end
end

function blista(somecar2) 
  Wait(100)
  TriggerEvent('esx:spawnVehicle', somecar2)
  admin_notifikacije("~g~Spawno Si Blistu")
  if Config.UkljuciLogove then
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local player = PlayerId()
  local ime = GetPlayerName(player)
  local msg = ''.. ime .. ' je spawno blistu '
  local bot = "ADMIN MENI"
		  
  TriggerServerEvent('adminsistem:logovi', bot, msg)
end
end

function bulldozer(somecar3) 
  Wait(100)
  TriggerEvent('esx:spawnVehicle', somecar3)
  admin_notifikacije("~g~Spawno Si Buldozera")
  if Config.UkljuciLogove then
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local player = PlayerId()
  local ime = GetPlayerName(player)
  local msg = ''.. ime .. ' je spawno bager '
  local bot = "ADMIN MENI"
		  
  TriggerServerEvent('adminsistem:logovi', bot, msg)
  end
end

function bati(somecar4) 
  Wait(100)
  TriggerEvent('esx:spawnVehicle', somecar4)
  admin_notifikacije("~g~Spawno Si Batia")
  if Config.UkljuciLogove then
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local player = PlayerId()
  local ime = GetPlayerName(player)
  local msg = ''.. ime .. ' je spawno batia '
  local bot = "ADMIN MENI"
		  
  TriggerServerEvent('adminsistem:logovi', bot, msg)
  end
end

function zx10(somecar5) 
  Wait(100)
  TriggerEvent('esx:spawnVehicle', somecar5)
  admin_notifikacije("~g~Spawno Si Kawasakija")
  if Config.UkljuciLogove then
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local player = PlayerId()
  local ime = GetPlayerName(player)
  local msg = ''.. ime .. ' je spawnao kawasakija '
  local bot = "ADMIN MENI"
		  
  TriggerServerEvent('adminsistem:logovi', bot, msg)
  end
end

function OtvoriAdminMeni2()

  ESX.UI.Menu.CloseAll()
  
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'admin_actions',
    {
      css      = 'meni',
      title    = 'AdminMenu | 👽',
      align    = 'top-left',
      elements = {
      {label = 'Nevidljivost | 🌟', value = 'nevidljivost'},
      {label = 'Teleport na marker | 👕', value = 'teleport'},
      {label = 'Popravi | 🔧', value = 'popravi'},
      {label = 'Očisti | 🧼', value = 'ocisti'},
      {label = 'Spectate | 🔭', value = 'posmatraj'},
	  {label = 'ozivi | 🏥', value = 'revive'},
      {label = 'godmode | 🔱', value = 'godmode'},
      {label = 'noclip | 🐦', value = 'noclip'},
	  {label = 'Obij Vozilo | 🚙', value = 'hijack_vehicle'},
	  {label = 'Obrisi Vozilo | ⚙️', value = 'del_vehicle'},
	  {label = 'Markeri | 🧹', value = 'markeri'},
	  {label = 'Heal | 🚑', value = 'heal'},
	  {label = 'Racuni | 💶', value = 'billing'},
      }
    },
    function(data, menu)			
      if data.current.value == 'nevidljivost' then
        if nevidljivost == false then
          SetEntityVisible(PlayerPedId(), false)
          admin_notifikacije("~g~Nevidljivost Ukljucen!")
          if Config.UkljuciLogove then
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je upalio nevidljivost '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
          end
          nevidljivost = true
        else
          SetEntityVisible(PlayerPedId(), true)
          admin_notifikacije("~g~Nevidljivost Iskljucena!")
          if Config.UkljuciLogove then
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je iskljucio nevidljivost '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
          end
          nevidljivost = false
        end
      end
	 
      if data.current.value == 'godmode' then
        if godmode == false then
        SetEntityInvincible(PlayerPedId(), true)
        SetPlayerInvincible(PlayerId(), true)
        SetPedCanRagdoll(PlayerPedId(), false)
        ClearPedBloodDamage(PlayerPedId())
        ResetPedVisibleDamage(PlayerPedId())
        ClearPedLastWeaponDamage(PlayerPedId())
        SetEntityProofs(PlayerPedId(), true, true, true, true, true, true, true, true)
        SetEntityOnlyDamagedByPlayer(PlayerPedId(), false)
        SetEntityCanBeDamaged(PlayerPedId(), false)
        admin_notifikacije("~g~GodMode Ukljucen!")
        if Config.UkljuciLogove then
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je upalio godmode '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
        end
          godmode = true
        else
        SetEntityInvincible(PlayerPedId(), false)
        SetPlayerInvincible(PlayerId(), false)
        SetPedCanRagdoll(PlayerPedId(), true)
        ClearPedLastWeaponDamage(PlayerPedId())
        SetEntityProofs(PlayerPedId(), false, false, false, false, false, false, false, false)
        SetEntityOnlyDamagedByPlayer(PlayerPedId(), false)
        SetEntityCanBeDamaged(PlayerPedId(), true)
        admin_notifikacije("~g~GodMode Iskljucen!")
        if Config.UkljuciLogove then
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je iskljucio godmode '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
        end
          godmode = false
        end
      end

	  
	  if data.current.value == 'hijack_vehicle' then

		local playerPed = PlayerPedId()
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(playerPed)

		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('inside_vehicle'))
			return
		end

		if DoesEntityExist(vehicle) then
			IsBusy = true
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)

				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ClearPedTasksImmediately(playerPed)

				admin_notifikacije("~g~Vozilo Otkljucano!")
				IsBusy = false
			end)
		else
			admin_notifikacije("~g~Nema Vozila!")
		end
	end
	
      if data.current.value == 'teleport' then
        local WaypointHandle = GetFirstBlipInfoId(8)

        if DoesBlipExist(WaypointHandle) then
          local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

          for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
              SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
              break
            end
            Citizen.Wait(0)
          end
          admin_notifikacije("~g~Uspesno ste se teleportovali!")
        else
          admin_notifikacije("~g~Morate da oznacite marker!")
        end
      end

      if data.current.value == 'popravi' then
        TriggerEvent('kastm:popravi')
        if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je popravio vozilo '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
      end
    end
      if data.current.value == 'ocisti' then
        TriggerEvent('kastm:ocisti')
        if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je ocistio vozilo '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
      end
    end
      if data.current.value == 'posmatraj' then
        TriggerEvent('esx_spectate:spectate')
      end  
	  if data.current.value == 'revive' then
        TriggerEvent('esx_ambulancejob:revive')
        admin_notifikacije("~g~Revivo Si Se")
        if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' se oziveo '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
      end
    end
	  if data.current.value == 'del_vehicle' then
        TriggerEvent('esx:deleteVehicle', source)
        admin_notifikacije("~g~Obriso Si Vozilo")
        if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je obriso auto '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
      end
    end
    if data.current.value == 'noclip' then
      TriggerEvent('esx:noclip')
		ESX.UI.Menu.CloseAll()
        admin_notifikacije("~g~Upalio Si Noclip")
        if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' se noclipo '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
        end
      end
	  if data.current.value == 'markeri' then
        SendToCommunityService(GetPlayerServerId(closestPlayer))
        if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' je poslao igraca na markere '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
        end
      end
	  if data.current.value == 'heal' then
        TriggerEvent('esx_basicneeds:healPlayer')
        admin_notifikacije("~g~Healo Si Se")
        if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local player = PlayerId()
		  local ime = GetPlayerName(player)
		  local msg = ''.. ime .. ' se healo '
		  local bot = "ADMIN MENI"
		  
		  TriggerServerEvent('adminsistem:logovi', bot, msg)
        end
      end
	  if data.current.value == 'billing' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = ('racun')
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					admin_notifikacije("~r~Nevazeci Iznos!")
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						admin_notifikacije("~r~Nema Igraca U Blizni!")
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mecano', _U('mechanic'), amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end
		)
	end
    end,
  function(data, menu)
    OtvoriAdminMeni()
  end
  )
end

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "MARKERI",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			admin_notifikacije('Invalid services count.')
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService", player, community_services_count)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

function OtvoriTeleportMeni()

  ESX.UI.Menu.CloseAll()
  
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'teleport_actions',
    {
      css      = 'meni',
      title    = 'Teleport | 🔥',
      align    = 'top-left',
      elements = {
	  {label = 'Glavna Garaza | 🚘️', value = 'glavna'},
      {label = 'Policija | 🚔', value = 'policija'},
      {label = 'Bolnica | 💉', value = 'bolnica'},
      {label = 'Mehanicarska | 🔧', value = 'mehanicarska'},
      {label = 'AutoSalon | 🚈', value = 'autosalon'},
      {label = 'SandyShores | 🏜️', value = 'sendi'},
      {label = 'PaletoBay | ⛰️', value = 'paleto'},
      }
    },
    function(data, menu)
      if data.current.value == 'glavna' then
	  SetEntityCoords(PlayerPedId(), vector3(219.66, -808.68, 30.69))
      SetEntityHeading(PlayerPedId(), 8)
      admin_notifikacije("~g~Teleportovao si se do glavne!")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' se teleportovao do glavne '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)		
      end
    end
	  if data.current.value == 'policija' then
	  SetEntityCoords(PlayerPedId(), vector3(424.33, -979.54, 30.71))
      SetEntityHeading(PlayerPedId(), 8)
      admin_notifikacije("~g~Teleportovao si se do policije!")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' se teleportovao do policije '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)		
      end
    end
	  if data.current.value == 'bolnica' then
	  SetEntityCoords(PlayerPedId(), vector3(298.22, -1434.54, 29.8))
      SetEntityHeading(PlayerPedId(), 8)
      admin_notifikacije("~g~Teleportovao si se do bolnice!")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' se teleportovao do bolnice  '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)		
      end
    end
	  if data.current.value == 'mehanicarska' then
	  SetEntityCoords(PlayerPedId(), vector3(-364.36, -133.16, 38.68))
      SetEntityHeading(PlayerPedId(), 8)
      admin_notifikacije("~g~Teleportovao si se do mehanicarske!")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' se teleportovao do mehanicarske  '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)		
      end
    end
      if data.current.value == 'sendi' then
      SetEntityCoords(PlayerPedId(), vector3(1804.98, 3628.84, 34.29))
      SetEntityHeading(PlayerPedId(), 8)
      admin_notifikacije("~g~Teleportovao si se do sandya!")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' se teleportovao do sandya  '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)		
      end
    end
      if data.current.value == 'paleto' then
      SetEntityCoords(PlayerPedId(), vector3(-228.46, 6146.26, 31.19))
      SetEntityHeading(PlayerPedId(), 8)
      admin_notifikacije("~g~Teleportovao si se do paleta!")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' se teleportovao do paleta  '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)	
    end	
      end
      if data.current.value == 'autosalon' then
      SetEntityCoords(PlayerPedId(), vector3(-38.18, -1100.08, 26.42))
      SetEntityHeading(PlayerPedId(), 8)
      admin_notifikacije("~g~Teleportovao si se do autosalona!")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' se teleportovao do autosalona  '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)		
      end
    end
    end,
  function(data, menu)
    OtvoriAdminMeni()
  end
  )
end

function OtvoriIgraciMeni()

  ESX.UI.Menu.CloseAll()
  
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'igraci_actions',
    {
      css      = 'meni',
      title    = 'Igraci | 🚗',
      align    = 'top-left',
      elements = {
	  {label = 'Heal Igraca | 💉️', value = 'healigraca'},
    {label = 'Crashaj Igraca | 🦵🏻', value = 'crashigraca'},
	  {label = 'ID | 🆔', value = 'id'},
      }
    },
    function(data, menu)
      if data.current.value == 'healigraca' then
        local odabraniIgrac = tonumber(UnosTastatura("ID", "", 100))
        TriggerServerEvent("adminmeni:healigrac", odabraniIgrac) 
        admin_notifikacije("Healo Si Igraca")
        if Config.UkljuciLogove then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' je healo igraca '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)	
        end	
	  end	
	  if data.current.value == 'crashigraca' then
        local odabraniIgrac = tonumber(UnosTastatura("ID", "", 100))
        crash(odabraniIgrac)
		admin_notifikacije("Crasho Si Igraca")
    if Config.UkljuciLogove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' je crasho igraca '
		local bot = "ADMIN MENI"
		  
	    TriggerServerEvent('adminsistem:logovi', bot, msg)	
      end
    end
	  if data.current.value == 'id' then
    ESX.TriggerServerCallback("lukex_core:proveriRank", function(playerRank)
    if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
    if not idovi then
    ESX.ShowNotification('Upalili ste idove')
    if Config.UkljuciLogove then
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
		local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' je upalio id '
		local bot = "ADMIN MENI"
		  
		TriggerServerEvent('adminsistem:logovi', bot, msg)	
    end
    idovi = true
    else
    idovi = false
    ESX.ShowNotification('iskljucili ste idove')
    if Config.UkljuciLogove then
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local player = PlayerId()
    local ime = GetPlayerName(player)
		local msg = ''.. ime .. ' je izgasio id '
		local bot = "ADMIN MENI"
		  
		TriggerServerEvent('adminsistem:logovi', bot, msg)
    end
    end
    else
    ESX.ShowNotification('nisi admin')
    end
    end)
    end
    end,
  function(data, menu)
    OtvoriAdminMeni()
  end
  )
end

function admin_notifikacije(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

RegisterNetEvent("adminmeni:healigrac")
AddEventHandler("adminmeni:healigrac", function()
    SetEntityHealth(PlayerPedId(), 200)
    TriggerEvent('esx_status:set', 'hunger', 1000000)
    TriggerEvent('esx_status:set', 'thirst', 1000000)
end)

playerDistances = {}

Citizen.CreateThread(function()
    Wait(1000)
    while true do
    Citizen.Wait(5)
      if not idovi then
        Citizen.Wait(2000)
      else
        for _, player in ipairs(GetActivePlayers()) do
          local ped = GetPlayerPed(player)
          if GetPlayerPed(player) ~= PlayerPedId() then
            if playerDistances[player] ~= nil and playerDistances[player] < disPlayerNames then
              x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
              if not NetworkIsPlayerTalking(player) then
                TINKY3D(vec(x2, y2, z2+0.94), '~b~' .. GetPlayerServerId(player) .. ' ~c~| ~b~[~w~' .. GetPlayerName(player)..'~b~]~w~')
              else
                TINKY3D(vec(x2, y2, z2+0.94), '🎤' .. GetPlayerServerId(player) .. ' ~c~| ~b~[~w~' .. GetPlayerName(player)..'~b~]~w~')
              end
            end
          end
        end
      end
    end
end)


Citizen.CreateThread(function()
    while true do
        for _, player in ipairs(GetActivePlayers()) do
            if GetPlayerPed(player) ~= PlayerPedId() then
                x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                playerDistances[player] = distance
            end
        end
        Citizen.Wait(1500)
    end
end)

function TINKY3D(coords, text, size)
  local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  if onScreen then
      SetTextScale(0.35, 0.38)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextDropshadow(255, 255, 255, 255, 255)
      SetTextEdge(1, 0, 0, 0, 150)
      SetTextDropshadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
  end
end

--crash
function crash()
  ESX.TriggerServerCallback("lukex_core:proveriRank", function(playerRank)
  end)
    if playerRank == "mod" or playerRank == "admin" or playerRank == "superadmin" then
  while true do 
  end
end
end
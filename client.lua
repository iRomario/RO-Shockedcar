--[[

  ____                            _         _  _    
 |  _ \ ___  _ __ ___   __ _ _ __(_) ___  _| || |_ 
 | |_) / _ \| '_ ` _ \ / _` | '__| |/ _ \|_  ..  _| 
 |  _ < (_) | | | | | | (_| | |  | | (_) |_      _| 
 |_| \_\___/|_| |_| |_|\__,_|_|  |_|\___/  |_||_|  

   ____             _    _____ _                     
 |  _ \  __ _ _ __| | _|  ___(_)_   _____ _ __ ___  
 | | | |/ _` | '__| |/ / |_  | \ \ / / _ \ '_ ` _ \ 
 | |_| | (_| | |  |   <|  _| | |\ V /  __/ | | | | |
 |____/ \__,_|_|  |_|\_\_|   |_| \_/ \___|_| |_| |_|


 
 
------

--]]



local isShockedout = false
local oldBodyDamage = 0
local oldSpeed = 0

local function Shockedout()
	
	if not isShockedout then
		isShockedout = true
	
		Citizen.CreateThread(function()
			ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 10.0)
			
			Citizen.Wait(Config.ShockedoutTime)
			StopGameplayCamShaking(false)
			isShockedout = false
		end)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if DoesEntityExist(vehicle) then
			
			if Config.ShockedoutFromDamage then
				local currentDamage = GetVehicleBodyHealth(vehicle)
				
				if currentDamage ~= oldBodyDamage then
					if not isShockedout and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.ShockedoutDamageRequired) then
						Shockedout()
					end
					oldBodyDamage = currentDamage
				end
			end
			
			
			if Config.ShockedoutFromSpeed then
				local currentSpeed = GetEntitySpeed(vehicle) * 2.23
				
				if currentSpeed ~= oldSpeed then
					if not isShockedout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= Config.ShockedoutSpeedRequired) then
						Shockedout()
					end
					oldSpeed = currentSpeed
				end
			end
		else
			oldBodyDamage = 0
			oldSpeed = 0
		end
		
		if isShockedout and Config.DisableControlsOnShockedout then
			-- Borrowed controls from https://github.com/Sighmir/FiveM-Scripts/blob/master/vrp/vrp_hotkeys/client.lua
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			DisableControlAction(0,75,true) -- disable exit vehicle
		end
	end
end)

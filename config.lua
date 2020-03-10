Config = {}

-- Amount of time
-- 2000 = 2 seconds
Config.ShockedoutTime = 3000

-- Enable shock car  due to vehicle damage
-- If a vehicle suffers an impact greater than the specified value, the player blacks out
Config.ShockedoutFromDamage = true
Config.ShockedoutDamageRequired = 25

-- Enable shcoking  due to speed deceleration
-- If a vehicle slows down rapidly over this threshold, the player shocks out
Config.ShockedoutFromSpeed = true
Config.ShockedoutSpeedRequired = 45 -- Speed in MPH

-- Enable the disabling of controls if the player is shocked out
Config.DisableControlsOnShockedout = false

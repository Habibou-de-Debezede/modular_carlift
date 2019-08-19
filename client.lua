-- By K3rhos



local elevatorProp = nil
local elevatorUp = false
local elevatorDown = false
local elevatorBaseX = -223.5853
local elevatorBaseY = -1327.158
local elevatorBaseZ = 29.8



function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, true)
end



function deleteObject(object)
	return Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(object))
end



function createObject(model, x, y, z)
	RequestModel(model)
	while (not HasModelLoaded(model)) do
		Citizen.Wait(0)
	end
	return CreateObject(model, x, y, z, true, true, false)
end



function spawnProp(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevatorProp = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevatorProp)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevatorProp, 0xFFFF)
		SetEntityCollision(elevatorProp, true, true)
		FreezeEntityPosition(elevatorProp, true)
		SetEntityCoords(elevatorProp, x, y, z, false, false, false, false) -- Patch un bug pour certains props.
	else
		drawNotification("Modèle invalide.")
	end
end



function Main()
    Menu.SetupMenu("mainmenu", "BENNY'S")
    Menu.Switch(nil, "mainmenu")
	
	Menu.addOption("mainmenu", function() if (Menu.Option("Test Spawn Prop")) then
		spawnProp("nacelle", elevatorBaseX, elevatorBaseY, elevatorBaseZ)
	end end)
	
	Menu.addOption("mainmenu", function() if (Menu.Option("Faire monter l'élévateur")) then
		if elevatorProp ~= nil then
			elevatorDown = false
			elevatorUp = true
		end
	end end)
	
    Menu.addOption("mainmenu", function() if (Menu.Option("Faire descendre l'élévateur")) then
		if elevatorProp ~= nil then
			elevatorUp = false
			elevatorDown = true
		end
	end end)
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
		local elevatorCoords = GetEntityCoords(elevatorProp, false)
		
		if elevatorUp then
			if elevatorCoords.z < 32.8 then
				elevatorBaseZ = elevatorBaseZ + 0.01
				SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
			end
		elseif elevatorDown then
			if elevatorCoords.z > 29.8 then
				elevatorBaseZ = elevatorBaseZ - 0.01
				SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
			end
		end
    end
end)
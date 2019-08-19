Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		
		if (Vdist(-219.3204, -1326.43, 29.89041, pos.x, pos.y, pos.z - 1) < 1.5) then
			if IsControlJustReleased(1, 51) then -- INPUT_CONTEXT
				PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				garage_menu = not garage_menu
				Main()
			end
		else
			if (prevMenu == nil) then
				Menu.Switch(nil, "")
				menuOpen = false
				if garage_menu then
					garage_menu = false
				end
				currentOption = 1
			elseif not (prevMenu == nil) then
				if not Menus[prevMenu].previous == nil then
					currentOption = 1
					Menu.Switch(nil, prevMenu)
				else
					if Menus[prevMenu].optionCount < currentOption then
						currentOption = Menus[prevMenu].optionCount
					end
					Menu.Switch(Menus[prevMenu].previous, prevMenu)
				end
			end
		end
		
        if garage_menu then
			DisableControlAction(1, 22, true)
			DisableControlAction(1, 0, true)
			DisableControlAction(1, 27, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 20, true)
			
			DisableControlAction(1, 187, true)
			
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 95, true)
			DisableControlAction(1, 96, true)
			DisableControlAction(1, 97, true)
			DisableControlAction(1, 98, true)
			
			DisableControlAction(1, 81, true)
			DisableControlAction(1, 82, true)
			DisableControlAction(1, 83, true)
			DisableControlAction(1, 84, true)
			DisableControlAction(1, 85, true)
			
			DisableControlAction(1, 74, true)
			
			HideHelpTextThisFrame()
			SetCinematicButtonActive(false)
            Menu.DisplayCurMenu()
        end
    end
end)



Citizen.CreateThread(function ()
	Citizen.Wait(10)
	for i = 1, #vehiclerepairStation do
		garageCoords = vehiclerepairStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 402) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

Key = 201 -- ENTER
vehiclerepairStation = {
	{ 1149.92, -777.82, 57.06,},
	{ 1174.98, 2637.559, 37.754},
	{109.47, 6628.0, 31.27}
}

function yx_notify(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function repair()
	local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)
	local flag = 0
	TaskLeaveVehicle(player, vehicle, flag)
	SetVehicleDeformationFixed(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
	SetVehicleEngineOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
	SetVehicleFixed(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(10)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehiclerepairStation do
				garageCoords2 = vehiclerepairStation[i]
				DrawMarker(36, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					yx_notify("Wciśnij [~g~E~s~] by naprawić auto!")
					if IsControlJustPressed(1, Key) then
					    repair()
						exports.FeedM:ShowNotification('~o~Mechanik zajmuje się twoim pojazdem...')
						Wait(15000)
						TriggerServerEvent('yxikk_carrepair:sprawdzkaske')
					end
				end
			end
		end
	end
end)


RegisterNetEvent('yxikk_carrepair:napraw')
AddEventHandler('yxikk_carrepair:napraw', function (kwotaes)
SetVehicleFixed(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
SetVehicleDeformationFixed(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
SetVehicleEngineOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1000)
	exports.FeedM:ShowNotification('~b~Samochód został naprawiony za~w~ ' .. kwotaes .. '$')
end)

RegisterNetEvent('yxikk_carrepair:niemakasy')
AddEventHandler('yxikk_carrepair:niemakasy', function (moneyleft)
	exports.FeedM:ShowNotification('~r~Na naprawę brakuje ci~w~ ' .. moneyleft .. '$')
end)

kwotaes = 12500 -- cena naprawy
potrzebnepieniadze = true -- czy musisz miec hajs zeby naprawic samochod

RegisterServerEvent('yxikk_carrepair:sprawdzkaske')
AddEventHandler('yxikk_carrepair:sprawdzkaske', function ()
	if potrzebnepieniadze == true then
		TriggerEvent('es:getPlayerFromId', source, function (xPlayer)
			hasjsikgracza = xPlayer.getMoney()
			if hasjsikgracza >= kwotaes then
				xPlayer.removeMoney(kwotaes)
	                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mecano', function(account)
			        account.addMoney(kwotaes)
end)
				TriggerClientEvent('yxikk_carrepair:napraw', source, kwotaes)
			else
				moneyleft = kwotaes - hasjsikgracza
				TriggerClientEvent('yxikk_carrepair:niemakasy', source, moneyleft)
			end
		end)
	end
end)

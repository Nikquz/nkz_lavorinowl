ESX = exports.es_extended:getSharedObject()

-- INZIO VITICOLTORORE -- 
RegisterServerEvent('nkz_viticoltore')
AddEventHandler('nkz_viticoltore', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local uva = xPlayer.getInventoryItem('grappoloduva')
	local ped = GetPlayerPed(source)
	local c = GetEntityCoords(ped)
	local cc = vector3(-1734.2380371094,2379.7438964844,47.770603179932)
	local dist = #(c - cc)
	if dist > 50 then
			print("^8ID: ["..source.."] "..GetPlayerName(source).." Cheater, è stato kickato, ha provato a triggerare nkz_viticoltore")
			DropPlayer(source, 'Non si fotte con noxon development')
	elseif uva.count < 100 then
		xPlayer.addInventoryItem('grappoloduva', 1)	
	else
		xPlayer.showNotification('Hai raggiunto il limite massimo di raccolta di grappoli d\'uva')
	end
end)

RegisterServerEvent('nkz_processoviticoltore')
AddEventHandler('nkz_processoviticoltore', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local nikquz = xPlayer.getInventoryItem('grappoloduva').count
	local vino = xPlayer.getInventoryItem('vinorosso')
	if vino.count < 10 then
		if nikquz < 25 then
			xPlayer.showNotification("Non hai abbastanza grappoli d\'uva")
		else
			xPlayer.addInventoryItem('vinorosso', 1)
			xPlayer.removeInventoryItem('grappoloduva', 25)
		end
	else
		xPlayer.showNotification('Hai raggiunto il limite massimo di processo del vino')
	end
end)

-- INZIA CERCATORE D'ORO -- 
RegisterServerEvent('nkz_cercaoro')
AddEventHandler('nkz_cercaoro', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(1,5)
	local ped = GetPlayerPed(source)
	local c = GetEntityCoords(ped)
	local cc = vector3(-613.77581787109, 2912.6662597656, 15.437425613403)
	local ccc = vector3(2943.0827636719, 2796.5129394531, 40.684658050537)
	local cccc = vector3(1583.2482910156, 6594.9243164063, 14.061966896057)
	local dist = #(c - cc)
	local distt = #(c - ccc)
	local disttt = #(c - cccc)
	if dist > 100.0 and distt > 100.0 and disttt > 100.0 then 
		print("^8ID: ["..source.."] "..GetPlayerName(source).." Cheater, è stato kickato, ha provato a triggerare nkz_cercaoro")
		DropPlayer(source, 'Non si fotte con noxon development')
	else
		if random == 1 then
			xPlayer.addInventoryItem('lattina', 1)
		elseif random == 2 then
			xPlayer.addInventoryItem('metallo', 1)
		elseif random == 3 then
			xPlayer.addInventoryItem('orologio', 1)
		elseif random == 4 then
			xPlayer.addInventoryItem('pepitadoro', 1)
		elseif random == 5 then
			xPlayer.addInventoryItem('chiavi', 1)
		end
	end
end)

ESX.RegisterUsableItem("metaldetector", function(source)
	TriggerClientEvent("nkz_iniziascannerizzare", source)
end)
-- FINE CERCATORE D'ORO --

-- BOSCAIOLO -- 
RegisterServerEvent('nkz_boscaiolo')
AddEventHandler('nkz_boscaiolo', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local troncodilegno = xPlayer.getInventoryItem('troncodilegno')
	local ped = GetPlayerPed(source)
	local c = GetEntityCoords(ped)
	local cc = vector3(-553.99652099609,5370.359375,70.363136291504)
	local dist = #(c - cc)
	if troncodilegno.count < 10 then 
		if dist > 75.0 then
			print("^8ID: ["..source.."] "..GetPlayerName(source).." Cheater, è stato kickato, ha provato a triggerare nkz_boscaiolo")
			DropPlayer(source, 'Non si fotte con noxon development')
		else
			xPlayer.addInventoryItem('troncodilegno', 1)	
		end
	else
		xPlayer.showNotification('Hai raggiunto il limite massimo di raccolta di legno')
	end
end)

RegisterServerEvent('nkz_processoboscaiolo')
AddEventHandler('nkz_processoboscaiolo', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local tronco = xPlayer.getInventoryItem('troncodilegno').count
	local tavole = xPlayer.getInventoryItem('tavoledilegno')
	if tavole.count < 100 then
		if tronco < 1 then
			xPlayer.showNotification("Non hai abbastanza tronchi di legno")
		else
			xPlayer.addInventoryItem('tavoledilegno', 10)
			xPlayer.removeInventoryItem('troncodilegno', 1)
		end
	else
		xPlayer.showNotification('Hai raggiunto il limite massimo di processo del legno')
	end
end)
-- FINE BOSCAIOLO -- 

-- INZIO PESCATORE --
ESX.RegisterUsableItem("cannadapescaconesca", function(source)
	TriggerClientEvent("nkz_iniziapescare", source)
end)

RegisterServerEvent('nkz_cercapesci')
AddEventHandler('nkz_cercapesci', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(1,10)
	local ped = GetPlayerPed(source)
	local c = GetEntityCoords(ped)
	local cc = vector3(-6024.4487304688,3442.6096191406,-0.63411700725555)
	local ccc = vector3(-278.98379516602,8771.9521484375,-1.4624372720718)
	local cccc = vector3(5100.576171875,2355.2346191406,-0.21889455616474)
	local dist = #(c - cc)
	local distt = #(c - ccc)
	local disttt = #(c - cccc)
	if dist > 1000.0 and distt > 1000.0 and disttt > 1000.0 then
		print("^8ID: ["..source.."] "..GetPlayerName(source).." Cheater, è stato kickato, ha provato a triggerare nkz_cercapesci")
		DropPlayer(source, 'Non si fotte con noxon development')
	elseif random == 1 then
		xPlayer.addInventoryItem('bottigliadiplastica', 1)
	elseif random == 2 then
		xPlayer.addInventoryItem('scarpa', 1)
	elseif random == 3 then
		xPlayer.addInventoryItem('pescespada', 1)
	elseif random == 4 then
		xPlayer.addInventoryItem('lattina', 1)
	elseif random == 5 then
		xPlayer.addInventoryItem('sardina', 1)
	elseif random == 6 then
		xPlayer.addInventoryItem('salmone', 1)
	elseif random == 7 then
		xPlayer.showNotification('Il pesce é scappato')
	elseif random == 8 then
		xPlayer.showNotification('Il pesce é scappato')
	elseif random == 9 then
		xPlayer.showNotification('Il pesce é scappato')
	elseif random == 10 then
		xPlayer.showNotification('Il pesce é scappato')
	end
end)

RegisterServerEvent('nkz_restituiscicanna')
AddEventHandler('nkz_restituiscicanna', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local cannadapescaconesca = xPlayer.getInventoryItem('cannadapescaconesca').count
	if cannadapescaconesca < 1 then
		xPlayer.showNotification('Non hai una canna da pesca con esca!')
	else
		xPlayer.removeInventoryItem('cannadapescaconesca', 1)
		xPlayer.addInventoryItem('cannadapesca', 1)
	end
end)

ESX.RegisterUsableItem("esca", function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local cannadapesca = xPlayer.getInventoryItem('cannadapesca').count
	if cannadapesca < 1 then
		xPlayer.showNotification('Non hai una canna da pesca senz \' esca!')
	else
		xPlayer.removeInventoryItem('esca', 1)
		xPlayer.removeInventoryItem('cannadapesca', 1)
		xPlayer.addInventoryItem('cannadapescaconesca', 1)
	end
end)
-- FINE PESCATORE --

-- INIZIO IMPORT --
RegisterServerEvent('nkz_venditaimport')
AddEventHandler('nkz_venditaimport', function(prezzo, item, quantita)
	local xPlayer = ESX.GetPlayerFromId(source)
	local soldi = xPlayer.getMoney()
	if soldi >= prezzo then
		xPlayer.removeMoney(prezzo)
		xPlayer.addInventoryItem(item, quantita)
	else
		xPlayer.showNotification('Non hai abbastanza soldi')
	end
end)
-- Nikquz®#9748 -- 

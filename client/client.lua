ESX = exports.es_extended:getSharedObject()

lavoro = false
incorso = false

-- GRID DEL MENU LAVORI -- 
TriggerEvent('gridsystem:registerMarker', {
	name = 'menulavori',  
	pos = vector3(1200.4458007813,-1277.3627929688,35.462917327881),
	scale = vector3(1.5, 1.5, 1.5),
	size = vector3(2.5, 2.5, 2.5),
	msg = '~b~[E] ~w~Menu lavori',
	type = -1,
	show3D = true,
    control = 'E',
	action = function()
		TriggerEvent('nkz_sceglilavoro')
	end
})

-- GRID DEL DEPOSITA VEICOLO --
TriggerEvent('gridsystem:registerMarker', {
	name = 'depositaveh',  
	pos = vector3(1211.576171875,-1262.3973388672,35.22677230835),
	scale = vector3(2.0, 2.0, 2.0),
	size = vector3(3.2, 3.2, 3.2),
	msg = 'Premi ~INPUT_CONTEXT~ per depositare il veicolo',
	type = 36,
    show3D = false,
    color =  { r = 40, b = 255, g = 140 },
    drawDistance = 8.0,
	control = 'E',
	action = function()
        if lavoro then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        DeleteEntity(veh)
        else
            ESX.ShowNotification('Non puoi depositare il veicolo se non stai lavorando')
        end
    end
})

-- GRID DELLA RACCOLTA UVA -- 
Citizen.CreateThread(function()
    for nkz,nikquz in pairs(Config.CoordsRaccoltaUva) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'raccoltauva'..nikquz.x,
            pos = vector3(nikquz.x, nikquz.y, nikquz.z),
            size = vector3(2.1,2.1,2.1),
            scale = vector3(0.7, 0.7, 0.7),
            color =  { r = 40, b = 255, g = 140 },
            drawDistance = 4.0,
            msg = 'Premi ~INPUT_CONTEXT~ per raccogliere l\'uva',
            control = 'E',
            type = 20,
            action = function()
                if lavoro then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        ESX.ShowNotification('Non puoi lavorare dentro un veicolo')
                    else
                        FreezeEntityPosition(PlayerPedId(), true)
                        RequestAnimDict("mini@repair")
                        while (not HasAnimDictLoaded("mini@repair")) do Citizen.Wait(0) end
                        TaskPlayAnim(PlayerPedId(),"mini@repair","fixing_a_ped",8.0, 8.0, -1, 81, 0, 0, 0, 0)
                        exports['progressBars']:startUI(5000, "Raccogliendo...")
                        Citizen.Wait(5000)
                        ClearPedTasks(PlayerPedId())						
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('nkz_viticoltore')
                    end
                else
                    ESX.ShowNotification('Vai prima al centro impieghi')
                end
            end,
        })
    end
end)

-- GRID DEL PROCESSO UVA -- 
Citizen.CreateThread(function()
    for nkz,nikquz in pairs(Config.CoordsProcessoUva) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'processouva'..nikquz.x,
            pos = vector3(nikquz.x, nikquz.y, nikquz.z),
            size = vector3(2.1,2.1,2.1),
            scale = vector3(0.7, 0.7, 0.7),
            color =  { r = 40, b = 255, g = 140 },
            drawDistance = 4.0,
            msg = 'Premi ~INPUT_CONTEXT~ per processare i grappoli d\'uva',
            control = 'E',
            type = 20,
            action = function()
                if lavoro then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        ESX.ShowNotification('Non puoi lavorare dentro un veicolo')
                    else
                        FreezeEntityPosition(PlayerPedId(), true)
                        RequestAnimDict("mini@repair")
                        while (not HasAnimDictLoaded("mini@repair")) do Citizen.Wait(0) end
                        TaskPlayAnim(PlayerPedId(),"mini@repair","fixing_a_ped",8.0, 8.0, -1, 81, 0, 0, 0, 0)
                        exports['progressBars']:startUI(20000, "Lavorando l\'uva...")
                        Citizen.Wait(20000)
                        ClearPedTasks(PlayerPedId())						
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('nkz_processoviticoltore')
                    end
                else
                    ESX.ShowNotification('Vai prima al centro impieghi')
                end
            end,
        })
    end
end)

-- GRID RACCOLTA LEGNA -- 
Citizen.CreateThread(function()
    for nkz,nikquz in pairs(Config.CoordsFelegnameria) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'falegname'..nikquz.x,
            pos = vector3(nikquz.x, nikquz.y, nikquz.z),
            size = vector3(2.1,2.1,2.1),
            scale = vector3(0.7, 0.7, 0.7),
            color =  { r = 40, b = 255, g = 140 },
            drawDistance = 4.0,
            msg = 'Premi ~INPUT_CONTEXT~ per tagliare il legno',
            control = 'E',
            type = 20,
            action = function()
		        if lavoro then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        ESX.ShowNotification('Non puoi lavorare dentro un veicolo')
                    else
                        ascia = CreateObject(GetHashKey('prop_w_me_hatchet'), 0, 0, 0, true, true, true)
                        AttachEntityToEntity(ascia, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, -0.02, -0.02, 350.0, 100.00, 280.0, true, true, false, true, 1, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        RequestAnimDict("amb@world_human_hammering@male@base")
                        while (not HasAnimDictLoaded("amb@world_human_hammering@male@base")) do Citizen.Wait(0) end 
                        TaskPlayAnim(PlayerPedId(),"amb@world_human_hammering@male@base","base",8.0, 8.0, -1, 49, 0, 0, 0, 0)
                        exports['progressBars']:startUI(10000, "Tagliando il legno...")
                        Citizen.Wait(10000)
                        DeleteEntity(ascia)
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('nkz_boscaiolo')
                    end
                else
                    ESX.ShowNotification('Vai prima al centro impieghi')
                end					
            end,
        })
    end
end)

-- GRID PROCESSO LEGNA -- 
Citizen.CreateThread(function()
    for nkz,nikquz in pairs(Config.CoordsProcessoFalegnameria) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'processofalegname'..nikquz.x,
            pos = vector3(nikquz.x, nikquz.y, nikquz.z),
            size = vector3(2.1,2.1,2.1),
            scale = vector3(0.7, 0.7, 0.7),
            color =  { r = 40, b = 255, g = 140 },
            drawDistance = 4.0,
            msg = 'Premi ~INPUT_CONTEXT~ per processare il legno',
            control = 'E',
            type = 20,
            action = function()
		        if lavoro then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        ESX.ShowNotification('Non puoi lavorare dentro un veicolo')
                    else
                        FreezeEntityPosition(PlayerPedId(), true)
                        RequestAnimDict("mini@repair")
                        while (not HasAnimDictLoaded("mini@repair")) do Citizen.Wait(0) end
                        TaskPlayAnim(PlayerPedId(),"mini@repair","fixing_a_ped",8.0, 8.0, -1, 80, 0, 0, 0, 0)
                        exports['progressBars']:startUI(12500, "Processando il legno...")
                        Citizen.Wait(12500)
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('nkz_processoboscaiolo')
                    end
                else
                    ESX.ShowNotification('Vai prima al centro impieghi')
		        end					
            end,
        })
    end
end)

-- GRID SPAWN BARCHE PESCA -- 
Citizen.CreateThread(function()
    for nkz,nikquz in pairs(Config.CoordsSpawnBarca) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'barca'..nikquz.x,
            pos = vector3(nikquz.x, nikquz.y, nikquz.z),
            size = vector3(2.1,2.1,2.1),
            scale = vector3(0.7, 0.7, 0.7),
            color =  { r = 40, b = 255, g = 140 },
            drawDistance = 10.0,
            msg = 'Premi ~INPUT_CONTEXT~ per prendere una barca',
            control = 'E',
            type = 35,
            action = function()
                if lavoro then
                    if ESX.Game.IsSpawnPointClear(vector3(-1603.056640625,5259.125,-0.47409653663635), 4.0) then
                        ESX.Game.SpawnVehicle('Suntrap', vector3(-1603.056640625,5259.125,-0.47409653663635), 17.27, function(v)
                            SetPedIntoVehicle(PlayerPedId(), v, -1)
                        end)
                    else
                        ESX.ShowNotification('C\'è un altro veicolo nell\'area di spawn, attendere')
                    end
                else
                    ESX.ShowNotification('Vai prima al centro impieghi')
                end
            end
        })
    end
end)

-- GRID IMPORT -- 
Citizen.CreateThread(function()
    for nkz,nikquz in pairs(Config.CoordsImport) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'import'..nikquz.x,
            pos = vector3(nikquz.x, nikquz.y, nikquz.z),
            size = vector3(2.1,2.1,2.1),
            scale = vector3(0.7, 0.7, 0.7),
            color =  { r = 40, b = 255, g = 140 },
            drawDistance = 6.0,
            msg = 'Premi ~INPUT_CONTEXT~ per acquistare oggetti',
            control = 'E',
            type = 20,
            action = function()
                TriggerEvent('nkz_menuimport')
            end,
        })
    end
end)

-- MENU SCELTA LAVORO -- 
RegisterNetEvent('nkz_sceglilavoro')
AddEventHandler('nkz_sceglilavoro', function()
    if not lavoro then
    Lavori = {
    {label = 'Viticoltore', value = 'viticoltore'},
    {label = 'Cercatore D\'oro', value = 'cercatoredoro'},
    {label = 'Boscaiolo', value = 'boscaiolo'},
    {label = 'Pescatore', value = 'pescatore'},
    }
    else
    Lavori = {
    {label = 'Annulla lavoro', value = 'annullalavoro'}
    }
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'nkz', {
        title = 'SCEGLI IL LAVORO',
        align = 'top-right',
        elements = Lavori
    },     function(data, menu)
            local bottone = data.current.value

            if bottone == 'viticoltore' then
                NKZ_viticoltore()
                menu.close()
            elseif bottone == 'cercatoredoro' then
                NKZ_Cercatoredoro()
                menu.close()
            elseif bottone == 'boscaiolo' then
                NKZ_Boscaiolo()
                menu.close()
            elseif bottone == 'pescatore' then
                NKZ_Pesca()
                menu.close()
            elseif bottone == 'annullalavoro' then
                NKZ_Annullalavoro()
                menu.close()
            end
        end, 
        function(data, menu)
               menu.close()
        end
    )
end)

-- MENU IMPORT -- 
RegisterNetEvent('nkz_menuimport')
AddEventHandler('nkz_menuimport', function()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'nkz', {
        title = 'IMPORT',
        align = 'top-right',
        elements = {
            {label = 'Canna da pesca: 100$', item = 'cannadapesca', prezzo = 100, type = 'slider', value = 1, min = 1, max = 1},
            {label = 'Esca: 20$', item = 'esca', prezzo = 20, type = 'slider', value = 1, min = 1, max = 50},
            {label = 'Metal detector: 2500$', item = 'metaldetector', prezzo = 2500, type = 'slider', value = 1, min = 1, max = 1},
        }
    },     function(data, menu)
            
            local item = data.current.item
            local paga = data.current.value * data.current.prezzo
            local quantita = data.current.value
            TriggerServerEvent('nkz_venditaimport', paga, item, quantita)
        end, 
        function(data, menu)
               menu.close()
        end
    )
end)

-- BLIP CENTRO IMPIEGHI -- 
nkzblip = AddBlipForCoord(1200.6398925781,-1274.7916259766)
SetBlipSprite(nkzblip, 685)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Centro impieghi")
EndTextCommandSetBlipName(nkzblip)

-- ANNULLA LAVORO --    
NKZ_Annullalavoro = function()
    lavoro = false
    RemoveBlip(nikquz1)
    RemoveBlip(nikquz2)
    RemoveBlip(zona1)
    RemoveBlip(zona2)
    RemoveBlip(zona3)
    RemoveBlip(zonaa1)
    RemoveBlip(zonaa2)
    RemoveBlip(zonaa3)
    RemoveBlip(nkz1)
    RemoveBlip(nkz2)
    RemoveBlip(nkz1blip)
    DeleteWaypoint(waypoint1)
    DeleteWaypoint(waypoint2)
    DeleteWaypoint(waypoint3)
    DeleteWaypoint(waypoint4)
    DeleteWaypoint(waypoint5)
end
-- FINE ANNULLA LAVORO --     

-- VITICOLTORE -- 
NKZ_viticoltore = function()
    if ESX.Game.IsSpawnPointClear(vector3(1218.6452636719,-1301.7208251953,35.226959228516), 3.0) then
        lavoro = true
        ESX.Game.SpawnVehicle('kalahari', vector3(1218.6452636719,-1301.7208251953,35.226959228516), 86.29, function(v)
            SetPedIntoVehicle(PlayerPedId(), v, -1)
        end)
        ESX.ShowNotification('Raggiungi la zona di raccolta e successivamente quella di processo')
        waypoint1 = SetNewWaypoint(-1741.4655761719,2387.923828125)
        nikquz1 = AddBlipForCoord(-1741.4655761719,2387.923828125)
        nikquz2 = AddBlipForCoord(-50.247978210449,1911.2589111328)
        SetBlipSprite(nikquz1, 535)
        SetBlipColour(nikquz1, 3)
        SetBlipSprite(nikquz2, 536)
        SetBlipColour(nikquz2, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Raccolta uva")
        EndTextCommandSetBlipName(nikquz1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Processo uva")
        EndTextCommandSetBlipName(nikquz2)
    else
        ESX.ShowNotification('C\'è un altro veicolo nell\'area di spawn, attendere')
    end
end
-- FINE LAVORO VITICOLTORE -- 

-- INIZIO CERCATORE D'ORO -- 
local blip1 = vector3(0,0,0)
local blip2 = vector3(0,0,0)
local blip3 = vector3(0,0,0)
local grandezzaarea = 100.0

NKZ_Cercatoredoro = function()
    if ESX.Game.IsSpawnPointClear(vector3(1190.1646728516,-1311.0445556641,34.97093963623), 3.0) then
        lavoro = true 
        ESX.Game.SpawnVehicle('burrito3', vector3(1190.1646728516,-1311.0445556641,34.97093963623), 267.20, function(v)
            SetPedIntoVehicle(PlayerPedId(), v, -1)
        end)
        ESX.ShowNotification('Vai nella zona preposta per la caccia all\'oro')
        local area = math.random(1,3)
        if area == 1 then
            blip1 = vector3(-613.77581787109, 2912.6662597656, 15.437425613403)
            zona1 = AddBlipForRadius(blip1, grandezzaarea)
            waypoint2 = SetNewWaypoint(-613.77581787109,2912.6662597656)
            SetBlipColour(zona1, 1)
            SetBlipAlpha (zona1, 128)
        elseif area == 2 then
            blip2 = vector3(2943.0827636719, 2796.5129394531, 40.684658050537)
            zona2 = AddBlipForRadius(blip2, grandezzaarea)
            waypoint3 = SetNewWaypoint(2943.0827636719,2796.5129394531)
            SetBlipColour(zona2, 2)
            SetBlipAlpha (zona2, 128)
        elseif area == 3 then
            blip3 = vector3(1583.2482910156, 6594.9243164063, 14.061966896057)
            zona3 = AddBlipForRadius(blip3, grandezzaarea)
            waypoint4 = SetNewWaypoint(1583.2482910156,6594.9243164063)
            SetBlipColour(zona3, 3)
            SetBlipAlpha (zona3, 128)
        end
    else
        ESX.ShowNotification('C\'è un altro veicolo nell\'area di spawn, attendere')
    end
end

RegisterNetEvent("nkz_iniziascannerizzare")
AddEventHandler("nkz_iniziascannerizzare", function()
    local pos = GetEntityCoords(PlayerPedId())
    local distanza1 = #(pos - blip1)
    local distanza2 = #(pos - blip2)
    local distanza3 = #(pos - blip3)
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPedId()) then
        ESX.ShowNotification('Non puoi usare il metal detector in un veicolo')
    elseif distanza1 < grandezzaarea or distanza2 < grandezzaarea or distanza3 < grandezzaarea then
        if not incorso then
            incorso = true
            metal = CreateObject(GetHashKey('w_am_digiscanner'), 0, 0, 0, true, true, true)
            AttachEntityToEntity(metal, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.30, 0.05, 0.0, 0.0, 90.0, 80.0, true, true, false, true, 1, true)
            RequestAnimDict("mini@golfai")
            while (not HasAnimDictLoaded("mini@golfai")) do Citizen.Wait(0) end
            TaskPlayAnim(PlayerPedId(),"mini@golfai","wood_idle_a",8.0, 8.0, -1, 49, 0, 0, 0, 0)
            Citizen.Wait(12000)
            DeleteEntity(metal)
            ClearPedTasks(PlayerPedId())
            ESX.ShowNotification('Hai trovato qualcosa!!!')
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
            Citizen.Wait(8000)
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent("nkz_cercaoro")
            incorso = false
        else
            ESX.ShowNotification('Non puoi fare quest\'azione in questo momento')
        end
    else
        ESX.ShowNotification('Non sei nell\'area di lavoro')
    end
end, false)
-- FINE CERCATORE D'ORO -- 

-- INIZIO BOSCAIOLO -- 
NKZ_Boscaiolo = function()
    if ESX.Game.IsSpawnPointClear(vector3(1214.5858154297,-1321.7121582031,35.226902008057), 3.0) then
        lavoro = true 
        ESX.Game.SpawnVehicle('mule3', vector3(1214.5858154297,-1321.7121582031,35.226902008057), 85.29, function(v)
            SetPedIntoVehicle(PlayerPedId(), v, -1)
        end)
        ESX.ShowNotification('Raggiungi la falegnameria')
        waypoint5 = SetNewWaypoint(-556.43975830078,5371.162109375)
        nkz1 = AddBlipForCoord(-556.43975830078,5371.162109375)
        SetBlipSprite(nkz1, 211)
        SetBlipColour(nkz1, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Falegnameria")
        EndTextCommandSetBlipName(nkz1)
        nkz2 = AddBlipForCoord(389.4284362793,798.81884765625)
        SetBlipSprite(nkz2, 478)
        SetBlipColour(nkz2, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Processo falegnameria")
        EndTextCommandSetBlipName(nkz2)
    else
        ESX.ShowNotification('C\'è un altro veicolo nell\'area di spawn, attendere')
    end
end

-- FINE BOSCAIOLO -- 
local blippus1 = vector3(0,0,0)
local blippus2 = vector3(0,0,0)
local blippus3 = vector3(0,0,0)
local grandezzaareaa = 1000.0

-- INIZIO PESCATORE -- 
NKZ_Pesca = function()
    if ESX.Game.IsSpawnPointClear(vector3(1190.1701660156,-1319.6052246094,34.98685836792), 3.0) then
        lavoro = true
        ESX.Game.SpawnVehicle('kalahari', vector3(1190.1701660156,-1319.6052246094,34.98685836792), 265.10, function(v)
            SetPedIntoVehicle(PlayerPedId(), v, -1)
        end)
        nkz1blip = AddBlipForCoord(-1611.0601806641,5257.7524414063)
        SetBlipSprite(nkz1blip, 427)
        SetBlipColour (nkz1blip, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Barca")
        EndTextCommandSetBlipName(nkz1blip)
        ESX.ShowNotification('Ti ho messo sulla mappa la zona di pesca, per la barca basta sempre aprire la mappa ed andare nel punto selezionato')
        waypoint6 = SetNewWaypoint(-1611.0601806641,5257.7524414063)
        ESX.ShowNotification('Nel caso non avessi le esche e la canna da pesca basta andare nello shop qui a sinistra')
        local area = math.random(1,3)
        if area == 1 then
            blippus1 = vector3(-6024.4487304688,3442.6096191406,-0.63411700725555)
            zonaa1 = AddBlipForRadius(blippus1, grandezzaareaa)
            SetBlipColour(zonaa1, 1)
            SetBlipAlpha (zonaa1, 128)
        elseif area == 2 then
            blippus2 = vector3(-278.98379516602,8771.9521484375,-1.4624372720718)
            zonaa2 = AddBlipForRadius(blippus2, grandezzaareaa)
            SetBlipColour(zonaa2, 2)
            SetBlipAlpha (zonaa2, 128)
        elseif area == 3 then
            blippus3 = vector3(5100.576171875,2355.2346191406,-0.21889455616474)
            zonaa3 = AddBlipForRadius(blippus3, grandezzaareaa)
            SetBlipColour(zonaa3, 3)
            SetBlipAlpha (zonaa3, 128)
        end
    else
        ESX.ShowNotification('C\'è un altro veicolo nell\'area di spawn, attendere')
    end
end

RegisterNetEvent("nkz_iniziapescare")
AddEventHandler("nkz_iniziapescare", function()
    local pos = GetEntityCoords(PlayerPedId())
    local pesca1 = #(pos - blippus1)
    local pesca2 = #(pos - blippus2)
    local pesca3 = #(pos - blippus3)
    if IsPedInAnyVehicle(PlayerPedId()) then
		ESX.ShowNotification('Non puoi pescare guidando un veicolo')
    elseif pesca1 < grandezzaareaa or pesca2 < grandezzaareaa or pesca3 < grandezzaareaa then
        if not incorso then
            incorso = true
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
            Citizen.Wait(15000)
            ClearPedTasks(PlayerPedId())
            ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 2.0, 0)
            FreezeEntityPosition(PlayerPedId(), false)
            incorso = false
            TriggerServerEvent("nkz_cercapesci")
            TriggerServerEvent("nkz_restituiscicanna")
        else
            ESX.ShowNotification('Non puoi fare quest\'azione in questo momento')
        end
    else
        ESX.ShowNotification('Non sei nella zona di pesca!!!')
    end
end, false)
-- FINE PESCATORE -- 

-- Nikquz®#9748 --
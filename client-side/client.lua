local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
heL = Tunnel.getInterface("high_taco")

-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local quantidade = 0
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAR LANCHE --
local CoordenadaX = 6.15
local CoordenadaY = -1602.4
local CoordenadaZ = 29.3
-- 6.15, -1602.4, 29.3
-- FAZER LANCHE -- 
local CoordenadaX1 = 11.33
local CoordenadaY1 = -1605.54
local CoordenadaZ1 = 29.4
-- 11.33,-1605.54,29.4
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1250.78, ['y'] = -1328.77, ['z'] = 3.88 }, -- OK
	[2] = { ['x'] = -1152.32, ['y'] = -1520.27, ['z'] = 4.37 },  -- OK
	[3] = { ['x'] = -1091.08, ['y'] = -1041.17, ['z'] = 2.16 }, -- OK
	[4] = { ['x'] = -928.67, ['y'] = -936.23, ['z'] = 2.16 }, -- OK
	[5] = { ['x'] = -1356.07, ['y'] = -774.92, ['z'] = 19.98 }, -- OK
	[6] = { ['x'] = -1881.62, ['y'] = -578.21, ['z'] = 11.81 }, -- OK
	[7] = { ['x'] = -1811.61, ['y'] = -637.68, ['z'] = 10.94 }, -- OK
	[8] = { ['x'] = -1766.43, ['y'] = -677.17, ['z'] = 10.18 }, -- OK
	[9] = { ['x'] = -1742.21, ['y'] = -700.02, ['z'] = 10.13 }, -- OK 
	[10] = { ['x'] = -1862.61, ['y'] = -353.89, ['z'] = 49.24 }, -- OK
	[11] = { ['x'] = -1663.37, ['y'] = -535.97, ['z'] = 35.32 }, -- OK
	[12] = { ['x'] = -1541.22, ['y'] = 125.65, ['z'] = 56.78 }, -- OK
	[13] = { ['x'] = -1494.61, ['y'] = 420.16, ['z'] = 111.24 }, -- OK
	[14] = { ['x'] = -1498.97, ['y'] = 520.31, ['z'] = 118.28 }, -- OK
	[15] = { ['x'] = -1358.73, ['y'] = 553.21, ['z'] = 130.0 }, -- OK
	[16] = { ['x'] = -1287.92, ['y'] = 625.41, ['z'] = 138.85 }, -- OK
	[17] = { ['x'] = -1241.85, ['y'] = 672.91, ['z'] = 142.83 }, -- OK
	[18] = { ['x'] = -1197.79, ['y'] = 692.6, ['z'] = 147.39 }, -- OK
	[19] = { ['x'] = -1033.87, ['y'] = 686.04, ['z'] = 161.31 }, -- OK
	[20] = { ['x'] = -951.24, ['y'] = 683.8, ['z'] = 153.58 }, -- OK
	[21] = { ['x'] = -575.29, ['y'] = 494.54, ['z'] = 106.41 }, -- OK
	[22] = { ['x'] = -686.17, ['y'] = 504.5, ['z'] = 109.74 }, -- OK
	[23] = { ['x'] = -762.07, ['y'] = 432.74, ['z'] = 99.57 }, -- OK
	[24] = { ['x'] = 1373.28, ['y'] = 1147.46, ['z'] = 113.76 }, -- OK
	[25] = { ['x'] = 1322.69, ['y'] = -1736.46, ['z'] = 54.4 }, -- OK
	[26] = { ['x'] = 378.99, ['y'] = -1814.89, ['z'] = 29.11 }, -- OK
	[27] = { ['x'] = 441.47, ['y'] = -1705.96, ['z'] = 29.35 }, -- OK
	[28] = { ['x'] = -1203.82, ['y'] = -131.74, ['z'] = 40.70 }, -- OK
	[29] = { ['x'] = -932.33, ['y'] = 326.64, ['z'] = 71.25 }, -- OK
	[30] = { ['x'] = -587.70, ['y'] = 250.66, ['z'] = 82.26 }, -- OK
	[31] = { ['x'] = -478.28, ['y'] = 223.87, ['z'] = 83.02 }, -- OK
	[32] = { ['x'] = -310.77, ['y'] = 226.85, ['z'] = 87.78 }, -- OK
	[33] = { ['x'] = 75.20, ['y'] = 229.06, ['z'] = 108.70 }, -- OK
	[34] = { ['x'] = 296.00, ['y'] = 147.55, ['z'] = 103.77 }, -- OK
	[35] = { ['x'] = 978.79, ['y'] = -117.71, ['z'] = 73.99 }, -- OK
	[36] = { ['x'] = 1187.01, ['y'] = -431.18, ['z'] = 67.02 }, -- OK
	[37] = { ['x'] = 1260.03, ['y'] = -582.09, ['z'] = 68.88 }, -- OK
	[38] = { ['x'] = 1360.39, ['y'] = -570.32, ['z'] = 74.22 } -- OK
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ENTREGAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ifood',function(source,args,rawCommand)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,CoordenadaZ,x,y,z,true)
	if args[1] == "iniciar" and distance <= 1.2 and not servico then
		servico = true
		selecionado = math.random(38)
		CriandoBlip(locs,selecionado)
		heL.Quantidade()
		TriggerEvent("Notify","sucesso","Você entrou em serviço.")
		TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Lanches</b>.")
	elseif args[1] == "cancelar" and servico then
		servico = false
		RemoveBlip(blips)
		TriggerEvent("Notify","aviso","Você saiu de serviço.")
	end	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FAZER LANCHE ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lanche',function(source,args,rawCommand)
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local distance = GetDistanceBetweenCoords(CoordenadaX1,CoordenadaY1,CoordenadaZ1,x,y,z,true)

    if distance <= 1.2 and heL.checkLanche() then
        TriggerEvent('cancelando',true)
		--vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",15,28422)
		processo = true
        segundos = 8
        TriggerEvent("progress",8000,"Fazendo Lanche")
        SetTimeout(7500,function()
            vRP._DeletarObjeto()
            vRP._stopAnim(false)
            TriggerServerEvent("trydeleteobj",ObjToNet("hei_prop_heist_box"))
        end)
    end
end)--
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ENTREGAS ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,247,217,99,100,1,0,0,1)
				if IsControlJustPressed(0,38) then
					if IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("pcj")) then
						if heL.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
										selecionado = math.random(38)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Lanches</b>.")
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ STATUS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("quantidade-lanche")
AddEventHandler("quantidade-lanche",function(status)
    quantidade = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if processo then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					processo = false
					TriggerEvent('cancelando',false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Lanche")
	EndTextCommandSetBlipName(blips)
end
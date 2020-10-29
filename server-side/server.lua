local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
heL = {}
Tunnel.bindInterface("high_taco",heL)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function heL.Quantidade()
	local source = source
	if quantidade[source] == nil then
	   quantidade[source] = 5
	end
	   TriggerClientEvent("quantidade-lanche",source,parseInt(quantidade[source]))
end

function heL.checkPayment()
	heL.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"lanche",quantidade[source]) then
			randmoney = (math.random(100,200)*quantidade[source])
	        vRP.giveMoney(user_id,parseInt(randmoney))
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			heL.Quantidade()
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..quantidade[source].."x Lanches</b>.")
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function heL.checkLanche()
	local source = source
	local user_id = vRP.getUserId(source)
	
	if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("lanche")*5 <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"lanche",5)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
		return false
	end
end
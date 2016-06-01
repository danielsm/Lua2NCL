local Lua2NCL = {}

local ids = {} -- tabela para armazenar todos os ids
local headElem = {}  -- contem as tabelas que referem aos elementos contidos no head do NCL
local body = {} -- contem as tabelas que referem aos elementos contidos no body do NCL. media, port..
local links = {} --  contem as tabelas apenas dos links


-- definicao do elemento head // HEAD CLASS
head = {	region = {},
			descriptor = {},
			connectorBase = {}
		}

function head:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	--headElem = o
	if (o:analyse()) then
		return o
	end
end

-- o head nao contem nenhum elemento obrigatorio, mas se existir algum elemento declarado nele
-- entao verifica-se se este elemento esta declarado corretamente.
function head:analyse()
	--print("Analysing head...")
	if (#self > 0) then
		-- itera sobre os elementos declarodos em head
		for i,elem in pairs(self) do
			count  = false
			-- itera sobre o modelo do elemento head
			for k,v in pairs(head) do
				-- testa so as tabelas
				if (type(v) ~= "function") then
					-- se o tipo do elemento declarado for igual a algum no modelo, esta correto.
					-- se o elemento nao estiver no modelo, o contador continua falso pois ele nao deveria estar em head
					if (elem:getType() == k) then
						count = true
					end
					--print(i, elem:getType(), k)
				end
			end
			-- se count eh falso, significa que o elemento nao pertence a head
			if (count == false) then
				print("Erro na definição do elemento HEAD: O tipo ".. elem.getType().. " não é permitido.")
				return false
			end
			--print(count)
		end
	end
	table.insert(headElem,self)
	--print("AAQUIIIIIIIIIIIIIIIII",#headElem)
	return true
end

function head:print()
	-- body
	--head:analyse()
end

function head:getType()
	return "head"
end

--++++++++++++++++++++++++++++++++++++++++++++++

-- definicao do elemento region // Region CLASS
region = {	id = "",
			left = "", 
			top = "", 
			right = "", 
			bottom = "", 
			width = "", 
			height = "",
			zIndex = "", 
			title = ""
		 }

function region:new(o)
	o = o or {}
	setmetatable(o,region)
	self.__index = self
	if (o:analyse()) then
		return o
	end
end

function region:getType()
	return "region"
end

-- region precisa ter pelo menos o id, os outros atributos sao opcionais
function region:analyse()

	--print("Analysing region...")
	if (self.id ~= "") then
		
		-- itera sobre os elementos definidos na regiao
		for attr,value in pairs(self) do
			count = false
			--print(attr, value)
			-- itera sobre o modelo de region
			for k,v in pairs(region) do
				-- testa apenas com as tabelas (atributos) do modelo
				if (type(v) ~= "function") then
					if (attr == k) then
						count = true
					end
				end
			end
			-- se count eh falso, significa que o elemento nao pertence a region
			if (count == false) then
				print("Erro na definição do elemento region: O atributo ".. attr.. " não é permitido.")
				return false
			end
		end

		-- verificar se o id definido ja existe
		--print(#ids)
		if (#ids == 0) then
			table.insert(ids,self.id)
		elseif (#ids > 0) then
			for i=1,#ids do
				if (self.id == ids[i]) then
					print("Erro na definição do elemento region: O valor do id ".. self.id .." ja existe")
					return false
				end
			end
			table.insert(ids,self.id)
		end
		table.insert(headElem,self)
		--print("region....OK")
		return true
	else
		print("Erro na definição do elemento region: id não definido")
		return false
	end
end

-- imprime a estrutura ncl de uma region
function region:print()
	
		local str = "<region "
		for attr,value in pairs(self) do
			str = str .. attr .. "=\"" .. value .. "\"" .. " "
		end
		str = str .. "/>\n"
		return (str)
	
end
--++++++++++++++++++++++++++++++++++++++++++++++

-- definicao do elemento descriptor // DESCRIPTOR CLASS
descriptor = {	id = "",
				region = "",
			 	player = "",
			 	explicitDur = "",
			 	freeze = "",
			 	tranIn = "",
			 	transOut = "",
			 	moveLeft = "",
			 	moveRight = "",
			 	moveUp = "",
			 	moveDown = "",
			 	focusIndex = "",
			 	foccusBorderColor = "",
			 	focusBorderWidth = "",
			 	focusBorderTransparency = "",
			 	focusSrc = "",
			 	focusSelSr = "",
			 	selBorderColor = ""
			 }

function descriptor:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	if (o:analyse()) then
		return o
	end
end

function descriptor:getType()
	return "descriptor"
end

function descriptor:analyse()
	--print("Analysing descriptor...")
	if (self.id ~= "") then
		-- itera sobre os elementos definidos no descriptor
		for attr,value in pairs(self) do
			count = false

			-- itera sobre o modelo de descriptor
			for k,v in pairs(descriptor) do
				-- testa apenas com as tabelas (atributos) do modelo
				if (type(v) ~= "function") then
					if (attr == k) then
						count = true
					end
				end
			end
			-- se count eh falso, significa que o elemento nao pertence a descriptor
			if (count == false) then
				print("Erro na definição do elemento descriptor: O atributo ".. attr.. " não é permitido.")
				return false
			end
		end

		-- verificar se o id definido ja existe
		--print(#ids)
		if (#ids == 0) then
			table.insert(ids,self.id)
		elseif (#ids > 0) then
			for i=1,#ids do
				if (self.id == ids[i]) then
					print("Erro na definição do elemento descriptor: O valor do id ".. self.id .." ja existe")
					return false
				end
			end
			table.insert(ids,self.id)
		end

		-- verifica se o region apontado existe
		auxFlag = false
		if (self.region ~= "") then
			for k,elem in pairs(headElem) do
				if (elem:getType() == "region") then
					if (self.region == elem.id) then
						auxFlag = true
					end
				end
			end

			if (auxFlag == false) then
				print("Erro na definição do elemento descriptor: o region referenciado não está definido")
				return false
			end
		end

		table.insert(headElem, self)
		--print("descriptor....OK")
		return true
		
	else
		print("Erro na definição do elemento descriptor: id não definido")
		return false
	end
end

-- imprime a estrutura ncl do descriptor
function descriptor:print()
	local str = "<descriptor "
	for attr,value in pairs(self) do
		str = str .. attr .. "=\"" .. value .. "\"" .. " "
	end
	str = str .. "/>\n"
	return (str)
end
--+++++++++++++++++++++++++++++++++++++++++++++++

-- definicao do connectorBase - CONNECTOR CLASS
connectorBase = {	documentURI = "",
				alias= ""}

function connectorBase:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	if (o:analyse()) then
		return o
	end
end

function connectorBase:getType()
	return "connectorBase"
end

function connectorBase:analyse()
	--print("Analysing connectorBase...")
	if (self.documentURI ~= "") then
		if (self.alias ~= "") then
			-- itera sobre os elementos definidos no descriptor
			for attr,value in pairs(self) do
				count = false
				--print(attr, value)
				-- itera sobre o modelo de descriptor
				for k,v in pairs(connectorBase) do
					-- testa apenas com as tabelas (atributos) do modelo
					if (type(v) ~= "function") then
						if (attr == k) then
							count = true
						end
					end
				end
				-- se count eh falso, significa que o elemento nao pertence a descriptor
				if (count == false) then
					print("Erro na definição do elemento connectorBase: O atributo ".. attr.. " não é permitido.")
					return false
				end
			end

			table.insert(headElem,self)
			--print("connectorBase....OK")
			return true
		else
			print("Erro na definição do elemento connectorBase: alias não definido")
			return false
		end
	else
		print("Erro na definição do elemento connectorBase: documentURI não definido")
		return false
	end
end

function connectorBase:print()
	-- body
	return "<importBase documentURI=\""..self.documentURI.."\" ".."alias=\""..self.alias.."\"/>\n"
end
--+++++++++++++++++++++++++++++++++++++++++++++++++++
-- Definicao do elemento property // PROPERTY CLASS

property = {	name="",
				value="",
				externable=""
			}

function property:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	if (o:analyse()) then
		return o
	end
end

function property:getType()
	return "property"
end

function property:analyse()
	
	if (self.name ~= "") then
		return true
	else
		return false
	end	
end	

function property:print()
	-- body
end

--+++++++++++++++++++++++++++++++++++++++++++++++++++
-- Definicao do elemento area // AREA CLASS

area = {	id="",
			begin="",
			['end']="",
			first="",
			last="",
			beginText="",
			endText="",
			beginPosition="",
			endPosition="",
			coords="",
			label="",
			clip=""
		}

function area:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	if (o:analyse()) then
		return o
	end
end

function area:getType()
	return "area"
end

function area:analyse()
	
	if (self.id ~= "") then
		if (#ids == 0) then
			table.insert(ids,self.id)
		elseif (#ids > 0) then
			for i=1,#ids do
				if (self.id == ids[i]) then
					print("Erro na definição do elemento MEDIA: O valor do id ".. self.id .." ja existe")
					return false
				end
			end
			table.insert(ids,self.id)
		end
		return true
	else
		return false
	end	
end	

function area:print()
	-- body
end

--+++++++++++++++++++++++++++++++++++++++++++++++


-- Definicao do elemento media // MEDIA CLASS
media = {	id = "",
			src = "", 
			descriptor = "",
			type = "",
			refer = "",
			instance = "",
			property = "",
			area = ""
		}

function media:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	if (o:analyse()) then
		return o
	end
end

function media:getType()
	return "media"
end

-- validacao sintatica da tabela media. Verifica se os atributos estao corretos.
function media:analyse()

	--print("Analysing MEDIA..")
	-- verifica se existe id definido
	if (self.id ~= "") then
		--verifica se o id ja existe no documento
		if (#ids == 0) then
			table.insert(ids,self.id)
		elseif (#ids > 0) then
			for i=1,#ids do
				if (self.id == ids[i]) then
					print("Erro na definição do elemento MEDIA: O valor do id ".. self.id .." ja existe")
					return false
				end
			end
			table.insert(ids,self.id)
		end

		-- verifica se ha src ou type, se nao houver apenas imprime sugestao
		if (self.src == "" and self.type == "") then
			print("Erro na definição do elemento MEDIA: O elemento deve possuir os atributos src ou type")
			return false
		end

		-- verifica se o descriptor apontado existe
		auxFlag = false
		if (self.descriptor ~= "") then
			for k,elem in pairs(headElem) do
				if (elem:getType() == "descriptor") then
					if (self.descriptor == elem.id) then
						auxFlag = true
					end
				end
			end
			
			if (auxFlag == false) then
				print("Erro na definição do elemento MEDIA: o descriptor referenciado não está definido")
				return false
			end
		end
		
		--print("MEDIA OK")
		table.insert(body, self)
		return true
	else
		print("Erro na definição do elemento MEDIA: id não definido")
		return false
	end

end

-- imprime a estrutura ncl da media
function media:print()	

	local flag = false
	local attrName, attrExtra = {},{}
	local str = "<media "

	for attr,value in pairs(self) do
		if (type(value) == "string") then
			str = str .. attr:lower() .. "=\"" .. value .. "\"" .. " "
		else
			if (value:getType() == "property" or value:getType() == "area") then
				flag = true
				table.insert(attrName,value:getType())
				table.insert(attrExtra,value)
			end
		end
	end
	
	if (#attrName > 0) then
		str = str .. ">\n"
		for i=1,(#attrName),1 do
			str = str .. "\t\t\t<"..attrName[i].." "
			for n,v in pairs(attrExtra[i]) do
				str = str..n.."=\""..v.. "\"" .. " "
			end
			str = str .. "/>\n"
		end
		str = str .."\t\t</media>\n"
	else
		str = str .. "/>\n"
	end
	return (str)
	
end


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++ 

-- definicao do port // PORT CLASS
port = {	id = "", 
			component = "",
			interface = ""
		}

function port:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	if (o:analyse()) then
		return o
	end
end

function port:getType()
	return "port"
end

function port:analyse()
	-- body
	if (self.id ~= "") then
		--verifica se o id ja existe no documento
		if (#ids == 0) then
			table.insert(ids,self.id)
		elseif (#ids > 0) then
			for i=1,#ids do
				if (self.id == ids[i]) then
					print("Erro na definição do elemento PORT: O valor do id ".. self.id .." ja existe")
					return false
				end
			end
			table.insert(ids,self.id)
		end

		-- verifica se o component apontado existe e se he valido
		auxFlag = false
		if (self.component ~= "") then
			for k,elem in pairs(body) do
				if (elem:getType() == "media" or elem:getType() == "context" ) then
					if (self.component == elem.id) then
						auxFlag = true
					end
				end
			end
			
			if (auxFlag == false) then
				print("Erro na definição do elemento PORT: o component referenciado não está definido")
				return false
			end
		else
			print("Erro na definição do elemento PORT: component não definido")
			return false
		end

		table.insert(body,self)
		return true

	else
		print("Erro na definição do elemento PORT: id não definido")
		return false
	end
end

-- imprime a estrutura ncl do port
function port:print()
	local str = "<port "
	for attr,value in pairs(self) do
		str = str .. attr:lower() .. "=\"" .. value .. "\"" .. " "
	end
	str = str .. "/>\n"
	return (str)
end

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++ 

-- Definicao do link // LINK CLASS 
link = {when = {}, ["do"]= {}}

function link:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	table.insert(links,o)
	return o
end


-- function verify(elo)
-- 	str = elo
-- 	local sentence = {
-- 		'full';
-- 		full = lpeg.V'begin' * lpeg.V'object' * (lpeg.V'complement'^0) *lpeg.P'do' * lpeg.V'space' * lpeg.V'reaction' * lpeg.P'end',
-- 		begin = lpeg.P'when' * lpeg.V'space',
-- 		object = lpeg.V'name' * lpeg.P'.' * lpeg.V'action' * lpeg.V'space',
-- 		action = lpeg.R'az'^1,
-- 		complement = lpeg.P'with' * lpeg.V'space' * lpeg.V'key' * lpeg.V'space',
-- 		key = lpeg.C( (lpeg.R'AZ') * ((lpeg.R'AZ' + lpeg.P'_')^0) ),
-- 		reaction = ((lpeg.P'and' * lpeg.V'space')^0 * ((lpeg.V'object')^1) * lpeg.V'space')^1,
-- 		space = (lpeg.S'\n \t\r\f')^0,
-- 		name = lpeg.C( (lpeg.R'AZ' + lpeg.R'az') * ((lpeg.R'AZ' + lpeg.R'az' + lpeg.R'09' + lpeg.P'_')^0) )
-- 	}

-- 	--print(lpeg.match(sentence, elo))
-- 	if lpeg.match(sentence, elo) == nil then
-- 		print("Erro na definicao do link")
-- 		return nil
-- 	end

-- end

function link:getType()
	return "link"
end

function link:print()
--[[	A tabela link eh dividida eh duas subtabelas, condition (indice "when") e action (indice "do".
		A subtabela de condicao (when) contem subtabelas 
		

		condition = {	[1]= condition do link, a acao que deve acontecer para disparar as actions
						[2]= id da media ligada a condition,
						[3]= * interface do componente
						[4]= * Nome do Parametro, caso exista
						[5]= * value do parametro
					 }

		action = {	[i] = contem os roles das acoes que devem ser disparadas pelo link }
		cmp = {	[i]= contem o component(media) correspondete ao role contido em action[i] } cmp -> component
		paramName = {} - tabela para uso caso exista parametros ou interface nas medias ligadas as actions, recebe apenas o nome do parametro
		paramValue = {} - recebe o valor do parametro ]]

	local condition, action, cmp = {}, {}, {}
	
	--string que sera impressa no file
	local tag = "<link xconnector=\""

	-- itera sobre a tabela link que deve conter os elementos "when"-condition e "do"-action	
	-- i iterara sobre os indices dos elementos(when e do) e v1 recebera seus valores
	for i,v1 in pairs(self) do

		-- a iteracao agora eh sobre os valores de "when" e "do" que também sao tabelas
		-- j contem o role(evento) e v2 contem as medias(componentes) que sofrera o evento j
		for j,v2 in pairs(v1) do
			
			-- verificando qual a condicao para o disparo do link
			if (i == "when") then
				-- primeiro elemento formara o alias do link
				condition[1] = j
				
				-- iteracao no proximo nivel. Tabela com a media(componente) da condicao 	
				for k,v3 in pairs(v2) do
					--print(type(k))
					if (type(k) == "string") then
						if (k == "interface") then condition[3] = v3  
						else
							condition[4] = k
							condition[5] = v3	
						end
					else
						condition[2]=v3
					end
				end

			-- verificando as acoes que serao disparadas pelo link
			elseif (i== "do") then
				-- iteracao no ultimo nivel das tabelas. 
				-- atribuiçao dos roles e respectivos componentes do action disparado pelo link
				for k,v3 in pairs(v2) do
					table.insert(action,j)
					table.insert(cmp,v3)
				end
			end
		end
	end
	-- contrucao do xconnector do link
	-- o xconnector eh composto do alias + role do condition + roles das actions
	-- primeiro eh preciso descobrir o alias do connector usado
	for i,t in pairs(headElem) do
		if (t:getType()=="connectorBase") then
			tag = tag..t.alias.."#"
		end 
	end
	-- concatenacao com a condition do link
	if (condition[4] == "keyCode") then
		tag = tag.."onKeySelection"
	else
		tag = tag..condition[1]
	end
	-- concatenacao com as actions do link
	for i,v in pairs(action) do
		-- if (string.find(tag,firstToUpper(v))) then
		-- 	tag = tag.."N"
		-- else
		if (action[i] ~= action[i+1]) then
			tag = tag..firstToUpper(v).."N"
		else
			tag = tag.."N"
		end
	end
	tag = tag .. "\">\n"

	-- criacao dos binds
	-- primeiro a condition
	-- sem interface
	if (condition[3] == nil) then
		-- verifica se existe uma key
		if (condition[4] == nil) then
			tag = tag .. "\t\t\t<bind role=\""..condition[1].."\" ".."component=\""..condition[2].."\"/>\n"
		else
			tag = tag .. "\t\t\t<bind role=\""..condition[1].."\" ".."component=\""..condition[2].."\">\n"
			tag = tag.. "\t\t\t\t<bindParam name=\""..condition[4].."\"".." value=\""..condition[5].."\"/>\n"
			tag = tag.. "\t\t\t</bind>\n"
		end
	else -- com interface
		-- verifica se existe uma key
		if (condition[4] == nil) then
			tag = tag .. "\t\t\t<bind role=\""..condition[1].."\" ".."component=\""..condition[2].."\"".." interface=\""..condition[3].."\"/>\n"
		else
			tag = tag .. "\t\t\t<bind role=\""..condition[1].."\" ".."component=\""..condition[2].."\"".." interface=\""..condition[3].."\">\n"
			tag = tag.. "\t\t\t\t<bindParam name=\""..condition[4].."\"".." value=\""..condition[5].."\"/>\n"
			tag = tag.. "\t\t\t</bind>\n"
		end
		
	end	

	-- agora a(s) action(s)
	for i,v in pairs(action) do
		tag = tag .. "\t\t\t<bind role=\""..action[i].."\" ".."component=\""..cmp[i].. "\"/>\n"
	end
	tag = tag .. "\t\t</link>\n"
	return(tag)	
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- Deixa a primeira letra maiscula
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end


function writeRegion()
	-- body
	local aux = false
	for i,t in pairs(headElem) do
		if t:getType() == "region" then 
			aux = true
		end
	end

	if (aux) then
		local text = ""
		text = text.."\t\t<regionBase>\n"
		for i,t in pairs(headElem) do
			if t:getType() == "region" then 
				string = t:print() 
				text = text.."\t\t\t"..string
			end
		end
		text = text.."\t\t</regionBase>\n\n"
		return text
	else
		return ""
	end
end

function writeDescriptor()
	-- body
	local aux = false
	for i,t in pairs(headElem) do
		if t:getType() == "descriptor" then 
			aux = true
		end
	end

	if (aux) then
		local text = ""
		text = text.."\t\t<descriptorBase>\n"
		for i,t in pairs(headElem) do
			if t:getType() == "descriptor" then  
				string = t:print() 
				text = text.."\t\t\t"..string
			end
		end
		text = text.."\t\t</descriptorBase>\n\n"
		return text
	else
		return ""
	end
end

function writeConnector()
	-- body
	local aux = false
	for i,t in pairs(headElem) do
		if t:getType() == "connectorBase" then 
			aux = true
		end
	end

	if (aux) then
		local text = ""
		text = text.."\t\t<connectorBase>\n"
		for i,t in pairs(headElem) do
			if t:getType() == "connectorBase" then  
				string = t:print() 
				text = text.."\t\t\t"..string
			end
		end
		text = text.."\t\t</connectorBase>\n\n"
		return text
	else
		return ""
	end
end


function writeLinks( )
	-- body
	local text = ""
	for i,t in pairs(links) do
		string = t:print()
		text = text.."\t\t"..string.."\n"
	end
	return text
end


-- Converter as tabelas luas em tags NCL
function Lua2NCL:Translate()

	--criar o arquivo .ncl com o mesmo nome do documento lua
	print("\nParsing document ".. arg[0] .." to NCL\n\n")
	--print("NUMERO DE IDS", #ids)



	local name = arg[0]
	name = string.sub(name,1,(string.find(name,".lua")-1))
	local f=io.open(name..".ncl","w")
	io.output(f)

	-- texto para ser escrito no documento .ncl
	local fulltext = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n<!--Generated by Lua2NCL v.1.0-->\n<ncl id=\"".. name.."\" xmlns=\"http://www.ncl.org.br/NCL3.0/EDTVProfile\">\n"
	

	--  imprimir elementos 
	if (#headElem > 0) then
		fulltext = fulltext .."\t<head>\n"
		fulltext = fulltext..writeRegion()
		fulltext = fulltext..writeDescriptor()
		fulltext = fulltext..writeConnector()
		fulltext = fulltext .."\t</head>\n"
	end
	

	fulltext = fulltext .."\t<body>\n"

	-- imprime os elementos do body: media, port
	if (#body > 0) then
		for i=1,#body,1 do
			fulltext = fulltext.."\t\t"..body[i]:print().."\n"
		end
	end

	fulltext = fulltext ..writeLinks()

	fulltext = fulltext .."\t</body>\n"
	fulltext = fulltext .."</ncl>"
	io.write(fulltext)
	io.close(f)
	print("**** DONE!! ****\n\n")
	print("Generated NCL file is:", name..".ncl\n\n")
	
	print("Analysing NCL file with NCL Validator\n")
	os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..name..".ncl")
	print("Lua2NCL v.1.0\n")
end

return Lua2NCL


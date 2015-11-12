local SNCLua = {}

local head = {}  -- contem as tabelas que referem aos elementos contidos no head do NCL
local body = {}  -- contem as tabelas que referem aos elementos contidos no body do NCL
local links = {} --  contem as tabelas apenas dos links

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
	setmetatable(o,self)
	self.__index = self
	table.insert(head, o)
	return o
end

function region:getType()
	return "region"
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
	table.insert(head, o)
	return o
end

function descriptor:getType()
	return "descriptor"
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
connector = {	documentURI = "",
				alias= ""}

function connector:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	table.insert(head, o)
	return o
end

function connector:getType()
	return "connector"
end

function connector:print()
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
	return o
end

function property:getType()
	return "property"
end

function property:print()
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
			property = {},
			area = {}
		}

function media:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	table.insert(body, o)
	return o
end

function media:getType()
	return "media"
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
			if (attr == "property" or attr == "area") then
				flag = true
				table.insert(attrName,attr)
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
	table.insert(body, o)
	return o
end

function port:getType()
	return "port"
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
	--verify(o[1])
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
	--condition = {	[1]= condition do link, a acao que deve acontecer para disparar as actions
	--				[2]= id da media ligada a condition,
	--				[3]= * interface do componente
	--				[4]= * Nome do Parametro, caso exista
	--				[5]= * value do parametro
	--				 }

	--action = {	[i] = contem os roles das acoes que devem ser disparadas pelo link }
	--cmp = {	[i]= contem o component(media) correspondete ao role contido em action[i] } cmp -> component
	-- paramName = {} - tabela para uso caso exista parametros ou interface nas medias ligadas as actions, recebe apenas o nome do parametro
	-- paramValue = {} - recebe o valor do parametro
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
				condition[1] = "on"..firstToUpper(j)
				
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
	for i,t in pairs(head) do
		if (t:getType()=="connector") then
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

-- Converter as tabelas luas em tags NCL
function SNCLua:Translate()

	print("Parsing document ".. arg[0] .." to NCL\n\n")
	local name = arg[0]

	name = string.sub(name,1,string.find(name,".lua"))
	
	local f=io.open(name.."ncl","w")
	io.output(f)


	io.write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n<ncl id=\"main\" xmlns=\"http://www.ncl.org.br/NCL3.0/EDTVProfile\">\n")
	io.write("\t<head>\n")

	if #head > 0 then
		writeRegion()
		writeDescriptor()
		writeConnector()
	end

	io.write("\t</head>\n")

	io.write("\t<body>\n")

	for i=1,#body,1 do
			io.write("\t\t"..body[i]:print().."\n")
	end

	writeLinks()

	io.write("\t</body>\n")
	io.write("</ncl>")
	io.close(f)
	print("**** DONE!! ****\n\n")
	print("Generated NCL file is:", name.."ncl")
end

function writeRegion()
	-- body
		io.write("\t\t<regionBase>\n")
		for i,t in pairs(head) do
			if t:getType() == "region" then 
				string = t:print() 
				io.write("\t\t\t"..string)
			end
		end
		io.write("\t\t</regionBase>\n\n")
end

function writeDescriptor()
	-- body
		io.write("\t\t<descriptorBase>\n")
		for i,t in pairs(head) do
			if t:getType() == "descriptor" then  
				string = t:print() 
				io.write("\t\t\t"..string)
			end
		end
		io.write("\t\t</descriptorBase>\n\n")

end

function writeConnector()
	-- body
		io.write("\t\t<connectorBase>\n")
		for i,t in pairs(head) do
			if t:getType() == "connector" then  
				string = t:print() 
				io.write("\t\t\t"..string)
			end
		end
		io.write("\t\t</connectorBase>\n\n")

end


function writeLinks( )
	-- body
	for i,t in pairs(links) do
		string = t:print()
		io.write("\t\t"..string.."\n")
	end
end
return SNCLua


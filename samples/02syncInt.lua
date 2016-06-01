Lua2NCL = require("Lua2NCL/Lua2NCL")
head:new {
		region:new{ id="backgroundReg", width="100%", height="100%", zIndex="1"},
		region:new{ id="screenReg", width="100%", height="88%", zIndex="2"},
		region:new{ id="frameReg", left="5%", top="6.7%", width="18.5%", height="18.5%", zIndex="3"},
		region:new{ id="iconReg", left="87.5%", top="11.7%", width="8.45%", height="6.7%", zIndex="3"},
		region:new{ id="shoesReg", left="15%", top="60%", width="25%", height="25%", zIndex="3"},
		descriptor:new{ id="backgroundDesc", region="backgroundReg"},
		descriptor:new{ id="screenDesc", region="screenReg"},
		descriptor:new{ id="photoDesc", region="frameReg", explicitDur="5s", descriptor:new{Param name="transparency", value="0.6"} },	
		descriptor:new{ id="audioDesc"},
		descriptor:new{ id="dribleDesc", region="frameReg", transIn="trans1", transOut="trans2"},			
		descriptor:new{ id="iconDesc", region="iconReg", explicitDur="6s"},			
		descriptor:new{ id="shoesDesc", region="shoesReg"},
		connectorBase:new{ documentURI= "ConnectorBase.ncl", alias= "con"}
}
port:new{ id="entry", component="animation"},
media:new{ id="background", src="../media/background.png", descriptor="backgroundDesc"}
media:new{ id="animation", src="../media/animGar.mp4", descriptor="screenDesc",
	area:new{ id="segDrible", begin="12s"},
	area:new{ id="segPhoto", begin="41s"},
	area:new{ id="segIcon", begin="45s" end="51s"},
	property:new{name="bounds"}
}
media:new{ id="choro", src="../media/choro.mp4", descriptor="audioDesc"}
media:new{ id="drible", src="../media/drible.mp4", descriptor="dribleDesc"}
media:new{ id="photo", src="../media/photo.png", descriptor="photoDesc"}
media:new{ id="icon", src="../media/icon.png", descriptor="iconDesc"}
media:new{ id="shoes", src="../media/shoes.mp4", descriptor="shoesDesc"}
link:new{ when = { onBegin = {"animation"} }, ["do"] = { start =  {"background", delay="5s" }, 
														 start =  {"choro", delay="5s" } } }
link:new{ when = {onBegin = {"animation", interface="segDrible"} }, ["do"] = {start = {"drible"} } }
link:new{ when = {onBegin = {"animation", interface="segPhoto"} }, ["do"] = {start = {"photo"} } }
link:new{ when = {onEnd = {"animation"} }, ["do"] = {stop = {"background"}, stop = {"choro"} } }
link:new{ when = {onBegin = {"animation", interface="segIcon"} }, ["do"] = {start = {"icon"} } }
link:new{ 	when = { onSelection = {"icon", keyCode="RED"} },
				["do"] = { set =  {"animation", interface="bounds", var="5%,6.67%,45%,45%" },
						   start = {"shoes"},
						   stop = {"icon"} } }
link:new{ when = {onEnd = {"shoes"} }, ["do"] = {set = {"animation", interface="bounds", var="0,0,222.22%,222.22%"} } }
Lua2NCL:Translate()
Lua2NCL = require("Lua2NCL/Lua2NCL")
head:new {
		region:new{ id="screenReg", width="100%", height="88%", zIndex="2"},
		region:new{ id="frameReg", left="5%", top="6.7%", width="18.5%", height="18.5%", zIndex="3"},
		descriptor:new{ id="screenDesc", region="screenReg"},
		descriptor:new{ id="photoDesc", region="frameReg", explicitDur="5s", descriptor:new{Param name="transparency", value="0.6"} },	
		descriptor:new{ id="audioDesc"},
		descriptor:new{ id="dribleDesc", region="frameReg", transIn="trans1", transOut="trans2"},
		connectorBase:new{ documentURI= "ConnectorBase.ncl", alias= "con"}
}
port:new{ id="entry", component="animation"},
media:new{ id="animation", src="../media/animGar.mp4", descriptor="screenDesc",
	area:new{ id="segDrible", begin="12s"},
	area:new{ id="segPhoto", begin="41s"},
}
media:new{ id="choro", src="../media/choro.mp4", descriptor="audioDesc"}
media:new{ id="drible", src="../media/drible.mp4", descriptor="dribleDesc"}
media:new{ id="photo", src="../media/photo.png", descriptor="photoDesc"}
link:new{ when = {onBegin = {"animation"} }, ["do"] = {start = {"choro", delay="5s"} } }
link:new{ when = {onBegin = {"animation", interface="segDrible"} }, ["do"] = {start = {"drible"} } }
link:new{ when = {onBegin = {"animation", interface="segPhoto"} }, ["do"] = {start = {"photo"} } }	
link:new{  when = {onEnd = {"animation"} }, ["do"] = {stop = {"choro"} } }
Lua2NCL:Translate()
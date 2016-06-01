Lua2NCL = require("Lua2NCL/Lua2NCL")
head:new {
		rule:new{ id="en", var="system.language", value="en", comparator="eq"},
		transition:new{ id="trans1", type="fade", dur="2s"},
		transition:new{ id="trans2", type="barWipe", dur="1s"},
		region:new{ id="backgroundReg", width="100%", height="100%", zIndex="1"},
		region:new{ id="screenReg", width="100%", height="88%", zIndex="2"},
		region:new{ id="frameReg", left="5%", top="6.7%", width="18.5%", height="18.5%", zIndex="3"},
		region:new{ id="iconReg", left="87.5%", top="11.7%", width="8.45%", height="6.7%", zIndex="3"},
		region:new{ id="shoesReg", left="15%", top="60%", width="25%", height="25%", zIndex="3"},
		region:new{ id="formReg", left="57.25%", top="9.83%", width="37.75%", height="70.2%", zIndex="3"},
		descriptor:new{ id="backgroundDesc", region="backgroundReg"},
		descriptor:new{ id="screenDesc", region="screenReg"},
		descriptor:new{ id="photoDesc", region="frameReg", explicitDur="5s", descriptor:new{Param name="transparency", value="0.6"} },	
		descriptor:new{ id="audioDesc"},
		descriptor:new{ id="dribleDesc", region="frameReg", transIn="trans1", transOut="trans2"},			
		descriptor:new{ id="iconDesc", region="iconReg", explicitDur="6s"},			
		descriptor:new{ id="shoesDesc", region="shoesReg"},
		descriptor:new{ id="formDesc", region="formReg", focusIndex="1", explicitDur="15s"},
		connectorBase:new{ documentURI= "ConnectorBase.ncl", alias= "con"}
},
port:new{ id="entry", component="animation"},
media:new{ id="background", src="../media/background.png", descriptor="backgroundDesc"}
media:new{ id="animation", src="../media/animGar.mp4", descriptor="screenDesc",
	area:new{ id="segDrible", begin="12s"},
	area:new{ id="segPhoto", begin="41s"},
	area:new{ id="segIcon", begin="45s" end="51s"},			
}
media:new{ id="choro", src="../media/choro.mp4", descriptor="audioDesc"}
media:new{ id="drible", src="../media/drible.mp4", descriptor="dribleDesc"},
media:new{ id="photo", src="../media/photo.png", descriptor="photoDesc",property:new{ name="top"} },					
context:new{ id="advert",
	media:new{ id="reusedAnimation", refer="animation", instance="instSame", property:new{ name="bounds"} }
	media:new{ id="icon", src="../media/icon.png", descriptor="iconDesc"}
	media:new{ id="shoes", src="../media/shoes.mp4", descriptor="shoesDesc"}
	switch:new{ id="form",
		switchPort:new{ id="spForm",
			mapping:new{ component="enForm"},
			mapping:new{ component="ptForm"}
		},
		bindRule:new{ constituent="enForm", rule="en"},
		defaultComponent:new{ component="ptForm"},
		media:new{ id="ptForm", src="../media/ptForm.htm", type="text/html", descriptor="formDesc"},
		media:new{ id="enForm", src="../media/enForm.htm", type="text/html", descriptor="formDesc"}
	},
	link:new{ 	when = { onBegin = {"reusedAnimation", interface="segIcon"} }, 
				["do"] = { var =  {"reusedGlobalVar", interface="service.interactivity" }
						   start = {"icon"} } },
	link:new{ 	when = { onSelection = {"icon", keyCode="RED"} },
				["do"] = { start = {"shoes"},
						   start = {"form", interface="spForm"},
						   set =  {"reusedAnimation", interface="bounds", var="5%,6.67%,45%,45%" },
						   stop = {"icon"} } },
	link:new{ 	when = { onEnd = {"form", interface="spForm"} }, 
				["do"] = { set =  {"reusedAnimation", interface="bounds", var="0,0,222.22%,222.22%" } }	} 
}
link:new{ 	when = { onBegin = {"animation"} }, 
			["do"] = { start =  {"background", delay="5s" },
					   start =  {"menu", delay="5s" } }
},
link:new{	when = { onBegin = {"animation", interface="segDrible"} }, ["do"] = { start = {"drible"} } },
link:new{	when = { onBegin = {"animation", interface="segPhoto"} }, 
			["do"] = { start = {"photo"} 
					   set = {"photo", interface="top", bindParam={var="290", delay ="1s", duration="3s"} } } 
},
Lua2NCL:Translate()


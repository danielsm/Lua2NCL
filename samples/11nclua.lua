Lua2NCL = require("Lua2NCL/Lua2NCL")
head:new {
		rule:new{ id="en", var="system.language", value="en", comparator="eq"},
		rule:new{ id="rRock", var="service.currentFocus", value="3", comparator="eq"},
		rule:new{ id="rTechno", var="service.currentFocus", value="4", comparator="eq"},
		rule:new{ id="rCartoon", var="service.currentFocus", value="5", comparator="eq"},
		transition:new{ id="trans1", type="fade", dur="2s"},
		transition:new{ id="trans2", type="barWipe", dur="1s"},
		region:new{ id="backgroundReg", width="100%", height="100%", zIndex="1"},
		region:new{ id="screenReg", width="100%", height="88%", zIndex="2"},
		region:new{ id="frameReg", left="5%", top="6.7%", width="18.5%", height="18.5%", zIndex="3"},
		region:new{ id="iconReg", left="87.5%", top="11.7%", width="8.45%", height="6.7%", zIndex="3"},
		region:new{ id="shoesReg", left="15%", top="60%", width="25%", height="25%", zIndex="3"},
		region:new{ id="formReg", left="57.25%", top="9.83%", width="37.75%", height="70.2%", zIndex="3"},
		region:new{ id="intReg", left="92.5%", top="91.7%", width="5.07%", height="6.51%", zIndex="3"},
		region:new{ id="chorinhoReg", left="2.5%", top="91.7%", width="11.7%", height="6.51%", zIndex="3"},
		region:new{ id="rockReg", left="25%", top="91.7%", width="11.7%", height="6.51%", zIndex="3"},
		region:new{ id="technoReg", left="47.5%", top="91.7%", width="11.7%", height="6.51%", zIndex="3"},
		region:new{ id="cartoonReg", left="70%", top="91.7%", width="11.7%", height="6.51%", zIndex="3"},
		region:new{ id="changesReg", left="0%", top="90%", width="100%", height="10%", zIndex="4"},
		descriptor:new{ id="backgroundDesc", region="backgroundReg"},
		descriptor:new{ id="screenDesc", region="screenReg"},
		descriptor:new{ id="photoDesc", region="frameReg", explicitDur="5s", descriptor:new{Param name="transparency", value="0.6"} },	
		descriptor:new{ id="audioDesc"},
		descriptor:new{ id="dribleDesc", region="frameReg", transIn="trans1", transOut="trans2"},			
		descriptor:new{ id="iconDesc", region="iconReg", explicitDur="6s"},			
		descriptor:new{ id="shoesDesc", region="shoesReg"},
		descriptor:new{ id="formDesc", region="formReg", focusIndex="1", explicitDur="15s"},
		descriptor:new{ id="intDesc", region="intReg"},
		descriptor:new{ id="chorinhoDesc", region="chorinhoReg", focusIndex="2", moveRight="3", moveLeft="5"},
		descriptor:new{ id="rockDesc", region="rockReg", focusIndex="3", moveRight="4", moveLeft="2"},
		descriptor:new{ id="technoDesc", region="technoReg", focusIndex="4", moveRight="5", moveLeft="3"},
		descriptor:new{ id="cartoonDesc", region="cartoonReg", focusIndex="5", moveRight="2", moveLeft="4"},
		descriptor:new{ id="changesDesc", region="changesReg"},
		connectorBase:new{ documentURI= "ConnectorBase.ncl", alias= "con"}
},
port:new{ id="entry", component="animation"},
media:new{ id="background", src="../media/background.png", descriptor="backgroundDesc"}
media:new{ id="animation", src="../media/animGar.mp4", descriptor="screenDesc",
	area:new{ id="segDrible", begin="12s"},
	area:new{ id="segPhoto", begin="41s"},
	area:new{ id="segIcon", begin="45s" end="51s"},
	area:new{ id="segLua", end="61s"},			
	area:new{ id="segCred", end="64s"}
}
media:new{ id="newChanges", refer="changes", ,instance="instSame"},
media:new{ id="drible", src="../media/drible.mp4", descriptor="dribleDesc"},
media:new{ id="photo", src="../media/photo.png", descriptor="photoDesc",property:new{ name="top"} },					
context:new{ id="interactivity",
	media:new{ id="globalVar", type="application/x-ginga-settings",
		property:new{ name="service.interactivity", value="true"},
		property:new{ name="service.currentFocus"},
	},	
	media:new{ id="anotherAnimation", refer="animation", instance="instSame"},
	media:new{ id="intOn", src="../media/intOn.png", descriptor="intDesc"},
	media:new{ id="intOff", src="../media/intOff.png", descriptor="intDesc"},
	link:new{ 	when = { onBegin = {"anotherAnimation"} }, 
				["do"] = { start = {"intOn"},
						   set =  {"globalVar", interface="service.interactivity", var="true" } }
	},
	link:new{ 	when = { onSelection = {"intOn", keyCode="INFO"} },
				["do"] = { start = {"intOff"},
						   stop = {"intOn"},
						   set =  {"globalVar", interface="service.interactivity", var="false" } }
	}	
	link:new{ 	when = { onSelection = {"intOff", keyCode="INFO"} },
				["do"] = { start = {"intOn"},
						   stop = {"intOff"},
						   set =  {"globalVar", interface="service.interactivity", var="true" } }
	}	
}
context:new{ id="advert",
	media:new{ id="reusedAnimation", refer="animation", instance="instSame", property:new{ name="bounds"} }
	media:new{ id="reusedGlobalVar", refer="globalVar", instance="instSame"}
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
	}
	link:new{ 	when = { onBegin = {"reusedAnimation", interface="segIcon"} }, 
				["do"] = { var =  {"reusedGlobalVar", interface="service.interactivity" }
						   start = {"icon"} }
	}
	link:new{ 	when = { onSelection = {"icon", keyCode="RED"} },
				["do"] = { start = {"shoes"},
						   start = {"form", interface="spForm"},
						   set =  {"reusedAnimation", interface="bounds", var="5%,6.67%,45%,45%" },
						   stop = {"icon"} }
	}
	link:new{ 	when = { onBegin = {"form"} }, 
				["do"] = { set =  {"reusedGlobalVar", interface="service.currentFocus" } }
	}	
	link:new{ 	when = { onEnd = {"form", interface="spForm"} }, 
				["do"] = { set =  {"reusedAnimation", interface="bounds", var="0,0,222.22%,222.22%" } }
	}
}
context:new{ id="menu",
	port:new{ id="pChoro", component="choro"},
	port:new{ id="pChorinho", component="imgChorinho"},
	port:new{ id="pRock", component="imgRock"},
	port:new{ id="pTechno", component="imgTechno"},
	port:new{ id="pCartoon", component="imgCartoon"},
	port:new{ id="pNCLua", component="changes"},
	media:new{ id="changes", src="../script/counter.lua", descriptor="changesDesc",
		area:new{ id="print", label="fim"},
		property:new{ name="add"}
	}
	media:new{ id="imgChorinho", src="../media/chorinho.png", descriptor="chorinhoDesc"},
	media:new{ id="imgRock", src="../media/rock.png", descriptor="rockDesc"},
	media:new{ id="imgTechno", src="../media/techno.png", descriptor="technoDesc"},
	media:new{ id="imgCartoon", src="../media/cartoon.png", descriptor="cartoonDesc"},
	media:new{ id="choro", src="../media/choro.mp4", descriptor="audioDesc",
		property:new{ name="soundLevel", value="1"}
	}	
	switch:new{ id="musics",
		bindRule:new{ constituent="rock", rule="rRock"},
		bindRule:new{ constituent="techno", rule="rTechno"},
		bindRule:new{ constituent="cartoon", rule="rCartoon"},
		media:new{ id="rock", src="../media/rock.mp4"},
		media:new{ id="techno", src="../media/techno.mp4"},
		media:new{ id="cartoon", src="../media/cartoon.mp4"}
	}
	link:new{ 	when = { onSelection = {"imgChorinho"} },
				["do"] = { set =  {"choro", interface="soundLevel", var="1" },
						   set =  {"changes", interface="add", var="1" },	
						   stop = {"musics"} }
	}
	link:new{ 	when = { onSelection = {"imgRock"}, 
						 onSelection = {"imgTechno"},
						 onSelection = {"imgCartoon"} },
				["do"] = { set =  {"choro", interface="soundLevel", var="0" },
						   set =  {"changes", interface="add", var="1" },	
						   stop = {"musics"},
						   start = {"musics"} }
	}
}
link:new{ 	when = { onBegin = {"animation"} }, 
			["do"] = { start =  {"background", delay="5s" },
					   start =  {"menu", delay="5s" } }
}
link:new{	when = { onBegin = {"animation", interface="segDrible"} }, ["do"] = { start = {"drible"} } },
link:new{	when = { onBegin = {"animation", interface="segPhoto"} }, 
			["do"] = { start = {"photo"} 
					   set = {"photo", interface="top", bindParam={var="290", delay ="1s", duration="3s"} }	} 
}
link:new{ when = { onEnd = {"animation"}, interface="segLua" }, ["do"] = { start = {"newChanges", interface="print"} } },
link:new{ when = { onEnd = {"animation"}, interface="segCred" }, ["do"] = { stop = {"menu"} } },
link:new{ when = { onEnd = {"animation"} }, ["do"] = { stop = {"background"}, stop = {"interactivity"} } },
Lua2NCL:Translate()


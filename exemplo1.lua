Lua2NCL = require("Lua2NCL/Lua2NCL")
head:new {
		rule:new{ id="en", var="system.language", value="en", comparator="eq"},
		rule:new{ id="rRock", var="service.currentFocus", value="3", comparator="eq"},
		rule:new{ id="rTechno", var="service.currentFocus", value="4", comparator="eq"},
		rule:new{ id="rCartoon", var="service.currentFocus", value="5", comparator="eq"},
		transition:new{ id="trans1", type="fade", dur="2s"},
		transition:new{ id="trans2", type="barWipe", dur="1s"},
		region:new{ id= "reg1", width = "100%", height = "100%"},
		descriptor:new{ id ="desc1", region = "reg1"},
		connectorBase:new{ documentURI= "ConnectorBase.ncl", alias= "con"}
}
media:new{ id ="img1", src = "medias/img1.jpg", descriptor="desc1", property:new{name="explicitDur", value= "3s"} }
media:new{ id ="img2", src = "medias/img2.jpg", descriptor="desc1", property:new{name="explicitDur", value= "3s"} }
media:new{ id ="img3", src = "medias/img3.png", descriptor="desc1", area:new{id="anchor1", begin="1s", ["end"]="3s"} }
port:new{ id = "p1", component = "img1"}

link:new{ when = { onEnd = {"img1"} }, ["do"] = { start = {"img2"} } }


link:new{ when = { onEnd = {"img2"} }, ["do"] = { start = {"img3"} } }
link:new{ when = { onEnd = {"img3", interface="anchor1"} }, ["do"] = { start = {"img1"} } }
Lua2NCL:Translate()


SNCLua = require("SNCLua/SNCLua")

head:new {
		region:new{ id= "reg1", width = "100%", height = "100%"},

		descriptor:new{ id ="desc1", region = "reg1"},

		importConnector:new{ documentURI= "ConnectorBase.ncl", alias= "con"}
}

media:new{ id ="img1", property = {name="explicitDur", value= "3s"}, src = "medias/img1.jpg", descriptor="desc1" }
media:new{ id ="img2", property = {name="explicitDur", value= "3s"}, src = "medias/img2.jpg", descriptor="desc1" }
media:new{ id ="img3", property = {name="explicitDur", value= "3s"}, src = "medias/img3.png", descriptor="desc1" }

port:new{ id = "p1", component = "img1"}

link:new{ when = { ["end"] = {"img1"} }, ["do"] = { start = {"img2"} } }
link:new{ when = { ["end"] = {"img2"} }, ["do"] = { start = {"img3"} } }
link:new{ when = { ["end"] = {"img3"} }, ["do"] = { start = {"img1"} } }

SNCLua:Translate()


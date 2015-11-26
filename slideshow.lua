SNCLua = require ("SNCLua/SNCLua")

head:new {
		region:new{ id= "reg1", width = "100%", height = "100%"},

		descriptor:new{ id ="desc1", region = "reg1"},

		importConnector:new{ documentURI= "ConnectorBase.ncl", alias= "con"}
}

media:new{ id ="img1", src = "medias/img1.jpg", descriptor="desc1" }
media:new{ id ="img2", src = "medias/img2.jpg", descriptor="desc1" }
media:new{ id ="img3", src = "medias/img3.png", descriptor="desc1" }

port:new{ id = "p1", component = "img1"}

link:new{ when = { ["selection"] = {"img1", keyCode="CURSOR_RIGHT"} }, ["do"] = {stop = {"img1"}, start = {"img2"}} }
link:new{ when = { ["selection"] = {"img2", keyCode="CURSOR_RIGHT"} }, ["do"] = {stop = {"img2"}, start = {"img3"}} }
link:new{ when = { ["selection"] = {"img3", keyCode="CURSOR_RIGHT"} }, ["do"] = {stop = {"img3"}, start = {"img1"}} }

link:new{ when = { ["selection"] = {"img1", keyCode="CURSOR_LEFT"} }, ["do"] = {stop = {"img1"}, start = {"img3"}} }
link:new{ when = { ["selection"] = {"img2", keyCode="CURSOR_LEFT"} }, ["do"] = {stop = {"img2"}, start = {"img1"}} }
link:new{ when = { ["selection"] = {"img3", keyCode="CURSOR_LEFT"} }, ["do"] = {stop = {"img3"}, start = {"img2"}} }

SNCLua:Translate()


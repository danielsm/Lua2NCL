SNCLua = require ("SNCLua")

region:new{id= "reg1", left="40%", width = "100%", height = "100%"}

descriptor:new{id ="desc1", region = "reg1"} 

connector:new{ documentURI= "connectorBase.ncl", alias= "con"}

media:new{ id ="img1", src = "a/dad.ada", descriptor="desc1" }
-- media:new{ id ="img2", src = "a/dad.ada", descriptor="desc1" }
-- media:new{ id ="img3", src = "a/dad.ada", descriptor="desc1" }

-- port:new{id = "p1", component = "img1"}

-- link:new { when = { ["end"] = {"img1"} }, ["do"] = { stop = {"img2"} }  }
-- link:new{ when = { begin = {"img1"} }, ["do"] = { stop = {"img2", "img3"} } }
-- link:new { when = { selection = {"img"} }, ["do"] = { start = {"img3"} } }

SNCLua:Translate()




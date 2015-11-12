<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="reg1" height="100%" width="100%" left="40%" />
		</regionBase>

		<descriptorBase>
			<descriptor id="desc1" region="reg1" />
		</descriptorBase>

		<connectorBase>
			<importBase documentURI="connectorBase.ncl" alias="con"/>
		</connectorBase>

	</head>
	<body>
		<media id="img1" descriptor="desc1" src="a/dad.ada" >
			<area id="areaVideo" end="8s" begin="3s" />
		</media>

	</body>
</ncl>
<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region width="100%" id="reg1" height="100%" />
		</regionBase>

		<descriptorBase>
			<descriptor id="desc1" region="reg1" />
		</descriptorBase>

		<connectorBase>
			<importBase documentURI="ConnectorBase.ncl" alias="con"/>
		</connectorBase>

	</head>
	<body>
		<media descriptor="desc1" src="medias/img1.jpg" id="img1" >
			<property name="explicitDur" value="3s" />
		</media>

		<media descriptor="desc1" src="medias/img2.jpg" id="img2" >
			<property name="explicitDur" value="3s" />
		</media>

		<media descriptor="desc1" src="medias/img3.png" id="img3" >
			<property name="explicitDur" value="3s" />
		</media>

		<port id="p1" component="img1" />

		<link xconnector="con#onEndStartN">
			<bind role="onEnd" component="img1"/>
			<bind role="start" component="img2"/>
		</link>

		<link xconnector="con#onEndStartN">
			<bind role="onEnd" component="img2"/>
			<bind role="start" component="img3"/>
		</link>

		<link xconnector="con#onEndStartN">
			<bind role="onEnd" component="img3"/>
			<bind role="start" component="img1"/>
		</link>

	</body>
</ncl>
<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="reg1" height="100%" width="100%" />
		</regionBase>

		<descriptorBase>
			<descriptor region="reg1" id="desc1" />
		</descriptorBase>

		<connectorBase>
			<importBase documentURI="ConnectorBase.ncl" alias="con"/>
		</connectorBase>

	</head>
	<body>
		<media descriptor="desc1" id="img1" src="medias/img1.jpg" >
			<property name="explicitDur" value="3s" />
		</media>

		<media descriptor="desc1" id="img2" src="medias/img2.jpg" >
			<property name="explicitDur" value="3s" />
		</media>

		<media descriptor="desc1" id="img3" src="medias/img3.png" >
			<property name="explicitDur" value="3s" />
		</media>

		<port component="img1" id="p1" />

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
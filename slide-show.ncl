<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region height="100%" width="100%" id="reg1" />
		</regionBase>

		<descriptorBase>
			<descriptor region="reg1" id="desc1" />
		</descriptorBase>

		<connectorBase>
			<importBase documentURI="ConnectorBase.ncl" alias="con"/>
		</connectorBase>

	</head>
	<body>
		<media src="medias/img1.jpg" descriptor="desc1" id="img1" />

		<media src="medias/img2.jpg" descriptor="desc1" id="img2" />

		<media src="medias/img3.png" descriptor="desc1" id="img3" />

		<port component="img1" id="p1" />

		<link xconnector="con#onKeySelectionStopNStartN">
			<bind role="onSelection" component="img1">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="stop" component="img1"/>
			<bind role="start" component="img2"/>
		</link>

		<link xconnector="con#onKeySelectionStopNStartN">
			<bind role="onSelection" component="img2">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="stop" component="img2"/>
			<bind role="start" component="img3"/>
		</link>

		<link xconnector="con#onKeySelectionStopNStartN">
			<bind role="onSelection" component="img3">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="stop" component="img3"/>
			<bind role="start" component="img1"/>
		</link>

		<link xconnector="con#onKeySelectionStopNStartN">
			<bind role="onSelection" component="img1">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>
			<bind role="stop" component="img1"/>
			<bind role="start" component="img3"/>
		</link>

		<link xconnector="con#onKeySelectionStopNStartN">
			<bind role="onSelection" component="img2">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>
			<bind role="stop" component="img2"/>
			<bind role="start" component="img1"/>
		</link>

		<link xconnector="con#onKeySelectionStopNStartN">
			<bind role="onSelection" component="img3">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>
			<bind role="stop" component="img3"/>
			<bind role="start" component="img2"/>
		</link>

	</body>
</ncl>
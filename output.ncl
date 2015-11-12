<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="reg1" height="100%" width="100%" />
		</regionBase>

		<descriptorBase>
			<descriptor id="desc1" region="reg1" />
		</descriptorBase>

		<connectorBase>
			<importBase documentURI="ConnectorBase.ncl" alias="con"/>
		</connectorBase>

	</head>
	<body>
		<media id="img1" src="medias/img1.jpg" descriptor="desc1" />

		<media id="img2" src="medias/img2.jpg" descriptor="desc1" />

		<media id="img3" src="medias/img3.jpg" descriptor="desc1" />

		<port id="p1" component="img1" />

		<link xconnector="con#onKeySelectionStartNStopN">
			<bind role="onSelection" component="img1">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="start" component="img2"/>
			<bind role="stop" component="img1"/>
		</link>

		<link xconnector="con#onKeySelectionStartNStopN">
			<bind role="onSelection" component="img2">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="start" component="img3"/>
			<bind role="stop" component="img2"/>
		</link>

		<link xconnector="con#onKeySelectionStartNStopN">
			<bind role="onSelection" component="img3">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="start" component="img1"/>
			<bind role="stop" component="img3"/>
		</link>

		<link xconnector="con#onKeySelectionStartNStopN">
			<bind role="onSelection" component="img1">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>
			<bind role="start" component="img3"/>
			<bind role="stop" component="img1"/>
		</link>

		<link xconnector="con#onKeySelectionStartNStopN">
			<bind role="onSelection" component="img2">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>
			<bind role="start" component="img1"/>
			<bind role="stop" component="img2"/>
		</link>

		<link xconnector="con#onKeySelectionStartNStopN">
			<bind role="onSelection" component="img3">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>
			<bind role="start" component="img2"/>
			<bind role="stop" component="img3"/>
		</link>

	</body>
</ncl>
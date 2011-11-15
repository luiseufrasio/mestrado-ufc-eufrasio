<%@page
	import="de.fuberlin.wiwiss.d2rq.dbschema.DatabaseSchemaInspector"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Easy RDB to RDF Mapping</title>
<%
	String url = "", driver = "", user = "";
	File f = new File("conn.properties");

	if (f.exists()) {
		Properties p = new Properties();
		p.load(new FileInputStream(f));
		url = p.getProperty("url");
		driver = p.getProperty("driver");
		user = p.getProperty("user");
	}
%>
</head>
<body>
	<h1>Easy RDB to RDF Mapping</h1>
	<h4>Phases:</h4>
	<ol>
		<li><a href="pages/configDatabase.jsp">Database Configuration</a>
		</li>
		<li><a href="pages/importOntologies.jsp">Ontologies
				Configuration</a>
		</li>
		<li><a href="pages/configMapping.jsp">Mapping Configuration</a>
		</li>
		<li><a href="pages/generateMapping.jsp">Mapping Generation</a>
		</li>
	</ol>
</body>
</html>
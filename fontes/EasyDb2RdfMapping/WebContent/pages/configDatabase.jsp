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

	if (request.getParameter("msg") != null) {
		response.getWriter()
				.write("<script type='text/javascript'>window.alert('Database configuration required!')</script>");
	}
%>
</head>
<body>
	<h1>Easy RDB to RDF Mapping</h1>
	<h4>Phases:</h4>
	<ol>
		<li>Database Configuration</li>
		<li><a href="importOntologies.jsp">Ontologies Configuration</a></li>
		<li><a href="configMapping.jsp">Mapping Configuration</a></li>
		<li><a href="generateMapping.jsp">Mapping Generation</a></li>
	</ol>

	<hr>

	<form action="../ConnectDatabase" method="post">
		<h4>Database Configuration</h4>
		<table>
			<tr>
				<td align="right">url:</td>
				<td align="left"><input type="text" name="url" value="<%=url%>"
					size="30" /></td>
			</tr>
			<tr>
				<td align="right">driver:</td>
				<td align="left"><input type="text" name="driver"
					value="<%=driver%>" size="30" /></td>
			</tr>
			<tr>
				<td align="right">user:</td>
				<td align="left"><input type="text" name="user"
					value="<%=user%>" size="30" /></td>
			</tr>
			<tr>
				<td align="right">password:</td>
				<td align="left"><input type="password" name="password" size="30" />
				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td align="left"><input type="submit" value="Send" /></td>
			</tr>
		</table>
	</form>
</body>
</html>
<%@page import="de.fuberlin.wiwiss.d2rq.algebra.Attribute"%>
<%@page import="de.fuberlin.wiwiss.d2rq.algebra.RelationName"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.List"%>
<%@page
	import="de.fuberlin.wiwiss.d2rq.dbschema.DatabaseSchemaInspector"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Easy RDB to RDF Mapping</title>
<%
	Object o = session.getAttribute("schema");
	if (o != null) {
		DatabaseSchemaInspector schema = (DatabaseSchemaInspector) o;
	} else {
		response.sendRedirect("configDatabase.jsp?msg=true");
	}
%>
<script type="text/javascript" src="../javascripts/jquery-1.7.js"></script>
</head>
<body>
	<h1>Easy RDB to RDF Mapping</h1>
	<h4>Phases:</h4>
	<ol>
		<li><a href="configDatabase.jsp">Database Configuration</a></li>
		<li><a href="importOntologies.jsp">Ontologies Configuration</a>
		<li>Mapping Configuration</li>
		<li><a href="generateMapping.jsp">Mapping Generation</a>
		</li>
	</ol>

	<hr>

	<form action="ConfigMapping" method="post">
		<h4>Mapping Configuration</h4>
		<h5>Type:
		<select name="type" id="slcType">
					<option value="1">Table to Class without constraint</option>
					<option value="2">Table to Class with constraint</option>
		</select>
		<script type="text/javascript">
			$("#slcType").change(function () {
				$("#slcType option:selected").each(function() {
					var i = $(this).val();
					
					for (var j = 1; j <=2; j++) {
						if (j == i) {
							$("#tbl" + j).css("display", "inline");
						} else {
							$("#tbl" + j).css("display", "none");
						}
					}
				});
			}).change();
		</script>
		</h5>

		<table id="tbl1" style="display: inline">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>Class</th>
				<th></th>
				<th>Table</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right">
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class">
				</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="table">
						<%
							DatabaseSchemaInspector schema = (DatabaseSchemaInspector) session
									.getAttribute("schema");
							List<RelationName> tables = schema.listTableNames();
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
		<table id="tbl2" style="display: none;">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>Class</th>
				<th></th>
				<th>Table</th>
				<th></th>
				<th>column</th>
				<th></th>
				<th>value</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right">
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class">
				</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="table" id="slcTables2">
						<%
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select>
				<script type="text/javascript">
					$("#slcTables2").change(function () {
						$("#slcTables2 option:selected").each(function() {
							var tableName = $(this).val();
						
							$.ajax({
								url: '../GetColumns?tableName=' + tableName,
								cache: false,
								success: function(data) {
									$("#cols2").find("option").remove().end();
									
									var listCols = data.split(",");
									for (var i = 0; i < listCols.length; i++) {
										$("#cols2").append("<option value='" 
												+ listCols[i] +"'>" 
												+ listCols[i] +"</option>");
									}
								}
							});
						});
					}).change();
				</script>
				</td>
				<td>,&nbsp;</td>
				<td><select name="column" id="cols2">
				</select></td>
				<td>=</td>
				<td><input type="text" name="colValue"></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
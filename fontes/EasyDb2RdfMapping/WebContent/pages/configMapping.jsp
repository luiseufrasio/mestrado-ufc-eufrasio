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
<script type="text/javascript" src="../javascripts/simpleAutoComplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/simpleAutoComplete.css" />
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
			<option value="3">Direct Table Column to DataProperty</option>
			<option value="4">Indirect Table Column to DataProperty</option>
			<option value="5">Table Column to Class without constraint</option>
			<option value="6">Table Column to Class with constraint</option>
			<option value="7">Table Column to ObjectProperty</option>
			<option value="8">Table Column to ObjectProperty using URI</option>
		</select>
		<script type="text/javascript">
			$("#slcType").change(function () {
				$("#slcType option:selected").each(function() {
					var i = $(this).val();
					
					for (var j = 1; j <= 8; j++) {
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
					style="text-align: right" id="prefixClass1">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass1").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class" id="nameClass1">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#nameClass1").simpleAutoComplete("../GetClasses");
					});
				</script>
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
				<th>constraint column</th>
				<th></th>
				<th>value</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right" id="prefixClass2">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass2").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class" id="nameClass2">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#nameClass2").simpleAutoComplete("../GetClasses");
					});
				</script>
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
				<td><select name="column" id="cols2" style="width: 100%">
				</select></td>
				<td>=</td>
				<td><input type="text" name="colValue"></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
		<table id="tbl3" style="display: none;">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>Class</th>
				<th></th>
				<th>dataProperty</th>
				<th></th>
				<th>Table</th>
				<th></th>
				<th>column</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right" id="prefixClass3">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass3").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class" id="nameClass3">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#nameClass3").simpleAutoComplete("../GetClasses");
					});
				</script>
				</td>
				<td>.</td>
				<td align="left"><input type="text" name="dataProperty">
				</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="table" id="slcTables3">
						<%
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select>
				<script type="text/javascript">
					$("#slcTables3").change(function () {
						$("#slcTables3 option:selected").each(function() {
							var tableName = $(this).val();
						
							$.ajax({
								url: '../GetColumns?tableName=' + tableName,
								cache: false,
								success: function(data) {
									$("#cols3").find("option").remove().end();
									
									var listCols = data.split(",");
									for (var i = 0; i < listCols.length; i++) {
										$("#cols3").append("<option value='" 
												+ listCols[i] +"'>" 
												+ listCols[i] +"</option>");
									}
								}
							});
						});
					}).change();
				</script>
				</td>
				<td>.</td>
				<td><select name="column" id="cols3">
				</select></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
		<table id="tbl4" style="display: none;">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>Class</th>
				<th></th>
				<th>dataProperty</th>
				<th></th>
				<th>Source Table</th>
				<th></th>
				<th>Target Table</th>
				<th></th>
				<th>column</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right" id="prefixClass4">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass4").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class" id="nameClass4">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#nameClass4").simpleAutoComplete("../GetClasses");
					});
				</script>
				</td>
				<td>.</td>
				<td align="left"><input type="text" name="dataProperty">
				</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="srcTable" id="slcSrcTables4" style="width: 100%;">
						<%
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select>
				<script type="text/javascript">
					$("#slcSrcTables4").change(function () {
						$("#slcSrcTables4 option:selected").each(function() {
							var tableName = $(this).val();
						
							$("#slcTables4").find("option").remove().end();
							var listTables = $("#slcSrcTables4").find("option");
							for (var i = 0; i < listTables.length; i++) {
								var option = listTables[i];
								if ($(option).val() != tableName) {
									$("#slcTables4").append("<option value='" 
											+ $(option).val() +"'>" 
											+ $(option).val() +"</option>");
								}
							}
						});
					}).change();
				</script>
				</td>
				<td>-</td>
				<td><select name="table" id="slcTables4" style="width: 100%;">
						<%
							int i = 0;
							for (RelationName table : tables) {
								if (i > 0) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
								} else {
									i++;
								}
							}
						%>
				</select>
				<script type="text/javascript">
					$("#slcTables4").change(function () {
						$("#slcTables4 option:selected").each(function() {
							var tableName = $(this).val();
						
							$.ajax({
								url: '../GetColumns?tableName=' + tableName,
								cache: false,
								success: function(data) {
									$("#cols4").find("option").remove().end();
									
									var listCols = data.split(",");
									for (var i = 0; i < listCols.length; i++) {
										$("#cols4").append("<option value='" 
												+ listCols[i] +"'>" 
												+ listCols[i] +"</option>");
									}
								}
							});
						});
					}).change();
				</script>
				</td>
				<td>.</td>
				<td><select name="column" id="cols4">
				</select></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
		<table id="tbl5" style="display: none;">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>Class</th>
				<th></th>
				<th>Table</th>
				<th></th>
				<th>column</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right" id="prefixClass5">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass5").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class" id="nameClass5">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#nameClass5").simpleAutoComplete("../GetClasses");
					});
				</script>
				</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="table" id="slcTables5" style="width: 100%;">
						<%
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select>
				<script type="text/javascript">
					$("#slcTables5").change(function () {
						$("#slcTables5 option:selected").each(function() {
							var tableName = $(this).val();
						
							$.ajax({
								url: '../GetColumns?tableName=' + tableName,
								cache: false,
								success: function(data) {
									$("#cols5").find("option").remove().end();
									
									var listCols = data.split(",");
									for (var i = 0; i < listCols.length; i++) {
										$("#cols5").append("<option value='" 
												+ listCols[i] +"'>" 
												+ listCols[i] +"</option>");
									}
								}
							});
						});
					}).change();
				</script>
				</td>
				<td>.</td>
				<td><select name="column" id="cols5">
				</select></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
		<table id="tbl6" style="display: none;">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>Class</th>
				<th></th>
				<th>Table</th>
				<th></th>
				<th>column</th>
				<th></th>
				<th>constraint column</th>
				<th></th>
				<th>value</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right" id="prefixClass6">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass6").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="class" id="nameClass6">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#nameClass6").simpleAutoComplete("../GetClasses");
					});
				</script>
				</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="table" id="slcTables6" style="width: 100%;">
						<%
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select>
				<script type="text/javascript">
					$("#slcTables6").change(function () {
						$("#slcTables6 option:selected").each(function() {
							var tableName = $(this).val();
						
							$.ajax({
								url: '../GetColumns?tableName=' + tableName,
								cache: false,
								success: function(data) {
									$("#cols6").find("option").remove().end();
									$("#ccols6").find("option").remove().end();
									
									var listCols = data.split(",");
									for (var i = 0; i < listCols.length; i++) {
										$("#cols6").append("<option value='" 
												+ listCols[i] +"'>" 
												+ listCols[i] +"</option>");
										$("#ccols6").append("<option value='" 
												+ listCols[i] +"'>" 
												+ listCols[i] +"</option>");
									}
								}
							});
						});
					}).change();
				</script>
				</td>
				<td>.</td>
				<td><select name="column" id="cols6">
				</select></td>
				<td>,&nbsp;</td>
				<td><select name="ccolumn" id="ccols6" style="width: 100%">
				</select></td>
				<td>=</td>
				<td><input type="text" name="colValue"></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
		<table id="tbl7" style="display: none;">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>objectProperty</th>
				<th></th>
				<th>Domain Class</th>
				<th></th>
				<th>Range Class</th>
				<th></th>
				<th></th>
				<th>Domain Table</th>
				<th></th>
				<th>Range Table</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right" id="prefixClass7">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass7").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="objProperty">
				</td>
				<td>(</td>
				<td align="right"><input type="text" name="domainClass">
				</td>
				<td>,&nbsp;</td>
				<td align="left"><input type="text" name="rangeClass">
				</td>
				<td>)</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="table" id="slcDomainTables7" style="width: 100%;">
						<%
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select>
				</td>
				<td>-</td>
				<td><select name="table" id="slcRangeTables7" style="width: 100%;">
						<%
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
		<table id="tbl8" style="display: none;">
			<tr>
				<th>prefix</th>
				<th></th>
				<th>objectProperty</th>
				<th></th>
				<th>Domain Class</th>
				<th></th>
				<th>Range Class</th>
				<th></th>
				<th></th>
				<th>Range Table</th>
				<th></th>
				<th>column</th>
				<th></th>
			</tr>
			<tr>
				<td align="right"><input type="text" name="prefix"
					style="text-align: right" id="prefixClass8">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass8").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
				<td>:</td>
				<td align="left"><input type="text" name="objProperty">
				</td>
				<td>(</td>
				<td align="right"><input type="text" name="domainClass">
				</td>
				<td>,&nbsp;</td>
				<td align="left"><input type="text" name="rangeClass">
				</td>
				<td>)</td>
				<td><img src="../images/seta.jpg">
				</td>
				<td><select name="table" id="slcRangeTables8" style="width: 100%;">
						<%
							for (RelationName table : tables) {
						%>
						<option value="<%=table.tableName()%>"><%=table.tableName()%></option>
						<%
							}
						%>
				</select>
				<script type="text/javascript">
					$("#slcRangeTables8").change(function () {
						$("#slcRangeTables8 option:selected").each(function() {
							var tableName = $(this).val();
						
							$.ajax({
								url: '../GetColumns?tableName=' + tableName,
								cache: false,
								success: function(data) {
									$("#cols8").find("option").remove().end();
									
									var listCols = data.split(",");
									for (var i = 0; i < listCols.length; i++) {
										$("#cols8").append("<option value='" 
												+ listCols[i] +"'>" 
												+ listCols[i] +"</option>");
									}
								}
							});
						});
					}).change();
				</script>
				</td>
				<td>.</td>
				<td><select name="column" id="cols8">
				</select></td>
				<td><input type="button" value="Add">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
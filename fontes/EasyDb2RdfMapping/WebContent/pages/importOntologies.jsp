<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Easy RDB to RDF Mapping</title>
<script type="text/javascript" src="../javascripts/jquery-1.7.js"></script>
<script type="text/javascript" src="../javascripts/simpleAutoComplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/simpleAutoComplete.css" />
<script type="text/javascript">
	function openClose(icon, table) {
		if (icon.src.indexOf('close.jpg') != -1) {
			icon.src = '../images/open.jpg';
			$("#" + table).css("display","none");
		} else {
			icon.src = '../images/close.jpg';
			$("#" + table).css("display","inline");
		}
	}
	
	function removeRow(button, param, type) {
		var answer = confirm('Delete this ' + type + '?');
		if (answer) {
			$(button).parent().parent().remove();
			
			if (type == 'Ontology') {
				$.ajax({
					url: '../DelOntology?prefix=' + param,
					cache: false,
					success: function(data) {
						if (data != 'ok') {
							alert('ERRO: ' + result);
						}				
					}
				});
			} else if (type == 'Class') {
				$.ajax({
					url: '../DelClass?id=' + param,
					cache: false,
					success: function(data) {
						if (data != 'ok') {
							alert('ERRO: ' + result);
						}				
					}
				});
			} else if (type == 'DataProperty') {
				$.ajax({
					url: '../DelDataProperty?id=' + param,
					cache: false,
					success: function(data) {
						if (data != 'ok') {
							alert('ERRO: ' + result);
						}				
					}
				});
			}
		}
	}
	
	function showDomains(id, radio) {
		$(radio).parent().parent().parent().children().css('background-color','white');
		$(radio).parent().parent().css('background-color','lightblue');
		
		$.ajax({
			url: '../GetDomains?id=' + id,
			cache: false,
			success: function(data) {
				$("#tblDomains").append(data);
			}
		});
	}
</script>
</head>
<body>
	<h1>Easy RDB to RDF Mapping</h1>
	<h4>Phases:</h4>
	<ol>
		<li><a href="configDatabase.jsp">Database Configuration</a>
		</li>
		<li>Ontologies Configuration</li>
		<li><a href="configMapping.jsp">Mapping Configuration</a></li>
		<li><a href="generateMapping.jsp">Mapping Generation</a></li>
	</ol>

	<hr>

	<h4>Ontologies Configuration</h4>
	
	<h5><a href="#"><img alt="open" src="../images/open.jpg" border="0" 
		onclick="javascript: openClose(this, 'divOntology');"></a> New Ontology</h5>
	<div id="divOntology" style="display: none;">
	<table>
		<tr>
			<th align="right">prefix</th>
			<td><input type="text" name="prefix" maxlength="20" id="txtPrefix" maxlength="20"></td>
		</tr>
		<tr>
			<th align="right">uri</th>
			<td><input type="text" name="uri" size="50" id="txtUri"></td>
		</tr>
		<tr>
			<th align="right"></th>
			<td><input type="button" value="Add" id="btnAddOntology">
				<script type="text/javascript">
				$("#btnAddOntology").click(function () {
					$.ajax({
						url: '../AddOntology?prefix=' + $("#txtPrefix").val() 
								+ '&uri=' + $("#txtUri").val(),
						cache: false,
						success: function(data) {
							if (data == 'ok') {
								$("#tblOntologies").append("<tr>" 
									+ "<td>" + $("#txtPrefix").val() + "</td>" 
									+ "<td>" + $("#txtUri").val() + "</td>"
									+ "<td align=\"center\"><a href=\"#\" onclick=\"javascript: removeRow(this, '" 
									+ $("#txtPrefix").val() + "', 'Ontology');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
									+ "</tr>");
							} else {
								alert('ERRO: ' + data);
							}
						}
					});
				});
				</script>
			</td>
		</tr>
		<tr>
	</table>
	<table border="1" id="tblOntologies">
		<tr>
			<th>prefix</th>
			<th>uri</th>
			<th>remove
			<script type="text/javascript">
				$.ajax({
					url: '../GetOntologies',
					cache: false,
					success: function(data) {
						$("#tblOntologies").append(data);
					}
				});
			</script>
			</th>
		</tr>
	</table>
	</div>
	
	<h5><a href="#"><img border="0" alt="open" src="../images/open.jpg" onclick="javascript: openClose(this, 'divClass');"></a> New Class</h5>
	<div id="divClass" style="display: none;">
	<table id="tblClass">
		<tr>
			<th align="right">prefix</th>
			<td><input type="text" name="prefix" maxlength="20" id="txtPrefixClass">
			<script type="text/javascript">
				$(document).ready(function(){
					$("#txtPrefixClass").simpleAutoComplete("../GetOntologies");
				});
			</script>
			</td>
		</tr>
		<tr>
			<th align="right">name</th>
			<td><input type="text" name="name" maxlength="50" id="txtNameClass"></td>
		</tr>
		<tr>
			<th align="right"></th>
			<td><input type="button" value="Add" id="btnAddClass">
			<script type="text/javascript">
				$("#btnAddClass").click(function () {
					$.ajax({
						url: '../AddClass?prefix=' + $("#txtPrefixClass").val() 
								+ '&name=' + $("#txtNameClass").val(),
						cache: false,
						success: function(data) {
							if (data != 'erro') {
								$("#tblClasses").append("<tr>" 
									+ "<td>" + $("#txtPrefixClass").val() + "</td>" 
									+ "<td>" + $("#txtNameClass").val() + "</td>"
									+ "<td align=\"center\"><a href=\"#\" onclick=\"javascript: removeRow(this, '" 
									+ data + "', 'Class');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
									+ "</tr>");
							} else {
								alert('ERRO: ' + data);
							}
						}
					});
				});
			</script>
			</td>
		</tr>
	</table>
	
	<table border="1" id="tblClasses">
		<tr>
			<th>prefix</th>
			<th>name</th>
			<th>remove
			<script type="text/javascript">
				$.ajax({
					url: '../GetClasses',
					cache: false,
					success: function(data) {
						$("#tblClasses").append(data);
					}
				});
			</script>
			</th>
		</tr>
	</table>
	</div>
		
	<h5><a href="#"><img border="0" alt="open" src="../images/open.jpg" onclick="javascript: openClose(this, 'divDataProperty');"></a> New DataProperty</h5>
	<div id="divDataProperty" style="display: none;">
	<table id="tblDataProperty">
		<tr>
			<th align="right">prefix</th>
			<td><input type="text" name="prefix" maxlength="20" id="txtPrefixDataProperty">*
			<script type="text/javascript">
				$(document).ready(function(){
					$("#txtPrefixDataProperty").simpleAutoComplete("../GetOntologies");
				});
			</script>
			</td>
		</tr>
		<tr>
			<th align="right">name</th>
			<td><input type="text" name="name" size="20" maxlength="50" id="txtNameDataProperty">*</td>
		</tr>
		<tr>
			<th align="right">domain prefix.class</th>
			<td><input type="text" size="7" maxlength="50" id="txtPrefixDomain">.<input type="text" size="7" maxlength="50" id="txtClassDomain">
			<script type="text/javascript">
				$(document).ready(function(){
					$("#txtPrefixDomain").simpleAutoComplete("../GetOntologies");
					$("#txtClassDomain").simpleAutoComplete("../GetClasses");
				});
			</script>
			</td>
		</tr>
		<tr>
			<th align="right">literal</th>
			<td><input type="text" name="name" maxlength="50" id="txtLiteralDataProperty"></td>
		</tr>
		<tr>
			<th align="right"></th>
			<td><input type="button" value="Add" id="btnAddDataProperty">
			<script type="text/javascript">
				$("#btnAddDataProperty").click(function () {
					$.ajax({
						url: '../AddDataProperty?prefix=' + $("#txtPrefixDataProperty").val() 
								+ '&name=' + $("#txtNameDataProperty").val()
								+ '&domainPrefix=' + $("#txtPrefixDomain").val()
								+ '&domainClass=' + $("#txtClassDomain").val()
								+ '&literal=' + $("#txtLiteralDataProperty").val(),
						cache: false,
						success: function(data) {
							if (data != 'erro') {
								$("#tblDataProperties").append("<tr>" 
									+ "<td>" + $("#txtPrefixDataProperty").val() + "</td>" 
									+ "<td>" + $("#txtNameDataProperty").val() + "</td>"
									+ "<td align='center'><input type=\"radio\" name=\"rDomains\" onclick=\"showDomains('" 
											+ data + "', this)\"></td>"
									+ "<td align=\"center\"><a href=\"#\" onclick=\"javascript: removeRow(this, '" 
									+ data + "', 'DataProperty');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
									+ "</tr>");
							} else {
								alert('ERRO: ' + data);
							}
						}
					});
				});
			</script>
			</td>
		</tr>
	</table>
	
	<table><tr><td>
	
	<table border="1" id="tblDataProperties">
		<tr>
			<th>prefix</th>
			<th>name</th>
			<th>domains</th>
			<th>remove
			<script type="text/javascript">
				$.ajax({
					url: '../GetDataProperties',
					cache: false,
					success: function(data) {
						$("#tblDataProperties").append(data);
					}
				});
			</script>
			</th>
		</tr>
	</table>
	</td>
	
	<td valign="top">
	<table border="1" id="tblDomains">
		<tr>
			<th>domain</th>
			<th>literal</th>
			<th>remove</th>
		</tr>
	</table>
	</td>
	</tr>
	</table>
	
	</div>
</body>
</html>
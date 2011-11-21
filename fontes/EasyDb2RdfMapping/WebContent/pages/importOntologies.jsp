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
	
	function removeRow(button, prefix) {
		var answer = confirm('Delete this ontology?');
		if (answer) {
			$(button).parent().parent().remove();
			
			$.ajax({
				url: '../DelOntology?prefix=' + prefix,
				cache: false,
				success: function(data) {
					if (data != 'ok') {
						alert('ERRO: ' + result);
					}				
				}
			});
		}
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

	<form action="ImportOntologies" method="post">
		<h4>Ontologies Configuration</h4>
		
		<h5><a href="#"><img alt="open" src="../images/open.jpg" border="0" 
			onclick="javascript: openClose(this, 'divOntology');"></a> New Ontology</h5>
		<div id="divOntology" style="display: none;">
		<table>
			<tr>
				<th align="right">prefix</th>
				<td><input type="text" name="prefix" id="txtPrefix"></td>
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
										+ $("#txtPrefix").val() + "');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
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
		
		<h5><a href="#"><img border="0" alt="open" src="../images/open.jpg" onclick="javascript: openClose(this, 'tblClass');"></a> New Class</h5>
		<table id="tblClass" style="display: none;">
			<tr>
				<th align="right">prefix</th>
				<td><input type="text" name="prefix" id="prefixClass">
				<script type="text/javascript">
					$(document).ready(function(){
						$("#prefixClass").simpleAutoComplete("../GetOntologies");
					});
				</script>
				</td>
			</tr>
			<tr>
				<th align="right">name</th>
				<td><input type="text" name="uri" size="50"></td>
			</tr>
			<tr>
				<th align="right"></th>
				<td><input type="button" value="Add"></td>
			</tr>
		</table>
	</form>
</body>
</html>
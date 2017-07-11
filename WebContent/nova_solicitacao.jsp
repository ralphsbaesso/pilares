<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
    
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<c:import url="cabecalho.jsp" />
	
	<table >
		<tr>
			<td style="width:10%">&nbsp</td>
			<!-- Inserir a página aqui a baixo -->
			<td style="witdh:100%">
			
			<form action="//" method="post">
				<label>Solicitação</label>
				<input type="text" id="txtSolicitante" name="txtSolicitante"><br>
				<label>Equipamento</label>
				<select id="cbEquipamento" name="cbEquipamento">
					<option value=""></option>
					<option value="Piano">Piano</option>
					<option value="Violão">Violão</option>
					<option value="Teclado">Teclado</option>
				</select><br>
				<label>Descrição da falha/anomalia</label>
				<input type="text" id="txtDescricao" name="txtDescricao"><br>
				<label>Equipamento</label>
				<select id="cbNivel" name="cbNivel">
					<option value=""></option>
					<option value="A">A</option>
					<option value="B">B</option>
					<option value="C">C</option>
				</select><br>
				<label>Informação auxiliar</label>
				<input type="text" id="txtInformacao" name="txtInformacao">
				
			</form>
		
			</td>
		</tr>
	</table>
	
	<c:import url="rodape.jsp" />
</body>
</html>
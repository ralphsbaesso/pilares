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
	<c:import url="/cabecalho.jsp" />
	
	<table >
		<tr>
			<td style="width:10%">&nbsp</td>
			<!-- Inserir a página aqui a baixo -->
			<td style="witdh:100%">
			
			<form action="ChamaTelas" method="post">
				<input type="submit" id="operacao" name="operacao" value="Nova solicitação">
				<input type="submit" id="operacao" name="operacao" value="Acompanhar solicitação">
				<input type="submit" id="operacao" name="operacao" value="Minhas solicitações">
				
			</form>
		
			</td>
		</tr>
	</table>
	
	<c:import url="/rodape.jsp" />
</body>
</html>
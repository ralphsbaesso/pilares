<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Controle</title>

<script src="jquery2.js" type="text/javascript"></script> 

<script type="text/javascript">
$(document).ready(function(){
	$("input[value = Equipamento]").click(function(){
		alert("Função em implementação!");
	});
});
</script>
</head>
<body>

	<c:import url="cabecalho.jsp" />
	
	<a href="pagina_inicial.jsp">Voltar a Página Inicial</a>
	
	<table >
		<tr>
			<td style="width:10%">&nbsp</td>
			<!-- Inserir a página aqui a baixo -->
			<td>
			<form action="mantenedor.jsp" method="get">
				<input type="submit" id="mantenedor" name="operacao" value="Mantenedores">
			</form>
			</td>
			<td>
				<input type="submit" id="equipamento" name="operacao" value="Equipamento">
			</td>
			<td>
				<form action="ordemdeservico.jsp">
					<input type="submit" id="manutencao" name="operacao" value="Manutenção">
				</form>
			</td>
			<td>
				<form action="planejamento.jsp">
					<input type="submit" id="planejamento" name="operacao" value="Planejamento">
				</form>
			</td>
			<td>
				<form action="apontamento.jsp">
					<input type="submit" id="apontamento" name="operacao" value="Apontamento">
				</form>
			</td>
			<td>
			<form action="especialidade.jsp" method="get">
				<input type="submit" id="especialidade" name="operacao" value="Especialidade">
			</form>
			</td>
			
		</tr>
	</table>
	
	<c:import url="rodape.jsp" />
</body>
</html>
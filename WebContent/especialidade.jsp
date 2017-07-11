<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

	<%@ page import="dominio.*,java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Especialidade</title>
</head>
<body>

<c:import url="cabecalho.jsp" />

<% //variaveis
	Especialidade especialidade = new Especialidade();
	List<Especialidade> especialidades = new ArrayList();
	StringBuilder ctrlDiv = new StringBuilder();
	StringBuilder mensagem = new StringBuilder();
	especialidades = (ArrayList)request.getAttribute("especialidades");
	ctrlDiv.append(request.getAttribute("ctrlDiv"));
	mensagem.append(request.getAttribute("mensagem"));
	
%>

<%--Voltar a página controle --%>
<a href="controle.jsp">Controle</a>

<!-- Títuo -->
<h1>Menu Especialidade</h1>

<!-- *********** -->
<!-- Botões iniciais -->
<%
	if(ctrlDiv.toString().equals("null")){
%>
<div>
<h2>Escoloha a opção</h2>
<form action="Especialidade">
	<table>
	<tbody>
	<tr>
	<td><input type="submit" name="operacao" value="Cadastro"></td>
	<td><input type="submit" name="operacao" value="Procurar"></td>
	<td>
	<input type="submit" name="operacao" value="Listar">
	</form>
	</td>
	</tr>
	</tbody>
	</table>
</form>
</div>
<%	} %>

<!-- *********** -->
<!-- Campo cadastro -->
<%
	if(ctrlDiv.toString().equals("cadastro")){
%>
<div>
<h2>Cadastrar nova Especialidade</h2>
<form action="Especialidade">
	<table>
	<tbody>
	<tr>
	<td><label>Descrição:</label></td>
	<td><input type="text" name="txtDescricao"></td>
	</tr>
	<tr>
	<td><label>Código:</label></td>
	<td><input type="text" name="txtCodigo"></td>
	</tr>
	<tr>
	<td><label>Detalhes:</label>
	<td><input type="text" name="txtDetalhes"></td>
	</td>
	</tr>
	<tr style="height: 10px;"></tr>
	<tr>
	<td></td>
	<td><input type="reset" name="operacao" value="Cancelar"></td>
	<td><input type="submit" name="operacao" value="Salvar"></td>
	</tr>
	</tbody>
	</table>
</form>
</div>
<%	} %>

<!-- *********** -->
<!-- Procura especialidade -->
<%
	if(ctrlDiv.toString().equals("procurar")){
%>
<div>
<form action="Especialidade">
	<label>Digite o Código da especialidade</label>
	<table>
	<tbody>
	<tr>
	<td><label>Código:</label></td>
	<td><input type="text" name="txtCodigo"></td>
	<td><input type="submit" name="operacao" value="Listar"></td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><input type="reset" name="operacao" value="Cancelar"></td>
	</tr>
	</tbody>
	</table>
</form>
</div>
<%	} %>

<!-- *********** -->
<!-- Lista um especialidade para alterar ou excluir -->
<%
	if(ctrlDiv.toString().equals("listar") && especialidades.size() == 1){
		especialidade = especialidades.get(0);
%>
<div>
<form action="Especialidade">
	<table>
	<tbody>
	<tr>
	<td></td>
	<td>Descrição</td>
	<td>Detalhes</td>
	<td></td>
	<td></td>
	</tr>
	<%if(especialidades != null){ %>
	<tr>
	<td><input type="hidden" name="txtCodigo" value="<%=especialidade.getCodigo() %>"></td>
	<td><input type="text" name="txtDescricao" value="<%=especialidade.getDescricao()%>"></td>
	<td><input type="text" name="txtDetalhes" value="<%=especialidade.getDetalhes()%>"></td>
	<td><input type="submit" name="operacao" value="Alterar"></td>
	<td><input type="submit" name="operacao" value="Excluir"></td>
	</tr>
	<%} %>
	</tbody>
	</table>
</form>
</div>
<%	} %>

<!-- *********** -->
<!-- Lista todos especialidades -->
<%
	if(ctrlDiv.toString().equals("listar") && especialidades.size() > 1){		
%>
<div class="divListar">

	<table>
	<thead>
	<tr>
	<td><!-- txtCodigo --></td>
	<th>Descrição</th>
	<th>Detalhes</th>
	<td></td>
	</tr>
	</thead>
	<% 
		if(especialidades != null){
			for(Especialidade esp: especialidades){ 
	%>

	<tbody>
	<form action="Especialidade">
	<tr>
	<td><input type="hidden" name="txtCodigo" value="<%=esp.getCodigo()%>"></td>
	<td><%=esp.getDescricao() %></td>
	<td><%=esp.getDetalhes() %></td>
	<td><input type="submit" name="operacao" value="Listar"></td>
	</tr>
	</form>
	<%	
			}
		}	
	%>
	</tbody>
	</table>
	<strong>Especialidades cadastradas: <%=especialidades.size() %></strong>
</div>
<% } %>

<!-- *********** -->
<!-- Mensagens para usuário -->
<%
	if(!mensagem.toString().equals("null")){
		
%>
<div class="divMensagem">
<label><%=mensagem%></label>
</div>
<% } %>

<!-- *********** -->
<!-- voltar ao menu especialidade -->
<%	if(!ctrlDiv.toString().equals("null")){  %>
<p></p>
<a href="especialidade.jsp">Voltar ao Menu Especialidade</a>
<%	} %>
<c:import url="rodape.jsp" />

</body>
</html>
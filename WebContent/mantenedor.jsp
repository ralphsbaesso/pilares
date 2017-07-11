<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

	<%@ page import="dominio.*,java.util.*, dao.*, dao.implementacao.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Mantenedor</title>

<script src="jquery2.js" type="text/javascript"></script> 
<script type="text/javascript">  
      $(document).ready(function(){
    		// Adiciona novo campo 
       		$(".adicionar").live('click', function(){
       			var clone = $(".trEspecialidade").clone().removeAttr("class");
       			var id = $(".adicionar").index(this);
       			$(".adicionar").eq(id).parent().parent().parent().append(clone);  
	            return false;  
	          })  
	          // Remove o campo  
	          $(".remover").live('click', function(){  
	               var id = $(".remover").index(this);  
	               $(".remover").eq(id).parent().parent().slideUp('fast', function() {  
	                    $(this).remove();  
	               })  
	          })  
    	  
      })
</script>
</head>
<%-- <body bgcolor="#d3d3d0"> --%>

<c:import url="cabecalho.jsp" />


<% //variaveis
	String displayDiv;
	Mantenedor mantenedor = new Mantenedor();
	List<Mantenedor> mantenedores = new ArrayList();
	StringBuilder ctrlDiv = new StringBuilder();
	StringBuilder mensagem = new StringBuilder();
	mantenedores = (ArrayList)request.getAttribute("mantenedores");
	ctrlDiv.append(request.getAttribute("ctrlDiv"));
	mensagem.append(request.getAttribute("mensagem"));
	
	// lista de especialidades
	Especialidade especialidade = new Especialidade();
	List<Especialidade> especialidades = new ArrayList();
	Idao dao = new DaoEspecialidade();
	
	especialidades = dao.listar(especialidade);
	
%>

<%--Voltar a página controle --%>
<a href="controle.jsp">Controle</a>

<%--Título --%>
<h1>Menu Mantenedores</h1>

<!-- *********** -->
<!-- Botões iniciais -->
<%
	if(ctrlDiv.toString().equals("null")){
%>
<div>
<h2>Escolha a opção</h2>
<form action="Mantenedor">
	<table>
	<tbody>
	<tr>
	<td><input type="submit" id="cadastro" name="operacao" value="Cadastro"></td>
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
<h2>Cadastro de Mantenedor</h2>
<form action="Mantenedor">
	<table id="tableCadastro">
	<tbody>
	<tr>
	<td><label>Nome:</label></td>
	<td><input type="text" name="txtNome"></td>
	</tr>
	<tr>
	<td><label>CPF:</label></td>
	<td><input type="text" name="txtCpf"></td>
	</tr>
	<tr>
	<tr>
	<td><label>Sexo:</label></td>
	<td><select id="cbSexo1" name="cbSexo">
		<option value=" "> </option>
		<option value="Feminino">Feminino</option>
		<option value="Masculino">Masculino</option>
	</select></td>
	</tr>
	<tr>
	<td><label>Email:</label></td>
	<td><input type="text" name="txtEmail"></td>
	</tr>
	
	<tr>
	<td><label>Setor:</label></td>
	<td><select name="cbSetor">
		<option value="F">Construção</option>
		<option value="M">Destruição</option>
	</select></td>
	</tr>
	
	<%if(especialidades != null){ %>
	<tr>
	<td><label>Especialidade:</label></td>
	<td><select name="cbEspecialidade_id">
		<option value=""></option>
		<%for(Especialidade esp: especialidades){ %>
		<option value="<%=esp.getId()%>"><%=esp.getDescricao() %></option>
		<%} %>
		
	</select>
	<input type="button" class="adicionar" value="mais">
	</td>
	</tr>
	<%} %>
	</tbody>
	<tfoot>
	<tr>
	<td></td>
	<td><input type="reset" name="operacao" value="Cancelar"></td>
	<td><input type="submit" id="salvarCadastro" name="operacao" value="Salvar"></td>
	</tr>
	</tfoot>
	</table>
</form>
</div>
<%	} %>

<!-- *********** -->
<!-- Procura mantenedor -->
<%
	if(ctrlDiv.toString().equals("procurar")){
%>
<div>
<h2>Procurar um Mantenedor</h2>
<form action="Mantenedor">
	<label>Digite o CPF do mantenedor</label>
	<table>
	<tbody>
	<tr>
	<td><label>CPF:</label></td>
	<td><input type="text" name="txtCpf"></td>
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
<!-- Lista um mantenedor para alterar ou excluir -->
<%
	if(ctrlDiv.toString().equals("listar") && mantenedores.size() == 1){
		mantenedor = mantenedores.get(0);
%>
<div>
<h2>Alterar ou Excluir Mantenedor</h2>
<form action="Mantenedor">
	<table>
		<tbody>
			<tr>
				<td>
					<input type="hidden" name="txtCpf" value="<%=mantenedor.getCpf() %>">
					<input type="hidden" name="txtId" value="<%=mantenedor.getId() %>">
				</td>
			</tr>
			<tr>
				<td>
					Nome
				</td>
				<td>
					<input type="text" name="txtNome" value="<%=mantenedor.getNome()%>">
				</td>
				<td>
					<input type="submit" name="operacao" value="Alterar">
				</td>
				<td>
					<input type="submit" name="operacao" value="Excluir">
				</td>
			</tr>
			<tr>
				<td>
				 Email
				</td>
				<td>
					<input type="text" name="txtEmail" value="<%=mantenedor.getEmail()%>">
				</td>
			</tr>
			<tr>
				<td>
					Sexo
				</td>
				<td>
					<select name="cbSexo">
						<option value=""> </option>
						<option value="Feminico">Feminino</option>
						<option value="Masculino">Masculino</option>
				</td>
			</tr>
			<!--<tr>
				<!-- <td>
					Setor
				</td> 
			</tr>-->
			<% for(Especialidade esp1: mantenedor.getEspecialidades()){ %>
			<tr>
				<td>
					Especialidade
				</td>
				<td>
					<select name="cbEspecialidade_id">
						<option value="<%=esp1.getId()%>"><%=esp1.getDescricao()%></option>
						<%for(Especialidade esp: especialidades){ %>
						<option value="<%=esp.getId()%>"><%=esp.getDescricao() %></option>
						<%} %>
					</select>
					<input type="button" class="adicionar" value="mais">
				</td>
				<td>
					<input type='button' class='remover' value='Remover'>
				</td>
			</tr>
			<%} %>
			<%if(especialidades != null){ %>
			<tr>
				<td>
					<label>Especialidade:</label>
				</td>
				<td>
					<select name="cbEspecialidade_id">
						<option value=""></option>
						<%for(Especialidade esp: especialidades){ %>
						<option value="<%=esp.getId()%>"><%=esp.getDescricao() %></option>
						<%} %>
		
					</select>
					<input type="button" class="adicionar" value="mais">
				</td>
			</tr>
			<%} %>
		</tbody>
	</table>
</form>
</div>
<%	} %>

<!-- *********** -->
<!-- Lista todos mantenedores -->
<%
	if(ctrlDiv.toString().equals("listar") && mantenedores.size() > 1){		
%>
<div class="divListar">
<h2>Listar todos Mantenedores</h2>
	<table>
		<thead>
			<tr>
				<td>
					<!-- txtCpf -->
				</td>
				<th>
					Nome
				</th>
				<th>
					Email
				</th>
				<th>
					Sexo
				</th>
				<th>
					Especialidade
				</th>
				<td>
				</td>
			</tr>
		</thead>
	<% 
		if(mantenedores != null){
			for(Mantenedor man: mantenedores){ 
	%>

		<tbody>
		<form action="Mantenedor">
			<tr>
				<td>
					<input type="hidden" name="txtCpf" value="<%=man.getCpf()%>">
				</td>
				<td>
					<%=man.getNome() %>
				</td>
				<td>
					<%=man.getEmail() %>
				</td>
				<td>
					<%=man.getSexo() %>
				</td>
				<td>
					<%if(man.getEspecialidades().size() > 0){
						out.print(man.getEspecialidades().get(0));
					}
				 %>
				</td>
				<td>
					<input type="submit" name="operacao" value="Listar">
				</td>
			</tr>
		</form>
		<%	
				}
			}	
		%>
		</tbody>
	</table>
	<strong>Mantenedores cadastrados: <%=mantenedores.size() %></strong>
</div>
<% } %>

<!-- *********** -->
<!-- Mensagens para usuário -->
<%
	if(!mensagem.toString().equals("null")){
		
%>
<div class="divMensagem">
	<h2>Informação</h2>
	<label name="lblResultado"><%=mensagem%></label>
</div>
<% } %>

<!-- *********** -->
<!-- voltar ao menu mantenedor -->
<%	if(!ctrlDiv.toString().equals("null")){  %>
<p></p>
<a href="mantenedor.jsp">Voltar ao Menu Mantenedor</a>
<%	} %>
<c:import url="rodape.jsp" />

<%-- elementos ocultos --%>
<table style="display: none">
	<%if(especialidades != null){ %>
	<tr class="trEspecialidade">
		<td>
			<label>Especialidade:
		</label></td>
		<td>
			<select name="cbEspecialidade_id">
				<option value=""></option>
				<%for(Especialidade esp: especialidades){ %>
				<option value="<%=esp.getId()%>"><%=esp.getDescricao() %></option>
				<%} %>
			
		</select>
		<input type="button" class="adicionar" value="mais">
		</td>
		<td>
			<input type='button' class='remover' value='Remover'>
		</td>
	</tr>
	<%} %>
</table>

</body>
</html>
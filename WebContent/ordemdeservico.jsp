<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
    
    <%@ page import="dominio.*,java.util.*, dao.*, dao.implementacao.*,java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Ordem de Serviço</title>

<link rel="stylesheet" type="text/css" href="jQuery/jquery.datetimepicker.css"/>
<script src="jQuery/jquery.js"></script>
<script src="jQuery/build/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">  
	$(document).ready(function(){

	$.datetimepicker.setLocale('pt-BR');

	$('.data').datetimepicker({
	    format: 'd/m/Y',                
	    mask:'99/99/9999',
	    timepicker: false,
	    step:30
		});

    	  // cor para as thead
    	  $(".thead").css({
    		  "color":"black",
    		  "font-style":"italic",
    		  "font-weight":"bold",
    		  "font-size":"16px"
    	  })
    	  
           // *** Adiciona uma nova atividade ***  
           $(".addAtividade").click( function(){
        	   
        	   //variaveis
        	   var qtdeAtividade;
        	   var qtdeTarefa = ".1";
        	   var cloneAti;
        	   var nomeTableAtividade;
        	   var nomeTableTarefa;
        	   
        	   //contar quantas divAtividade existe
        	   qtdeDivAtividade = $("#divFormulario div[class=divAtividade]").length + 1;
        	   //clonar divAtividade
        	   cloneDivAtividade = $("#divAtividade0").clone();
        	   //nome dos novos ids
        	   nomeTableAtividade = "tableAtividade" + qtdeDivAtividade;
        	   nomeTableTarefa = "tableTarefa" + qtdeDivAtividade + "_1";
        	   nomeDivAtividade = "divAtividade" + qtdeDivAtividade;
        	   
        	   //incrementar nova divAtividade
                $("#divFormulario")
        	   		.append(cloneDivAtividade
        	   				.attr("id", nomeDivAtividade)
        	   				.addClass("divAtividade")
        	   				.show()
        	   				.fadeIn(1000));
        	   
        	   // modificar os atributos da tableAtividade
        	   
        	   // renomear tabela
        	   $("#" + nomeDivAtividade + " .tableAtividade")
                	.attr("id", "tableAtividade" + qtdeDivAtividade);
        	   
                // mudar o nome da lblNumeroAtividade atividade
                $("#" + nomeDivAtividade + " .tableAtividade label[name=lblNumeroAtividade]")
                	.text(qtdeDivAtividade);
        	   
                $("#" + nomeDivAtividade + " .tableAtividade select[name=cbEspecialidade_id]")
            	.attr("name", "cbEspecialidade_id" + qtdeDivAtividade);
                
                $("#" + nomeDivAtividade + " .tableAtividade input[name=txtDescricaoAtividade]")
            	.attr("name", "txtDescricaoAtividade" + qtdeDivAtividade);
                
                // alterar o nome lblNumeroTarefa;
                $("#" + nomeDivAtividade + " .tableTarefa label[name=lblNumeroTarefa]")
                	.text((qtdeDivAtividade) + ".1");
                
                // renomear tableTarefa
                $("#" + nomeDivAtividade + " .tableTarefa")
                	.attr("id", "tableTarefa" + qtdeDivAtividade);
                
                $("#" + nomeDivAtividade + " .tableTarefa tbody tr")
            	.removeClass();
                
             	// alterar os input da tableTarefa
                $("#" + nomeDivAtividade + " .tableTarefa input[name=txtNomeTarefa]")
                	.attr("name", "txtNomeTarefa" + (qtdeDivAtividade));
             	 
                $("#" + nomeDivAtividade + " .tableTarefa input[name=txtDetalhamento]")
                	.attr("name", "txtDetalhamento" + (qtdeDivAtividade));
             	
                $("#" + nomeDivAtividade + " .tableTarefa input[name=txtQtdeHomem]")
                	.attr("name", "txtQtdeHomem" + (qtdeDivAtividade));
             	
                $("#" + nomeDivAtividade + " .tableTarefa input[name=txtQtdeHora]")
                	.attr("name", "txtQtdeHora" + (qtdeDivAtividade));
                
                return false; 
           });  
           
        	// *** Adiciona uma nova tarefa ***  
          	$("body").on("click", ".addTarefa", function() { 
          		
          		// clone de tarefa
     		   	var cloneTarefa = $(".trTarefa").clone();
          		
				// achar elemento pai
     		   	var divAtividade = $(this).parent().parent().parent().parent().parent().attr("id");
				
     		   var indice = $("#" + divAtividade + " .tableAtividade label[name=lblNumeroAtividade]")
           			.text();
     		   
     		   //achar qtde de linha
     		   var qtdeLinha = $("#" + divAtividade + " .tableTarefa tbody tr").length + 1;
     		   
     		   //alert($("#" + divAtividade + " .tableTarefa tbody tr").length);
				
        		   
				// anexar o clone da tarefa em div tarefa
            	$("#" + divAtividade + " .tableTarefa tbody")
					.append(cloneTarefa.removeClass()
						.fadeIn(1000));
				
				
				// alterar o label
               $("#" + divAtividade + " .tableTarefa tbody tr:last label")
               	.text( indice + "." + qtdeLinha);
				
	            // alterar os input da tableTarefa
	               $("#" + divAtividade + " .tableTarefa input[name=txtNomeTarefa]")
	               	.attr("name", "txtNomeTarefa" + (indice));
	            	 
	               $("#" + divAtividade + " .tableTarefa input[name=txtDetalhamento]")
	               	.attr("name", "txtDetalhamento" + (indice));
	            	
	               $("#" + divAtividade + " .tableTarefa input[name=txtQtdeHomem]")
	               	.attr("name", "txtQtdeHomem" + (indice));
	            	
	               $("#" + divAtividade + " .tableTarefa input[name=txtQtdeHora]")
	               	.attr("name", "txtQtdeHora" + (indice));
        		  
			});  
        	
           // *** Remove Atividade ***  
           $("body").on('click',".deleteAtividade", function(){  
        	   
                var id = $(".deleteAtividade").index(this); 
                if(id > -1){
	                $(".deleteAtividade").eq(id)
	                	.parent()
	                	.parent()
	                	.parent()
	                	.parent()
	                	.parent()
	                	.fadeOut(1000, function() {  
	                     	$(this).remove();  
	                })
                }
           }); 
           
        	// Remove o campo   
        	$("body").on('click', ".deleteTarefa", function(){  
                var id = $(".deleteTarefa").index(this);  
                $(".deleteTarefa").eq(id)
                	.parent()
                	.parent()
                	.fadeOut(1000, function() {  
                     $(this).remove();  
                })  
           }); 
        	
    	  
        	
      });
    	  
</script> 
</head>
<body>

<c:import url="cabecalho.jsp" />

<%
	//variaveis
	OrdemDeServico ordem = new OrdemDeServico();
	Mantenedor man = new Mantenedor();
	List<Mantenedor> mans = new ArrayList();
	List<OrdemDeServico> ordens = new ArrayList();
	StringBuilder ctrlDiv = new StringBuilder();
	StringBuilder mensagem = new StringBuilder();
	ordens = (ArrayList)request.getAttribute("ordens");
	ctrlDiv.append(request.getAttribute("ctrlDiv"));
	mensagem.append(request.getAttribute("mensagem"));
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
	
	// lista de especialidades
	Especialidade especialidade = new Especialidade();
	List<Especialidade> especialidades = new ArrayList();
	Idao dao = new DaoEspecialidade();
	
	especialidades = dao.listar(especialidade);
	
	// pagar mantenedores
	Idao dao2 = new DaoMantenedor();
	mans = dao2.listar(man);
%>

<%--Voltar a página controle --%>
<a href="controle.jsp">Controle</a>

<%--Título --%>
<h1>Ordem de Serviço</h1>


<%--**Botões Iniciais **--%>
<%
	if(ctrlDiv.toString().equals("null")){
%>
<div>
<h2>Escolha a opção</h2>
<form action="OrdemDeServico">
	<table>
		<tbody>
			<tr>
				<td>
					<input type="submit" id="cadastro" name="operacao" value="Cadastro">
				</td>
				<%-- <td><input type="submit" name="operacao" value="Procurar"></td> --%>
				<td>
					<input type="submit" id="listar" name="operacao" value="Listar">
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>
<%	} %>

<%--Cadastro de uma nova Ordem de Serviço --%>
<%
	if(ctrlDiv.toString().equals("cadastro")){
%>
<div>

<h2>Cadastrar nova Ordem de Serviço</h2>

<form action="OrdemDeServico">
	<table>
	<tr>
		<td>
			Autor
		</td>
		<td>
			<select name="cbMantenedor">
				<option value=""> </option>
				<%
				for(Mantenedor m: mans){ 
				%>
				<option value=<%=m.getId() %>>
					<%=m.getNome() %>
				</option>
				<%
				}
				%>
			</select>
		</td>
	</tr>
	<tr>
	<td>Título</td>
	<td><input type="text" name="txtTitulo"></td>
	</tr>
	<tr>
	<td>Observação</td>
	<td><input type="text" name="txtObservacao"></td>
	</tr>
	<tr>
	<td>Equipamento</td>
	<td><select name="cbEquipamento_id">
		<option value=""></option>
		<option value="1">equipamento1</option>
		<option value="2">equipamento2</option>
		<option value="3">equipamento3</option>
	</select></td>
	</tr>
	<tr>
	<td>Criticidade</td>
	<td>
		<select name="cbCriticidade">
			<option value=""></option>
			<option value="alta">Alta</option>
			<option value="media">média</option>
			<option value="baixa">baixa</option>
		</select></td>
	</tr>
		<td>
			Data limite
		</td>
		<td>
			<input type="text" class="data" id="data" name="txtDataLimite">
		</td>
	</tr>
	<tr>
	<td>Tipo de Manutenção</td>
		<td>
			<select name="cbTipoManutencao">
				<option value=""></option>
				<option value="Preventiva">Preventiva</option>
				<option value="Corretiva">Corretiva</option>
				<option value="Preditiva">Preditiva</option>
			</select>
		</td>
	</tr>
</table>

<br>

<div id="divFormulario">

<label>Atividades</label>
&nbsp
<input type="button" class="addAtividade" value="Nova Atividade">

<div id="divAtividade1" class="divAtividade" style="border:1px solid #000;">
<table id="tableAtividade1" class="tableAtividade">
	<tr>
		<td>
			<label>Atividade</label>
		</td>
		<td>
			<label name="lblNumeroAtividade">1</label>
		</td>
	</tr>
	<tr>
		<td>
			<label>Descrição da Atividade</label>
		</td>
		<td>
			<input type="text" name="txtDescricaoAtividade1">
		</td>
	</tr>
	<tr>
		<td>
			<label>Especialidade</label>
		</td>
		<td>
			<select name="cbEspecialidade_id1">
				<option value=""></option>
				<%for(Especialidade esp: especialidades){ %>
				<option value="<%=esp.getId()%>"><%=esp.getDescricao() %></option>
				<%} %>
			</select>
		</td>
	</tr>
	
</table>

<table id="tableTarefa1" class="tableTarefa">
	<thead>
		<tr>
			<td colspan="6">
				<label>Tarefas</label>
				&nbsp
				<input type="button" class="addTarefa" value="Nova Tarefa">
			</td>
		</tr>
		<tr>
			<td>
				Nº da Tarefa
			</td>
			<td>
				Detalhamento
			</td>
			<td>
				Qtde Homem
			</td>
			<td>
				Qtde Hora
			</td>
			<td>
			
			</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<label name="lblNumeroTarefa">1.1</label>
			</td>
			<td>
				<input type="text" name="txtDetalhamento1">
			</td>
			<td>
				<input type="text" name="txtQtdeHomem1">
			</td>
			<td>
				<input type="text" name="txtQtdeHora1">
			</td>
			<td>
				<input type="button" class="deleteTarefa" value="Eliminar Tarefa">
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td>
				<p></p>
			</td>
		</tr>
	</tfoot>
</table>

</div>

</div>

<input type="submit" name="operacao" value="Salvar">	
&nbsp
<input type="reset" value="Cancelar">
</form>
</div>
<%
	}
%>

<%--div listar ordens --%>
<%
	if(ctrlDiv.toString().equals("listar")){
 
		Double qtdeTotalHoras = 0.0;
%>
<div>
	<h2>Todas Ordens de Serviço</h2>

	<table border="1">
		<thead class="thead">
			<tr>
				<td style="display:none">
					id
				</td>
				<td>
					Codigo
				</td>
				<td>
					Criticidade
				</td>
				<td>
					Status
				</td>
				<td>
					Data Cadastro
				</td>
				<td>
					Equipamento
				</td>
				<td>
					Título
				</td>
				<td>
					Observação
				</td>
				<td>
					Autor
				</td>
				<td>
					Data Limite
				</td>
				<td>
					Tipo de manutenção
				</td>
				<td>
					Quantidade total de horas prevista
				</td>
			</tr>
		</thead>
		<tbody>
		
			<%for(OrdemDeServico os: ordens){ %>
			<tr>
				<td style="display:none">
					<%=os.getId()%>
				</td>
				<td>
					<%=os.getCodigo() %>
				</td>
				<td>
					<%=os.getCriticidade() %>
				</td>
				<td>
					<%=os.getStatus() %>
				</td>
				<td>
					<%=
						sdf2.format(os.getDataCadastro().getTime())
					%>
				</td>
				<td>
					<%=os.getEquipamento().getNome()%>
				</td>
				<td>
					<%=os.getTitulo() %>
				</td>
				<td>
					<%=os.getObservacao() %>
				</td>
				<td>
					<%=os.getAutor().getNome()%>
				</td>
				<td>
					<%=
						sdf2.format(os.getDataLimite().getTime())
					%>
				</td>
				<td>
					<%=os.getTipoManutencao() %>
				</td>
				<td>
					<%=os.getTotalHorasEstimada() %>
				</td>
				<td>
					<form action="OrdemDeServico">
						<input type="hidden" name="txtTitulo" value="<%=os.getTitulo() %>">
						<input type="hidden" name="txtCodigo" value="<%=os.getCodigo() %>">
						<input type="submit" name="operacao" value="Excluir">
					</form>
				</td>
			</tr>
			<% qtdeTotalHoras += os.getTotalHorasEstimada();
			} %>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="13">
					<strong>
						Quantidade de Ordem de Serviço: <%=ordens.size() %> Total de horas: <%=qtdeTotalHoras %>
					</strong>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
<%} %>

<!-- Mensagens para usuário -->
<%
	if(!mensagem.toString().equals("null")){
		
%>
<div class="divMensagem">
	<h2>Informação</h2>
	<label name="lblMensagem"><%=mensagem%></label>
</div>
<% 
	}//if
%>

<%
	/* Voltar ao menu Ordem de Serviço */
	if(!ctrlDiv.toString().equals("null")){
%>
<br>
<a href="ordemdeservico.jsp">Voltar ao menu</a>
<%
	}//if
%>

<c:import url="rodape.jsp" />

<%-- Elementos ocultas --%>

<%-- div Atividade --%>
<div id="divAtividade0" style="display: none; border:1px solid #000;">

<table id="tableAtividade1" class="tableAtividade">
	<tr>
		<td>
			<label>Atividade</label>
		</td>
		<td>
			<label name="lblNumeroAtividade">
				1  
			</label>
			&nbsp <input type="button" class="deleteAtividade" value="Eliminar Atividade">
		</td>
	</tr>
	<tr>
		<td>
			<label>Descrição da Atividade</label>
		</td>
		<td>
			<input type="text" name="txtDescricaoAtividade">
		</td>
	</tr>
	<tr>
		<td>
			<label>Especialidade</label>
		</td>
		<td>
			<select name="cbEspecialidade_id">
				<option value=""></option>
				<%for(Especialidade esp: especialidades){ %>
				<option value="<%=esp.getId()%>"><%=esp.getDescricao() %></option>
				<%} %>
			</select>
		</td>
	</tr>
	
</table>

<table id="tableTarefa1" class="tableTarefa">
	<thead>
		<tr>
			<td colspan="6">
				<label>Tarefas</label>
				&nbsp
				<input type="button" class="addTarefa" value="Nova Tarefa">
			</td>
		</tr>
		<tr>
			<td>
				Nº da Tarefa
			</td>
			<td>
				Detalhamento
			</td>
			<td>
				Qtde Homem
			</td>
			<td>
				Qtde Hora
			</td>
			<td>
			
			</td>
		</tr>
	</thead>
	<tbody>
		<tr class="trTarefa">
			<td>
				<label name="lblNumeroTarefa">1.1</label>
			</td>
			<td>
				<input type="text" name="txtDetalhamento">
			</td>
			<td>
				<input type="text" name="txtQtdeHomem">
			</td>
			<td>
				<input type="text" name="txtQtdeHora">
			</td>
			<td>
				<input type="button" class="deleteTarefa" value="Eliminar Tarefa">
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td>
				<p></p>
			</td>
		</tr>
	</tfoot>
</table>


</body>
</html>
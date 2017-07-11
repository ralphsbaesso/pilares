<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
    <%@ page import="dominio.*,java.util.*, dao.*, dao.implementacao.*,java.text.SimpleDateFormat" %>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Planejamento</title>

<link rel="stylesheet" type="text/css" href="jQuery/jquery.datetimepicker.css"/>
<script src="jQuery/jquery.js"></script>
<script src="jQuery/build/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">  
	$(document).ready(function(){

	$.datetimepicker.setLocale('pt-BR');

	$('.data').datetimepicker({
	    format: 'd/m/Y H:i',                
	    mask:'99/99/9999 99:99',
	    step:30
		}).css({
				"width":"110px"
			});
    	
    	//Estilizar os label's
    	$("label").css({
    		/*definimos a largura do box*/
    		"width":"300px",
    		/* definimos a altura do box */
    		"height":"130px",
    		/* definimos a cor de fundo do box */
    		"background-color":"#F0FFFF",
    		/* definimos o quão arredondado irá ficar nosso box */
    		"border-style":"groove"
    		});
    	  
    	// cor para as thead
    	  $("thead").css({
    		  "color":"black",
    		  "font-style":"italic",
    		  "font-weight":"bold",
    		  "font-size":"16px"
    	  });
		
    	// Adiciona uma nova linha para programar a tarefa 
          $("body").on("click",".addLinha", function(){
       	   
       		   var indice = $(".addLinha").index(this);
       		   var cloneLinha = $(".addLinha").eq(indice).parent().parent().clone();
       		   //alert(indice);
       		   $(".addLinha").eq(indice).parent().parent().after(cloneLinha);
       		      
          });
          
          // Remove linha para programar tarefa 
          $("body").on('click',".removeLinha", function(){  
               var indice = $(".removeLinha").index(this);
               if(indice > 0){
	                $(".removeLinha").eq(indice).parent().parent().slideUp('fast', function() {  
	                     $(this).remove();  
	                })  
               }
          }); 
    	   
      });
 </script>  

</head>
<body>

<c:import url="cabecalho.jsp" />

<%
	//objetos
	OrdemDeServico ordem = new OrdemDeServico();
	Especialidade especialidade = new Especialidade();
	Mantenedor mantenedor = new Mantenedor();
	StringBuilder ctrlDiv = new StringBuilder();
	StringBuilder mensagem = new StringBuilder();
	StringBuilder codigo = new StringBuilder();
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
	
	// lista de objetos
	List<Especialidade> especialidades = new ArrayList();
	List<OrdemDeServico> ordens = new ArrayList();
	List<Mantenedor> mantenedores = new ArrayList();
	List<Tarefa> tarefas = new ArrayList();
	
	Idao dao = new DaoEspecialidade();
	Idao dao2 = new DaoOrdemDeServico();
	Idao dao3 = new DaoMantenedor();
	
	mantenedores = dao3.listar(mantenedor);
	especialidades = dao.listar(especialidade);
	
	// getAtributos
	ctrlDiv.append(request.getAttribute("ctrlDiv"));
	mensagem.append(request.getAttribute("mensagem"));
	codigo.append(request.getAttribute("codigo"));
	tarefas = (List)request.getAttribute("lista");
%>

<%--Voltar a página controle --%>
<a href="controle.jsp">Controle</a>

<%--Título --%>
<h1>Planejamento</h1>

<%--**Botões Iniciais **--%>
<%
	if(ctrlDiv.toString().equals("null")){
%>
<div>
<h2>Escolha a opção</h2>
<form action="Planejamento">
	<table>
		<tbody>
			<tr>
				<td>
					<input type="submit" name="operacao" value="Procurar uma Ordem de Servico">
				</td>
				<td>
					<input type="submit" name="operacao" value="Listar todas Ordem de Servico">
				</td>
				<td>
					<input type="submit" name="operacao" value="Listar">
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>
<%
	}
%>

<%-- Procurar uma Ordem de Serviço --%>
<% 
	if(ctrlDiv.toString().equals("listarUm")){
%>
<div>
	<form action="Planejamento">
	Digite o código da Ordem de Serviço: <input type="text" name="txtCodigo">
	<input type="submit" name="operacao" value="Planejar">
	</form>
</div>
<%
	}
%>

<%--Planejar uma ordem de serviço --%>

<%
	if(ctrlDiv.toString().equals("planejar")){
		ordem.setCodigo(codigo.toString());
		ordens = dao2.listar(ordem);
		if(ordens.size() > 0){
			ordem = ordens.get(0);
			
%>
<div>
<form action="Planejamento">

<%-- pegar o status da om --%>
<input type="hidden" name="txtStatusOs" value="<%=ordem.getStatus() %>">

<label>
	Planejador: 
	<select name="cbAutorId">
		<option value=""> </option>
		<%
		for(Mantenedor man: mantenedores){ 
		%>
		<option value=<%=man.getId() %>>
			<%=man.getNome() %>
		</option>
		<%
		}
		%>
	</select>
</label>
<br>
<label>Equipamento: <%=ordem.getEquipamento().getId() %>
	<input type="hidden" name="txtOsId" value="<%=ordem.getId() %>">
</label> &nbsp;
<label>Criticidade: <%=ordem.getCriticidade() %></label> &nbsp;
<label>Codigo: <%=ordem.getCodigo() %></label>
<br>
<label>Título: <%=ordem.getTitulo() %></label>&nbsp;
<label>Observação: <%=ordem.getObservacao() %></label>&nbsp;
<label>Tipo de manutenção: <%=ordem.getTipoManutencao()%></label>
<br>
<label>Data de abertura: <%=sdf.format(ordem.getDataCadastro().getTime()) %></label>
<label>Data limite: <%=sdf2.format(ordem.getDataLimite().getTime()) %></label>
<br>
<label>Autor: <%=ordem.getAutor().getNome() %></label>
<strong>
	<label>Status: <%=ordem.getStatus() %></label>&nbsp;
</strong>
<br>
	
<%-- Table atividade --%>
	<%
	int i = 1;
	for(Atividade ati: ordem.getAtividades()){
	%>
	<br>
	<label>
		<input type="hidden" name="txtAtividadeId<%=i %>" value="<%=ati.getId() %>">
		<strong>
			Atividade <%=i %> - Descrição: <%=ati.getDescricao() %> - Especialidade: <%=ati.getEspecialidade().getDescricao() %>
		</strong>
	</label>
					
	<table style="border:1px solid">
		<thead>
			<tr>
				<td>
					Tarefa
				</td>
				<td>
					detalhamento
				</td>
				<td>
					Homem
				</td>
				<td>
					Hora
				</td>
				<td>
					Data inicial
				</td>
				<td>
					Data final
				</td>
				<td>
					Mantenedor
				</td>
				<td>
					Observação
				</td>
				<td>
					Campos
				</td>
			</tr>
		</thead>
		<tbody>
			<%
			int j = 1;
			for(Tarefa taf: ati.getTarefas()){
			%>
			<tr>
				<td>
					<%=j %> 
					<input type="hidden" name="txtTarefaId<%=i %>_<%=j %>" value="<%=taf.getId() %>">
				</td>
				<td>
					<%=taf.getDetalhamento() %>
				</td>
				<td>
					<%=taf.getQtdeHomemEstimado() %>
				</td>
				<td text-align="left">
					 <%=taf.getQtdeHoraEstimada() %>
				</td>
				<td text-align="left">
					<input type="text" class="data" name="txtDataInicial<%=i %>_<%=j %>">
				</td>
				<td>
					<input type="text" class="data" name="txtDataFinal<%=i %>_<%=j %>">
				</td>
				</td>
				<td class="tdMantenedor">
					<select name="cbMantenedor<%=i %>_<%=j %>">
						<option value=""></option>
						<%
						for(Mantenedor man: mantenedores){ 
						%>
						<option value=<%=man.getId() %>>
							<%=man.getNome() %>
						</option>
						<%
						}
						%>
					</select>
				</td>
				<td>
					<input type="text" name="txtObservacao<%=i %>_<%=j %>" >
				</td>
				<td>
					<input type="button" value="mais" class="addLinha">
					<input type="button" value="menos" class="removeLinha">
				</td>
			</tr>
			<%
			j++;
			}
			%>
		</tbody>
	</table>
	<%
	i++;
	}
	%>
	
	<input type="submit" value="Salvar" name="operacao">
</form>
</div>
<%		
		}else{
			mensagem.setLength(0);
			mensagem.append("Ordem de Serviço não encontrada!");
		}
	}
%>

<%--div listar ordens --%>
<%
	if(ctrlDiv.toString().equals("listarTodos")){
		ordens = dao2.listar(null);
		Double qtdeTotalHoras = 0.0;
%>

<div>
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
					Equipamento id
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
		
			<%
				int qtdeOs = 0;
				for(OrdemDeServico os: ordens){
					String status = os.getStatus();
					if(status == null)
						status = "null";
					if(!status.equals("null") && !status.equals("Encerrada")){
			%>
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
					<form action="Planejamento">
						<input type="hidden" name="txtCodigo" value="<%=os.getCodigo() %>">
						<input type="submit" name="operacao" value="Planejar">
					</form>
				</td>
			</tr>
			<% 
				qtdeOs ++;
				qtdeTotalHoras += os.getTotalHorasEstimada();
					}// if
				}// for
			%>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="13">
					<strong>
						Quantidade de Ordem de Serviço: <%=qtdeOs %> Total de horas: <%=qtdeTotalHoras %>
					</strong>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
<%
	}
%>

<%-- Listar todos os Planejamentos --%>
<%
	if(ctrlDiv.toString().equals("listar")){
%>
	<table border="1">
		<thead>
			<tr>
				<td>
					ID
				</td>
				<td>
					Código
				</td>
				<td>
					Detalhamento
				</td>
				<td>
					Data inicial
				</td>
				<td>
					Data final
				</td>
				<td>
					Total em Horas
				</td>
				<td>
					Autor
				</td>
				<td>
					Executante
				</td>
			</tr>
		</thead>

		<tbody>
<%
		for(Tarefa tarefa: tarefas){
			for(Planejamento apon: tarefa.getPlanejamentos()){
%>
			<tr>
				<td>
					<%=apon.getId() %>
				</td>
				<td>
					<%=apon.getCodigo() %>
				</td>
				<td>
					<%=apon.getDetalhamento() %>
				</td>
				<td>
					<%=sdf.format(apon.getDataInicial().getTime()) %>
				</td>
				<td>
					<%=sdf.format(apon.getDataFinal().getTime()) %>
				</td>
				<td>
					<%=apon.getTotalHoras() %>
				</td>
				<td>
					<%=apon.getAutor().getNome() %>
				</td>
				<td>
					<%=apon.getExecutante().getNome() %>
				</td>
			</tr>
<%
			} //for
		} //for
%>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="7">
					Quantidade de Apontamento: <%=tarefas.get(0).getPlanejamentos().size() %>
				</td>
			</tr>
		</tfoot>
	</table>
<%
	} //if
%>

<!-- Mensagens para usuário -->
<%
	if(!mensagem.toString().equals("null")){
		
%>
<div class="divMensagem">
	<h2>Informação</h2>
	<label><%=mensagem%></label>
</div>
<% 
	}
%>

<%-- voltar ao menu planejamento --%>
<%	
	if(!ctrlDiv.toString().equals("null")){  
%>
<br>
<a href="planejamento.jsp">Voltar ao Menu Planejamento</a>
<%	
	}
%>

<c:import url="rodape.jsp" />




</body>
</html>
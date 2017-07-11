<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
    <%@ page import="dominio.*,java.util.*, dao.*, dao.implementacao.*,java.text.SimpleDateFormat" %>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Analise</title>


<%
	//objetos
	StringBuilder ctrlDiv = new StringBuilder();
	StringBuilder mensagem = new StringBuilder();
	StringBuilder grafico = new StringBuilder();
	StringBuilder mes = new StringBuilder();
	StringBuilder ano = new StringBuilder();
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat sdfDia = new SimpleDateFormat("dd");
	SimpleDateFormat sdfMes = new SimpleDateFormat("MM");
	List<Planejamento> tarefasPlanejada;
	List<Apontamento> tarefasApontada;
	Resultado resultado = new Resultado();
	
	// getAtributos
	ctrlDiv.append(request.getAttribute("ctrlDiv"));
	mensagem.append(request.getAttribute("mensagem"));
	tarefasPlanejada = (List)request.getAttribute("tarefasPlanejada");
	tarefasApontada = (List)request.getAttribute("tarefasApontada");
	grafico.append(request.getAttribute("grafico"));
	mes.append(request.getAttribute("mes"));
	ano.append(request.getAttribute("ano"));
	resultado = (Resultado)request.getAttribute("resultado");
	
%>
<!-- Bibliotecas -->
<script src="jquery2.js" type="text/javascript"></script> 
<script src="jquery-ui.mim.js"></script>
<script src="jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="jquery-ui.mim.css" />
<link rel="stylesheet" type="text/css" href="jquery-ui.css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<%-- Gráfico 1 - por Mês --%>

<% 
	if(ctrlDiv.toString().equals("salvar") && grafico.toString().equals("1")){
%>

<script type="text/javascript">
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Dia');
      data.addColumn('number', 'Realizado');
      data.addColumn('number', 'Planejado');

      data.addRows([
    	  <%
    	  	double totalRealizado = 0;
    	  	double totalPlanejado = 0;
    	  	
    	  if(ctrlDiv.toString().equals("salvar") && (tarefasPlanejada != null || tarefasApontada != null)){
    		  
    	  
    	  	for(int i = 1; i < 32; i++){
    	  		for(Apontamento a: tarefasApontada){
    	  			if(i == Integer.valueOf(sdfDia.format(a.getDataFinal().getTime()))){
    	  				totalRealizado += a.getTotalHoras();
    	  			}
    	  		}
    	  		
    	  		for(Planejamento p: tarefasPlanejada){
    	  			if(i == Integer.valueOf(sdfDia.format(p.getDataFinal().getTime()))){
    	  				totalPlanejado += p.getTotalHoras();
    	  			}
    	  		}
    	  %>	
    	  		// dados para o gráfico
    	  		[<%=i%>, <%=totalRealizado%>, <%=totalPlanejado%>]
    	  		
    	  		// verificar se é o ultimo para não colocar virgula
    	  		<%  if(i != 31){ 	%> 	, <%  }  %>
    	  <%	
    	  	}
    	  }
    	  %>
    	  
      	]);

      var options = {
        chart: {
          title: 'Curva S - <%=mes%> de <%=ano%>',
          subtitle: 'Planejado x Realizado'
        },
        width: 900,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          },
          
        }
      };

      var chart = new google.charts.Line(document.getElementById('divGrafico'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }
  </script>
  
  <%-- Gráfico de pizza --%>
  <%-- Realizado --%>
  
  <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Corretiva Emergencial',     <%=resultado.getContApontamento().horasPreventiva%>],
          ['Preventiva',      <%=resultado.getContApontamento().horasCorretivaEmergencial %>]
        ]);

        var options = {
          title: 'Tipos de manutenção Realizada',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('pizzaApontamento'));
        chart.draw(data, options);
      }
    </script>
    
    <%-- Planejado --%>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Corretiva Emergencial',     <%=resultado.getContPlanejamento().horasPreventiva%>],
          ['Preventiva',      <%=resultado.getContPlanejamento().horasCorretivaEmergencial %>]
        ]);

        var options = {
          title: 'Tipos de manutenção Planejada',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('pizzaPlanejamento'));
        chart.draw(data, options);
      }
    </script>
    
    <%-- Gráfico Pizza Donut --%>
    <%-- Apontado --%>
    
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Bomba Mecânica',     <%=resultado.getContApontamento().bombaMecanica %>],
          ['Bebedouro',      <%=resultado.getContApontamento().bebedouro %>],
          ['Tanque',  <%=resultado.getContApontamento().tanque %>],
          ['Ventilador', <%=resultado.getContApontamento().ventilador %>],
          ['Filtro',    <%=resultado.getContApontamento().filtro %>],
          ['Geladeira', <%=resultado.getContApontamento().geladeira %>],
          ['Aquecedor', <%=resultado.getContApontamento().aquecedor %>],
          ['Ar Condicionado', <%=resultado.getContApontamento().arCondicionado %>],
          ['Desconhecido', <%=resultado.getContApontamento().desconhecido%>]
        ]);

        var options = {
          title: 'Horas Realizada por Tipo de Equipamento',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('PizzaEquipamentoApontado'));
        chart.draw(data, options);
      }
    </script>
    
    <%-- Planejado --%>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Bomba Mecânica',     <%=resultado.getContPlanejamento().bombaMecanica %>],
          ['Bebedouro',      <%=resultado.getContPlanejamento().bebedouro %>],
          ['Tanque',  <%=resultado.getContPlanejamento().tanque %>],
          ['Ventilador', <%=resultado.getContPlanejamento().ventilador %>],
          ['Filtro',    <%=resultado.getContPlanejamento().filtro %>],
          ['Geladeira', <%=resultado.getContPlanejamento().geladeira %>],
          ['Aquecedor', <%=resultado.getContPlanejamento().aquecedor %>],
          ['Ar Condicionado', <%=resultado.getContPlanejamento().arCondicionado %>],
          ['Desconhecido', <%=resultado.getContPlanejamento().desconhecido%>]
        ]);

        var options = {
          title: 'Horas Planejada por Tipo de Equipamento',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('PizzaEquipamentoPlanejado'));
        chart.draw(data, options);
      }
    </script>

<%
	}
%>

<%-- Gráfico 2 - por Ano --%>

<% 
	if(ctrlDiv.toString().equals("salvar") && grafico.toString().equals("2")){
%>
  <script type="text/javascript">
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Mês');
      data.addColumn('number', 'Realizado');
      data.addColumn('number', 'Planejado');

      data.addRows([
    	  <%
    	  	double totalRealizado = 0;
    	  	double totalPlanejado = 0;
    	  	
    	  if(ctrlDiv.toString().equals("salvar") && (tarefasPlanejada != null || tarefasApontada != null)){
    		  
    	  
    	  	for(int i = 1; i < 13; i++){
    	  		for(Apontamento a: tarefasApontada){
    	  			if(i == Integer.valueOf(sdfMes.format(a.getDataFinal().getTime()))){
    	  				totalRealizado += a.getTotalHoras();
    	  			}
    	  		}
    	  		
    	  		for(Planejamento p: tarefasPlanejada){
    	  			if(i == Integer.valueOf(sdfMes.format(p.getDataFinal().getTime()))){
    	  				totalPlanejado += p.getTotalHoras();
    	  			}
    	  		}
    	  %>	
    	  		// dados para o gráfico
    	  		[<%=i%>, <%=totalRealizado%>, <%=totalPlanejado%>]
    	  		
    	  		// verificar se é o ultimo para não colocar virgula
    	  		<%  if(i != 12){ 	%> 	, <%  }  %>
    	  <%	
    	  	}
    	  }
    	  %>
    	  
      	]);

      var options = {
        chart: {
          title: "Curva S - <%=ano%>",
          subtitle: 'Planejado x Realizado'
        },
        width: 900,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          },
          
        }
      };

      var chart = new google.charts.Line(document.getElementById('divGrafico2'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }
  </script>

 	<%-- Gráfico de pizza --%>
  	<%-- Realizado --%>
  
  <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Corretiva Emergencial',     <%=resultado.getContApontamento().horasPreventiva%>],
          ['Preventiva',      <%=resultado.getContApontamento().horasCorretivaEmergencial %>]
        ]);

        var options = {
          title: 'Tipos de manutenção Realizada',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('pizzaApontamento'));
        chart.draw(data, options);
      }
    </script>
    
    <%-- Planejado --%>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Corretiva Emergencial',     <%=resultado.getContPlanejamento().horasPreventiva%>],
          ['Preventiva',      <%=resultado.getContPlanejamento().horasCorretivaEmergencial %>]
        ]);

        var options = {
          title: 'Tipos de manutenção Planejada',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('pizzaPlanejamento'));
        chart.draw(data, options);
      }
    </script>
    
     <%-- Gráfico Pizza Donut --%>
    <%-- Apontado --%>
    
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Bomba Mecânica',     <%=resultado.getContApontamento().bombaMecanica %>],
          ['Bebedouro',      <%=resultado.getContApontamento().bebedouro %>],
          ['Tanque',  <%=resultado.getContApontamento().tanque %>],
          ['Ventilador', <%=resultado.getContApontamento().ventilador %>],
          ['Filtro',    <%=resultado.getContApontamento().filtro %>],
          ['Geladeira', <%=resultado.getContApontamento().geladeira %>],
          ['Aquecedor', <%=resultado.getContApontamento().aquecedor %>],
          ['Ar Condicionado', <%=resultado.getContApontamento().arCondicionado %>],
          ['Desconhecido', <%=resultado.getContApontamento().desconhecido%>]
        ]);

        var options = {
          title: 'Horas Realizada por Tipo de Equipamento',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('PizzaEquipamentoApontado'));
        chart.draw(data, options);
      }
    </script>
    
    <%-- Planejado --%>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Bomba Mecânica',     <%=resultado.getContPlanejamento().bombaMecanica %>],
          ['Bebedouro',      <%=resultado.getContPlanejamento().bebedouro %>],
          ['Tanque',  <%=resultado.getContPlanejamento().tanque %>],
          ['Ventilador', <%=resultado.getContPlanejamento().ventilador %>],
          ['Filtro',    <%=resultado.getContPlanejamento().filtro %>],
          ['Geladeira', <%=resultado.getContPlanejamento().geladeira %>],
          ['Aquecedor', <%=resultado.getContPlanejamento().aquecedor %>],
          ['Ar Condicionado', <%=resultado.getContPlanejamento().arCondicionado %>],
          ['Desconhecido', <%=resultado.getContPlanejamento().desconhecido%>]
        ]);

        var options = {
          title: 'Horas Planejada por Tipo de Equipamento',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('PizzaEquipamentoPlanejado'));
        chart.draw(data, options);
      }
    </script>

<%
	}
%>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("#graficoAno").click(function(){
			$("#graficoAno").hide().val("Salvar");
		});
		
		$("#graficoMesAno").click(function(){
			$("#graficoMesAno").hide().val("Salvar");
		});
		
	});

</script>
</head>
<body>

<c:import url="cabecalho.jsp" />



<%--Voltar a página inicial --%>
<a href="pagina_inicial.jsp">Pagina Inicial</a>

<%--Título --%>
<h1>Analise</h1>

<%--**Botões Iniciais **--%>
<%
	if(ctrlDiv.toString().equals("null")){
%>
<div>
<h2>Escolha a opção</h2>
<form action="Analise">

	Planejado x Realizado por MÊS
	&nbsp;
<br>
<br>
Selecione o Mês: 
	<select name="cbMes">
		<option value=""> </option>
		<option value="01">Janeiro</option>
		<option value="02">Fevereiro</option>
		<option value="03">Março</option>
		<option value="04">Abril</option>
		<option value="05">Maio</option>
		<option value="06">Junho</option>
		<option value="07">Julho</option>
		<option value="08">Agosto</option>
		<option value="09">Setembro</option>
		<option value="10">Outubro</option>
		<option value="11">Novembro</option>
		<option value="12">Dezembro</option>
	</select>
	
Selecione o Ano: 
	<select name="cbAno">
		<option value=""> </option>
		<option value="2010">2010</option>
		<option value="2011">2011</option>
		<option value="2012">2012</option>
		<option value="2013">2013</option>
		<option value="2014">2014</option>
		<option value="2015">2015</option>
		<option value="2016">2016</option>
		<option value="2017">2017</option>
	</select>
	
	&nbsp;
	<input type="submit" name="operacao" id="graficoMesAno" value="Gerar">
	
</form>

<br><br>

<%-- Segunda Pesquisa --%>

<form action="Analise">

	Planejado x Realizado por ANO
	&nbsp;
<br>
<br>
	
Selecione o Ano: 
	<select name="cbAno">
		<option value=""> </option>
		<option value="2010">2010</option>
		<option value="2011">2011</option>
		<option value="2012">2012</option>
		<option value="2013">2013</option>
		<option value="2014">2014</option>
		<option value="2015">2015</option>
		<option value="2016">2016</option>
		<option value="2017">2017</option>
	</select>
	
	&nbsp;
	<input type="submit" name="operacao" id="graficoAno" value="Gerar">
	
</form>
</div>
<%
	}
%>


<%-- Gráfico do mês --%>
<%
	if(ctrlDiv.toString().equals("salvar") && grafico.toString().equals("1")){
%>
	
<div id="divGrafico"></div>
	<table>
		<tr>
			<td>
				<label id="pizzaApontamento">
			</td>
			<td>
				</label><label id="pizzaPlanejamento"></label>
			</td>
		</tr>
		<tr>
			<td>
				<label id="PizzaEquipamentoApontado">
			</td>
			<td>
				</label><label id="PizzaEquipamentoPlanejado"></label>
			</td>
		</tr>
	</table>

<%
	}
%>
<%
	if(ctrlDiv.toString().equals("salvar") && grafico.toString().equals("2")){
%>

<div id="divGrafico2"></div>
	<table>
		<tr>
			<td>
				<label id="pizzaApontamento">
			</td>
			<td>
				</label><label id="pizzaPlanejamento"></label>
			</td>
		</tr>
		<tr>
			<td>
				<label id="PizzaEquipamentoApontado">
			</td>
			<td>
				</label><label id="PizzaEquipamentoPlanejado"></label>
			</td>
		</tr>
	</table>

<%
	}
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

<%-- voltar ao menu analise --%>
<%	
	if(!ctrlDiv.toString().equals("null")){  
%>
<br>
<a href="analise.jsp">Voltar ao Menu </a>
<%
	}
%>

<c:import url="rodape.jsp" />




</body>
</html>
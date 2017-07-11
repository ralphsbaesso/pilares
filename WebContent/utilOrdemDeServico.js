/**
 * 
 */
//Atividade
function duplicarCamposAtividade(){
	//alert("ok");
	var clone = document.getElementById('origemAtividade').cloneNode(true);
	var destino = document.getElementById('destinoAtividade');
	destino.appendChild (clone);
	// limpar o campo de entrada de texto
	var camposClonados = clone.getElementsByTagName('input');
	for(i=0; i<camposClonados.length;i++){
		camposClonados[i].value = '';
	}
}
function removerCamposAtividade(id){
	var node1 = document.getElementById('destinoAtividade');
	node1.removeChild(node1.childNodes[0]);
}
//Tarefa
function duplicarCamposTarefa(){
	//alert("ok");
	var clone = document.getElementById('origemTarefa').cloneNode(true);
	var destino = document.getElementById('destinoTarefa');
	destino.appendChild (clone);
	// limpar o campo de entrada de texto
	var camposClonados = clone.getElementsByTagName('input');
	for(i=0; i<camposClonados.length;i++){
		camposClonados[i].value = '';
	}
}
function removerCamposTarefa(id){
	var node1 = document.getElementById('destinoTarefa');
	node1.removeChild(node1.childNodes[0]);
}
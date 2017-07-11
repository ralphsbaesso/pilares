package negocio;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import dao.Idao;
import dao.implementacao.DaoMantenedor;
import dominio.*;

public class AtualizarStatusOs implements IStrategy {

	@Override
	public String processar(Entidade entidade) {
		
		if(entidade instanceof Tarefa){
			Tarefa tarefa = (Tarefa)entidade;
			OrdemDeServico os = new OrdemDeServico();
			String tipo;
			
			os.setStatus(tarefa.getAtividade().getOs().getStatus());
			
			//verificar se há OS já está encerrada
			if(os.getStatus().equals("encerrada")){
				return "Ordem de Seviço já encerrado!";
			}
			
			//verificar se está salvando apontamento ou planejamento
			if(tarefa.getApontamentos().size() > 0){
				// apontamento
				tipo = "apontamento";
			}else{
				// planejamento
				tipo = "planejamento";
			}
			
			//encerrar ordem de serviço?
			if(tarefa.getAtividade().getOs().getEncerrada().equals("encerrar")){
				os.setStatus("encerrada");
			// não encerrar, apenas atualizar
			}else if(tipo.equals("planejamento") &&
					(os.getStatus().equals("aberta") || os.getStatus().equals("inicializada") || os.getStatus().equals("reinicializada"))){
				os.setStatus("programada");
			}else if(tipo.equals("planejamento") &&
					os.getStatus().equals("programada")){
				os.setStatus("reprogramada");
			}else if(tipo.equals("apontamento") &&
					(os.getStatus().equals("aberta") || os.getStatus().equals("programada") || os.getStatus().equals("reprogramada"))){
				os.setStatus("inicializada");
			}else if(tipo.equals("apontamento") &&
					os.getStatus().equals("inicializada")){
				os.setStatus("reinicializada");
			}
			tarefa.getAtividade().getOs().setStatus(os.getStatus());
			return null;
		}
		
		return "Erro na atualização do status da Ordem de Serviço";
	}
}

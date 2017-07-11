package negocio;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import dao.Idao;
import dao.implementacao.DaoMantenedor;
import dao.implementacao.DaoOrdemDeServico;
import dominio.*;

public class VerificarStatusNoDeletar implements IStrategy {

	@Override
	public String processar(Entidade entidade) {
		
		if(entidade instanceof OrdemDeServico){
			OrdemDeServico os = (OrdemDeServico)entidade;
			
			// buscar dados desta ordem de serviço
			Idao dao = new DaoOrdemDeServico();
			List<OrdemDeServico> listaOS = dao.listar(os);
			
			if(listaOS.size() > 0){
				os = listaOS.get(0);
			}else{
				return "Erro na busca da Ordem de Serviço";
			}
			
			// verificar se ordem de serviço já foi inicializada, status diferente de aberta
			if(!os.getStatus().equals("aberta")){
				// Já inicializada, não poderá ser deletada
				return "Ordem de Serviço já inicializada, não pode ser apagada!";
			}
		}
		
		return null;
	}
}

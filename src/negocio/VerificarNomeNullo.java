package negocio;

import dominio.Entidade;
import dominio.Mantenedor;
import dominio.OrdemDeServico;

public class VerificarNomeNullo implements IStrategy {

	@Override
	public String processar(Entidade entidade) {
		
		// verificar se eh uma instancia de Mantenedor
		if(entidade instanceof Mantenedor){
			Mantenedor man = (Mantenedor) entidade;
			// verificar se o atributo nome está vazio ou se é null
			if(man.getNome().equals("") || man.getNome().equals(null)){
				return "É obrigatório o preenchimento do nome!!!";
			}
		}
		return null;
	}

}

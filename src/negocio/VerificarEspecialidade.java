package negocio;

import dominio.Entidade;
import dominio.Mantenedor;

public class VerificarEspecialidade implements IStrategy {

	@Override
	public String processar(Entidade entidade) {
		
		// verificar se eh uma instancia de Mantenedor
		if(entidade instanceof Mantenedor){
			Mantenedor man = (Mantenedor) entidade;
			// verificar se há pelo menos uma especialidade
			if(man.getEspecialidades().size() < 1){
				return "É obrigatório escolher uma especialidade!!!";
			}
		}
		return null;
	}

}

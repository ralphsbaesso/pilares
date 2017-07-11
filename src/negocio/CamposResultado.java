package negocio;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import dao.Idao;
import dao.implementacao.DaoMantenedor;
import dominio.*;

public class CamposResultado implements IStrategy {

	@Override
	public String processar(Entidade entidade) {
		
		StringBuilder sb = new StringBuilder();
		
		
		if(entidade instanceof Resultado){
			Resultado r = (Resultado) entidade;
			
			if(r.getAno().equals("")){
				sb.append("É obrigatório o preenchimento do ano\n");
			}
			if(r.getMes().equals("") && !r.getMes().equals("vazio")){
				sb.append("É obrigatório o preenchimento do mês\n");
			}
			
			if(sb.length() > 0){
				return sb.toString();
			}else{
				return null;
			}
		}
		
		return "Erro da valição de Resultado";
	}

}

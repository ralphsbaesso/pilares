package web.viewhelper;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dominio.Entidade;
import dominio.Especialidade;

public class VhEspecialidade extends AbstractVH{

	@Override
	public Entidade getEntidade(HttpServletRequest request) {

		operacao = request.getParameter("operacao").toLowerCase();		
		
		String descricao = request.getParameter("txtDescricao");
		String codigo = request.getParameter("txtCodigo");
		String detalhes = request.getParameter("txtDetalhes");
  		
		
		Especialidade especialidade = new Especialidade();
		especialidade.setDescricao(descricao);
		especialidade.setCodigo(codigo);
		especialidade.setDetalhes(detalhes);
		
		// armazer a entidade
		this.entidade = especialidade;
		
		return especialidade;
		
	}

	@Override
	public void setView(Object resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
			Especialidade esp = (Especialidade)this.entidade;
			SimpleDateFormat formataData = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			RequestDispatcher rd = request.getRequestDispatcher("especialidade.jsp");
			request.setAttribute("ctrlDiv", operacao.toLowerCase());
			
			// eh uma lista?
			if(resultado instanceof ArrayList){
				
				List<Especialidade> lista = (List) resultado;
				
				if(operacao.equals("listar")){
					
					request.setAttribute("especialidades", lista);
				}
			}else if(resultado != null){			
				//falha na validação de regras de negocio
				// exibe as mesagens
				request.setAttribute("mensagem", resultado.toString());
				
			}else{
				// resultado igual a nulo
				// operação com sucesso ou controle da <div>
				if(operacao.equals("salvar")){		
					request.setAttribute("mensagem", esp.getDescricao() + " salvo com sucesso!!!");			
				}else if(operacao.equals("excluir")){		
					request.setAttribute("mensagem", esp.getDescricao() + " excluído com sucesso!!!");
				}else if(operacao.equals("alterar")){
					request.setAttribute("mensagem","Especialidade alterado com sucesso!");
				}
			}
			System.out.println("operacao: " + operacao);
			rd.forward(request, response);
		}
}

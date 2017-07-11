package dao.implementacao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.Idao;
import dominio.Entidade;
import dominio.Especialidade;
import dominio.Especialidade;

public class DaoEspecialidade implements Idao {

	// objetos para coneccao
    private final String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private final String usuario = "les";
    private final String senha = "123";
    private String sql;
    private String msg;
    private Connection conexao;
    private PreparedStatement preparedStatement;
    private ResultSet resultset;
	
	@Override
	public boolean salvar(Entidade entidade) {
		
		Especialidade especialidade = (Especialidade)entidade;
		
		conectar();
	        
        sql = "INSERT INTO Especialidades"
        		+ " (descricao,data_cadastro, codigo, detalhes)"
        		+ " VALUES (?,?,?,?)";
        System.out.println(sql);
        
        try {
            preparedStatement = conexao.prepareStatement(sql);
            preparedStatement.setString(1, especialidade.getDescricao());
            preparedStatement.setDate(2, new Date(especialidade.getDataCadastro().getTimeInMillis()));
            preparedStatement.setString(3, especialidade.getCodigo());
            preparedStatement.setString(4, especialidade.getDetalhes());
            preparedStatement.execute();
            preparedStatement.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	desconectar();
        }
        
		return true;
	}

	@Override
	public boolean alterar(Entidade entidade) {
		Especialidade especialidade = (Especialidade)entidade;
		
		conectar();
	        
        sql = "UPDATE Especialidades"
        		+ " SET descricao = ?, "
        		+ " detalhes = ? "
        		+ " WHERE codigo = ?";
        
        try {
            preparedStatement = conexao.prepareStatement(sql);
            preparedStatement.setString(1, especialidade.getDescricao());
            preparedStatement.setString(2, especialidade.getDetalhes());
            preparedStatement.setString(3, especialidade.getCodigo());
            preparedStatement.execute();
            preparedStatement.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro na alteração");
            return false;
        }finally{
        	desconectar();
        }
        
		return true;
	}

	@Override
	public boolean excluir(Entidade entidade) {
		
		Especialidade especialidade = (Especialidade)entidade;
		
		conectar();
        
        sql = "DELETE FROM Especialidades "
        		+ "WHERE  codigo = (?)";
        System.out.println(sql);
        
        try {
            preparedStatement = conexao.prepareStatement(sql);
            preparedStatement.setString(1, especialidade.getCodigo());
            preparedStatement.execute();
            preparedStatement.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	desconectar();
        }
        
		return true;
	}

	@Override
	public List listar(Entidade entidade) {
		
		List <Especialidade> especialidades = new ArrayList();
		Especialidade especialidade = (Especialidade)entidade;
		
		try {
			conectar();
			
			// Primeira opção
			// Buscar dados utilizando filtro 'codigo'
			if(especialidade.getCodigo() != null){	// objeto não vazio?
				
				// buscar uma entidade
				especialidades = listarUmaEntidade(especialidade);
			
			}else{
				// Segundo opção
				// Buscar todos os dados da tabela
				
				especialidades = listarTodasEntidades();
			}
			
			// fechar o PreparedStatement
			preparedStatement.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		desconectar();
		
		return especialidades;
	}
	
	//*****************//
	// metodos privados
	private void conectar(){
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conexao = DriverManager.getConnection(url, usuario, senha);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			 //TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void desconectar(){
		try {
			conexao.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private List listarUmaEntidade(Especialidade especialidade){
		
		List<Especialidade> especialidades = new ArrayList();
		Especialidade esp;
		
		sql = "SELECT * "
				+ "FROM especialidades "
				+ "WHERE codigo = ?";
		
		// retorno
		return especialidades = selectEntidade(especialidade, sql);
	}
	
	// listar todas as entidades
	private List listarTodasEntidades(){
		
		List<Especialidade> especialidades = new ArrayList();
		Especialidade esp;
		
		sql = "SELECT * "
				+ "FROM especialidades "
				+ "ORDER BY descricao ASC";
		
		
		// retorno
		return especialidades = selectEntidade(null, sql);
	}
	
	// loop de select no banco
	private List selectEntidade(Especialidade especialidade, String sql){
		
		Especialidade esp;
		List<Especialidade> especialidades = new ArrayList();
		
		try {
			preparedStatement = conexao.prepareStatement(sql);
			if(especialidade != null)
				preparedStatement.setString(1, especialidade.getCodigo());
			resultset = preparedStatement.executeQuery();
			
			while(resultset.next()){
				esp = new Especialidade();
				esp.setId(resultset.getInt("id"));
				esp.setDescricao(resultset.getString("descricao"));
				esp.setCodigo(resultset.getString("codigo"));
				esp.setDetalhes(resultset.getString("detalhes"));
				try{
					esp.getDataCadastro().setTime(resultset.getTimestamp("data_cadastro"));
					}catch(java.lang.NullPointerException e){
					System.out.println("erro");
					esp.getDataCadastro().getInstance();
				}
				
				especialidades.add(esp);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return especialidades;
	}
}

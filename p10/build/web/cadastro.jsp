<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Parâmetros do formulário
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    // Configuração do banco de dados
    String url = "jdbc:mysql://localhost:3306/clinica";
    String usuario = "root"; // Substitua pelo seu usuário
    String senhaDB = "admin"; // Substitua pela sua senha
    Connection conexao = null;
    PreparedStatement stmt = null;

    try {
        // Conexão com o banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexao = DriverManager.getConnection(url, usuario, senhaDB);

        String query = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";
        stmt = conexao.prepareStatement(query);
        stmt.setString(1, nome);
        stmt.setString(2, email);
        stmt.setString(3, senha);

        int linhasAfetadas = stmt.executeUpdate();
        if (linhasAfetadas > 0) {
            out.println("<h1>Cadastro realizado com sucesso!</h1>");
                            out.println("<a href='index.html'>Voltar</a>");

        } else {
            out.println("<h1>Erro ao realizar o cadastro. Tente novamente.</h1>");
                            out.println("<a href='index.html'>Tente Novamente</a>");

        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h1>Erro ao conectar ao banco de dados: " + e.getMessage() + "</h1>");
    } finally {
        if (stmt != null) stmt.close();
        if (conexao != null) conexao.close();
    }
%>
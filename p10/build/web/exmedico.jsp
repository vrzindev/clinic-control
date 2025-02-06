<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<html>
<head>
    <title>Exclusão de Médico</title>
    <link rel="stylesheet" href="style2.css"/>
    
</head>
<body>

    <header class="header">
        <h1 class="firsth1">EXCLUIR MÉDICO</h1>
    </header>

    <br> 
    
    <main>
        <div class="mensagem">
            <% 
                // Recuperar o CRM do formulário
                String crmExcluir = request.getParameter("crmExcluir");
                
                if (crmExcluir != null && !crmExcluir.isEmpty()) {
                    // Acessar o banco de dados e realizar a exclusão
                    Connection con = null;
                    PreparedStatement stmt = null;
                    String url = "jdbc:mysql://localhost:3306/clinica";  // Substitua pelo seu banco de dados
                    String user = "root";  // Substitua pelo seu usuário
                    String password = "admin";  // Substitua pela sua senha

                    try {
                        // Estabelecer conexão
                        con = DriverManager.getConnection(url, user, password);
                        
                        // Criar o comando SQL para excluir o médico
                        String sql = "DELETE FROM medico WHERE crm = ?";
                        stmt = con.prepareStatement(sql);
                        stmt.setString(1, crmExcluir);
                        
                        // Executar a exclusão
                        int rowsAffected = stmt.executeUpdate();
                        
                        // Exibir mensagem dependendo do resultado da exclusão
                        if (rowsAffected > 0) {
                            out.println("<p>Médico com CRM " + crmExcluir + " excluído com sucesso!</p>");
                        } else {
                            out.println("<p>Não foi possível excluir o médico com CRM " + crmExcluir + ". Verifique se o CRM está correto.</p>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Erro ao excluir o médico. Tente novamente mais tarde.</p>");
                    } finally {
                        try {
                            if (stmt != null) stmt.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    out.println("<p>CRM não fornecido. Não foi possível realizar a exclusão.</p>");
                }
            %>
        </div>
        
        <br>
        
<a href="medico.html" class="button">Voltar</a>
    </main>

</body>
</html>

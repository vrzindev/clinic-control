<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Cadastrar Médico</title>
    <link rel="stylesheet" href="style2.css"/>
</head>

<body>
    <header class="header">
        <h1 class="firsth1">CADASTRAR MÉDICO</h1>
    </header>
    
    <br>
    
    <main>
        <div class="mensagem">
            <%
                // Configurando o logger
                Logger logger = Logger.getLogger("cadmedico");
                FileHandler fileHandler = null;
                try {
                    fileHandler = new FileHandler("cadmedico.log", true); // Log será salvo no mesmo diretório do servidor
                    fileHandler.setFormatter(new SimpleFormatter());
                    logger.addHandler(fileHandler);
                } catch (Exception e) {
                    out.println("<p>Erro ao configurar o logger: " + e.getMessage() + "</p>");
                }

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String crm = request.getParameter("crm");
                    String nome = request.getParameter("nome");
                    String especialidade = request.getParameter("especialidade");

                    try {
                        // Estabelecendo a conexão com o banco de dados
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");

                        String query = "INSERT INTO medico (crm, nome, especialidade) VALUES (?, ?, ?)";
                        PreparedStatement stmt = con.prepareStatement(query);
                        stmt.setString(1, crm);
                        stmt.setString(2, nome);
                        stmt.setString(3, especialidade);

                        int rowsAffected = stmt.executeUpdate();
                        if (rowsAffected > 0) {
                            out.println("<p>Médico cadastrado com sucesso!</p>");
                        } else {
                            out.println("<p>Erro ao cadastrar médico. Nenhuma linha foi afetada.</p>");
                        }

                        stmt.close();
                        con.close();
                    } catch (SQLException e) {
                        logger.severe("Erro no banco de dados: " + e.getMessage()); // Log detalhado no servidor
                        if (e.getMessage().contains("Duplicate entry")) {
                            out.println("<p>Erro: CRM já cadastrado. Por favor, insira um CRM único.</p>");
                        } else {
                            out.println("<p>Erro ao cadastrar médico: " + e.getMessage() + "</p>");
                        }
                    } catch (Exception e) {
                        logger.severe("Erro geral: " + e.getMessage());
                        out.println("<p>Erro inesperado: " + e.getMessage() + "</p>");
                    }
                }

                if (fileHandler != null) {
                    fileHandler.close();
                }
            %>
        </div>
        
        <br>
<a href="medico.html" class="button">Voltar</a>
    </main>
</body>
</html>

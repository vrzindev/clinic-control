<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Consultar Paciente</title>
    <link rel="stylesheet" href="style2.css"/>
</head>

<body>
    
    <header class="header">
        <h1 class="firsth1">CONSULTA DE PACIENTES</h1>
    </header>
    
    <br>
    
    <main>
        <%
            String cpfConsultar = request.getParameter("cpfConsultar");

            if (cpfConsultar != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");
                    String query = "SELECT * FROM paciente WHERE cpf = ?";
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, cpfConsultar);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        out.println("<p>CPF: " + rs.getString("cpf") + "</p>");
                        out.println("<p>Nome: " + rs.getString("nome") + "</p>");
                        out.println("<p>Email: " + rs.getString("email") + "</p>");
                        out.println("<p>Telefone: " + rs.getString("telefone") + "</p>");
                    } else {
                        out.println("<p>Paciente não encontrado.</p>");
                    }

                    con.close();
                } catch (Exception e) {
                    out.println("<p>Erro: " + e.getMessage() + "</p>");
                }
            }
        %>
        
        <br>
        
        <a href="paciente.html" class="button">Voltar</a>
    </main>
        
</body>
</html>

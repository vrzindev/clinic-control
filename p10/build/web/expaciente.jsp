<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Excluir Paciente</title>
    <link rel="stylesheet" href="style2.css"/>
</head>

<body>
    
   <header class="header">
        <h1 class="firsth1">EXCLUIR PACIENTE</h>
          </header>
    
    <br>
    
    <main>

    <%
        String cpfExcluir = request.getParameter("cpfExcluir");

        if (cpfExcluir != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");
                String query = "DELETE FROM paciente WHERE cpf = ?";
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setString(1, cpfExcluir);
                int result = stmt.executeUpdate();

                if (result > 0) {
                    out.println("<p>Paciente com CPF " + cpfExcluir + " excluído com sucesso!</p>");
                } else {
                    out.println("<p>Paciente não encontrado.</p>");
                }

                con.close();
            } catch (Exception e) {
                out.println("<p>Erro: " + e.getMessage() + "</p>");
            }
        }
    %>
    </main>
    <br>
    <a href="paciente.html">Voltar</a>
</body>
</html>

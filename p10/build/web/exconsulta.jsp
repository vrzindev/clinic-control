<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
  <title>Excluir Consulta</title>
  <link rel="stylesheet" href="style2.css"/>
</head>
<body>

  <header class="header">
    <h1 class="firsth1"> EXCLUIR CONSULTA MÉDICA</h1>
  </header>

    <br>
    
  <main>
    <%
      String cpfExcluir = request.getParameter("cpfExcluir");

      if (cpfExcluir != null) {
        try {
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");
          String sql = "DELETE FROM consulta WHERE cpf = ?";
          PreparedStatement stmt = con.prepareStatement(sql);
          stmt.setString(1, cpfExcluir);
          int rowsDeleted = stmt.executeUpdate();
          
          if (rowsDeleted > 0) {
            out.println("<p>Consulta excluída com sucesso!</p>");
          } else {
            out.println("<p>Consulta não encontrada para o CPF informado.</p>");
          }

          con.close();
        } catch (Exception e) {
          out.println("<p>Erro: " + e.getMessage() + "</p>");
        }
      }
    %>

    <br>
<a href="consulta.html" class="button">Voltar</a>  </main>
  </main>
</body>
</html>

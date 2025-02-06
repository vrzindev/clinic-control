<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
  <title>Consultar Consulta</title>
  <link rel="stylesheet" href="style2.css"/>
</head>
<body>

  <header class="header">
    <h1 class="firsth1">CONSULTAR CONSULTAR MÉDICA</h1>
  </header>

    <br>
    
  <main>
    <%
      String cpfConsultar = request.getParameter("cpfConsultar");

      if (cpfConsultar != null) {
        try {
          // Conectar ao banco de dados
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");
          
          // Consulta SQL para pegar as informações da consulta
          String sql = "SELECT * FROM consulta WHERE cpf = ?";
          PreparedStatement stmt = con.prepareStatement(sql);
          stmt.setString(1, cpfConsultar);
          ResultSet rs = stmt.executeQuery();

          // Verifica se encontrou o paciente com o CPF informado
          if (rs.next()) {
            out.println("<p><strong>CRM:</strong> " + rs.getString("crm") + "</p>");
            out.println("<p><strong>CPF:</strong> " + rs.getString("cpf") + "</p>");
            out.println("<p><strong>Data:</strong> " + rs.getDate("data") + "</p>");
            out.println("<p><strong>Hora:</strong> " + rs.getTime("hora") + "</p>");
            out.println("<p><strong>Diagnóstico:</strong> " + rs.getString("diagnostico") + "</p>");
          } else {
            out.println("<p>Consulta não encontrada para o CPF informado.</p>");
          }

          // Fechar a conexão
          con.close();
        } catch (Exception e) {
          out.println("<p>Erro: " + e.getMessage() + "</p>");
        }
      } else {
        out.println("<p>Por favor, informe o CPF para consulta.</p>");
      }
    %>

    <br>
<a href="consulta.html" class="button">Voltar</a>  </main>
  </main>
</body>
</html>

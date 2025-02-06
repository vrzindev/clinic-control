<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Cadastrar Consulta</title>
    <link rel="stylesheet" href="style2.css"/>
</head>
<body>

  <header class="header">
    <h1 class="firsth1">CONSULTA - CADASTRAR</h1>
  </header>

    <br> 
    
  <main>

    <% 
      // Verificando se a página foi submetida
      String crm = request.getParameter("crm");
      String cpf = request.getParameter("cpf");
      String data = request.getParameter("data");
      String hora = request.getParameter("hora");
      String diagnostico = request.getParameter("diagnostico");

      if (crm != null && cpf != null && data != null && hora != null && diagnostico != null) {
        try {
          // Conectar ao banco de dados
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");

          // Verificar se o CRM existe na tabela medico
          String checkCRMQuery = "SELECT crm FROM medico WHERE crm = ?";
          PreparedStatement checkCRMStmt = con.prepareStatement(checkCRMQuery);
          checkCRMStmt.setString(1, crm);
          ResultSet rsCRM = checkCRMStmt.executeQuery();

          if (!rsCRM.next()) {
            out.println("<p>Erro: O CRM informado não existe na tabela de médicos.</p>");
          } else {
            // Verificar se o CPF existe na tabela paciente
            String checkCPFQuery = "SELECT cpf FROM paciente WHERE cpf = ?";
            PreparedStatement checkCPFStmt = con.prepareStatement(checkCPFQuery);
            checkCPFStmt.setString(1, cpf);
            ResultSet rsCPF = checkCPFStmt.executeQuery();

            if (!rsCPF.next()) {
              out.println("<p>Erro: O CPF informado não existe na tabela de pacientes.</p>");
            } else {
              // Se o CRM e o CPF existirem, insere a consulta
              String insertConsultaQuery = "INSERT INTO consulta (crm, cpf, data, hora, diagnostico) VALUES (?, ?, ?, ?, ?)";
              PreparedStatement insertStmt = con.prepareStatement(insertConsultaQuery);
              insertStmt.setString(1, crm);
              insertStmt.setString(2, cpf);
              insertStmt.setString(3, data);
              insertStmt.setString(4, hora);
              insertStmt.setString(5, diagnostico);

              int rowsAffected = insertStmt.executeUpdate();
              if (rowsAffected > 0) {
                out.println("<p>Consulta cadastrada com sucesso!</p>");
              } else {
                out.println("<p>Erro ao cadastrar consulta. Tente novamente.</p>");
              }
            }
          }

          // Fechar a conexão
          con.close();
        } catch (SQLException e) {
          out.println("<p>Erro: " + e.getMessage() + "</p>");
        }
      } else {
        // Exibe o formulário apenas se não houve envio anterior
    %>
    <form method="POST">
      <label for="crm">CRM:</label>
      <input type="text" id="crm" name="crm" required><br><br>

      <label for="cpf">CPF:</label>
      <input type="text" id="cpf" name="cpf" required><br><br>

      <label for="data">Data:</label>
      <input type="date" id="data" name="data" required><br><br>

      <label for="hora">Hora:</label>
      <input type="time" id="hora" name="hora" required><br><br>

      <label for="diagnostico">Diagnóstico:</label>
      <textarea id="diagnostico" name="diagnostico" required></textarea><br><br>

      <button type="submit">Cadastrar</button>
    </form>
    <% } %>

    <br>
<a href="consulta.html" class="button">Voltar</a>  </main>
  </main>

</body>
</html>

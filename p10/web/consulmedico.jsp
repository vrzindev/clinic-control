<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Consultar Médico</title>
    <link rel="stylesheet" href="style2.css"/>
</head>

<body>
    <header class="header">
        <h1 class="firsth1">CONSULTAR MÉDICO</h1>
    </header>
    
    <br>
    
    <main>
        <div class="mensagem">
            <%
                String crmConsultar = request.getParameter("crmConsultar");
                if (crmConsultar != null && !crmConsultar.isEmpty()) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");
                        String query = "SELECT * FROM medico WHERE crm = ?";
                        PreparedStatement stmt = con.prepareStatement(query);
                        stmt.setString(1, crmConsultar);
                        
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            out.println("<p>CRM: " + rs.getString("crm") + "</p>");
                            out.println("<p>Nome: " + rs.getString("nome") + "</p>");
                            out.println("<p>Especialidade: " + rs.getString("especialidade") + "</p>");
                        } else {
                            out.println("<p>Nenhum médico encontrado com o CRM " + crmConsultar + ".</p>");
                        }
                        
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("<p>Erro: " + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>CRM não fornecido. Não foi possível realizar a consulta.</p>");
                }
            %>
        </div>
        
        <br>
<a href="medico.html" class="button">Voltar</a>
    </main>
</body>
</html>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Login - Clínica</title>
</head>
<body>
<%
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    if (email != null && senha != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "admin");
            String query = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Login correto, redireciona para a tela de início
                response.sendRedirect("inicio.html");
            } else {
                // Login incorreto
                out.println("<p style='color: red;'>E-mail ou senha inválidos.</p>");
                out.println("<a href='index.html'>Tentar novamente</a>");
            }

            con.close();
        } catch (Exception e) {
            out.println("<p style='color: red;'>Erro: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p style='color: red;'>Por favor, preencha os campos de login.</p>");
        out.println("<a href='login.html'>Voltar</a>");
    }
%>
</body>
</html>

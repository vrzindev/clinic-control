<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Paciente</title>
    <link rel="stylesheet" href="style2.css"/>

    <script>
        // Função para aplicar a máscara de CPF
        function mascaraCPF(cpf) {
            cpf = cpf.replace(/\D/g, ''); // Remove caracteres não numéricos
            cpf = cpf.replace(/(\d{3})(\d)/, '$1.$2'); // Adiciona ponto após os 3 primeiros números
            cpf = cpf.replace(/(\d{3})(\d)/, '$1.$2'); // Adiciona ponto após os 6 primeiros números
            cpf = cpf.replace(/(\d{3})(\d{1,2})$/, '$1-$2'); // Adiciona hífen antes dos 2 últimos números
            return cpf;
        }

        // Função para aplicar a máscara ao campo CPF enquanto o usuário digita
        function aplicarMascara(event) {
            const campo = event.target;
            campo.value = mascaraCPF(campo.value);
        }
    </script>
</head>

<body>
    
    <header class="header">
        <h1 class="firsth1">CADASTRAR PACIENTE</h>
          </header>
    
    <br>
    
    <main>
        <div class="mensagem">
            <%
                String cpf = request.getParameter("cpf");
                String nome = request.getParameter("nome");
                String email = request.getParameter("email");
                String telefone = request.getParameter("telefone");

                if (cpf != null && nome != null && email != null && telefone != null) {
                    Connection con = null;
                    PreparedStatement stmt = null;
                    String url = "jdbc:mysql://localhost:3306/clinica"; // Substitua pelo seu banco
                    String user = "root"; // Substitua pelo seu usuário
                    String password = "admin"; // Substitua pela sua senha

                    try {
                        con = DriverManager.getConnection(url, user, password);
                        String sql = "INSERT INTO paciente (cpf, nome, email, telefone) VALUES (?, ?, ?, ?)";
                        stmt = con.prepareStatement(sql);
                        stmt.setString(1, cpf);
                        stmt.setString(2, nome);
                        stmt.setString(3, email);
                        stmt.setString(4, telefone);

                        int rowsInserted = stmt.executeUpdate();

                        if (rowsInserted > 0) {
                            out.println("<p>Paciente cadastrado com sucesso!</p>");
                        } else {
                            out.println("<p>Erro ao cadastrar o paciente. Tente novamente.</p>");
                        }
                    } catch (SQLIntegrityConstraintViolationException e) {
                        out.println("<p>Erro: O CPF informado já está cadastrado. Por favor, verifique.</p>");
                    } catch (SQLException e) {
                        out.println("<p>Erro ao conectar ao banco de dados. Tente novamente mais tarde.</p>");
                        e.printStackTrace(); // Log para o servidor
                    } catch (Exception e) {
                        out.println("<p>Erro inesperado: " + e.getMessage() + "</p>");
                    } finally {
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    }
                } else {
                    out.println("<p>Por favor, preencha todos os campos.</p>");
                }
            %>
        </div>
        <br>
        
        <a href="paciente.html" class="button">Voltar</a>
        
    </main>
</body>
</html>

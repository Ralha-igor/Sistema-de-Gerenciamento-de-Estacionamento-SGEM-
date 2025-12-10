<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - Sistema de Estacionamento</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                background: #f5f5f5;
            }

            /* Menu fixo no topo */
            .top-menu {
                background: #2c3e50;
                color: white;
                padding: 15px 20px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
            }

            .top-menu h1 {
                font-size: 22px;
                text-align: center;
            }

            .login-container {
                max-width: 400px;
                margin: 100px auto 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .system-header {
                background: #3498db;
                color: white;
                padding: 25px 20px;
                text-align: center;
                border-bottom: 3px solid #2980b9;
            }

            .system-header h2 {
                font-size: 20px;
                margin-bottom: 5px;
            }

            .system-subtitle {
                font-size: 14px;
                opacity: 0.9;
            }

            .login-form {
                padding: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
                font-size: 14px;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                outline: none;
                border-color: #3498db;
            }

            .remember-me {
                display: flex;
                align-items: center;
                gap: 8px;
                margin: 15px 0;
                font-size: 14px;
                color: #666;
            }

            input[type="checkbox"] {
                width: 16px;
                height: 16px;
            }

            .login-button {
                width: 100%;
                background: #27ae60;
                color: white;
                border: none;
                padding: 14px;
                font-size: 16px;
                font-weight: bold;
                border-radius: 4px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .login-button:hover {
                background: #229954;
            }

            .alert-message {
                padding: 12px;
                border-radius: 4px;
                margin-bottom: 20px;
                text-align: center;
                font-size: 14px;
                background: #fee;
                color: #c33;
                border: 1px solid #fcc;
            }

            .login-footer {
                text-align: center;
                padding: 20px;
                background: #f8f9fa;
                border-top: 1px solid #eee;
                color: #666;
                font-size: 12px;
            }

            @media (max-width: 480px) {
                .login-container {
                    margin: 80px 15px 20px;
                }

                .login-form {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Menu fixo no topo -->
        <div class="top-menu">
            <h1>Sistema de Estacionamento</h1>
        </div>

        <div class="login-container">
            <!-- Cabeçalho do sistema -->
            <div class="system-header">
                <h2>Acesso ao Sistema</h2>
                <div class="system-subtitle">Faça login para continuar</div>
            </div>

            <div class="login-form">
                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                <div class="alert-message">
                    <%= msg%>
                </div>
                <% } %>

                <%
                    HttpSession sessao = request.getSession(false);
                    if ((sessao != null)
                            && (sessao.getAttribute("usuario") != null)
                            && (sessao.getAttribute("tipo_usuario") != null)) {
                        response.sendRedirect(request.getContextPath() + "/home/app/menu.jsp");
                    }
                %>

                <%
                    int id = -1;
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie c : cookies) {
                            if (c.getName().equals("id")) {
                                id = Integer.parseInt(c.getValue());
                            }
                        }
                    }
                %>

                <form action="<%= request.getContextPath()%>/home?task=login" method="post">

                    <div class="form-group">
                        <label for="id">ID do Usuário:</label>
                        <input type="text" id="id" name="id" pattern="\d+" 
                               title="apenas dígitos" 
                               value="<%= (id != -1) ? id : ""%>" 
                               required
                               placeholder="Digite seu ID">
                    </div>

                    <div class="form-group">
                        <label for="senha">Senha:</label>
                        <input type="password" id="senha" name="senha" 
                               required
                               placeholder="Digite sua senha">
                    </div>

                    <div class="remember-me">
                        <input type="checkbox" id="lembrar" name="lembrar">
                        <label for="lembrar">Lembrar meu ID</label>
                    </div>

                    <button type="submit" class="login-button">
                        Entrar no Sistema
                    </button>

                </form>
            </div>

            <div class="login-footer">
                <p>Entre com suas credenciais para acessar o sistema</p>
            </div>
        </div>
    </body>
</html>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuário</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                background-color: #f5f5f5;
                padding: 20px;
                color: #333;
            }

            h1 {
                color: #2c3e50;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #3498db;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            label {
                font-weight: bold;
                color: #2c3e50;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="password"],
            input[type="date"],
            input[type="submit"],
            input[type="button"],
            textarea {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus,
            input[type="password"]:focus,
            input[type="date"]:focus,
            textarea:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            }

            input[type="text"][readonly] {
                background-color: #f8f9fa;
                color: #6c757d;
                cursor: not-allowed;
            }

            input[type="submit"] {
                background-color: #2ecc71;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 10px;
                align-self: flex-start;
            }

            input[type="submit"]:hover {
                background-color: #27ae60;
            }

            input[type="button"] {
                background-color: #3498db;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                margin-left: 10px;
                transition: background-color 0.3s;
            }

            input[type="button"]:hover {
                background-color: #2980b9;
            }

            .modulos {
                margin-bottom: 20px;
                padding: 15px;
                background-color: #ecf0f1;
                border-radius: 5px;
            }

            .error-message {
                color: #e74c3c;
                font-size: 14px;
                margin-top: 5px;
                display: none;
            }

            input:invalid,
            textarea:invalid {
                border-color: #e74c3c;
            }

            input:invalid + .error-message {
                display: block;
            }

            .cep-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .cep-group input[type="text"] {
                flex: 1;
            }

            textarea {
                resize: vertical;
                min-height: 80px;
                font-family: Arial, sans-serif;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <%@ include file="/home/app/modulos.jsp" %>

            <%
                Usuario us = null;

                String action = request.getParameter("action");
                if (action == null) {
                    action = "create";
                } else {
                    if (action.equals("update")) {

                        int id = Integer.valueOf(request.getParameter("id"));

                        us = new Usuario();
                        us.setId(id);
                        us.load();

                    }
                }
            %>

            <h1>Usuário - <%= action.equals("create") ? "Novo" : "Editar"%></h1>

            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=usuarios" method="post">

                <div class="form-group">
                    <label for="id">ID:</label>
                    <input type="text" id="id" name="id" pattern="\d+" title="Apenas dígitos numéricos" 
                           value="<%= (us != null) ? us.getId() : ""%>" 
                           <%= (us != null) ? "readonly" : ""%> required>
                    <div class="error-message">Digite apenas números</div>
                </div>

                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" 
                           value="<%= ((us != null) && (us.getNome() != null)) ? us.getNome() : ""%>" required>
                    <div class="error-message">Este campo é obrigatório</div>
                </div>

                <div class="form-group">
                    <label for="nascimento">Nascimento:</label>
                    <input type="date" id="nascimento" name="nascimento" 
                           value="<%= ((us != null) && (us.getNascimento() != null)) ? us.getNascimento() : ""%>">
                </div>

                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <input type="text" id="cpf" name="cpf" pattern="\d{3}\.\d{3}\.\d{3}-\d{2}" 
                           title="Formato: 000.000.000-00" 
                           value="<%= ((us != null) && (us.getCpf() != null)) ? us.getCpf() : ""%>">
                    <div class="error-message">Formato inválido. Use: 000.000.000-00</div>
                </div>

                <div class="form-group">
                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" 
                           value="<%= ((us != null)) ? us.getSenha() : ""%>" required>
                    <div class="error-message">Este campo é obrigatório</div>
                </div>

                <div class="cep-group">
                    <input type="text" id="cep" name="cep" pattern="\d{5}-\d{3}" 
                           title="Formato: 00000-000" 
                           value="">
                    <input type="button" id="buscar_por_cep" name="buscar_por_cep" 
                           value="Buscar Endereço" onclick="buscar_endereco_cep()">
                </div>

                <div class="form-group">
                    <label for="endereco">Endereço:</label>
                    <textarea id="endereco" name="endereco" rows="4"><%= ((us != null) && (us.getEndereco() != null)) ? us.getEndereco() : ""%></textarea>
                </div>

                <div class="form-group">
                    <label for="tipo_usuario_id">Tipo Usuário ID:</label>
                    <input type="text" id="tipo_usuario_id" name="tipo_usuario_id" pattern="\d+" 
                           title="Apenas dígitos numéricos" 
                           value="<%= ((us != null)) ? us.getTipoUsuarioId() : ""%>" required>
                    <div class="error-message">Digite apenas números</div>
                </div>

                <input type="submit" name="Salvar" value="Salvar">
            </form>
        </div>
    </body>
</html>
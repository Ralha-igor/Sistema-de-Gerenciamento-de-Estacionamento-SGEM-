<%@page import="model.Carro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carro</title>
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
            input[type="submit"] {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus {
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

            input:invalid {
                border-color: #e74c3c;
            }

            input:invalid + .error-message {
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <%@ include file="/home/app/modulos.jsp" %>

            <%
                Carro us = null;

                String action = request.getParameter("action");
                if (action == null) {
                    action = "create";
                } else {
                    if (action.equals("update")) {

                        int id = Integer.valueOf(request.getParameter("id"));

                        us = new Carro();
                        us.setId(id);
                        us.load();

                    }
                }
            %>

            <h1>Carro - <%= action.equals("create") ? "Novo" : "Editar"%></h1>

            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=carro" method="post">

                <div class="form-group">
                    <label for="id">ID:</label>
                    <input type="text" id="id" name="id" pattern="\d+" title="Apenas dígitos numéricos" 
                           value="<%= (us != null) ? us.getId() : ""%>" 
                           <%= (us != null) ? "readonly" : ""%> required>
                    <div class="error-message">Digite apenas números</div>
                </div>

                <div class="form-group">
                    <label for="placa">Placa:</label>
                    <input type="text" id="placa" name="placa" 
                           value="<%= ((us != null) && (us.getPlaca() != null)) ? us.getPlaca() : ""%>" required>
                    <div class="error-message">Este campo é obrigatório</div>
                </div>

                <div class="form-group">
                    <label for="modelo">Modelo:</label>
                    <input type="text" id="modelo" name="modelo" 
                           value="<%= ((us != null) && (us.getModelo() != null)) ? us.getModelo() : ""%>" required>
                    <div class="error-message">Este campo é obrigatório</div>
                </div>

                <div class="form-group">
                    <label for="cor">Cor:</label>
                    <input type="text" id="cor" name="cor" 
                           value="<%= ((us != null) && (us.getCor() != null)) ? us.getCor() : ""%>" required>
                    <div class="error-message">Este campo é obrigatório</div>
                </div>

                <div class="form-group">
                    <label for="usuarios_id">Usuário ID:</label>
                    <input type="text" id="usuarios_id" name="usuarios_id" pattern="\d+" 
                           title="Apenas dígitos numéricos" 
                           value="<%= (us != null) ? us.getUsuarios_id() : ""%>" required>
                    <div class="error-message">Digite apenas números</div>
                </div>

                <input type="submit" name="Salvar" value="Salvar">
            </form>
        </div>
    </body>
</html>
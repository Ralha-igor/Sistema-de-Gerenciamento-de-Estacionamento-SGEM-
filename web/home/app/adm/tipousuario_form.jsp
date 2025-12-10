<%@page import="model.TipoUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tipo Usuário</title>
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

            input[type="text"] {
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

            .checkbox-group {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-top: 10px;
            }

            .checkbox-item {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            input[type="checkbox"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
            }

            input[type="checkbox"]:checked {
                accent-color: #3498db;
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
                TipoUsuario tp = null;

                String action = request.getParameter("action");
                if (action == null) {
                    action = "create";
                } else {
                    if (action.equals("update")) {

                        int id = Integer.valueOf(request.getParameter("id"));

                        tp = new TipoUsuario();
                        tp.setId(id);
                        tp.load();

                    }
                }
            %>

            <h1>Tipo Usuário - <%= action.equals("create") ? "Novo" : "Editar"%></h1>

            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=tipousuario" method="post">

                <div class="form-group">
                    <label for="id">ID:</label>
                    <input type="text" id="id" name="id" pattern="\d+" title="Apenas dígitos numéricos" 
                           value="<%= (tp != null) ? tp.getId() : ""%>" 
                           <%= (tp != null) ? "readonly" : ""%> required>
                    <div class="error-message">Digite apenas números</div>
                </div>

                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" 
                           value="<%= ((tp != null) && (tp.getNome() != null)) ? tp.getNome() : ""%>" required>
                    <div class="error-message">Este campo é obrigatório</div>
                </div>

                <div class="form-group">
                    <label>Módulos:</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="modulo_administrativo" name="modulo_administrativo" value="S" 
                                   <%= ((tp != null) && (tp.getModuloAdministrativo().equals("S"))) ? "checked" : ""%>>
                            <label for="modulo_administrativo">Administrativo</label>
                        </div>

                        <div class="checkbox-item">
                            <input type="checkbox" id="modulo_estacionamento" name="modulo_estacionamento" value="S"  
                                   <%= ((tp != null) && (tp.getModuloEstacionamento().equals("S"))) ? "checked" : ""%>>
                            <label for="modulo_estacionamento">Estacionamento</label>
                        </div>

                        <div class="checkbox-item">
                            <input type="checkbox" id="modulo_atendimento" name="modulo_atendimento" value="S"  
                                   <%= ((tp != null) && (tp.getModuloAtendimento().equals("S"))) ? "checked" : ""%>>
                            <label for="modulo_atendimento">Atendimento</label>
                        </div>
                    </div>
                </div>

                <input type="submit" name="Salvar" value="Salvar">
            </form>
        </div>
    </body>
</html>
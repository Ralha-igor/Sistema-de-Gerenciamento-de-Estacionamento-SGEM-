<%@page import="model.Vaga"%>
<%@page import="model.Carro"%>
<%@page import="model.Usuario"%>
<%@page import="model.Estacionamento"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Estacionamento</title>
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

            input[type="datetime-local"],
            input[type="text"],
            input[type="submit"],
            button,
            select {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            input[type="datetime-local"]:focus,
            select:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            }

            button {
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

            button:hover {
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

            input:invalid,
            select:invalid {
                border-color: #e74c3c;
            }

            input:invalid + .error-message {
                display: block;
            }

            a {
                color: #3498db;
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 3px;
                transition: all 0.3s ease;
                display: inline-block;
                margin-top: 15px;
            }

            a:hover {
                background-color: #f0f7ff;
                text-decoration: underline;
            }

            option {
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <%@ include file="/home/app/modulos.jsp" %>

            <%
                String action = request.getParameter("action");
                if (action == null) {
                    action = "create";
                }

                Estacionamento est = new Estacionamento();

                if ("update".equals(action)) {
                    int id = Integer.valueOf(request.getParameter("id"));
                    est.setId(id);
                    est.load();
                }

                ArrayList<Vaga> vagas = new Vaga().getAllTableEntities();
                ArrayList<Carro> carros = new Carro().getAllTableEntities();
                ArrayList<Usuario> usuarios = new Usuario().getAllTableEntities();

                String entradaValue = (est.getEntrada_datetime() != null)
                        ? est.getEntrada_datetime().replace(" ", "T")
                        : "";

                String saídaValue = (est.getSaida_datetime() != null)
                        ? est.getSaida_datetime().replace(" ", "T")
                        : "";
            %>

            <h1>Estacionamento - <%= action.equals("update") ? "Editar" : "Novo"%></h1>

            <form method="post" action="<%= request.getContextPath()%>/home">
                <input type="hidden" name="task" value="estacionamento">
                <input type="hidden" name="action" value="<%= action%>">
                <input type="hidden" name="id" value="<%= est.getId()%>">

                <div class="form-group">
                    <label for="entrada_datetime">Data/Hora Entrada:</label>
                    <input type="datetime-local" id="entrada_datetime" name="entrada_datetime" required
                           value="<%= entradaValue%>">
                    <div class="error-message">Este campo é obrigatório</div>
                </div>

                <div class="form-group">
                    <label for="saida_datetime">Data/Hora Saída:</label>
                    <input type="datetime-local" id="saida_datetime" name="saida_datetime"
                           value="<%= saídaValue%>">
                </div>

                <div class="form-group">
                    <label for="usuarios_id">Usuário:</label>
                    <select id="usuarios_id" name="usuarios_id" required>
                        <option value="">Selecione um usuário...</option>
                        <% for (Usuario u : usuarios) {%>
                        <option value="<%= u.getId()%>"
                                <%= (u.getId() == est.getUsuarios_id()) ? "selected" : ""%>>
                            <%= u.getNome()%>
                        </option>
                        <% } %>
                    </select>
                    <div class="error-message">Selecione um usuário</div>
                </div>

                <div class="form-group">
                    <label for="carro_id">Carro:</label>
                    <select id="carro_id" name="carro_id" required>
                        <option value="">Selecione um carro...</option>
                        <% for (Carro c : carros) {%>
                        <option value="<%= c.getId()%>"
                                <%= (c.getId() == est.getCarro_id()) ? "selected" : ""%>>
                            <%= c.getPlaca()%> - <%= c.getModelo()%>
                        </option>
                        <% } %>
                    </select>
                    <div class="error-message">Selecione um carro</div>
                </div>

                <div class="form-group">
                    <label for="vaga_id">Vaga:</label>
                    <select id="vaga_id" name="vaga_id" required>
                        <option value="">Selecione uma vaga...</option>
                        <% for (Vaga v : vagas) {%>
                        <option value="<%= v.getId()%>"
                                <%= (v.getId() == est.getVaga_id()) ? "selected" : ""%>>
                            Vaga <%= v.getNumero_vaga()%> - <%= v.getStatus()%>
                        </option>
                        <% }%>
                    </select>
                    <div class="error-message">Selecione uma vaga</div>
                </div>

                <button type="submit">
                    <%= action.equals("update") ? "Salvar Alterações" : "Registrar Entrada"%>
                </button>
            </form>

            <a href="<%= request.getContextPath()%>/home/app/esm/estacionamento.jsp">Voltar</a>
        </div>
    </body>
</html>
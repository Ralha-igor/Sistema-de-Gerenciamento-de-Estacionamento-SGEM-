<%@page import="model.Estacionamento"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                border-radius: 5px;
                overflow: hidden;
            }

            th {
                background-color: #3498db;
                color: white;
                font-weight: bold;
                padding: 12px;
                text-align: left;
                border-bottom: 2px solid #2980b9;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid #eee;
            }

            tr:hover {
                background-color: #f8f9fa;
            }

            tr:last-child td {
                border-bottom: none;
            }

            a {
                color: #3498db;
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 3px;
                transition: all 0.3s ease;
                display: inline-block;
            }

            a:hover {
                background-color: #f0f7ff;
                text-decoration: underline;
            }

            a[href*="action=update"] {
                color: #f39c12;
            }

            a[href*="action=delete"] {
                color: #e74c3c;
            }

            a[href*="action=create"] {
                background-color: #2ecc71;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                margin-top: 10px;
                display: inline-block;
            }

            a[href*="action=create"]:hover {
                background-color: #27ae60;
                text-decoration: none;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .modulos {
                margin-bottom: 20px;
                padding: 15px;
                background-color: #ecf0f1;
                border-radius: 5px;
            }

            .valor-total {
                color: #27ae60;
                font-weight: bold;
            }

            .separator {
                color: #ddd;
                margin: 0 5px;
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
                ArrayList<Estacionamento> dados = new Estacionamento().getAllTableEntities();
            %>

            <h1>Estacionamento</h1>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Entrada</th>
                    <th>Saída</th>
                    <th>Valor Total</th>
                    <th>Usuário ID</th>
                    <th>Vaga ID</th>
                    <th>Carro ID</th>
                    <th>Ações</th>
                </tr>

                <% for (Estacionamento us : dados) {%>
                <tr>
                    <td><%= us.getId()%></td>
                    <td><%= us.getEntrada_datetime()%></td>
                    <td><%= us.getSaida_datetime()%></td>
                    <td class="valor-total">R$ <%= String.format("%.2f", us.getValor_total())%></td>
                    <td><%= us.getUsuarios_id()%></td>
                    <td><%= us.getVaga_id()%></td>
                    <td><%= us.getCarro_id()%></td>

                    <td>
                        <a href="<%= request.getContextPath()%>/home/app/esm/estacionamento_form.jsp?action=update&id=<%= us.getId()%>">Alterar</a>
                        <span class="separator">|</span>
                        <a href="<%= request.getContextPath()%>/home?action=delete&id=<%= us.getId()%>&task=estacionamento"
                           onclick="return confirm('Deseja realmente excluir o registro <%= us.getId()%>?')">
                            Excluir
                        </a>
                    </td>
                </tr>
                <% }%>
            </table>

            <a href="<%= request.getContextPath()%>/home/app/esm/estacionamento_form.jsp?action=create">
                Estacionar Carro
            </a>
        </div>
    </body>
</html>
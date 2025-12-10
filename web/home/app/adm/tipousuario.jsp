<%@page import="model.TipoUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tipo Usuario</title>
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
        </style>
    </head>
    <body>
        <div class="container">
            <%@ include file="/home/app/modulos.jsp" %>

            <% ArrayList<TipoUsuario> dados = new TipoUsuario().getAllTableEntities(); %>

            <h1>Tipo Usuario</h1>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Administrativo</th>
                    <th>Estacionamento</th>
                    <th>Atendimento</th>
                    <th></th>
                    <th></th>
                </tr>

                <% for (TipoUsuario tp : dados) {%>
                <tr>
                    <td><%= tp.getId()%></td>
                    <td><%= tp.getNome()%></td>
                    <td><%= tp.getModuloAdministrativo()%></td>
                    <td><%= tp.getModuloEstacionamento()%></td>
                    <td><%= tp.getModuloAtendimento()%></td>

                    <td><a href="<%= request.getContextPath()%>/home/app/adm/tipousuario_form.jsp?action=update&id=<%= tp.getId()%>" >Alterar</a></td>

                    <td><a href="<%= request.getContextPath()%>/home?action=delete&id=<%= tp.getId()%>&task=tipousuario" onclick="return confirm('Deseja realmente excluir Tipo Usuário <%= tp.getId()%> (<%= tp.getNome()%>) ?')">Excluir</a></td>
                </tr>
                <% }%>

            </table>

            <a href="<%= request.getContextPath()%>/home/app/adm/tipousuario_form.jsp?action=create" >Adicionar Novo Tipo</a>
        </div>
    </body>
</html>
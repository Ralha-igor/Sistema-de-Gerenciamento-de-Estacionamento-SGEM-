<%@page import="model.TipoUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String usuarioLogado = (String) session.getAttribute("usuario");
    TipoUsuario tipoUsuarioLogado = (TipoUsuario) session.getAttribute("tipo_usuario");

    if ((usuarioLogado == null) || (tipoUsuarioLogado == null)) {
        response.sendRedirect(request.getContextPath() + "/home/login.jsp");
    }
%>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    /* Menu fixo no topo */
    .top-menu {
        background: #2c3e50;
        color: white;
        padding: 15px 20px;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .menu-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
    }

    .menu-content h1 {
        font-size: 20px;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 14px;
    }

    .user-avatar {
        width: 35px;
        height: 35px;
        background: #27ae60;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 16px;
    }

    .menu-links {
        background: #f8f9fa;
        padding: 10px 20px;
        margin-top: 60px;
        border-bottom: 1px solid #ddd;
    }

    .menu-links ul {
        list-style: none;
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        max-width: 1200px;
        margin: 0 auto;
    }

    .menu-links a {
        color: #2c3e50;
        text-decoration: none;
        font-size: 14px;
        padding: 5px 10px;
        border-radius: 4px;
        transition: background 0.3s;
    }

    .menu-links a:hover {
        background: #e9ecef;
    }

    .menu-links a.logout {
        color: #e74c3c;
        margin-left: auto;
    }

    /* Sistema de módulos */
    .module-section {
        background: white;
        padding: 20px;
        margin: 0 auto 20px;
        max-width: 1200px;
        border-bottom: 2px solid #3498db;
    }

    .module-title {
        font-size: 18px;
        color: #2c3e50;
        margin-bottom: 15px;
        font-weight: bold;
    }

    /* Tabelas */
    .data-table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        background: white;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }

    .data-table th {
        background: #2c3e50;
        color: white;
        padding: 12px 15px;
        text-align: left;
        font-weight: bold;
        font-size: 14px;
    }

    .data-table td {
        padding: 10px 15px;
        border-bottom: 1px solid #ddd;
        font-size: 14px;
    }

    .data-table tr:hover {
        background: #f8f9fa;
    }

    /* Botões */
    .btn {
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 13px;
        text-decoration: none;
        display: inline-block;
        text-align: center;
    }

    .btn-edit {
        background: #3498db;
        color: white;
    }

    .btn-delete {
        background: #e74c3c;
        color: white;
    }

    .btn-add {
        background: #27ae60;
        color: white;
        padding: 10px 20px;
        font-size: 14px;
        margin: 10px 0;
        display: inline-block;
    }

    .btn:hover {
        opacity: 0.9;
    }

    /* Status badges */
    .badge {
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: bold;
    }

    .badge-yes {
        background: #d4edda;
        color: #155724;
    }

    .badge-no {
        background: #f8d7da;
        color: #721c24;
    }

    /* Container principal */
    .main-container {
        max-width: 1200px;
        margin: 80px auto 20px;
        padding: 0 20px;
    }

    /* Responsivo */
    @media (max-width: 768px) {
        .menu-links ul {
            flex-direction: column;
            gap: 10px;
        }

        .menu-links a.logout {
            margin-left: 0;
        }

        .data-table {
            display: block;
            overflow-x: auto;
        }
    }
</style>

<!-- Menu fixo no topo -->
<div class="top-menu">
    <div class="menu-content">
        <h1>Sistema de Estacionamento</h1>
        <div class="user-info">
            <div class="user-avatar">
                <%= usuarioLogado != null ? usuarioLogado.substring(0, 1).toUpperCase() : "U"%>
            </div>
            <div>
                <div><strong><%= usuarioLogado != null ? usuarioLogado : "Usuário"%></strong></div>
                <div style="font-size: 12px;"><%= tipoUsuarioLogado != null ? tipoUsuarioLogado.getNome() : "Visitante"%></div>
            </div>
        </div>
    </div>
</div>

<!-- Links de navegação -->
<div class="menu-links">
    <ul>
        <li><a href="<%= request.getContextPath()%>/home/app/menu.jsp">Início</a></li>

        <%if (tipoUsuarioLogado.getModuloAdministrativo().equals("S")) {%>  
        <li><a href="<%= request.getContextPath()%>/home/app/adm/tipousuario.jsp">Tipos de Usuário</a></li>
        <li><a href="<%= request.getContextPath()%>/home/app/adm/usuarios.jsp">Usuários</a></li>
            <%}%>

        <%if (tipoUsuarioLogado.getModuloAtendimento().equals("S")) {%>
        <li><a href="<%= request.getContextPath()%>/home/app/atm/carro.jsp">Carros</a></li>
        <li><a href="<%= request.getContextPath()%>/home/app/atm/vaga.jsp">Vagas</a></li>
            <%}%>

        <%if (tipoUsuarioLogado.getModuloEstacionamento().equals("S")) {%>
        <li><a href="<%= request.getContextPath()%>/home/app/esm/estacionamento.jsp">Estacionamento</a></li>
            <%}%>

        <li><a href="<%= request.getContextPath()%>/home?task=logout" class="logout">Sair</a></li>
    </ul>
</div>

<!-- Seções de conteúdo serão inseridas aqui pelas outras páginas -->
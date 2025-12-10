<!DOCTYPE html>
<html>
    <head>
        <title>Página de Erro</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                padding: 50px;
                background-color: #f8f8f8;
            }
            .error-box {
                border: 2px solid #e74c3c;
                background-color: #fdecea;
                color: #c0392b;
                padding: 20px;
                display: inline-block;
                margin-top: 30px;
                border-radius: 8px;
            }
            a.button {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
            a.button:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>
        <h1>Ocorreu um Erro</h1>

        <div class="error-box">
            <%
                String msg = request.getParameter("msg");
                if(msg != null) {
                     out.print(msg);
                } else {
                    out.print("Um erro inesperado aconteceu.");
                }
            %>
        </div>
        
        <br>
        <a href="<%= request.getContextPath() %>/home/app/menu.jsp" class="button">Voltar ao Menu</a>
    </body>
</html>

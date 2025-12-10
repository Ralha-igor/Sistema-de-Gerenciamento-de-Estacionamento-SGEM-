package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import logtrack.ExceptionLogTrack;
import model.Carro;
import model.Estacionamento;
import model.TipoUsuario;
import model.Usuario;
import model.Vaga;
import java.sql.SQLException;


public class FrontController extends HttpServlet {  

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) {
            task = "";
        }

        try {
            switch (task) {

                case "tipousuario":
                    doGetTipoUsuario(request, response);
                    break;
                case "usuarios":
                    doGetUsuarios(request, response);
                    break;
                case "estacionamento":
                    doGetEstacionamento(request, response);
                    break;
                case "vaga":
                    doGetVaga(request, response);
                    break;
                case "carro":
                    doGetCarro(request, response);
                    break;
                case "logout":
                    doGetLogout(request, response);
                    break;

                default:
                    doDefault(request, response);
            }

        } catch (RuntimeException ex) {

            String msg = ex.getMessage();

            if ("ERRO_INTEGRIDADE".equalsIgnoreCase(msg)) {
                msg = "Erro: Este registro não pode ser excluído pois está sendo utilizado por outra tabela.";
            }

            response.sendRedirect(
                    request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                    + URLEncoder.encode(msg, "UTF-8")
            );

        } catch (Exception ex) {

            String msg = "Erro inesperado: " + ex.getMessage();

            response.sendRedirect(
                    request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                    + URLEncoder.encode(msg, "UTF-8")
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) {
            task = "";
        }

        try {
            switch (task) {

                case "tipousuario":
                    doPostTipoUsuario(request, response);
                    break;
                case "usuarios":
                    doPostUsuarios(request, response);
                    break;
                case "estacionamento":
                    doPostEstacionamento(request, response);
                    break;
                case "vaga":
                    doPostVaga(request, response);
                    break;
                case "carro":
                    doPostCarro(request, response);
                    break;
                case "login":
                    doPostLogin(request, response);
                    break;

                default:
                    doDefault(request, response);
            }

        } catch (RuntimeException ex) {

            String msg = ex.getMessage();

            if ("ERRO_INTEGRIDADE".equalsIgnoreCase(msg)) {
                msg = "Erro: A operação não pode ser concluída pois o registro está em uso.";
            }

            response.sendRedirect(
                    request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                    + URLEncoder.encode(msg, "UTF-8")
            );

        } catch (Exception ex) {

            String msg = "Erro inesperado: " + ex.getMessage();

            response.sendRedirect(
                    request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                    + URLEncoder.encode(msg, "UTF-8")
            );
        }
    }

    
    private void doGetTipoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String action = request.getParameter("action");
        if( ( action != null ) &&
                action.equals("delete") ) {
            
            int id = Integer.valueOf( request.getParameter("id") );
            
            TipoUsuario tp = new TipoUsuario();
            tp.setId(id);
            
            tp.delete();
        }
        
        response.sendRedirect( request.getContextPath() + "/home/app/adm/tipousuario.jsp" );
        
    }
    
    private void doGetUsuarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String action = request.getParameter("action");
        if( ( action != null ) &&
                action.equals("delete") ) {
            
            int id = Integer.valueOf( request.getParameter("id") );
            
            Usuario us = new Usuario();
            us.setId(id);
            
            us.delete();
            
        }
        
        response.sendRedirect( request.getContextPath() + "/home/app/adm/usuarios.jsp");
        
    }
    
    private void doGetEstacionamento(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    String action = request.getParameter("action");
    if ((action != null) && action.equals("delete")) {
        
        int id = Integer.valueOf(request.getParameter("id"));
        
        Estacionamento est = new Estacionamento();
        est.setId(id);
        
        if (est.load()) { // Carrega os dados do estacionamento
            // Carrega a vaga relacionada
            Vaga vaga = new Vaga();
            vaga.setId(est.getVaga_id());
            if (vaga.load()) {
                vaga.setStatus("LIVRE"); // Altera o status para LIVRE
                vaga.save();             // Salva a alteração no banco
            }
            
            // Deleta o estacionamento
            est.delete();
        }
    }
    
    response.sendRedirect(request.getContextPath() + "/home/app/esm/estacionamento.jsp");
}

    private void doGetVaga(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String action = request.getParameter("action");
        if( ( action != null ) &&
                action.equals("delete") ) {
            
            int id = Integer.valueOf( request.getParameter("id") );
            
            Vaga us = new Vaga();
            us.setId(id);
            
            us.delete();
            
        }
        
        response.sendRedirect( request.getContextPath() + "/home/app/atm/vaga.jsp");
    
    }
    
    private void doGetCarro(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String action = request.getParameter("action");
        if( ( action != null ) &&
                action.equals("delete") ) {
            
            int id = Integer.valueOf( request.getParameter("id") );
            
            Carro us = new Carro();
            us.setId(id);
            
            us.delete();
            
        }
        
        response.sendRedirect( request.getContextPath() + "/home/app/atm/carro.jsp");
    
    }
   
    private void doGetLogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
       HttpSession sessao = request.getSession(false);
       if( sessao != null ) {
           sessao.removeAttribute("usuario");
           sessao.removeAttribute("tipo_usuario");
           
           sessao.invalidate();
       }
       
       response.sendRedirect( request.getContextPath() +  "/home/login.jsp" );
        
    }
    
    private void doPostTipoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");

        // Pega o valor dos checkboxes e define "N" se não estiver marcado
        String moduloAdministrativo = request.getParameter("modulo_administrativo");
        moduloAdministrativo = (moduloAdministrativo != null) ? moduloAdministrativo : "N";

        String moduloEstacionamento = request.getParameter("modulo_estacionamento");
        moduloEstacionamento = (moduloEstacionamento != null) ? moduloEstacionamento : "N";

        String moduloAtendimento = request.getParameter("modulo_atendimento");
        moduloAtendimento = (moduloAtendimento != null) ? moduloAtendimento : "N";

        // Cria o objeto TipoUsuario
        TipoUsuario tp = new TipoUsuario();
        tp.setId(id);

        if ("update".equalsIgnoreCase(action)) {
            tp.load();
        }

        tp.setNome(nome);
        tp.setModuloAdministrativo(moduloAdministrativo);
        tp.setModuloEstacionamento(moduloEstacionamento);
        tp.setModuloAtendimento(moduloAtendimento);

        tp.save();

        response.sendRedirect(request.getContextPath() + "/home/app/adm/tipousuario.jsp");
    }
    
    private void doPostUsuarios(HttpServletRequest request, HttpServletResponse response) throws Exception {  
        
        String action = request.getParameter("action");

        int id = Integer.valueOf( request.getParameter("id") );
        
        String nome = request.getParameter("nome");
        
        String nascimento = request.getParameter("nascimento"); // AAAA-MM-DD
        
        String cpf = request.getParameter("cpf");
        
        String senha = request.getParameter("senha");
        
        String endereco = request.getParameter("endereco");
        
        int tipoUsuarioId = Integer.valueOf( request.getParameter("tipo_usuario_id") );
        
        String convenioId = request.getParameter("convenio");
        
        Usuario us = new Usuario();

        us.setId(id);

        if( action.equals("update") ) us.load();

        us.setNome(nome);
        
        if( nascimento.equals("") ) {
            us.setNascimento(null);
        } else {
            us.setNascimento(nascimento);
        }
        
        us.setCpf(cpf);
        us.setSenha(senha);
        us.setEndereco(endereco);
        us.setTipoUsuarioId(tipoUsuarioId);
        

        us.save();
        
        response.sendRedirect( request.getContextPath() + "/home/app/adm/usuarios.jsp");
        
    } 
    
    private void doPostEstacionamento(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        int id = Integer.parseInt(request.getParameter("id"));
        String entrada_datetime = request.getParameter("entrada_datetime");
        String saida_datetime = request.getParameter("saida_datetime");
        int usuarios_id = Integer.parseInt(request.getParameter("usuarios_id"));
        int vaga_id = Integer.parseInt(request.getParameter("vaga_id"));
        int carro_id = Integer.parseInt(request.getParameter("carro_id"));

        // Valida se a vaga existe
        Vaga novaVaga = new Vaga();
        novaVaga.setId(vaga_id);
        if (!novaVaga.load()) {
            response.sendRedirect(request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                    + URLEncoder.encode("Erro: Vaga inexistente!", "UTF-8"));
            return;
        }

        Estacionamento est = new Estacionamento();
        est.setId(id);

        Vaga vagaAntiga = null;
        boolean isUpdate = action.equalsIgnoreCase("update") && est.load();

        // Valida se a vaga está livre
        if (isUpdate) {
            vagaAntiga = new Vaga();
            vagaAntiga.setId(est.getVaga_id());
            vagaAntiga.load();

            if (vagaAntiga.getId() != vaga_id && novaVaga.getStatus().equalsIgnoreCase("OCUPADO")) {
                response.sendRedirect(request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                        + URLEncoder.encode("Erro: A nova vaga selecionada já está ocupada!", "UTF-8"));
                return;
            }
        } else {
            if (novaVaga.getStatus().equalsIgnoreCase("OCUPADO")) {
                response.sendRedirect(request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                        + URLEncoder.encode("Erro: A vaga escolhida já está ocupada!", "UTF-8"));
                return;
            }
        }

        // Calcula valor_total baseado no tempo
        double valor_total = 0.0;
        if (entrada_datetime != null && saida_datetime != null && !entrada_datetime.isEmpty() && !saida_datetime.isEmpty()) {
            try {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                LocalDateTime entrada = LocalDateTime.parse(entrada_datetime, formatter);
                LocalDateTime saida = LocalDateTime.parse(saida_datetime, formatter);

                long minutos = Duration.between(entrada, saida).toMinutes();
                long blocos = (long) Math.ceil(minutos / 30.0); // Cada 30 minutos
                BigDecimal total = BigDecimal.valueOf(blocos * 10.90).setScale(2, RoundingMode.HALF_UP);
                valor_total = total.doubleValue();
            } catch (Exception ex) {
                response.sendRedirect(request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                        + URLEncoder.encode("Erro ao calcular o valor total: " + ex.getMessage(), "UTF-8"));
                return;
            }
        }

        // Atualiza/Salva o estacionamento
        est.setUsuarios_id(usuarios_id);
        est.setCarro_id(carro_id);
        est.setVaga_id(vaga_id);
        est.setEntrada_datetime(entrada_datetime);
        est.setSaida_datetime(saida_datetime);
        est.setValor_total(valor_total);
        est.save();

        // Atualiza status das vagas
        if (isUpdate && vagaAntiga.getId() != vaga_id) {
            vagaAntiga.setStatus("LIVRE");
            vagaAntiga.save();
        }

        novaVaga.setStatus("OCUPADO");
        novaVaga.save();

        response.sendRedirect(request.getContextPath() + "/home/app/esm/estacionamento.jsp");
    }

    private void doPostVaga(HttpServletRequest request, HttpServletResponse response) throws Exception {  

    String action = request.getParameter("action");

    int id = Integer.valueOf(request.getParameter("id"));
    int numeroVaga = Integer.valueOf(request.getParameter("numero_vaga"));
    String status = request.getParameter("status");

    Vaga vaga = new Vaga();
    vaga.setId(id);

    // Se for update, carrega os dados existentes
    if(action.equals("update")) {
        vaga.load();
    }

    vaga.setNumero_vaga(numeroVaga);
    vaga.setStatus(status);

    vaga.save();

    // Redireciona para a página de listagem de vagas
    response.sendRedirect(request.getContextPath() + "/home/app/atm/vaga.jsp");
}
    
    private void doPostCarro(HttpServletRequest request, HttpServletResponse response) throws Exception {  

    String action = request.getParameter("action");

    int id = Integer.valueOf(request.getParameter("id"));
    String placa = request.getParameter("placa");
    String modelo = request.getParameter("modelo");
    String cor = request.getParameter("cor");
    int usuariosId = Integer.valueOf(request.getParameter("usuarios_id"));
    

    Carro carro = new Carro();
    carro.setId(id);

    // Se for update, carrega os dados existentes
    if(action.equals("update")) {
        carro.load();
    }

    carro.setPlaca(placa);
    carro.setModelo(modelo);
    carro.setCor(cor);
    carro.setUsuarios_id(usuariosId);

    carro.save();

    // Redireciona para a página de listagem de carros
    response.sendRedirect(request.getContextPath() + "/home/app/atm/carro.jsp");
}

    private void doPostLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {  
        
        int id = Integer.valueOf( request.getParameter("id") );        
        String senha = request.getParameter("senha");
        
        Usuario usuarioTry = new Usuario();
        usuarioTry.setId(id);
        usuarioTry.setSenha(senha);
        
        Usuario usuario = new Usuario();
        usuario.setId(id);        
        boolean status = usuario.load();
        
        if( ( status == true ) &&
              ( usuario.getSenha().equals( usuarioTry.getSenha() ) ) ) {
            
            // true crie um sessão se não houver alguma, false do contrário
            // informações amarmazenadas no servidor
            HttpSession sessao = request.getSession(false);
            if( sessao != null ) {
                sessao.removeAttribute("usuario");
                sessao.removeAttribute("tipo_usuario");
           
                sessao.invalidate();
            }
            
            sessao = request.getSession(true);
            
            sessao.setAttribute( "usuario", "(" + usuario.getNome() + ", " + usuario.getId() + ")" );
            
            TipoUsuario tipoUsuario = new TipoUsuario();
            tipoUsuario.setId( usuario.getTipoUsuarioId() );
            tipoUsuario.load();
            
            sessao.setAttribute( "tipo_usuario", tipoUsuario );
            
            sessao.setMaxInactiveInterval( 60 * 60 ); // em segundos
            
            // criado e armazenado no cliente
            Cookie cookie = new Cookie( "id", String.valueOf(id) );
            cookie.setMaxAge( 60 * 10 ); // em segundos
            response.addCookie(cookie);
            
            // faz com que o cliente acesse o recurso
            response.sendRedirect( request.getContextPath() +  "/home/app/menu.jsp" );
            
        } else {
            
            // faz com que o servidor acesso o recurso
            request.setAttribute("msg", "id e/ou senha incorreto(s)");
            request.getRequestDispatcher( "/home/login.jsp" ).forward(request, response);
            
        }
        
        
    } 
         

    


    private void handleSQLException(SQLException ex,
            HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String text = ex.getMessage().toLowerCase();
        String msg;

        if (text.contains("foreign key") || text.contains("constraint")) {
            msg = "Erro: Não é possível excluir este registro pois ele está relacionado a outros dados.";
        } else if (text.contains("duplicate")) {
            msg = "Erro: Já existe um registro com este valor.";
        } else {
            msg = "Erro de banco de dados: " + ex.getMessage();
        }

        ExceptionLogTrack.getInstance().addLog(ex);

        response.sendRedirect(
                request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                + URLEncoder.encode(msg, "UTF-8")
        );
    }


    private void handleGeneralException(Exception ex,
            HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String msg = "Ocorreu um erro inesperado.";

        ExceptionLogTrack.getInstance().addLog(ex);

        response.sendRedirect(
                request.getContextPath() + "/home/app/erro_pagina.jsp?msg="
                + URLEncoder.encode(msg, "UTF-8")
        );
    }

    
    
    private void doDefault(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        response.sendRedirect( request.getContextPath() + "/home/login.jsp" );
        
    }
    
}

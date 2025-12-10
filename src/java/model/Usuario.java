package model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Usuario extends DataAccessObject {
    
    private int id;
    private String nome;
    private String nascimento;
    private String cpf;
    private String senha;
    private String endereco;
    private int tipoUsuarioId;

    
    public Usuario() {
        super("usuarios");
    }
    
    
    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }
    
    public String getNascimento() {
        return nascimento;
    }

    public String getCpf() {
        return cpf;
    }

    public String getSenha() {
        return senha;
    }

    public String getEndereco() {
        return endereco;
    }

    public int getTipoUsuarioId() {
        return tipoUsuarioId;
    }
    
    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }
    
    public void setNascimento(String nascimento) {
        this.nascimento = nascimento;
        addChange("nascimento", this.nascimento);
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
        addChange("cpf", this.cpf);
    }

    public void setSenha(String senha) throws Exception {
        if (senha == null) {
            if (this.senha != null) {
                this.senha = senha;
                addChange("senha", this.senha);
            }
        } else {
            if (senha.equals(this.senha) == false) {

                String senhaSal = getId() + senha + getId() / 2;

                MessageDigest md = MessageDigest.getInstance("SHA-512");
                String hash = new BigInteger(1, md.digest(senhaSal.getBytes("UTF-8"))).toString(16);

                // DEBUG - Mostra o hash gerado
                System.out.println("Hash gerado para '" + senha + "': " + hash);

                this.senha = hash;
                addChange("senha", this.senha);
            }
        }
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
        addChange("endereco", this.endereco);
    }
    
    public void setTipoUsuarioId(int tipoUsuarioId) {
        if( this.tipoUsuarioId != tipoUsuarioId ) {
            this.tipoUsuarioId = tipoUsuarioId;
            addChange("tipo_usuario_id", this.tipoUsuarioId);
        }
    }

    @Override 
    protected String getWhereClauseForOneEntity() {
        return " id = " + getId();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        nome = (String) data.get(1);
        
        if( data.get(2) != null ) {
            nascimento = data.get(2).toString();
        } else {
            nascimento = null;
        }
        
        cpf = (String) data.get(3);
        senha = (String) data.get(4);
        endereco = (String) data.get(5);
        tipoUsuarioId = (int) data.get(6);
                
        return this;
    }

    @Override
    protected Usuario copy() {
        Usuario cp = new Usuario();
        
        cp.setId( getId() );
        cp.setNome( getNome() );
        cp.setNascimento( getNascimento() );
        cp.setCpf( getCpf() );
        cp.senha = getSenha();
        cp.setEndereco( getEndereco() );
        cp.setTipoUsuarioId( getTipoUsuarioId() );
        
        cp.setNovelEntity(false);
        
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Usuario ) {
            Usuario aux = (Usuario) obj;
            if( getId() == aux.getId() ) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

}

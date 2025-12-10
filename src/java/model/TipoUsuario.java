package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class TipoUsuario extends DataAccessObject {
    
    private int id;
    private String nome;
    private String moduloAdministrativo;
    private String moduloEstacionamento;
    private String moduloAtendimento;

    public TipoUsuario() {
        super("tipo_usuario");
    }
    
    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getModuloAdministrativo() {
        return moduloAdministrativo;
    }

    public String getModuloAtendimento() {
        return moduloAtendimento;
    }

    public String getModuloEstacionamento() {
        return moduloEstacionamento;
    }

    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setModuloAdministrativo(String moduloAdministrativo) {
        this.moduloAdministrativo = moduloAdministrativo;
        addChange("modulo_administrativo", this.moduloAdministrativo);
    }

    public void setModuloAtendimento(String moduloAtendimento) {
        this.moduloAtendimento = moduloAtendimento;
        addChange("modulo_atendimento", this.moduloAtendimento);
    }

   
    

    public void setModuloEstacionamento(String moduloEstacionamento) {
        this.moduloEstacionamento = moduloEstacionamento;
        addChange("modulo_estacionamento", this.moduloEstacionamento);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + getId();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        // segue a ordem das colunas da tabela no banco de dados
        id = (int) data.get(0);
        nome = (String) data.get(1);
        moduloAdministrativo = (String) data.get(2);
        moduloEstacionamento = (String) data.get(3);
        moduloAtendimento = (String) data.get(4);
        
        return this;
    }

    @Override
    protected TipoUsuario copy() {        
        TipoUsuario cp = new TipoUsuario();
        
        cp.setId( getId() );
        cp.setNome( getNome() );
        cp.setModuloAdministrativo( getModuloAdministrativo() );
        cp.setModuloEstacionamento(getModuloEstacionamento() );
        cp.setModuloAtendimento( getModuloAtendimento());
        
        cp.setNovelEntity(false); // assume que o objeto copiado já existe no banco de dados
        
        return cp;
    }
    
    @Override
    public String toString() {
        return "(" + getId() + "," + getNome() + "," + getModuloAdministrativo() + "," + getModuloEstacionamento() + "," + getModuloAtendimento()  + ")";
    }
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof TipoUsuario ) {
            TipoUsuario aux = (TipoUsuario) obj;
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
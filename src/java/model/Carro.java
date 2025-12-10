package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Carro extends DataAccessObject {
    
    private int id;
    private String placa;
    private String modelo;
    private String cor;
    private int usuarios_id;

    public Carro() {
        super("carro");
    }
    
    public int getId() {
        return id;
    }

    public String getPlaca() {
        return placa;
    }

    public String getModelo() {
        return modelo;
    }

    public String getCor() {
        return cor;
    }

    public int getUsuarios_id() {
        return usuarios_id;
    }
    
    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setPlaca(String placa) {
        this.placa = placa;
        addChange("placa", this.placa);
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
        addChange("modelo", this.modelo);
    }

    public void setCor(String cor) {
        this.cor = cor;
        addChange("cor", this.cor);
    }

    public void setUsuarios_id(int usuarios_id) {
        this.usuarios_id = usuarios_id;
        addChange("usuarios_id", this.usuarios_id);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + getId();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        placa = (String) data.get(1);
        modelo = (String) data.get(2);
        cor = (String) data.get(3);
        usuarios_id = (int) data.get(4);
        
        return this;
    }

    @Override
    protected Carro copy() {
        Carro cp = new Carro();
        
        cp.setId( getId() );
        cp.setPlaca( getPlaca() );
        cp.setModelo( getModelo() );
        cp.setCor( getCor() );
        cp.setUsuarios_id( getUsuarios_id() );
        
        cp.setNovelEntity(false);
        
        return cp;
    }
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Carro ) {
            Carro aux = (Carro) obj;
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
package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Vaga extends DataAccessObject {
    private int id;
    private int numero_vaga;
    private String status;

    public Vaga() {
        super("vaga");
    }
    
    public int getId() {
        return id;
    }

    public int getNumero_vaga() {
        return numero_vaga;
    }

    public String getStatus() {
        return status;
    }

    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setNumero_vaga(int numero_vaga) {
        this.numero_vaga = numero_vaga;
        addChange("numero_vaga", this.numero_vaga);
    }

    public void setStatus(String status) {
        this.status = status;
        addChange("status", this.status);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return "id = " + getId();
    }
    
    
    
    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        numero_vaga = (int) data.get(1);
        status = (String) data.get(2);
        
        return this;
    }
    
    @Override
    protected Vaga copy() {
        Vaga cp = new Vaga();
        
        cp.setId( getId() );
        cp.setNumero_vaga(getNumero_vaga());
        cp.setStatus(getStatus());
        
        cp.setNovelEntity(false);
        
        return cp;
    }
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Vaga ) {
            Vaga aux = (Vaga) obj;
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

package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Estacionamento extends DataAccessObject {
    
    private int id;
    private String entrada_datetime;
    private String saida_datetime;
    private double valor_total;
    private int usuarios_id;
    private int vaga_id;
    private int carro_id;

    public Estacionamento() {
        super("estacionamento");
    }
    
    public int getId() {
        return id;
    }

    public String getEntrada_datetime() {
        return entrada_datetime;
    }

    public String getSaida_datetime() {
        return saida_datetime;
    }

    public double getValor_total() {
        return valor_total;
    }

    public int getUsuarios_id() {
        return usuarios_id;
    }

    public int getVaga_id() {
        return vaga_id;
    }

    public int getCarro_id() {
        return carro_id;
    }
    
    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setEntrada_datetime(String entrada_datetime) {
        this.entrada_datetime = entrada_datetime;
        addChange("entrada_datetime", this.entrada_datetime);
    }

    public void setSaida_datetime(String saida_datetime) {
        this.saida_datetime = saida_datetime;
        addChange("saida_datetime", this.saida_datetime);
    }

    public void setValor_total(double valor_total) {
        this.valor_total = valor_total;
        addChange("valor_total", this.valor_total);
    }

    public void setUsuarios_id(int usuarios_id) {
        this.usuarios_id = usuarios_id;
        addChange("usuarios_id", this.usuarios_id);
    }

    public void setVaga_id(int vaga_id) {
        this.vaga_id = vaga_id;
        addChange("vaga_id", this.vaga_id);
    }

    public void setCarro_id(int carro_id) {
        this.carro_id = carro_id;
        addChange("carro_id", this.carro_id);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + getId();
    }

    

    @Override
    protected Estacionamento copy() {
        Estacionamento cp = new Estacionamento();
        
        cp.setId( getId() );
        cp.setEntrada_datetime( getEntrada_datetime() );
        cp.setSaida_datetime( getSaida_datetime() );
        cp.setValor_total( getValor_total() );
        cp.setUsuarios_id( getUsuarios_id() );
        cp.setVaga_id( getVaga_id() );
        cp.setCarro_id( getCarro_id() );
        
        cp.setNovelEntity(false);
        
        return cp;
    }
    
    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {

    id = (data.get(0) == null ? 0 : Integer.parseInt(data.get(0).toString()));
    entrada_datetime = (data.get(1) == null ? null : data.get(1).toString());
    saida_datetime = (data.get(2) == null ? null : data.get(2).toString());
    valor_total = (data.get(3) == null ? 0.0 : Double.parseDouble(data.get(3).toString()));
    usuarios_id = (data.get(4) == null ? 0 : Integer.parseInt(data.get(4).toString()));
    vaga_id = (data.get(5) == null ? 0 : Integer.parseInt(data.get(5).toString()));
    carro_id = (data.get(6) == null ? 0 : Integer.parseInt(data.get(6).toString()));
    
    return this;
    
    }
    
    
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Estacionamento ) {
            Estacionamento aux = (Estacionamento) obj;
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

package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;

@Entity
@Table(name = "revues")
@DiscriminatorValue("REVUE")
public class Revue extends Document {

    @Column(name = "mois")
    private Integer mois;
    
    @Column(name = "annee")
    private Integer annee;

    public Revue() {
        super();
    }

    public Revue(String titre, Integer mois, Integer annee) {
        super(titre);
        this.mois = mois;
        this.annee = annee;
    }

    public Integer getMois() {
        return mois;
    }

    public void setMois(Integer mois) {
        this.mois = mois;
    }

    public Integer getAnnee() {
        return annee;
    }

    public void setAnnee(Integer annee) {
        this.annee = annee;
    }

    @Override
    public String toString() {
        return super.toString() + " - Revue [Mois=" + mois + ", Année=" + annee + "]";
    }
}
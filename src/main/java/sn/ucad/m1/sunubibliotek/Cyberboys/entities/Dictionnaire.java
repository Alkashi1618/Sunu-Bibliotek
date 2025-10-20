package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;

@Entity
@Table(name = "dictionnaires")
@DiscriminatorValue("DICTIONNAIRE")
public class Dictionnaire extends Document {

    @Column(name = "langue", length = 50)
    private String langue;

    public Dictionnaire() {
        super();
    }

    public Dictionnaire(String titre, String langue) {
        super(titre);
        this.langue = langue;
    }

    public String getLangue() {
        return langue;
    }

    public void setLangue(String langue) {
        this.langue = langue;
    }

    @Override
    public String toString() {
        return super.toString() + " - Dictionnaire [Langue=" + langue + "]";
    }
}
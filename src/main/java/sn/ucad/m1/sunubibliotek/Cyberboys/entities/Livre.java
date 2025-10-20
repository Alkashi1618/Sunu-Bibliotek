package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;

@Entity
@Table(name = "livres")
@DiscriminatorValue("LIVRE")
public class Livre extends Document {

    @Column(name = "auteur", length = 150)
    private String auteur;
    
    @Column(name = "nbr_pages")
    private Integer nbrPages;

    public Livre() {
        super();
    }

    public Livre(String titre, String auteur, Integer nbrPages) {
        super(titre);
        this.auteur = auteur;
        this.nbrPages = nbrPages;
    }

    public String getAuteur() {
        return auteur;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }

    public Integer getNbrPages() {
        return nbrPages;
    }

    public void setNbrPages(Integer nbrPages) {
        this.nbrPages = nbrPages;
    }

    @Override
    public String toString() {
        return super.toString() + " - Livre [Auteur=" + auteur + ", Pages=" + nbrPages + "]";
    }
}